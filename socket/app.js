var server, socket,
    step = require("step"),
    sockjs = require("sockjs"),
    redis = require("then-redis"),
    http = require("http"),
    env = process.env.RAILS_ENV || "development";

var authenticate = function (client, id, callback) {
    step(
        function () {
            console.log("1");
            console.log(arguments);
            client.unsubscribe().then(this.bind(null, null), this);
        },
        function (error) {
            console.log("2");
            console.log(arguments);
            if (error) throw error;
            client.publish(env + "/" + id, JSON.stringify({ event: "ping" })).then(this.bind(null, null), this);
        },
        function (error, count) {
            console.log("3");
            console.log(arguments);
            if (error) throw error;
            if (count === 0) {
                client.subscribe(env + "/" + id).then(this.bind(null, null), this);
            } else {
                throw new Error("could not connect to an active channel");
            }
        },
        function (error) {
            console.log("4");
            console.log(arguments);
            callback(error);
        }
    );
};

var subscribe = function (client, oldChannel, newChannel, callback) {
    step(
        function () {
            client.unsubscribe(env + "/" + oldChannel).then(this.bind(null, null), this);
        },
        function (error) {
            if (error) throw error;
            client.subscribe(env + "/" + newChannel).then(this.bind(null, null), this);
        },
        function (error) {
            callback(error);
        }
    );
};

socket = sockjs.createServer();

socket.on("connection", function (connection) {
    redis.connect().then(
        function (client) {
            var channel;

            connection.write(JSON.stringify({ event: "ready" }));

            connection.on("data", function (message) {
                try {
                    var payload = JSON.parse(message),
                        event = payload.event,
                        data = payload.data;

                    switch (event) {
                    case "authenticate":
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
                client.quit();
            });
        },
        function (error) {
            console.error("error: " + error.message);
            connection.close(1, error.message);
        }
    );

});

server = http.createServer();

server.on("error", function (error) {
    console.error("error: " + error.message);
    process.exit(1);
});

server.listen(parseInt(process.env.PORT, 10) || 5100, "localhost");
socket.installHandlers(server, { prefix: "/socket" });
