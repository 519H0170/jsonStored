<%@ Page Title="Order Status" Language="C#" MasterPageFile="~/WareHouse_Order/Site.Master" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="FinalProject_Web.Create_Order" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #container{
            width:800px;
            max-width:800px;
            min-width:800px;
            height:500px;
            margin:auto;
            position:relative;
        }
        #itemDiv{
            width:100%;
            max-height:400px;
            padding:5px;
            overflow-y:scroll;
        }
        .gridHeaderShort{
            vertical-align:central;
            text-align:center;
            padding:5px;
            font-size:14px;
        }
        .gridItemShort{
            vertical-align:central;
            text-align:center;
            padding:5px;
            font-size:12px;
        }
        .gridHeaderLong{
            vertical-align:central;
            text-align:left;
            padding:5px;
            font-size:14px;

        }
        .gridItemLong{
            vertical-align:central;
            text-align:left;
            padding:5px;
            font-size:12px;
        }

        #payment{
            width:100%;
            height:100px;
            position:absolute;
            left:0;
            bottom:-125;
        }
        #method{
            width:150px;
            height:50px;
            font-size:16px;

            position:absolute;
            right:100px;
            top:20px;
        }

        .btnOrder{
            width:100px;
            height:50px;
            font-size:16px;


            position:absolute;
            right:0;
            top:20px;
        }
    </style>
    <div id="container">
        <h2>New Order</h2>

        <div id="itemDiv">
            <asp:GridView ID="itemList" runat="server" AutoGenerateColumns="false" BackColor="White">
                <Columns>
                    <asp:BoundField DataField="Product's ID" HeaderText="Product's ID" HeaderStyle-Width="125" HeaderStyle-CssClass="gridHeaderShort" ItemStyle-CssClass="gridItemShort" ReadOnly="true"/>
                    <asp:BoundField DataField="Product's Name" HeaderText="Product's Name"  HeaderStyle-Width="250"  HeaderStyle-CssClass="gridHeaderLong" ItemStyle-CssClass="gridItemLong" ReadOnly="true"/>
                    <asp:BoundField DataField="Unit Type" HeaderText="Unit Type"  HeaderStyle-Width="125"  HeaderStyle-CssClass="gridHeaderShort" ItemStyle-CssClass="gridItemShort" ReadOnly="true"/>
                    <asp:BoundField DataField="Price" HeaderText="Price"  HeaderStyle-Width="150"  HeaderStyle-CssClass="gridHeaderShort" ItemStyle-CssClass="gridItemShort" ReadOnly="true"/>
                    <asp:TemplateField HeaderText = "Quantity" HeaderStyle-Width="100"  HeaderStyle-CssClass="gridHeaderShort" ItemStyle-CssClass="gridItemShort">
                        <ItemTemplate>
                            <asp:TextBox ID="quantity" runat="server" Width="100" TextMode="Number" min="0" max="100" step="0" Text="0">
                            </asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div id="payment">
            <div id="method">
                <asp:RadioButtonList runat="server">
                    <asp:ListItem Selected="true" ID="btnBank">Banking</asp:ListItem>
                    <asp:ListItem>Momo</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div>
                <asp:Button ID="btnOrder" Text="Place Order" runat="server" CssClass="btnOrder" OnClick="btnOrder_Click"/>
            </div>
        </div>
        
    </div>
     
    <asp:Label ID="loadError" runat="server"></asp:Label>
    <br />
    <asp:Label ID="orderError" runat="server"></asp:Label>

</asp:Content>
