using System;
using System.Data;
using System.Web.UI;
using GroupProject_Ecommerce.Scripts;

namespace GroupProject_Ecommerce
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        DBContext kn = new DBContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProductDetail();
                LoadSimilarProducts();
            }
        }

        private void LoadProductDetail()
        {
            int productId = 1; // For testing, replace with actual logic to get productId

            // Query product details
            string sql = @"
                SELECT Products.*, ProductImages.ImageName 
                FROM Products 
                LEFT JOIN ProductImages ON Products.ProductID = ProductImages.ProductID 
                WHERE Products.ProductID = @ProductId";

            var parameters = new System.Collections.Generic.Dictionary<string, object>();
            parameters.Add("@ProductId", productId);

            var productDetail = kn.GetDataWithParameters(sql, parameters);
            if (productDetail != null && productDetail.Rows.Count > 0)
            {
                dl_productDetail.DataSource = productDetail;
                dl_productDetail.DataBind();
            }
            else
            {
                // Handle case where no product detail found
                Response.Write("Không có dữ liệu cho ProductID = " + productId);
            }
        }

        private void LoadSimilarProducts()
        {
            string productId = "1"; // For testing, replace with actual logic to get productId

            // Query similar products
            string similarProductsSql = @"
                SELECT TOP 4 Products.*, ProductImages.ImageName 
                FROM Products 
                LEFT JOIN ProductImages ON Products.ProductID = ProductImages.ProductID 
                WHERE Products.ProductID != @ProductId
                ORDER BY NEWID()"; // Get random 4 different products

            var parameters = new System.Collections.Generic.Dictionary<string, object>();
            parameters.Add("@ProductId", productId);

            var similarProducts = kn.GetDataWithParameters(similarProductsSql, parameters);
            if (similarProducts != null && similarProducts.Rows.Count > 0)
            {
                dl_similarProducts.DataSource = similarProducts;
                dl_similarProducts.DataBind();
            }
            else
            {
                // Handle case where no similar products found
                Response.Write("Không có dữ liệu cho các sản phẩm tương tự với ProductID = " + productId);
            }
        }
    }
}
