<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="GroupProject_Ecommerce.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container-profile {
            display: flex;
        }
        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #f9f9f9;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar .profile {
            text-align: center;
            margin-bottom: 20px;
        }
        .sidebar .profile img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
        }
        .sidebar .profile p {
            margin: 10px 0 0;
            font-weight: bold;
        }
        .sidebar .menu-item {
            display: flex;
            align-items: center;
            padding: 10px 0;
            color: #333;
            text-decoration: none;
            transition: background 0.3s;
        }
        .sidebar .menu-item:hover {
            background-color: #eee;
        }
        .sidebar .menu-item img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        .sidebar .menu-item span {
            font-size: 16px;
        }
        .content {
            flex-grow: 1;
            padding: 20px;
        }
        .content-section {
            display: none;
        }
        .content-section.active {
            display: block;
        }
    </style>
    <script>
        function showSection(sectionId) {
            var sections = document.querySelectorAll('.content-section');
            sections.forEach(function (section) {
                section.classList.remove('active');
            });
            document.getElementById(sectionId).classList.add('active');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-profile">
        <div class="sidebar">
            <div class="profile">
                <img src="/Content/Images/Icon/user.png" alt="Profile Image" />
                <p>truong1623</p>
                <a href="#" onclick="showSection('edit-profile'); return false;">Edit Profile</a>
            </div>
            <a id="my-account" class="menu-item" href="#" onclick="showSection('my-account-section'); return false;">
                <img src="/Content/Images/Icon/profile-user.png" alt="Icon" />
                <span>My Account</span>
            </a>
            <a id="my-purchase" class="menu-item" href="#" onclick="showSection('my-purchase-section'); return false;">
                <img src="/Content/Images/Icon/order.png" alt="Icon" />
                <span>My Purchase</span>
            </a>
            <a id="notifications" class="menu-item" href="#" onclick="showSection('notifications-section'); return false;">
                <img src="/Content/Images/Icon/notification.png" alt="Icon" />
                <span>Notifications</span>
            </a>
        </div>

        <div class="content">
            <div id="edit-profile" class="content-section">
                <h2>Edit Profile</h2>
                <!-- Add fields for editing user information -->

                <asp:TextBox ID="txtUsername" runat="server" Text="truong1623"></asp:TextBox>
                <asp:Button ID="btnSaveProfile" runat="server" Text="Save" />
            </div>

            <div id="my-account-section" class="content-section">
                <h2>My Account</h2>
                <p>Email: <asp:Label ID="lblEmail" runat="server" Text="user@example.com"></asp:Label></p>
                <p>Password: <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox></p>
                <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" />
            </div>

            <div id="my-purchase-section" class="content-section">
                <h2>My Purchase</h2>
                <asp:DataList ID="dlPurchases" runat="server">
                    <ItemTemplate>
                        <p>Transaction ID: <%# Eval("TransactionID") %></p>
                        <p>Date: <%# Eval("Date") %></p>
                        <p>Amount: <%# Eval("Amount") %></p>
                    </ItemTemplate>
                </asp:DataList>
            </div>

            <div id="notifications-section" class="content-section">
                <h2>Notifications</h2>
                <asp:DataList ID="dlNotifications" runat="server">
                    <ItemTemplate>
                        <p><%# Eval("Message") %></p>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
</asp:Content>
