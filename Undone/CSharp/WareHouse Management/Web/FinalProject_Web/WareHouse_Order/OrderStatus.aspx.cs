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
    public partial class Order_Status : Page
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
                initPage();
            }
            else { }
        }
        protected void initPage()
        {
            unprocessBtn.BackColor = System.Drawing.Color.Blue;
            unprocessBtn.ForeColor = System.Drawing.Color.White;
            unprocessBtn.Font.Bold = true;
            unprocessList.Visible = true;
            onshippedBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            onshippedBtn.ForeColor = System.Drawing.Color.Black;
            onshippedList.Visible = false;

            historyBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            historyBtn.ForeColor = System.Drawing.Color.Black;
            historyList.Visible = false;

            loadUnprocess();
            loadOnShipped();
            loadHistory();
        }

        protected void loadUnprocess()
        {
            try
            {
                conn.Open();

                string command = "Select SoPhieu,NgayDatHang From PhieuDatHang Where ID_NguoiDat = '"+userID+"' and Trangthai='On pending'";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                DataTable dataTable = new DataTable();
                DataColumn dataColumn; DataRow dataRow;
                dataColumn = new DataColumn("Order's ID"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Order's Info"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Order Date"); dataTable.Columns.Add(dataColumn);

                while (read.Read())
                {
                    dataRow = dataTable.NewRow();
                    dataRow["Order's ID"] = read.GetString(0);
                    dataRow["Order Date"] = DateTime.Parse(read.GetDateTime(1).ToString()).ToLongDateString().ToString();
                    dataTable.Rows.Add(dataRow);
                }
                read.Close();
                unprocessList.DataSource = dataTable;
                unprocessList.DataBind();

                for(int i = 0; i < unprocessList.Rows.Count; i++)
                {
                    string billId = unprocessList.Rows[i].Cells[0].Text;
                    int item = 1;
                    command = "Select HH.TenMatHang,DS.SoLuong From DanhSachDatHang DS Left join HangHoa HH on HH.MaHang = DS.MaHangHoa Where MaDanhSach='"+billId+"'";
                    
                    DropDownList dropDownList = (DropDownList)unprocessList.Rows[i].Cells[1].FindControl("orderInfo");
                    cmd = new SqlCommand(command, conn);
                    
                    read = cmd.ExecuteReader();
                    dropDownList.Items.Insert(0, new ListItem("----- Order info: Name / Quantity -----"));
                    while (read.Read())
                    {
                        dropDownList.Items.Insert(item, new ListItem(read.GetString(0)+" : "+read.GetInt32(1).ToString()));
                    }
                    read.Close();
                    
                }

                conn.Close();
            }
            catch
            {
                loadError.Text = "Fail on load Unprocess List";
            }
        }
        protected void loadOnShipped()
        {
            try
            {
                conn.Open();

                string command = "Select SoPhieu,NgayDatHang From PhieuDatHang Where ID_NguoiDat = '" + userID + "' and Trangthai='On being shipped'";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                DataTable dataTable = new DataTable();
                DataColumn dataColumn; DataRow dataRow;
                dataColumn = new DataColumn("Order's ID"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Order's Info"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Order Date"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Accept Pay"); dataTable.Columns.Add(dataColumn);


                while (read.Read())
                {
                    dataRow = dataTable.NewRow();
                    dataRow["Order's ID"] = read.GetString(0);
                    dataRow["Order Date"] = DateTime.Parse(read.GetDateTime(1).ToString()).ToLongDateString().ToString();
                    dataTable.Rows.Add(dataRow);
                }
                read.Close();
                onshippedList.DataSource = dataTable;
                onshippedList.DataBind();

                for (int i = 0; i < onshippedList.Rows.Count; i++)
                {
                    string billId = onshippedList.Rows[i].Cells[0].Text;
                    int item = 1;
                    command = "Select HH.TenMatHang,DS.SoLuong From DanhSachDatHang DS Left join HangHoa HH on HH.MaHang = DS.MaHangHoa Where MaDanhSach='" + billId + "'";

                    DropDownList dropDownList = (DropDownList)onshippedList.Rows[i].Cells[1].FindControl("orderInfo");
                    cmd = new SqlCommand(command, conn);

                    read = cmd.ExecuteReader();
                    dropDownList.Items.Insert(0, new ListItem("----- Order info: Name / Quantity -----"));
                    while (read.Read())
                    {
                        dropDownList.Items.Insert(item, new ListItem(read.GetString(0) + " : " + read.GetInt32(1).ToString()));
                    }
                    read.Close();
                }

                conn.Close();
            }
            catch
            {
                loadError.Text = "Fail on load On Shipped List";
            }
        }
        protected void onshippedList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AcceptPay")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = onshippedList.Rows[rowIndex];
                string billId = row.Cells[0].Text;
                try
                {
                    conn.Open();
                    string command = "exec nhanduocHang '" + billId + "'";
                    SqlCommand cmd = new SqlCommand(command, conn);
                    SqlDataReader read = cmd.ExecuteReader();
                    read.Read();
                    read.Close();
                    conn.Close();

                    loadOnShipped();
                    loadHistory();
                    loadError.Text = "Payment success!!! Check History :>>";
                }
                catch (Exception ex)
                {
                    loadError.Text = "Payment failed!!!";
                }
            }
        }
        protected void loadHistory()
        {
            try
            {
                conn.Open();

                string command = "Select SoPhieu,NgayDatHang,NgayNhanHang From PhieuDatHang Where ID_NguoiDat = '" + userID + "' and Trangthai='Have Arrived' Order by NgayNhanHang Desc";
                SqlCommand cmd = new SqlCommand(command, conn);
                SqlDataReader read = cmd.ExecuteReader();
                DataTable dataTable = new DataTable();
                DataColumn dataColumn; DataRow dataRow;
                dataColumn = new DataColumn("Order's ID"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Order's Info"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Order Date"); dataTable.Columns.Add(dataColumn);
                dataColumn = new DataColumn("Paid Date"); dataTable.Columns.Add(dataColumn);


                while (read.Read())
                {
                    dataRow = dataTable.NewRow();
                    dataRow["Order's ID"] = read.GetString(0);
                    dataRow["Order Date"] = DateTime.Parse(read.GetDateTime(1).ToString()).ToLongDateString().ToString();
                    dataRow["Paid Date"] = DateTime.Parse(read.GetDateTime(2).ToString()).ToLongDateString().ToString();
                    dataTable.Rows.Add(dataRow);
                }
                read.Close();
                historyList.DataSource = dataTable;
                historyList.DataBind();

                for (int i = 0; i < historyList.Rows.Count; i++)
                {
                    string billId = historyList.Rows[i].Cells[0].Text;
                    int item = 1;
                    command = "Select HH.TenMatHang,DS.SoLuong From DanhSachDatHang DS Left join HangHoa HH on HH.MaHang = DS.MaHangHoa Where MaDanhSach='" + billId + "'";

                    DropDownList dropDownList = (DropDownList)historyList.Rows[i].Cells[1].FindControl("orderInfo");
                    cmd = new SqlCommand(command, conn);

                    read = cmd.ExecuteReader();
                    dropDownList.Items.Insert(0, new ListItem("----- Order info: Name / Quantity -----"));
                    while (read.Read())
                    {
                        dropDownList.Items.Insert(item, new ListItem(read.GetString(0) + " : " + read.GetInt32(1).ToString()));
                    }
                    read.Close();
                }

                conn.Close();
            }
            catch
            {
                loadError.Text = "Fail on load History List";
            }
        }
        protected void unprocessBtn_Click(object sender, EventArgs e)
        {
            unprocessBtn.BackColor = System.Drawing.Color.Blue;
            unprocessBtn.ForeColor = System.Drawing.Color.White;
            unprocessBtn.Font.Bold = true;
            unprocessList.Visible = true;

            onshippedBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            onshippedBtn.ForeColor = System.Drawing.Color.Black;
            onshippedList.Visible = false;


            historyBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            historyBtn.ForeColor = System.Drawing.Color.Black;
            historyList.Visible = false;
        }

        protected void onshippedBtn_Click(object sender, EventArgs e)
        {
            unprocessBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            unprocessBtn.ForeColor = System.Drawing.Color.Black;
            unprocessList.Visible = false;

            onshippedBtn.BackColor = System.Drawing.Color.Blue;
            onshippedBtn.ForeColor = System.Drawing.Color.White;
            onshippedBtn.Font.Bold = true;
            onshippedList.Visible = true;

            historyBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            historyBtn.ForeColor = System.Drawing.Color.Black;
            historyList.Visible = false;
        }

        protected void historyBtn_Click(object sender, EventArgs e)
        {
            unprocessBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            unprocessBtn.ForeColor = System.Drawing.Color.Black;
            unprocessList.Visible = false;

            onshippedBtn.BackColor = System.Drawing.Color.WhiteSmoke;
            onshippedBtn.ForeColor = System.Drawing.Color.Black;
            onshippedList.Visible = false;

            historyBtn.BackColor = System.Drawing.Color.Blue;
            historyBtn.ForeColor = System.Drawing.Color.White;
            historyBtn.Font.Bold = true;
            historyList.Visible = true;
        }


    }
}