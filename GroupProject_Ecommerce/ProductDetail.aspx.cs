using System;
using System.Web.UI;
using GroupProject_Ecommerce.Scripts;

namespace GroupProject_Ecommerce
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        DBContext kn = new DBContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            string productId = "1"; // Trực tiếp sử dụng ProductID = 1 để test

            // Truy vấn chi tiết sản phẩm
            string sql = $@"
                SELECT Products.*, ProductImages.ImageName 
                FROM Products 
                LEFT JOIN ProductImages ON Products.ProductID = ProductImages.ProductID 
                WHERE Products.ProductID = {productId}";

            var productDetail = kn.GetData(sql);
            if (productDetail != null && productDetail.Rows.Count > 0)
            {
                dl_productDetail.DataSource = productDetail;
                dl_productDetail.DataBind();
            }
            else
            {
                // Log or handle the case where no data is returned
                Response.Write("Không có dữ liệu cho ProductID = 1");
            }

            // Truy vấn các sản phẩm tương tự (ví dụ: chọn 4 sản phẩm ngẫu nhiên khác)
<<<<<<< HEAD
            string similarProductsSql = $@"
                SELECT TOP 4 Products.*, ProductImages.ImageName 
=======
            string similarProductsSql = $@"SELECT TOP 4 Products.*, ProductImages.ImageName 
>>>>>>> 00b3d273786941346b8c5c2a06fc830c9cace4e6
                FROM Products 
                LEFT JOIN ProductImages ON Products.ProductID = ProductImages.ProductID 
                WHERE Products.ProductID != {productId}
                ORDER BY NEWID()"; // Lấy ngẫu nhiên 4 sản phẩm khác

            var similarProducts = kn.GetData(similarProductsSql);
            if (similarProducts != null && similarProducts.Rows.Count > 0)
            {
                dl_similarProducts.DataSource = similarProducts;
                dl_similarProducts.DataBind();
            }
            else
            {
                // Log or handle the case where no data is returned
                Response.Write("Không có dữ liệu cho các sản phẩm tương tự");
            }
        }
    }
}
