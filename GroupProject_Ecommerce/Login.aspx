<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GroupProject_Ecommerce.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-container {
            width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

            .login-container h2 {
                text-align: center;
            }

            .login-container div {
                margin-bottom: 15px;
            }

            .login-container label {
                display: block;
                margin-bottom: 5px;
            }

            .login-container input[type="text"],
            .login-container input[type="password"] {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }

            .login-container input[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-container">
        <h2>Login</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <div>
            <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click1" />
        </div>
    </div>
</asp:Content>
