using System;
using System.Data;
using System.Web.UI;
using GroupProject_Ecommerce.Scripts;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace GroupProject_Ecommerce
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        DBContext kn = new DBContext();
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Lấy productId từ QueryString
                string productId = Request.QueryString["productId"] ?? "1";
                Session["ProductId"] = productId; // Lưu productId vào session để sử dụng khi mua hàng

                // Lấy ShopID cho sản phẩm từ cơ sở dữ liệu
                int shopIdToTest = GetShopIdForProduct(productId);

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

                // Lấy ảnh chính và ảnh thumbnail của sản phẩm
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
                string sqlSimilarProducts = "SELECT TOP 8 ProductID, ProductName, Image, Price FROM Products WHERE ShopID = @ShopID AND ProductID <> @ProductID ORDER BY NEWID()";
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

        private int GetShopIdForProduct(string productId)
        {
            // Thực hiện truy vấn để lấy ShopID từ cơ sở dữ liệu
            string sqlGetShopId = "SELECT ShopID FROM Products WHERE ProductID = @ProductID";

            var parameters = new Dictionary<string, object>
            {
                { "@ProductID", productId }
            };

            DataTable dt = kn.GetDataWithParameters(sqlGetShopId, parameters);

            if (dt != null && dt.Rows.Count > 0)
            {
                return Convert.ToInt32(dt.Rows[0]["ShopID"]);
            }

            // Trường hợp không tìm thấy hoặc xử lý khác
            return 1; // Giá trị mặc định hoặc xử lý khác theo logic của bạn
        }

        protected void btnBuy_Click(object sender, EventArgs e)
        {
            // Lấy thông tin sản phẩm từ Session
            Button btn = (Button)sender;
            DataListItem item = (DataListItem)btn.NamingContainer;

            Label lblProductName = (Label)item.FindControl("LabelProductName");
            Label lblPrice = (Label)item.FindControl("LabelPrice");
            string priceText = lblPrice.Text.Replace("$", "").Replace("VND", "").Trim(); // Thay thế ký hiệu tiền tệ
            TextBox txtQuantity = (TextBox)item.FindControl("TextBox1");
            string productId = Session["ProductId"]?.ToString();
            // Parse necessary values
            string productName = lblProductName.Text;
            decimal price = Decimal.Parse(priceText);
         
            int quantity = txtQuantity.Text==null?1:Int32.Parse(txtQuantity.Text);
            price *= quantity;

            // Thêm sản phẩm vào giỏ hàng (hoặc bảng Cart)
            if (UserContext.CheckLoginStatus(HttpContext.Current))
            {
                int userID = UserContext.GetCurrentUserId(HttpContext.Current);
                List<int> selectedCartItems = new List<int>();
                // Thêm sản phẩm vào giỏ hàng
                AddToCart(userID, int.Parse(productId), productName, price, quantity,true);
                int cartID= GetCartID(userID);
                string sql = @"Select CartItemID from CartItem where CartID=" + cartID + " AND ProductID =" + int.Parse(productId) + " AND Quantity =" + quantity;
                DataTable dt2 = kn.GetData(sql);

                if (dt2.Rows.Count > 0)
                {
                  int CartItemID= Convert.ToInt32(dt2.Rows[0]["CartItemID"]);
                    selectedCartItems.Add(CartItemID);

                }
                if (selectedCartItems.Count > 0)
                {
                    // Store selectedCartItems in Session
                    Session["SelectedCartItems"] = selectedCartItems;

                    // Redirect to Checkout.aspx
                    Response.Redirect("Checkout.aspx");
                }

              
            }
            else
            {
                // Nếu người dùng chưa đăng nhập, chuyển hướng tới trang đăng nhập
                Response.Redirect("Login.aspx");
            }
        }
      public int GetCartID(int userID)
        {
            int cartID = 0;
            string sql = "SELECT CartID FROM Cart WHERE UserID =" + userID;

            DataTable dt = kn.GetData(sql);

            if (dt.Rows.Count > 0)
            {
                cartID = Convert.ToInt32(dt.Rows[0]["CartID"]);

            }
            else
            {

                string sqlCreateNewCart = @"
  
                 INSERT INTO Cart (UserID)
                 VALUES (
                       " + userID + @"
                     )";

                SqlCommand cmd1 = new SqlCommand(sqlCreateNewCart);

                int result = kn.ExecuteCommand(cmd1);
                if (result > 0)
                {
                    string sql2 = "SELECT CartID FROM Cart WHERE UserID =" + userID;

                    DataTable dt2 = kn.GetData(sql);

                    if (dt2.Rows.Count > 0)
                    {
                        cartID = Convert.ToInt32(dt2.Rows[0]["CartID"]);

                    }
                }
            }
            return cartID;
        }
        private void AddToCart(int userID, int productId, string productName, decimal price, int quantity,bool buy=false)
        {
            

            if (!UserContext.CheckLoginStatus(HttpContext.Current))
            {
                Response.Redirect("Login.aspx");
                return;
            }
            int cartID = GetCartID(userID);
            string checkCartItem = @"SELECT CartItemID, Quantity FROM CartItem WHERE ProductID = " + productId + " AND CartID = " + cartID;
            DataTable dt3 = kn.GetData(checkCartItem);
            string sqlAddToCart = "";
            if (dt3.Rows.Count > 0 && buy==false)
            {

                int currentQuantity = Convert.ToInt32(dt3.Rows[0]["Quantity"]);
                int newQuantity = currentQuantity + quantity;

                sqlAddToCart = @"
        UPDATE CartItem
        SET Quantity = " + newQuantity + @",
            Price = " + price + @"
        WHERE ProductID = " + productId + " AND CartID = " + cartID;

            }
            else
            {

           

            // Thực hiện câu lệnh SQL hoặc gọi phương thức từ DBContext để thêm sản phẩm vào giỏ hàng của người dùng
             sqlAddToCart = @"
  
    INSERT INTO CartItem (CartID, ProductID, Quantity, Price)
    VALUES (
        " + cartID + @", 
        " + productId + @", 
        " + quantity + @", 
        " + price + @"
    )";
 }
            // Thực thi câu lệnh SQL bằng cách sử dụng DBContext
            SqlCommand cmd = new SqlCommand(sqlAddToCart);
            int rowsAffected = kn.ExecuteCommand(cmd);

            if (rowsAffected > 0)
            {
                // Thành công, có thể hiển thị thông báo hoặc thực hiện các hành động khác
                Console.WriteLine("Product added to cart successfully.");
            }
            else
            {
                // Xử lý khi thêm sản phẩm vào giỏ hàng không thành công
                Console.WriteLine("Failed to add product to cart.");
            }
        }
        protected void SimilarImageClick(object sender, EventArgs e)
        {
            string productId = ((ImageButton)sender).CommandArgument;
            Response.Redirect("ProductDetail.aspx?productId=" + productId);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            DataListItem item = (DataListItem)btn.NamingContainer;

            Label lblProductName = (Label)item.FindControl("LabelProductName");
            Label lblPrice = (Label)item.FindControl("LabelPrice");
            string priceText = lblPrice.Text.Replace("$", "").Replace("VND", "").Trim(); // Thay thế ký hiệu tiền tệ
            TextBox txtQuantity = (TextBox)item.FindControl("TextBox1");
            string productId = Session["ProductId"]?.ToString();
            // Parse necessary values
            string productName = lblProductName.Text;
            decimal price = Decimal.Parse(priceText);
            
            int quantity = Int32.Parse(txtQuantity.Text);
            price *= quantity;
            AddToCart(UserContext.GetCurrentUserId(HttpContext.Current), int.Parse(productId),productName, price, quantity);


            Response.Redirect("~/Cart.aspx"); // Redirect to cart page after adding item
        }
    }
}
