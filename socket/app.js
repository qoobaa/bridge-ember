var server, socket,
    step = require("step"),
    sockjs = require("sockjs"),
    redis = require("then-redis"),
    http = require("http"),
    env = process.env.RAILS_ENV || "development";

var authenticate = function (client, id, callback) {
    step(
        function () {
            client.unsubscribe().then(this.bind(null, null), this);
        },
        function (error) {
            if (error) throw error;
            if (id) {
                client.publish(env + "/" + id, JSON.stringify({ event: "ping" })).then(this.bind(null, null), this);
            } else {
                this(null, 0);
            }
        },
        function (error, count) {
            if (error) throw error;
            if (count === 0) {
                if (id) {
                    client.subscribe(env + "/" + id).then(this.bind(null, null), this);
                } else {
                    this();
                }
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
            if (oldChannel) {
                client.unsubscribe(env + "/" + oldChannel).then(this.bind(null, null), this);
            } else {
                this();
            }
        },
        function (error) {
            if (error) throw error;
            if (newChannel) {
                client.subscribe(env + "/" + newChannel).then(this.bind(null, null), this);
            } else {
                this();
            }
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
                        authenticate(client, data, function (error) {
                            if (error) {
                                connection.close(1, error.message);
                            } else {
                                connection.write(JSON.stringify({ event: "authenticated", data: data }));
                            }
                        });
                        break;
                    case "subscribe":
                        subscribe(client, channel, data, function (error) {
                            if (error) {
                                connection.close(1, error.message);
                            } else {
                                channel = data;
                                connection.write(JSON.stringify({ event: "subscribed", data: data }));
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
