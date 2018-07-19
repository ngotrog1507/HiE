using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace HiSchool.Handler
{
    [HubName("layoutHub")]
    public class LayoutHub : Hub
    {
        private static int totalOnline = 0;
        private static readonly ConcurrentDictionary<string, UserHubModels> Users =
        new ConcurrentDictionary<string, UserHubModels>(StringComparer.InvariantCultureIgnoreCase);
        private static string MyFirstTimeConnectionId = string.Empty;
        public readonly string SqlConnection =
      ConfigurationManager.ConnectionStrings["ConnectionString"]
          .ConnectionString;
        //public override Task OnConnected()
        //{
        //    string userName = Context.User.Identity.Name;
        //    string connectionId = Context.ConnectionId;
        //    MyFirstTimeConnectionId = connectionId;

        //    NotificationHub hub =new NotificationHub();
        //    hub.
        //    var user = Users.GetOrAdd(userName, _ => new UserHubModels
        //    {
        //        UserName = userName,
        //        ConnectionIds = new HashSet<string>()
        //    });

        //    lock (user.ConnectionIds)
        //    {
        //        totalOnline = Users.Count();
        //        SendNotificationsTotalOnline();
        //        user.ConnectionIds.Add(connectionId);
        //    }

        //    return base.OnConnected();
        //}
        //public override Task OnDisconnected(bool stopCalled)
        //{
        //    string userName = Context.User.Identity.Name;
        //    string connectionId = Context.ConnectionId;

        //    UserHubModels user;
        //    Users.TryGetValue(userName, out user);

        //    if (user != null)
        //    {
        //        lock (user.ConnectionIds)
        //        {
        //            user.ConnectionIds.RemoveWhere(cid => cid.Equals(connectionId));
        //            if (!user.ConnectionIds.Any())
        //            {
        //                UserHubModels removedUser;
        //                Users.TryRemove(userName, out removedUser);
        //                Clients.Others.userDisconnected(userName);
        //            }
        //        }
        //    }

        //    return base.OnDisconnected(stopCalled);
        //}
    }
}