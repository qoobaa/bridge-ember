var server, socket,
    sockjs = require("sockjs"),
    redis = require("redis"),
    http = require("http");

socket = sockjs.createServer();

socket.on("connection", function (connection) {
    var client = redis.createClient();

    client.on("ready", function () {
        client.subscribe(connection.id);
    });

    client.on("error", function (error) {
        console.error("error: " + error.message);
        connection.removeAllListeners("disconnect");
        connection.disconnect();
    });

    // client.on("message", function (channel, payload) {
    //     connection.emit("message", payload);
    // });

    connection.on("close", function () {
        client.unsubscribe();
        client.quit();
    });
});

server = http.createServer();
server.listen(parseInt(process.env.PORT, 10) || 5100, "localhost");
socket.installHandlers(server, { prefix: "/socket" });
