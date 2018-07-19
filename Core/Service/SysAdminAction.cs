using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class SysAdminAction<TEntity> where TEntity : new()
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;
        public int Payment(Cms_HistoryPayment model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_HistoryPayment_Insert")
               , CommonHelper.Null.GetNull(model.IdGuid),model.Code, CommonHelper.Null.GetNull(model.FromUser), CommonHelper.Null.GetNull(model.ToUser)
               , CommonHelper.Null.GetNull(model.BCoin), CommonHelper.Null.GetNull(model.Summary),
              model.CreatedDate, CommonHelper.Null.GetNull(model.IsShow), CommonHelper.Null.GetNull(model.IsActive));
            return 1;
        }
        public List<Cms_HistoryPayment> HistoryPaymentStudent(DateTime fromDate, DateTime toDate, int userId)
        {
            return SqlHelper.ExecuteList<Cms_HistoryPayment>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_HistoryPayment_GetStudent")
               , CommonHelper.Null.GetNull(fromDate), CommonHelper.Null.GetNull(toDate), CommonHelper.Null.GetNull(userId));
        }
        public List<Cms_HistoryPayment> HistoryPayment(DateTime fromDate, DateTime toDate, int userId)
        {
            return SqlHelper.ExecuteList<Cms_HistoryPayment>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_HistoryPayment_GetAll")
               , CommonHelper.Null.GetNull(fromDate), CommonHelper.Null.GetNull(toDate), CommonHelper.Null.GetNull(userId));
        }

        public List<Cms_HistoryPayment> GetHistoryPaymentNotShow(int top, int userId)
        {
            return SqlHelper.ExecuteList<Cms_HistoryPayment>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_HistoryPayment_GetNotShow")
            , CommonHelper.Null.GetNull(top), CommonHelper.Null.GetNull(userId));
        }
        public TEntity GetByGuidId(string id)
        {
            return SqlHelper.ExecuteTObject<TEntity>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_GetByGuidId"), typeof(TEntity).Name, id);
        }
        public TEntity GetById(int id)
        {
            return SqlHelper.ExecuteTObject<TEntity>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_GetById"), typeof(TEntity).Name, id);
        }
        public int Deletes(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_Deletes"), typeof(TEntity).Name, sWhere);
        }
        public int Updates(string sSet, string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_Updates"), typeof(TEntity).Name, sSet, sWhere);
        }
        public List<TEntity> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<TEntity>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_List"), typeof(TEntity).Name, sWhere, sOrder, fromRow, toRow);
        }
        public List<TEntity> Select(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<TEntity>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_Select"), typeof(TEntity).Name, sWhere, sOrder, fromRow, toRow);
        }
    }
}
