<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="GroupProject_Ecommerce.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .contact-form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between; /* Dàn trang form và thông tin liên hệ */
        }

        .contact-info {
            flex: 1;
            padding: 20px;
            font-size: 18px;
        }

        .contact-info h2 {
            margin-bottom: 10px;
            color: #333;
        }

        .contact-info p {
            margin-bottom: 20px;
            color: #666;
        }

        .contact-form {
            flex: 2;
            padding: 20px;
        }

        .contact-form h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-group textarea {
            resize: vertical;
            height: 150px;
        }

        .error-message {
            color: red;
            font-size: 14px;
        }

        .btn-submit {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-submit:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contact-form-container">
        <div class="contact-info">
            <h2>Gửi liên hệ tới AppMvc</h2>
            <p>Chúng tôi luôn lắng nghe các ý kiến của bạn!</p>
        </div>
        <div class="contact-form">
            <h2>Liên hệ với chúng tôi</h2>
            
            <div class="form-group">
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Họ Tên"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Phải nhập Họ Tên" ForeColor="Red" CssClass="error-message"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Địa chỉ email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Phải nhập Địa chỉ email" ForeColor="Red" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email không hợp lệ" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$" ForeColor="Red" CssClass="error-message"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Số điện thoại"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Nội dung"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Gửi liên hệ" OnClick="btnSubmit_Click" CssClass="btn-submit" />
            </div>
            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
        </div>
    </div>
</asp:Content>
