using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalProject_Web
{
    public partial class Create_Order : Page
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
            if (!Page.IsPostBack)
            {
                loadProduct();
            }
            else { }
        }

        protected void loadProduct() {
            try
            {
                conn.Open();

                string command = "Select MaHang,TenMatHang,DonVi,Cast(GiaBan as bigint) From HangHoa";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                DataTable dataTable = new DataTable();
                DataColumn dataColumn; DataRow dataRow;
                dataColumn = new DataColumn("Product's ID"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Product's Name"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Unit Type"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Price"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Quantity"); dataTable.Columns.Add(dataColumn);

                while (read.Read())
                {
                    dataRow = dataTable.NewRow();
                    dataRow["Product's ID"] = read.GetString(0);
                    dataRow["Product's Name"] = read.GetString(1);
                    dataRow["Unit Type"] = read.GetString(2);
                    dataRow["Price"] = read.GetSqlInt64(3).ToString();
                    dataRow["Quantity"] = 0;

                    dataTable.Rows.Add(dataRow);
                }
                read.Close();
                itemList.DataSource = dataTable;

                itemList.DataBind();
                conn.Close();
                loadError.Text = "";
            }
            catch
            {
                loadError.Text = "Fail on load Product List";
            }
        }
        protected void createOrderBill(string paymethod)
        {
            try
            {
                conn.Open();
                string command = "exec themPhieuDatHang '" + userID + "','" + paymethod + "'";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                read.Read();
                string billid = read.GetString(0);
                read.Close();

                for (int i = 0; i < itemList.Rows.Count; i++)
                {
                    string tmpquan = ((TextBox)itemList.Rows[i].Cells[4].FindControl("quantity")).Text;
                    int quan = int.Parse(tmpquan);
                    if (quan > 0)
                    {
                        string proid = itemList.Rows[i].Cells[0].Text;
                        command = "exec dbo.themDanhSachDatHang '" + billid + "','" + proid + "'," + quan;
                        cmd = new SqlCommand(command, conn);
                        read = cmd.ExecuteReader();
                        read.Close();
                    }
                }
                conn.Close();
            }
            catch{}
        }
        protected void btnOrder_Click(object sender, EventArgs e)
        {
            decimal total = 0;
            for(int i = 0; i < itemList.Rows.Count;i++)
            {
                string quan = ((TextBox)itemList.Rows[i].Cells[4].FindControl("quantity")).Text;
                string price = itemList.Rows[i].Cells[3].Text;
                decimal sum = Convert.ToDecimal(quan) * Convert.ToDecimal(price);
                total += sum;
            }
            string paymethod = (btnBank.Selected) ? "Banking" : "Momo";

            if (total > 0)
            {
                createOrderBill(paymethod);
                orderError.Text = "Place order success. Paid: " + total+" by "+paymethod+". Check in Order(s) Status!!!";
            }
            else
            {
                orderError.Text = "Nothing to place order!!!";
            }

            loadProduct();
        }
    }


}