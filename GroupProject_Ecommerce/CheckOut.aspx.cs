using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GroupProject_Ecommerce.Scripts;

namespace GroupProject_Ecommerce
{
    public partial class CheckOut : System.Web.UI.Page
    {
        public DBContext dbContext = new DBContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            // Kiểm tra xem Session có tồn tại và có chứa danh sách các CartItemID hay không
            if (Session["SelectedCartItems"] != null && Session["SelectedCartItems"] is List<int>)
            {
                List<int> selectedCartItems = (List<int>)Session["SelectedCartItems"];

                LoadOrderItems(selectedCartItems);

                // Sau khi hoàn thành xử lý, bạn có thể xóa Session để không lưu trữ nữa
                Session.Remove("SelectedCartItems");


            }
        }
        private void LoadOrderItems(List<int> cartItemIds)
        {
            // Tạo câu truy vấn SQL để lấy thông tin chi tiết của các CartItemID từ Database
            string cartItemIdsStr = string.Join(",", cartItemIds);
            string sql = @"
                SELECT 
                    ci.CartItemID,
                    p.ProductID,
                    p.ProductName,
                    p.Description,
                    ci.Quantity,
                    ci.Price,
                    pi.ImageName,
                    s.ShopID
                FROM 
                    CartItem ci
                    INNER JOIN Products p ON ci.ProductID = p.ProductID
                    LEFT JOIN (
                        SELECT 
                            ProductID, 
                            MIN(ProductImageID) AS ProductImageID 
                        FROM 
                            ProductImages 
                        GROUP BY 
                            ProductID
                    ) pi_min ON p.ProductID = pi_min.ProductID
                    LEFT JOIN ProductImages pi ON pi_min.ProductImageID = pi.ProductImageID
                    LEFT JOIN Shops s ON p.ShopID = s.ShopID
                WHERE 
                    ci.CartItemID IN (" + cartItemIdsStr + ");";

            // Thực hiện truy vấn và lấy dữ liệu vào DataTable
            DataTable dt = dbContext.GetData(sql);

            // Bind dữ liệu lên GridView
            if (dt != null && dt.Rows.Count > 0)
            {
                OrderItems.DataSource = dt;
                OrderItems.DataBind();

                // Thêm dữ liệu vào bảng Transactions
                foreach (DataRow row in dt.Rows)
                {
                    int productId = int.Parse(row["ProductID"].ToString());
                    int shopId = int.Parse(row["ShopID"].ToString());
                    int quantity = int.Parse(row["Quantity"].ToString());
                    double price = double.Parse(row["Price"].ToString());

                    AddTransaction(productId, shopId, quantity, price);
                }
                DeleteCheckedOutCartItems(cartItemIdsStr);
            }
        }
        private void AddTransaction(int productId, int shopId, int quantity, double price)
        {
            int userID = UserContext.GetCurrentUserId(HttpContext.Current);
            // Lấy ngày và giờ hiện tại
            DateTime transactionDate = DateTime.Now;

            string price1 = price.ToString(CultureInfo.InvariantCulture);

            // Tạo câu truy vấn SQL để thêm dữ liệu vào bảng Transactions
            string sql = $@"
                INSERT INTO Transactions (ProductID, ShopID, Quantity, Price, TransactionDate, UserID)
                VALUES ({productId}, {shopId}, {quantity}, {price1}, '{transactionDate.ToString("yyyy-MM-dd HH:mm")}', {userID})";

            // Thực thi câu truy vấn
            dbContext.ExecuteCommand(sql);
        }

        private void DeleteCheckedOutCartItems(string cartItemIdsStr)
        {
            // Tạo câu truy vấn SQL để xóa các mục CartItem đã checkout
            string sql = $@"
                DELETE FROM CartItem
                WHERE CartItemID IN ({cartItemIdsStr});";

            // Thực thi câu truy vấn
            dbContext.ExecuteCommand(sql);
        }

    }
}