<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GroupProject_Ecommerce.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

            .form-container h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .form-container input[type="text"],
            .form-container input[type="password"],
            .form-container input[type="email"],
            .form-container select {
                width: 100%;
                padding: 10px;
                margin: 5px 0 10px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

                .form-container input[type="text"]::placeholder,
                .form-container input[type="password"]::placeholder,
                .form-container input[type="email"]::placeholder {
                    color: #aaa;
                }

            .form-container label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .form-container .form-error {
                color: red;
                font-size: 0.875em;
                margin-top: -10px;
                margin-bottom: 10px;
            }

            .form-container button[type="submit"] {
                width: 100%;
                background-color: #4CAF50;
                color: white;
                padding: 10px;
                margin-top: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
            }

                .form-container button[type="submit"]:hover {
                    background-color: #45a049;
                }

            .form-container .form-error-summary {
                color: red;
                font-size: 0.875em;
                margin-bottom: 10px;
                list-style: none;
                padding: 0;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container">
        <h2>Register</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />--%>

        <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required" ForeColor="Red" />

        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="Red" />

        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required" ForeColor="Red" />
        <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match" ForeColor="Red" />

        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" />
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="Red" />
        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.\w]*\w+)*@\w+([-.\w]*\w+)*\.\w+([-.\w]*\w+)*" ForeColor="Red" />

        <asp:TextBox ID="txtDisplayName" runat="server" placeholder="Display Name" />

        <asp:TextBox ID="txtAddress" runat="server" placeholder="Address" />

        <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="Phone Number" />

        <asp:DropDownList ID="ddlGender" runat="server">
            <asp:ListItem Text="Select Gender" Value=""></asp:ListItem>
            <asp:ListItem Text="Male" Value="1"></asp:ListItem>
            <asp:ListItem Text="Female" Value="2"></asp:ListItem>
            <asp:ListItem Text="Other" Value="3"></asp:ListItem>
        </asp:DropDownList>

        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
    </div>
</asp:Content>
