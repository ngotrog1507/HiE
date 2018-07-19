using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using WebMatrix.WebData;

namespace HiSchool.Handler
{
    [HubName("notificationHub")]
    public class NotificationHub : Hub
    {
        private static int totalOnline = 0;
        private static readonly ConcurrentDictionary<string, UserHubModels> Users =
        new ConcurrentDictionary<string, UserHubModels>(StringComparer.InvariantCultureIgnoreCase);
        private static string MyFirstTimeConnectionId = string.Empty;
        public readonly string SqlConnection =
      ConfigurationManager.ConnectionStrings["ConnectionString"]
          .ConnectionString;

        public override Task OnConnected()
        {
            string userName = Context.User.Identity.Name;
            string connectionId = Context.ConnectionId;
            MyFirstTimeConnectionId = connectionId;
            if (!string.IsNullOrEmpty(userName))
            {
                var user = Users.GetOrAdd(userName, _ => new UserHubModels
                {
                    UserName = userName,
                    ConnectionIds = new HashSet<string>()
                });

                lock (user.ConnectionIds)
                {
                    totalOnline = Users.Count();
                    SendNotificationsTotalOnline();
                    user.ConnectionIds.Add(connectionId);
                }
            }
            return base.OnConnected();
        }
        public override Task OnDisconnected(bool stopCalled)
        {
            string userName = Context.User.Identity.Name;
            string connectionId = Context.ConnectionId;

            UserHubModels user;
            Users.TryGetValue(userName, out user);

            if (user != null)
            {
                lock (user.ConnectionIds)
                {
                    user.ConnectionIds.RemoveWhere(cid => cid.Equals(connectionId));
                    if (!user.ConnectionIds.Any())
                    {
                        UserHubModels removedUser;
                        Users.TryRemove(userName, out removedUser);
                        Clients.Others.userDisconnected(userName);
                    }
                }
            }

            return base.OnDisconnected(stopCalled);
        }
        [HubMethodName("sendNotificationsTotalOnline")]
        public Task SendNotificationsTotalOnline()
        {
            IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            return contextall.Clients.All.recieveNotificationsTotalOnline(totalOnline);
        }
        [HubMethodName("sendNotifications")]
        public Task SendNotifications()
        {
            var userName = Context.User.Identity.Name;
            int userId = WebSecurity.CurrentUserId;
            //Lấy danh sách các Học viên trong lớp vừa đăng ký

            var lstUserInClass = new List<Cms_HistoryPayment>();

            if (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
            {
                lstUserInClass = new SysAdminAction<Cms_HistoryPayment>().GetHistoryPaymentNotShow(100, 0);
            }
            else
            {
                lstUserInClass = new SysAdminAction<Cms_HistoryPayment>().GetHistoryPaymentNotShow(100, userId);
            }
            lstUserInClass.ForEach(x =>
            {
                x.CreatedDateStr = Convert.ToDateTime(x.CreatedDate).ToString("dd/MM/yyy HH:mm");
            });
            IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            return contextall.Clients.Client(MyFirstTimeConnectionId).recieveNotificationFirstTime(lstUserInClass); ;
        }
        [HubMethodName("getNotificationsChat")]
        public Task GetNotificationsChat()
        {
            var userName = Context.User.Identity.Name;
            int userId = WebSecurity.CurrentUserId;
            //Lấy het cac Comment theo user

            var lstModel = new List<Cms_Comments>();

            if (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
            {
                //lstModel = new SysAdminAction<Cms_Comments>().GetHistoryPaymentNotShow(100, 0);
            }
            else
            {
                string sql = "select top 50 a.*,b.IdGuid as ClassGuid,c.FullName  from Cms_Comments a";
                sql += " left join Cms_Class b  on a.ClassId = b.Id";
                sql += " left join SysUser c  on c.Id = a.UserId";
                sql += " where ClassId in(select Id from Cms_Class where CreatedBy = " + userId + ") and a.UserId !=" + userId + " order by a.CreatedDate desc";
                lstModel = SqlHelper.ExecuteList<Cms_Comments>(SqlConnection, CommandType.Text, sql);
            }
            lstModel.ForEach(x =>
            {
                x.CreatedDateStr = Convert.ToDateTime(x.CreatedDate).ToString("dd/MM/yyy HH:mm");
            });
            IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            return contextall.Clients.Client(MyFirstTimeConnectionId).recieveNotificationChatTeacherAdmin(0, lstModel); ;
        }
        public UserHubModels GetUser(string userName)
        {
            UserHubModels user;
            Users.TryGetValue(userName, out user);
            return user;
        }
    }
    public class UserHubModels
    {
        #region Constructor
        public UserHubModels()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion


        #region Properties

        /// <summary>
        /// Property to get/set ProfileId
        /// </summary>
        public string UserName
        {
            get;
            set;
        }

        /// <summary>
        /// Propoerty to get/set multiple ConnectionId
        /// </summary>
        public HashSet<string> ConnectionIds
        {
            get;
            set;
        }

        #endregion
    }
}