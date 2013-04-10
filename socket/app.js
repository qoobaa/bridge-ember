var server, socket,
    step = require("step"),
    sockjs = require("sockjs"),
    redis = require("redis"),
    http = require("http"),
    env = process.env.RAILS_ENV || "development";

var authenticate = function (client, id, callback) {
    step(
        function () {
            client.publish(env + "/" + id, JSON.stringify({ event: "ping" }), this);
        },
        function (error, count) {
            if (error) throw error;
            if (count === 0) {
                client.subscribe(env + "/" + id, this);
            } else {
                throw new Error("could not connect to an active channel");
            }
        },
        function (error) {
            callback(error);
        }
    );
};

var subscribe = function (client, oldChannel, newChannel, callback) {
    step(
        function () {
            client.unsubscribe(env + "/" + oldChannel, this);
        },
        function (error) {
            if (error) throw error;
            client.subscribe(env + "/" + newChannel, this);
        },
        function (error) {
            callback(error);
        }
    );
};

socket = sockjs.createServer();

socket.on("connection", function (connection) {
    var channel, id,
        client = redis.createClient();

    client.on("ready", function () {
        connection.write(JSON.stringify({ event: "ready" }));
    });

    client.on("error", function (error) {
        console.error("error: " + error.message);
        connection.removeAllListeners();
        connection.close(1, error.message);
    });

    connection.on("data", function (message) {
        try {
            var payload = JSON.parse(message),
                event = payload.event,
                data = payload.data;

            switch (event) {
            case "authenticate":
                if (id) throw new Error("already authenticated");
                if (channel) throw new Error("cannot authenticate after subscribing");
                if (!data) throw new Error("invalid or missing argument");

                authenticate(client, data, function (error) {
                    if (error) {
                        connection.close(1, error.message);
                    } else {
                        connection.write(JSON.stringify({ event: "authenticated" }));
                    }
                });
                break;
            case "subscribe":
                if (!data) throw new Error("invalid or missing argument");

                subscribe(client, channel, data, function (error) {
                    if (error) {
                        connection.close(1, error.message);
                    } else {
                        channel = data;
                        connection.write(JSON.stringify({ event: "subscribed" }));
                    }
                });
                break;
            default:
                connection.close(1, "unknown command");
                break;
            }
        } catch (error) {
            connection.close(1, error.message);
        }
    });

    client.on("message", function (channel, message) {
        var payload = {};

        try {
            payload = JSON.parse(message);
        } catch (error) {
        }

        if (payload.event !== "ping") {
            connection.write(message);
        }
    });

    connection.on("close", function () {
        client.unsubscribe();
        client.quit();
    });
});

server = http.createServer();

server.on("error", function (error) {
    console.error("error: " + error.message);
    process.exit(1);
});

server.listen(parseInt(process.env.PORT, 10) || 5100, "localhost");
socket.installHandlers(server, { prefix: "/socket" });
