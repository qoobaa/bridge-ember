var socketServer, httpServer,
    io = require("socket.io"),
    redis = require("redis"),
    url = require("url"),
    http = require("http"),
    socketUrl = url.parse(process.env.SOCKET_URL || ""),
    redisUrl = url.parse(process.env.REDIS_URL || "");

httpServer = http.createServer();
httpServer.listen(parseInt(process.env.PORT, 10) || 5100, "localhost");
socketServer = io.listen(httpServer);

socketServer.sockets.on("connection", function (socket) {
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
