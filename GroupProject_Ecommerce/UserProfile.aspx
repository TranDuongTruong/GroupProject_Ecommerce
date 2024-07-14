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
             display: flex;
             flex-direction: column;
             flex-wrap: wrap;
             align-content: space-around;
             justify-content: space-between;
        }
        .content-section {
            display: none;
        }
        .content-section.active {
            display: block;
        }
         .container-profile {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 20px;
        }
        .column {
            flex: 1;
            margin-right: 20px;
        }
        .column:last-child {
            margin-right: 0;
        }
        .form-group {
        display: flex;
        justify-content: flex-start; /* Align items to the left */
        align-items: center; /* Center items vertically */
        margin-bottom: 10px;        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .avatar-container {
            position: relative;
            display: inline-block;
             position: relative;
        width: 100%;
        max-width: 500px; /* Giới hạn kích thước tối đa */
        height: auto;
        margin-top: 20px;
        }
         .avatar-container img {
        width: 100%;
        height: auto;
        display: block;
    }
        .avatar-container:hover .overlay {
            opacity: 1;
        }
        .avatar-container:hover img {
            opacity: 0.7;
        }

        .overlay {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            height: 100%;
            width: 100%;
            opacity: 0;
            transition: .3s ease;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 20px;
        }
        .file-input {
            display: none;
        }
         .editLabel {
        width: 150px; /* Set a fixed width for labels */
        text-align: right;
        margin-right: 10px; /* Add some space between the label and the input */
    }
    .editInput {
        width: 300px; /* Set a fixed width for input fields */
    }
    .form-group.inline {
        display: flex;
        justify-content: flex-start; /* Align items to the left */
    }
    .form-group.inline > * {
        margin-right: 10px; /* Add some space between inline items */
    }
    .form-group.inline label {
        margin-right: 0; /* Remove right margin from inline labels */
    }

      .content-section {
            margin: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            text-align: center;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 10px;
        }

        .modal-title {
            margin: 0;
            font-size: 1.25rem;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-body {
            padding: 10px 0;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            border-top: 1px solid #e5e5e5;
            padding-top: 10px;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            text-align: center;
            margin-left: 10px;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }
        #btnChangePassword{
            color: blue;
            text-decoration: underline;
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
        function showFileDialog() {
            document.getElementById('<%= fileUpload.ClientID %>').click();

        }
        function autoUpload() {
            document.getElementById('<%= btnUpload.ClientID %>').click();
         
        }
        function showChangePasswordModal() {
            document.getElementById('changePasswordModal').style.display = 'block';
        }

        function closeChangePasswordModal() {
            document.getElementById('changePasswordModal').style.display = 'none';
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-profile">
        <div class="sidebar">
            <div class="profile">
                <asp:Image ID="Image1"  runat="server" />
                <br />
                <asp:Label ID="UserName" runat="server" >truong1623</asp:Label>
                 <br />
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
                 <div class="container-profile">
        <div class="column">
            <!-- Add fields for editing user information -->
             <div class="form-group">
        <asp:Label ID="Label1" Class="editLabel" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox ID="txtUsername"  Class="editInput" runat="server" Text="truong1623"></asp:TextBox>
    </div>
    <div class="form-group">
        <asp:Label ID="Label2" Class="editLabel" runat="server" Text="Name: "></asp:Label>
        <asp:TextBox ID="txtDisplayName" Class="editInput" runat="server"></asp:TextBox>
    </div>
    <div class="form-group">
        <asp:Label ID="Label3" Class="editLabel" runat="server" Text="Email: "></asp:Label>
        <asp:TextBox ID="txtEmail" Class="editInput" runat="server"></asp:TextBox>
    </div>
    <div class="form-group">
        <asp:Label ID="Label4" Class="editLabel" runat="server" Text="Phone Number: "></asp:Label>
        <asp:TextBox ID="txtPhoneNumber" Class="editInput" runat="server"></asp:TextBox>
    </div>
             <div class="form-group">
     <asp:Label ID="Label7" Class="editLabel" runat="server" Text="Address: "></asp:Label>
     <asp:TextBox ID="txtAddress" Class="editInput" runat="server"></asp:TextBox>
 </div>
    <div class="form-group inline">
        <asp:Label ID="Label5" Class="editLabel" runat="server" Text="Gender: "></asp:Label>
        <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" />
        <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" />
        <asp:RadioButton ID="rbOther" runat="server" GroupName="Gender" Text="Other" />
    </div>
   
        </div>
        <div class="column">
             <div class="avatar-container" onclick="showFileDialog()" >
                <asp:Image ID="UpdateImage" runat="server" />
                <div class="overlay">Change Avatar</div>
            </div>
             <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-input" onchange="autoUpload()"/>
             <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" Style="display:none;" />
     
        </div>
    </div>

                <br />
                <asp:Button ID="btnSaveProfile" runat="server" Text="Save" onClick="btnSaveProfile_Click"/>
            </div>

            <div id="my-account-section" class="content-section">
                <h2>My Account</h2>
                <p>Email: <asp:Label ID="lblEmail" runat="server" Text="user@example.com"></asp:Label></p>
                <p>Password:  <asp:Label ID="txtPassword" runat="server" Text="Label"></asp:Label></p>
                <a ID="btnChangePassword"  OnClick=" showChangePasswordModal()" >Change Password</a>




            </div>
            
                    <!-- Change Password Modal -->
        <!-- Change Password Modal -->
            <div id="changePasswordModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Change Password</h5>
                    <span class="close" onclick="closeChangePasswordModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                          <br />
                        <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="Current password is required." CssClass="validation-error" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="New password is required." CssClass="validation-error" Display="Dynamic" />
                       <br />
                        <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Password must be at least 5 characters long." CssClass="validation-error" Display="Dynamic" ValidationExpression="^.{5,}$" />
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                           <br />
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm password is required." CssClass="validation-error" Display="Dynamic" />
                        <asp:CompareValidator ID="cvPasswords" runat="server" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match." CssClass="validation-error" Display="Dynamic" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSubmitPasswordChange" runat="server" Text="Submit" CssClass="btn-primary" OnClick="btnSubmitPasswordChange_Click" />
                    <button type="button" class="btn-secondary" onclick="closeChangePasswordModal()">Close</button>
                </div>
            </div>
        </div>




            <div id="my-purchase-section" class="content-section active">
          <h2>My Purchase</h2>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
            <Columns>
            <asp:BoundField DataField="TransactionID" HeaderText="Mã giao dịch" />
            <asp:TemplateField HeaderText="Sản phẩm">
                <ItemTemplate>
                    <asp:Image ID="productImage" runat="server" ImageUrl='<%# Eval("ImageName", "~/Content/Images/ProductImages/{0}") %>' />
                    <br />
                    <asp:Label ID="ProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />
            <asp:BoundField DataField="TransactionDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ngày mua" />
        </Columns>
    </asp:GridView>
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
