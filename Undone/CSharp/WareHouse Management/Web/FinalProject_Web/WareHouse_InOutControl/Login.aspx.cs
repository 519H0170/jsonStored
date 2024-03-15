using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalProject_Web
{
    public partial class _Login : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                Response.Redirect("~/WareHouse_Order/AccountInfo", true);
            }
            else { }

            conn = ConnectSQL.SQLconnect();
            if (!Page.IsPostBack)
            {
                loadAccount();
            }
            else { }
        }

        protected void loadAccount()
        {
            try
            {
                conn.Open();
                accList.Text = "Valid Account: <br/>";

                string command = "Select TenDangNhap,Matkhau From Taikhoan Where Vaitro=N'Đại Lý'";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                int i = 0;
                while (read.Read())
                {
                    string tmp = "("+(++i)+")  "+read.GetString(0) + " - " + read.GetString(1);
                    accList.Text += tmp+"<br/>";
                }
                read.Close();
                conn.Close();
            }
            catch {
                accList.Text = "Error in Load Acc List";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUsername.Text.Trim().Length == 0 | txtPassword.Text.Trim().Length == 0)
            {
                errorLabel.Text = "Username and Password cannot null";
                errorLabel.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                conn.Open();
                string command = "Select Top 1 1 From Taikhoan Where Tendangnhap='"+txtUsername.Text+"' and Matkhau='"+txtPassword.Text+"' and Vaitro=N'Đại Lý'";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                int row = 0;
                while (read.Read())
                {
                    row++;
                }
                read.Close();

                if (row != 0)
                {
                    errorLabel.Text = "Login Success";
                    errorLabel.ForeColor = System.Drawing.Color.DarkGreen;

                    command = "Select Id_Taikhoan From Taikhoan Where Tendangnhap='" + txtUsername.Text + "'";
                    cmd = new SqlCommand(command, conn);

                    read = cmd.ExecuteReader();
                    read.Read();
                    string userid = read.GetString(0);
                    read.Close();

                    conn.Close();

                    Session["UserID"] = userid;
                    Response.Redirect("~/WareHouse_Order/AccountInfo", true);
                }
                else
                {
                    errorLabel.Text = "Wrong username/password";
                    errorLabel.ForeColor = System.Drawing.Color.Red;
                    conn.Close();
                }
            }
            catch
            {
                errorLabel.Text = "Login Fail";
                errorLabel.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}