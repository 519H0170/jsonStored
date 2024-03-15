<%@ Page Title="Account's Info" Language="C#" MasterPageFile="~/WareHouse_Order/Site.Master" AutoEventWireup="true" CodeBehind="AccountInfo.aspx.cs" Inherits="FinalProject_Web.Account_Info" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .colname{
            font-size:16px;
            display:inline;
        }
    </style>
    <h2><%: Title %></h2>
    <div>
        <div>
            <div class="colname"> Id: </div>
            <asp:Label ID="txtID" runat="server"></asp:Label>
        </div>
        <div>
            <div class="colname">Họ và tên: </div>
            <asp:Label ID="txtName" runat="server"></asp:Label>
        </div>
        <div>
            <div class="colname">Địa chỉ: </div>
            <asp:Label ID="txtAddress" runat="server"></asp:Label>
        </div>
        <div>
            <div class="colname">Số điện thoại: </div>
            <asp:Label ID="txtPhone" runat="server"></asp:Label>
        </div>
    </div>
</asp:Content>
