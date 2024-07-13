using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GroupProject_Ecommerce.Scripts;
using System.Diagnostics;

namespace GroupProject_Ecommerce
{
    public partial class Cart : System.Web.UI.Page
    {
        DBContext DBContext = new DBContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            /*string username = Session["user"] != null ? Session["user"].ToString() : null;*/
            string username = "user1";
            Console.WriteLine(username);    
            if (!string.IsNullOrEmpty(username))
            {
                LoadCartItems(username);
            }
            else
            {
                // Handle the case where the user is not logged in
                Response.Redirect("Login.aspx");
            }
        }
        private void LoadCartItems(string username)
        {
            string sql = @"
                SELECT 
                    p.ProductName,
                    p.Description,
                    ci.Quantity,
                    ci.Price,
                    pi.ImageName
                FROM 
                    Users u
                    INNER JOIN Cart c ON u.UserID = c.UserID
                    INNER JOIN CartItem ci ON c.CartID = ci.CartID
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
                WHERE 
                    u.Username = '"+ username +"';";
            DataTable dt = DBContext.GetData(sql);
            if (dt != null)
            {
                CartItems.DataSource = dt;
                CartItems.DataBind();
            }
            else
            {
                Notify.Text = "Không có sản phẩm trong giỏ hàng";
            }
        }
    }
}
