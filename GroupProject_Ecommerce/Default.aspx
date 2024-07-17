<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GroupProject_Ecommerce.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Categories */
        .categories-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .categories-container div {
            margin: 10px 0;
        }

        .categories-container a {
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
        }

        .categories-container a:hover {
            text-decoration: underline;
        }

        /* Products Container */
        .products-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        /* Product Item */
        .product-item {
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            flex: 1 1 calc(33.333% - 10px); /* 3 products per row with a 10px gap */
            box-sizing: border-box;
        }

        .product-item h3 {
            margin: 0 0 10px;
            font-size: 1.5em;
            color: #333;
        }

        .product-item p {
            margin: 5px 0;
            color: #666;
        }

        .product-item p.price {
            font-size: 1.2em;
            color: #000;
        }

        .product-item p.stock {
            font-size: 1em;
            color: #888;
        }

        .product-item p.rating {
            font-size: 1em;
            color: #ffa500;
        }

        /* Pagination */
        .pagination {
            margin: 20px 0;
            text-align: center;
        }

        .pagination a {
            padding: 5px 10px;
            margin: 0 5px;
            border: 1px solid #ddd;
            background-color: #f8f8f8;
            text-decoration: none;
            cursor: pointer;
        }

        .pagination a:hover {
            background-color: #e0e0e0;
        }

        .pagination a[disabled] {
            background-color: #f0f0f0;
            cursor: not-allowed;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Home Page</h1>
    <h2>Categories</h2>
    <div class="categories-container">
        <asp:Repeater ID="rptCategories" runat="server" OnItemCommand="rptCategories_ItemCommand">
            <ItemTemplate>
                <div>
                    <asp:LinkButton ID="lnkCategory" runat="server" CommandName="SelectCategory" CommandArgument='<%# Eval("CategoryID") %>'>
                        <%# Eval("CategoryName") %>
                    </asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <h2>Products</h2>
    <div class="products-container">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="product-item">
                    <h3><%# Eval("ProductName") %></h3>
                   <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%# Eval("ProductID")  %>' OnClick="ImageButton1_Click" ImageUrl='<%# "images/"+Eval("Image") %>' alt='<%# Eval("ProductName") %>' style="height: 200px;" />

                    <p><%# Eval("Description") %></p>
                    <p class="price">Price: <%# Eval("Price", "{0:C}") %></p>
                    <p class="stock">Stock: <%# Eval("Stock") %></p>
                    <p class="rating">Rating: <%# Eval("Rating") %></p>
                    <p class="sold_quantity">Sold Quantity: <%# Eval("SoldQuantity") %></p>

                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="pagination">
        <asp:LinkButton ID="lnkPrev" runat="server" OnCommand="Page_Command" CommandArgument="Prev">Previous</asp:LinkButton>
        <asp:Label ID="lblPageInfo" runat="server" Text="Page 1" />
        <asp:LinkButton ID="lnkNext" runat="server" OnCommand="Page_Command" CommandArgument="Next">Next</asp:LinkButton>
    </div>
</asp:Content>
