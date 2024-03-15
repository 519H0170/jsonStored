using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalProject_Web
{
    public partial class Log_out : Page
    {
        SqlConnection conn;
        string userID;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = ConnectSQL.SQLconnect();

            Session["UserID"] = null;
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/WareHouse_InOutControl/Login");
            }
            else { }
        }
    }
}