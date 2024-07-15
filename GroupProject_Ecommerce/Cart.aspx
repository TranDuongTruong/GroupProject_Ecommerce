<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="GroupProject_Ecommerce.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/css/Cart-Checkout.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Cart</h1>

    <asp:GridView ID="CartItems" runat="server" CssClass="gridview" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# "Content/Images/ProductImages/" + Eval("ImageName") %>' />
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
                        <asp:Button ID="Button1" runat="server" Text="-" CssClass="quantity-button" CommandArgument='<%# Eval("CartItemID") %>' OnClick="MinusButton_Click" Enabled='<%# Convert.ToInt32(Eval("Quantity")) > 1 %>' />
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-textbox" />
                        <asp:Button ID="Button2" runat="server" Text="+" CssClass="quantity-button" CommandArgument='<%# Eval("CartItemID") %>' OnClick="PlusButton_Click" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Price" HeaderText="Price" ItemStyle-CssClass="gridview-row" DataFormatString="{0:C}">
                <HeaderStyle></HeaderStyle>
                <ItemStyle></ItemStyle>
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="Delete" runat="server" CommandArgument='<%# Eval("CartItemID") %>' OnClick="DeleteButton_Click" ImageUrl='<%# "Content/Images/Icon/delete-icon.png" %>' Width="30px"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:LinkButton ID="Checkout" runat="server" CssClass="Checkout" OnClick="BuyButton_Click">Check Out</asp:LinkButton>

    <asp:Label ID="Notify" runat="server" Text="" CssClass="Notify" />
</asp:Content>

