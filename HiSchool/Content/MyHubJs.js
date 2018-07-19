$(function () {
    var notifications = $.connection.notificationHub;
    $.connection.hub.start()
        .done(function () {
            console.log("Hub Connected!");
            notifications.server.sendNotifications();
            notifications.server.getNotificationsChat();
        })
        .fail(function () {
            console.log("Could not Connect!");
        });
    //Tổng số người Online
    notifications.client.recieveNotificationsTotalOnline = function (totalOnline) {
        if ($(".counterOnline").text() > 0) {
            $(".counterOnline").text(totalOnline);
        } else {
            $(".counterOnline").text(totalOnline);

            $(".counterOnline").countUp();
        }
    }
    notifications.client.recieveNotificationFirstTime = function (value) {
      
        try {
            if (value && value.length > 0) {
                bindingStudentNew(value);
            }
        } catch (e) {

        };
    }
    //Load chát ban đầu
    notifications.client.recieveNotificationChatTeacher = function (makh,value) {
        try {
            if (value && value.length > 0) {
                bindingChatTeacher(makh,value);
            }
        } catch (e) {

        };
    }
    //Load chat khi có comment
    notifications.client.bindingPreChatTeacher = function (makh, value) {
        try {
            if (value && value.length > 0) {
                bindingPreChatTeacher(makh, value);
            }
        } catch (e) {

        };
    }
    //Load thông báo ở quản trị "Ban đầu" và khi có "Comment mới"
    notifications.client.recieveNotificationChatTeacherAdmin = function (makh, value) {
        try {
            if (value && value.length > 0) {
                bindingChatTeacherAdmin(value);
            }
        } catch (e) {

        };
    }
    //Load chat khi có comment
    notifications.client.bindingPreCommentDienDan = function (ids, value) {
        try {
            if (value && value.length > 0) {
                bindingPreCommentDienDan(ids, value);
            }
        } catch (e) {

        };
    }
    function bindingStudentNew(item) {
        console.log(item);
        for (var i = item.length-1; i >= 0; i--) {
            var html = "<li>";
            html += "<a href='#'>"
            html += "    <div class='pull-left'>"
            html += "        <img src='/user.png' class='img-circle' alt='User Image'>"
            html += "    </div>"
            html += "    <h4>" + item[i].FromUserStr + ""
            html += "    </h4>"
            html += "        <small><i class='fa fa-clock-o'></i> " + item[i]. CreatedDateStr + "</small>"
            html += "        <p>" + item[i].Summary + "</p>";

            html += "</a>"
            html += "</li>"
            $('#studentNew').prepend(html);
        }
        $('span.studentNew').html(parseInt($('span.studentNew').text()) + item.length);
        if (parseInt($('span.studentNew').text()) == 0) {
            $('span.studentNew').hide();
        }
    }
    function bindingChatTeacherAdmin(item) {
        console.log(item)
        var totalNew = 0;
        for (var i = item.length - 1; i >= 0; i--) {
            var html = "<li>";
            html += "<a target='_blank' href='/KhoaHoc/VaoHoc?ids=" + item[i].ClassGuid + "&mkh=" + item[i].ClassStudentId+"'>"
            html += "    <div class='pull-left'>"
            html += "        <img src='/Uploads/CKFinder/files/icon_comment.png' class='img-circle' alt='User Image'>"
            html += "    </div>"
            html += "    <h4>" + item[i].FullName + ""
            html += "    </h4>"
            html += "        <small><i class='fa fa-clock-o'></i> " + item[i].CreatedDateStr + "</small>"
            html += "        <p>" + item[i].Comments + "</p>";
            html += "</a>"
            html += "</li>"
            $('#studentChat').prepend(html);
            if (!item[i].IsShow) {
                totalNew += 1;
            }
        }
        $('span.studentChat').html(parseInt($('span.studentChat').text()) + totalNew);
        if (parseInt($('span.studentChat').text()) == 0) {
            $('span.studentChat').hide();
        } else { $('span.studentChat').show();}
    }

});
