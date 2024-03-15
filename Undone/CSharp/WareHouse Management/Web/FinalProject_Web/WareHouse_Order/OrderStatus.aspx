<%@ Page Title="Order Status" Language="C#" MasterPageFile="~/WareHouse_Order/Site.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="FinalProject_Web.Order_Status" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #container{
            width:800px;
            max-width:800px;
            min-width:800px;
            margin:auto;
            position:relative;
            padding:10px;
        }

        #statusDiv{
            
        }

        #statusTable{
            width:100%;
            min-height:400px;
            max-height:400px;

            margin-top:10px;
            overflow-y:scroll;
        }
        .table-Frame{
            width:100%;
        }
        .table-Header{
            padding:5px;
            font-size:16px;
        }
        .table-Item{
            padding:5px;
            font-size:14px;
        }
        .dropdownTable{
            width:100%;
        }
    </style>
    
    <div id="container">
        <h2>Order Status</h2>
        <div id="statusDiv">
            <asp:Button ID="unprocessBtn" runat="server" Text="Unprocessed" Width="150" Height="40" OnClick="unprocessBtn_Click"/>
            <asp:Button ID="onshippedBtn" runat="server" Text="On shipped"  Width="150" Height="40" OnClick="onshippedBtn_Click"/>
            <asp:Button ID="historyBtn" runat="server" Text="History"  Width="150" Height="40" OnClick="historyBtn_Click"/>
        </div>
        <div id="statusTable">
            <asp:GridView ID="unprocessList" runat="server" AutoGenerateColumns="false" BackColor="White" CssClass="table-Frame">
                <Columns>
                    <asp:BoundField DataField="Order's ID" HeaderText="Order's ID" ReadOnly="true" HeaderStyle-Width="150" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>
                    <asp:TemplateField HeaderText="Order's Info" HeaderStyle-Width="350" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item">
                        <ItemTemplate>
                            <asp:DropDownList runat="server" CssClass="dropdownTable" ID="orderInfo"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Order Date" HeaderText="Order Date" ReadOnly="true" HeaderStyle-Width="280" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>
                </Columns>
            </asp:GridView>

            <asp:GridView ID="onshippedList" runat="server" AutoGenerateColumns="false" BackColor="White" CssClass="table-Frame" OnRowCommand="onshippedList_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Order's ID" HeaderText="Order's ID" ReadOnly="true" HeaderStyle-Width="150" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>
                    <asp:TemplateField HeaderText="Order's Info" HeaderStyle-Width="300" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item">
                        <ItemTemplate>
                            <asp:DropDownList runat="server" CssClass="dropdownTable" ID="orderInfo"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Order Date" HeaderText="Order Date" ReadOnly="true" HeaderStyle-Width="230" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>
                    <asp:TemplateField HeaderText="Accept Pay" HeaderStyle-Width="100" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item">
                        <ItemTemplate>
                            <asp:Button runat="server" CssClass="acceptBtn" ID="acceptPay" Text="Pay for this bill" CommandName="AcceptPay" CommandArgument="<%# Container.DataItemIndex %>"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:GridView ID="historyList" runat="server" AutoGenerateColumns="false" BackColor="White" CssClass="table-Frame" OnRowCommand="onshippedList_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Order's ID" HeaderText="Order's ID" ReadOnly="true" HeaderStyle-Width="150" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>
                    <asp:TemplateField HeaderText="Order's Info" HeaderStyle-Width="300" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item">
                        <ItemTemplate>
                            <asp:DropDownList runat="server" CssClass="dropdownTable" ID="orderInfo"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Order Date" HeaderText="Order Date" ReadOnly="true" HeaderStyle-Width="170" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>
                    <asp:BoundField DataField="Paid Date" HeaderText="Paid Date" ReadOnly="true" HeaderStyle-Width="170" HeaderStyle-CssClass="table-Header" ItemStyle-CssClass="table-Item"/>

                </Columns>
            </asp:GridView>
        </div>
        <asp:Label ID="loadError" runat="server"></asp:Label>
    </div>
</asp:Content>
  