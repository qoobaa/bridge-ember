var server, socket,
    sockjs = require("sockjs"),
    redis = require("redis"),
    http = require("http");

socket = sockjs.createServer();

socket.on("connection", function (connection) {
    var authenticationTimeout, subscribedChannel,
        client = redis.createClient();

    client.on("ready", function () {
        connection.write(JSON.stringify({ event: "ready" }));
        authenticationTimeout = setTimeout(function () {
            connection.close();
        }, 1000);
    });

    client.on("error", function (error) {
        console.error("error: " + error.message);
        connection.removeAllListeners("close");
        connection.close();
    });

    connection.once("data", function (message) {
        clearTimeout(authenticationTimeout);
        try {
            var payload = JSON.parse(message),
                event = payload.event,
                id = payload.data;
            if (event === "authenticate") {
                // TODO: check authenticity of id
                connection.write(JSON.stringify({ event: "authenticated" }));
                client.subscribe(id);
                connection.on("data", function (message) {
                    try {
                        var payload = JSON.parse(message),
                            event = payload.event,
                            channel = payload.data;
                        if (event === "subscribe" && channel) {
                            if (subscribedChannel) {
                                client.unsubscribe(subscribedChannel);
                                subscribedChannel = null;
                            }
                            client.subscribe(channel);
                            subscribedChannel = channel;
                            connection.write(JSON.stringify({ event: "subscribed" }));
                        } else {
                            connection.close();
                        }
                    } catch (error) {
                        connection.close();
                    }
                });
            } else {
                connection.close();
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
