<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="GroupProject_Ecommerce.ProductDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DataList ID="dl_productDetail" runat="server" CssClass="product-list">
        <ItemTemplate>
            
        </ItemTemplate>
    </asp:DataList>

    
</asp:Content>
