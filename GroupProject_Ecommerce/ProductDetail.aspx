<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="GroupProject_Ecommerce.ProductDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-list img {
            width: 73px;
            height: 62px;
            margin: 5px;
           cursor:pointer;
        }
        
        .product-list .main-image img {
            width: 337px;
            height: 300px;
        }

        .thumbnail-images {
            display: flex;
            flex-wrap: wrap;
            gap: 5px; /* Khoảng cách giữa các hình nhỏ */
            justify-content: space-between; /* Để chia đều khoảng cách */
        }

        .thumbnail-images img {
            max-width: calc(25% - 10px); /* Chia đều 4 hình, trừ khoảng cách */
        }

        .product-details {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
        }

        .product-details .btn-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }

        .product-details .btn-container button {
            margin-left: 10px;
        }

        .similar-products {
            margin-top: 20px;
        }

        .similar-products h3 {
            margin-bottom: 10px;
        }

        .similar-products .product-item {
            width: 23%; /* Để 4 cột sản phẩm */
            margin: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            text-align: center;
        }

        .similar-products .product-item img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .product-name {
            font-weight: bold;
        }

        .product-price {
            color: red;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DataList ID="dl_productDetail" runat="server" CssClass="product-list">
        <ItemTemplate>
            <div style="display: flex; margin-bottom: 20px;">
                <div style="margin-right: 40px;">
                    <div class="main-image">
                        <img src='<%# Eval("MainImage") %>' alt="Main Image">
                    </div>
                    <asp:Repeater ID="rptThumbnails" runat="server" DataSource='<%# Eval("Thumbnails") %>'>
                        <ItemTemplate>
                            <img src='<%# Eval("ThumbnailImage") %>' alt="Thumbnail Image" onclick='updateMainImage("<%# Eval("ThumbnailImage") %>")'>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
                <div style="margin-left: 20px;">
                    <div>
                        <asp:Label ID="LabelProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                    </div>
                    <div style="display: flex; align-items: center; margin-top: 10px;">
                        <asp:Label ID="Label1" runat="server" Text="rating"></asp:Label> <img src="/Content/Images/Icon/star.png" style="height:20px;width:20px;margin-right:5px;" alt="Icon" />|
                        <asp:Label ID="Label2" runat="server" Text="stock" style="margin: 0 5px;"></asp:Label>|
                        <asp:Label ID="Label3" runat="server" Text="soldquanliry"></asp:Label>
                    </div>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="LabelDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                    </div>
                    <div style="background: #eeeeee; color: red; padding: 15px 20px; margin-top: 10px;">
                        <asp:Label ID="LabelPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                    </div>
                    <div style="margin-top: 10px;">
                        Số lượng: <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </div>
                    <div class="btn-container" style="margin-top: 10px;">
                        <asp:Button ID="Button1" runat="server" Text="Thêm vào giỏ hàng" />
                        <asp:Button ID="Button2" runat="server" Text="Mua ngay" />
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <div class="similar-products">
        <h3>Sản phẩm tương tự</h3>
        <asp:DataList ID="dl_similarProducts" runat="server" RepeatColumns="4">
            <ItemTemplate>
                <div class="product-item">
                    <asp:Image ID="SimilarImage" runat="server" ImageUrl='<%# "Content/Images/ProductImages/" + Eval("ImageName") %>' />
                    <asp:Label ID="SimilarProductName" runat="server" Text='<%# Eval("ProductName") %>' CssClass="product-name"></asp:Label><br />
                    Giá: <asp:Label ID="SimilarProductPrice" runat="server" Text='<%# Eval("Price", "{0:C}") %>' CssClass="product-price"></asp:Label>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
    <asp:Label ID="lblNoSimilarProducts" runat="server" Text=""></asp:Label>
    <script>
        function updateMainImage(imageUrl) {
            var mainImage = document.querySelector('.main-image img');
            if (mainImage) {
                mainImage.src = imageUrl;
            }
        }
    </script>
</asp:Content>

