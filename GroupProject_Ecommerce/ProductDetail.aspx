<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="GroupProject_Ecommerce.ProductDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .danhmuc {
            margin-bottom: 30px;
        }
        .image {
            width: 300px;
            height: 300px;
        }
        .button1 {
            background-color: red;
        }
        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 50px;
        }
        .product-table td {
            padding: 10px;
            border: 1px solid #ccc;
            vertical-align: top;
        }
        .similar-products {
            margin-top: 50px;
        }
        .similar-products h3 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
            text-align: center;
        }
        .similar-products .similar-product-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            margin: 10px;
            transition: transform 0.2s;
        }
        .similar-products .similar-product-item:hover {
            transform: scale(1.05);
        }
        .similar-products .similar-product-item img {
            width: 150px;
            height: 150px;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .similar-products .similar-product-item label {
            text-align: center;
            font-size: 14px;
            color: #555;
        }
        .similar-products .similar-product-item .product-name {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .similar-products .similar-product-item .product-price {
            color: #e74c3c;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DataList ID="dl_productDetail" runat="server" CssClass="product-list">
        <ItemTemplate>
            <table class="product-table">
                <tr>
                    <td rowspan="7">
                        <asp:Image ID="Image1" runat="server" CssClass="image" ImageUrl='<%# "Content/Images/ProductImages/" + Eval("ImageName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Mô tả: <asp:Label ID="Label2" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
<<<<<<< HEAD
                    <td>
                        Giá: <asp:Label ID="Label3" runat="server" Text='<%# Eval("Price", "{0:C}") %>'></asp:Label>
=======
                    <td>Giá: <asp:Label ID="Label3" runat="server" Text='<%# Eval("Price", "{0:C}") %>'></asp:Label>
>>>>>>> 00b3d273786941346b8c5c2a06fc830c9cace4e6
                    </td>
                </tr>
                <tr>
                    <td>
                        Còn: <asp:Label ID="Label4" runat="server" Text='<%# Eval("Stock") %>'></asp:Label> sản phẩm
                    </td>
                </tr>
                <tr>
                    <td>
                        Đánh giá: <asp:Label ID="Label5" runat="server" Text='<%# Eval("Rating") %>'></asp:Label> sao
                    </td>
                </tr>
                <tr>
                    <td>
                        Đã bán: <asp:Label ID="Label6" runat="server" Text='<%# Eval("SoldQuantity") %>'></asp:Label> sản phẩm
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>

    <div class="similar-products">
        <h3>Sản phẩm tương tự</h3>
        <asp:DataList ID="dl_similarProducts" runat="server" RepeatColumns="4">
            <ItemTemplate>
                <div class="similar-product-item">
                    <asp:Image ID="SimilarImage" runat="server" ImageUrl='<%# "Content/Images/ProductImages/" + Eval("ImageName") %>' />
                    <asp:Label ID="SimilarProductName" runat="server" Text='<%# Eval("ProductName") %>' CssClass="product-name"></asp:Label><br />
                    Giá: <asp:Label ID="SimilarProductPrice" runat="server" Text='<%# Eval("Price", "{0:C}") %>' CssClass="product-price"></asp:Label>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
<<<<<<< HEAD
</asp:Content>
=======
</asp:Content>
>>>>>>> 00b3d273786941346b8c5c2a06fc830c9cace4e6
