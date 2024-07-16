<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="GroupProject_Ecommerce.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* CSS styles for Contact page */
        .profile-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .profile-container h4 {
            margin-bottom: 10px;
            font-size: 24px;
            color: #333;
        }
        .profile-container .profile-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .profile-container .profile-item .profile-label {
            width: 100px;
            font-weight: bold;
            color: #555;
        }
        .profile-container .profile-item .profile-input {
            flex: 1;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .profile-container .profile-item .profile-image {
            flex: 1;
            text-align: right;
        }
        .profile-container .profile-item .profile-image img {
            max-width: 100px;
            max-height: 100px;
            border-radius: 50%;
        }
        /* Customize further as needed */
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="profile-container">
        <h4>Thông tin cá nhân của tôi</h4>
        <asp:DataList ID="dl_contact" runat="server">
            <ItemTemplate>
                <div class="profile-item">
                    <div class="profile-label">
                        <asp:Label ID="Label1" runat="server" Text="Tên đăng nhập:"></asp:Label>
                    </div>
                    <div class="profile-input">
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Username") %>' CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="profile-image">
                        <asp:Image ID="ProfileImage" runat="server" ImageUrl='<%# Eval("Avatar") %>' AlternateText="Avatar" />
                    </div>
                </div>
                <div class="profile-item">
                    <div class="profile-label">
                        <asp:Label ID="Label2" runat="server" Text="Mật khẩu:"></asp:Label>
                    </div>
                    <div class="profile-input">
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Password") %>' CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="profile-item">
                    <div class="profile-label">
                        <asp:Label ID="Label3" runat="server" Text="Email:"></asp:Label>
                    </div>
                    <div class="profile-input">
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Eval("Email") %>' CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="profile-item">
                    <div class="profile-label">
                        <asp:Label ID="Label4" runat="server" Text="Địa chỉ:"></asp:Label>
                    </div>
                    <div class="profile-input">
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Eval("Address") %>' CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="profile-item">
                    <div class="profile-label">
                        <asp:Label ID="Label5" runat="server" Text="Số điện thoại:"></asp:Label>
                    </div>
                    <div class="profile-input">
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Eval("PhoneNumber") %>' CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>