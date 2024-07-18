<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="GroupProject_Ecommerce.ProductDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-detail-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .product-list img {
            width: 73px;
            height: 62px;
            margin: 5px;
            cursor: pointer;
        }
        
        .product-list .main-image img {
            width: 337px;
            height: 300px;
            display: block;
            margin: 0 auto;
        }

        .thumbnail-images {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            justify-content: center;
        }

        .thumbnail-images img {
            max-width: calc(25% - 10px);
        }

        .product-details {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            text-align: center;
        }

        .product-details .btn-container {
            display: flex;
            justify-content: center;
            margin-top: 10px;
            flex-wrap: wrap;
        }

        .product-details .btn-container button {
            margin: 10px;
        }

        .similar-products {
            margin-top: 20px;
            text-align: center;
        }

        .similar-products h3 {
            margin-bottom: 10px;
        }

        .similar-products .product-item {
              width: 200px;
            height: 300px;
            margin: 10px auto;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            text-align: center;
            display: inline-block;
        }

        .similar-products .product-item img {
            max-width: 100%;         
            margin-bottom: 10px;
        }

        .product-name {
            font-weight: bold;
        }

        .product-price {
            color: red;
        }
        .simiproduct-Image{
            width: 200px;
            height: 150px;
        }
        .similar-products-list{
            width: 100%;

        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="product-detail-container">
        <asp:DataList ID="dl_productDetail" runat="server" CssClass="product-list">
            <ItemTemplate>
                <div style="display: flex; justify-content: center; margin-bottom: 20px;margin-left: 278px">
                    <div style="margin-right: 40px;">
                        <div class="main-image">
                            <img src='<%# Eval("MainImage")+".jpg" %>' alt="Main Image">
                        </div>
                        <asp:Repeater ID="rptThumbnails" runat="server" DataSource='<%# Eval("Thumbnails") %>'>
                            <ItemTemplate>
                                <img src='<%# Eval("ThumbnailImage")+".jpg" %>' alt="Thumbnail Image" onclick='updateMainImage("<%# Eval("ThumbnailImage")+".jpg" %>")'>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div style="margin-left: 20px; text-align: left;">
                        <div>
                            <asp:Label ID="LabelProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                        </div>
                        <div style="display: flex; align-items: center; margin-top: 10px;">
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("rating") %>'></asp:Label>
                            <img src="/Content/Images/Icon/star.png" style="height:20px;width:20px;margin-right:5px;" alt="Icon" />|
                            Còn <asp:Label ID="Label2" runat="server" Text='<%# Eval("Stock") %>' style="margin: 0 5px;"></asp:Label> sản phẩm |
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("SoldQuantity") %>' style="margin: 0 5px;"></asp:Label>   đã bán
                        </div>
                        <div style="margin-top: 10px;">
                            <asp:Label ID="LabelDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                        </div>
                        <div style="background: #eeeeee; color: red; padding: 15px 20px; margin-top: 10px;">
                            <asp:Label ID="LabelPrice" runat="server" Text='<%# Eval("Price", "{0:C}")%>'></asp:Label>
                        </div>
                        <div style="margin:20px 0px;">
                            Số lượng: <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        </div>
                        <div class="btn-container" style="margin-top: 10px;">
                            <asp:Button ID="Button1" Style="padding:10px;border-radius:5px;cursor:pointer; " runat="server" Text="Thêm vào giỏ hàng" onClick="Button1_Click" />
                           <asp:Button ID="btnBuy" runat="server" Style="padding:10px;border-radius:5px;cursor:pointer;" Text="Buy Now" OnClick="btnBuy_Click" CssClass="buy-button" />

                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        
        <asp:Label ID="lblNoSimilarProducts" runat="server" Text=""></asp:Label>
    </div>
    <div class="product-detail-container" style="margin-top:30px">
        <div class="similar-products">
            <h3>Sản phẩm tương tự</h3>
            <asp:DataList ID="dl_similarProducts" runat="server" class="similar-products-list" RepeatColumns="4">
                <ItemTemplate>
                    <div class="product-item">
                        
                        <asp:ImageButton ID="SimilarImage" class="simiproduct-Image" runat="server"  ImageUrl='<%# "Content/Images/ProductImages/" + Eval("Image")+".jpg" %>' CommandArgument='<%# Eval("ProductID")  %>' onClick="SimilarImageClick"/>
                        <asp:Label ID="SimilarProductName" runat="server" Text='<%# Eval("ProductName") %>' CssClass="product-name"></asp:Label><br />
                        Giá: <asp:Label ID="SimilarProductPrice" runat="server" Text='<%# Eval("Price", "{0:C}") %>' CssClass="product-price"></asp:Label>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            </div>
    </div>
    
    <script>
        function updateMainImage(imageUrl) {
            var mainImage = document.querySelector('.main-image img');
            if (mainImage) {
                mainImage.src = imageUrl;
            }
        }
    </script>
</asp:Content>
