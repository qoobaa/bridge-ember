var server,
    io = require("socket.io"),
    redis = require("redis"),
    url = require("url"),
    socketUrl = url.parse(process.env.SOCKET_URL || ""),
    redisUrl = url.parse(process.env.REDIS_URL || "");

server = io.listen(parseInt(socketUrl.port, 10) || 3001);

server.sockets.on("connection", function (socket) {
    var client = redis.createClient(redisUrl.port, redisUrl.hostname);

    redisUrl.auth && client.auth(redisUrl.auth.split(":")[1], function (error) {
        if (error) {
            console.error("error: " + error.message);
            socket.removeAllListeners("disconnect");
            socket.disconnect();
        }
    });

    client.on("ready", function () {
        client.subscribe(socket.id);
    });

    client.on("error", function (error) {
        console.error("error: " + error.message);
        socket.removeAllListeners("disconnect");
        socket.disconnect();
    });

    client.on("message", function (channel, payload) {
        var message = JSON.parse(payload);

        socket.emit("message", message);
    });

    socket.on("disconnect", function () {
        client.unsubscribe();
        client.quit();
    });
});
