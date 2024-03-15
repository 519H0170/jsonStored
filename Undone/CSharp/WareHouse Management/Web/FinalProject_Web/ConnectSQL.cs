using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FinalProject_Web
{
    class ConnectSQL
    {
        internal static SqlConnection SQLconnect()
        {
            string servername = "MY-LUV";
            string database = "DailyBanHang";

            string connectionString = "Server=" + servername + "; Database=" + database + "; Integrated Security=True;";

            SqlConnection conn = new SqlConnection(connectionString);

            return conn;
        }
    }
}