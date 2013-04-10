var server, socket,
    Step = require("step"),
    sockjs = require("sockjs"),
    redis = require("redis"),
    http = require("http");

var authenticate = function (client, id, callback) {
    Step(
        function () {
            client.publish(id, JSON.stringify({ event: "ping" }), this);
        },
        function (error, count) {
            if (error) throw error;
            if (count === 0) {
                client.subscribe(id, this);
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
    Step(
        function () {
            client.unsubscribe(oldChannel, this);
        },
        function (error) {
            if (error) throw error;
            client.subscribe(newChannel, this);
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
        connection.close();
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

                authenticate(client, data, function (error) {
                    if (error) {
                        connection.close();
                    } else {
                        connection.write(JSON.stringify({ event: "authenticated" }));
                    }
                });
                break;
            case "subscribe":
                subscribe(client, channel, data, function (error) {
                    if (error) {
                        connection.close();
                    } else {
                        channel = data;
                        connection.write(JSON.stringify({ event: "subscribed" }));
                    }
                });
                break;
            }
        } catch (error) {
            connection.close();
        }
    });

    client.on("message", function (channel, payload) {
        connection.write(payload);
    });

    connection.on("close", function () {
        client.unsubscribe();
        client.quit();
    });
});

server = http.createServer();
server.listen(parseInt(process.env.PORT, 10) || 5100, "localhost");
socket.installHandlers(server, { prefix: "/socket" });
