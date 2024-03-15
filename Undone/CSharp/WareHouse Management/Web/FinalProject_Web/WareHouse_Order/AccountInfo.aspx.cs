using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalProject_Web
{
    public partial class Account_Info : Page
    {
        SqlConnection conn;
        string userID;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = ConnectSQL.SQLconnect();


            if (Session["UserID"] == null)
            {
                Response.Redirect("~/WareHouse_InOutControl/Login");
            }
            else { }

            userID = Convert.ToString(Session["UserID"]);

            try
            {
                conn.Open();

                string command = "Select Id_Taikhoan,HoVaTen,DiaChi,SoDienThoai From TaiKhoan Where Id_Taikhoan='" + userID +"'";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                read.Read();

                txtID.Text = read.GetString(0);
                txtName.Text = read.GetString(1);
                txtAddress.Text = read.GetString(2);
                txtPhone.Text = read.GetString(3);

                read.Close();
                conn.Close();
            }
            catch
            {
                Session["UserID"] = null;
                Response.Redirect("~/WareHouse_InOutControl/Login");
            }
        }
    }
}