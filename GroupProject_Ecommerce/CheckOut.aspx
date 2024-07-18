<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="GroupProject_Ecommerce.CheckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/css/Cart-Checkout.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Cảm ơn đã mua hàng</h1>
    <asp:GridView ID="OrderItems" runat="server" CssClass="gridview" AutoGenerateColumns="False">
    <Columns>
        <asp:TemplateField HeaderText="Image">
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "Content/Images/ProductImages/" + Eval("ImageName")+".jpg" %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="ProductName" HeaderText="Product Name" ItemStyle-CssClass="gridview-row">
            <HeaderStyle CssClass="gridview-header"></HeaderStyle>
            <ItemStyle></ItemStyle>
        </asp:BoundField>
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:TemplateField HeaderText="Quantity">
            <ItemTemplate>
                <div class="quantity-controls">
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-textbox" />
                </div>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Price" HeaderText="Price" ItemStyle-CssClass="gridview-row" DataFormatString="{0:C}">
            <HeaderStyle></HeaderStyle>
            <ItemStyle></ItemStyle>
        </asp:BoundField>
    </Columns>
</asp:GridView>
</asp:Content>
