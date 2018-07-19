$(function () {
    var notifications2 = $.connection.notificationHub;
    $.connection.hub.start()
        .done(function () {
            console.log("Hub Client Connected!");
            notifications2.server.sendNotificationsTotalOnline();
        })
        .fail(function () {
            console.log("Could not Connect!");
        });
    notifications2.client.recieveNotificationsTotalOnline = function (totalOnline) {
        if ($(".counterOnline").text() > 0) {
            $(".counterOnline").text(totalOnline);
        } else {
            $(".counterOnline").text(totalOnline);
            $(".counterOnline").countUp();
        }
    }
});