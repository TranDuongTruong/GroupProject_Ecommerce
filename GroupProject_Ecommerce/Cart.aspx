<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="GroupProject_Ecommerce.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Định dạng cho header của GridView */
        .gridview-header {
            font-weight: bold;
            background-color: #f2f2f2;
            color: #333;
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        /* Định dạng cho từng dòng (row) của GridView */
        .gridview-row {
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        /* Định dạng cho cột hình ảnh trong GridView */
        .gridview-image {
            width: 100px;
            height: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Cart</h1>
    <asp:GridView ID="CartItems" runat="server" CssClass="gridview" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" CssClass="gridview-image" ImageUrl='<%# "Content/Images/ProductImages/"+Eval("ImageName") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" HeaderStyle-CssClass="gridview-header" ItemStyle-CssClass="gridview-row" />
            <asp:BoundField DataField="Description" HeaderText="Description" HeaderStyle-CssClass="gridview-header" ItemStyle-CssClass="gridview-row" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-CssClass="gridview-header" ItemStyle-CssClass="gridview-row" />
            <asp:BoundField DataField="Price" HeaderText="Price" HeaderStyle-CssClass="gridview-header" ItemStyle-CssClass="gridview-row" DataFormatString="{0:C}" />
        </Columns>
    </asp:GridView>

    <asp:Label ID="Notify" runat="server" Text="" />
</asp:Content>
