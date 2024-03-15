<%@ Page Title="Login Page" Language="C#" MasterPageFile="~/WareHouse_InOutControl/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FinalProject_Web._Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="LoginContent" runat="server">
    <style>
        #form{
            width:374px;
            height:214px;

            margin:auto;
            margin-top:50px;

            border:dashed;
            border-width:5px;
            border-color:aqua;

            padding:12px;
            position:relative;
        }
        #demoAcc{
            width:374px;

            margin:auto;
            margin-top:50px;

            border:dashed;
            border-width:5px;
            border-color:blueviolet;

            padding:12px;
            position:relative;
        }
        #form strong{
            font-size:20px;
            padding-left:10px;
        }

        #form .inputRow{
            height:40px;
            position:relative;
        }
         #form .inputRow div{
            font-size:20px;

            display:inline;
            position:absolute;
            top:6px;
            left:10px;
         }
         #form .inputRow input{
             height:24px;
             width:220px;

             position:absolute;
             top:7px;
             left:110px;
         }

         #form div button{
            width:226px;

            position:absolute;
            bottom:6px;
            left:110px;
         }

         .errorRow{
             font-size:14px;
             color:red;

             vertical-align:central;
             text-align:left;

             position:absolute;
             top:0px;
             left:110px;
             width: 260px;
        }
    </style>

    <div id ="form">
        <strong>Login Form</strong> 
        <div class ="inputRow">
            <div>Username:</div>
            <asp:TextBox ID="txtUsername" runat="server" />
        </div>   
        <div class ="inputRow">
            <div>Password:</div>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
        </div> 
        <div class ="inputRow">
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"></asp:Button> 
        </div>
        <div class ="inputRow">
            <asp:Label ID="errorLabel" runat="server" CssClass="errorRow" Height="40px" Visible="true"></asp:Label> 
        </div>
    </div>
    <div id ="demoAcc">
        <asp:Label  ID="accList" runat="server"></asp:Label>
    </div>
</asp:Content>