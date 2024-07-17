using System;
using System.Data;
using System.Web.UI;
using GroupProject_Ecommerce.Scripts;
using System.Collections.Generic;
using System.Linq;

namespace GroupProject_Ecommerce
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        DBContext kn = new DBContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Thiết lập ProductID mặc định là 1
            string productId = "1";

            // ShopID mẫu để test
            int shopIdToTest = 1; // Thay thế bằng ShopID cụ thể của bạn

            // Lấy chi tiết sản phẩm từ cơ sở dữ liệu
            string sqlProductDetail = @"
        SELECT 
            p.ProductName, 
            p.Description, 
            p.Price, 
            p.Stock, 
            p.Rating, 
            p.SoldQuantity
        FROM 
            Products p
        WHERE 
            p.ProductID = @ProductID";

            // Tham số cho truy vấn
            var parametersDetail = new Dictionary<string, object>
    {
        { "@ProductID", productId }
    };

            // Lấy dữ liệu chi tiết sản phẩm
            DataTable dtProductDetail = kn.GetDataWithParameters(sqlProductDetail, parametersDetail);

            // Lấy ảnh chính và ảnh thumbnail
            string sqlMainImage = "SELECT TOP 1 ImageName AS MainImage FROM ProductImages WHERE ProductID = @ProductID ORDER BY ProductImageID";
            string sqlThumbnails = "SELECT ImageName AS ThumbnailImage FROM ProductImages WHERE ProductID = @ProductID";

            // Tham số cho các truy vấn ảnh
            var parametersImages = new Dictionary<string, object>
    {
        { "@ProductID", productId }
    };

            DataTable dtMainImage = kn.GetDataWithParameters(sqlMainImage, parametersImages);
            DataTable dtThumbnails = kn.GetDataWithParameters(sqlThumbnails, parametersImages);

            // Lấy danh sách sản phẩm tương tự từ cùng một cửa hàng
            string sqlSimilarProducts = "SELECT TOP 8 ProductName, Price FROM Products WHERE ShopID = @ShopID AND ProductID <> @ProductID ORDER BY NEWID()";
            var parametersSimilar = new Dictionary<string, object>
    {
        { "@ShopID", shopIdToTest },
        { "@ProductID", productId }
    };

            DataTable dtSimilarProducts = kn.GetDataWithParameters(sqlSimilarProducts, parametersSimilar);

            if (dtProductDetail != null && dtMainImage != null && dtThumbnails != null &&
                dtProductDetail.Rows.Count > 0 && dtMainImage.Rows.Count > 0 && dtThumbnails.Rows.Count > 0)
            {
                var productDetail = new
                {
                    ProductName = dtProductDetail.Rows[0]["ProductName"].ToString(),
                    Description = dtProductDetail.Rows[0]["Description"].ToString(),
                    Price = (decimal)dtProductDetail.Rows[0]["Price"],
                    Stock = Convert.ToInt32(dtProductDetail.Rows[0]["Stock"]),
                    Rating = Convert.ToDouble(dtProductDetail.Rows[0]["Rating"]),
                    SoldQuantity = Convert.ToInt32(dtProductDetail.Rows[0]["SoldQuantity"]),
                    MainImage = "/Content/Images/ProductImages/" + dtMainImage.Rows[0]["MainImage"].ToString(),
                    Thumbnails = dtThumbnails.AsEnumerable().Select(row => new { ThumbnailImage = "/Content/Images/ProductImages/" + row["ThumbnailImage"].ToString() }).ToList()
                };

                dl_productDetail.DataSource = new[] { productDetail };
                dl_productDetail.DataBind();

                // Gán dữ liệu cho danh sách sản phẩm tương tự
                if (dtSimilarProducts != null && dtSimilarProducts.Rows.Count > 0)
                {
                    dl_similarProducts.DataSource = dtSimilarProducts;
                    dl_similarProducts.DataBind();
                }
                else
                {
                    // Hiển thị thông báo nếu không có sản phẩm tương tự
                    dl_similarProducts.Visible = false; // Ẩn danh sách sản phẩm tương tự
                    lblNoSimilarProducts.Visible = true; // Hiển thị thông báo
                }
            }
            else
            {
                // Xử lý trường hợp không có dữ liệu
                Console.WriteLine("No data found for ProductID = " + productId);
            }
        }





    }
}
