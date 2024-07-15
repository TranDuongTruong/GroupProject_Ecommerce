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
        public DBContext DBContext = new DBContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            if (UserContext.CheckLoginStatus(HttpContext.Current))
            {
                int userID = UserContext.GetCurrentUserId(HttpContext.Current);
                LoadCartItems(userID);
            }
            else
            {
                // Handle the case where the user is not logged in
                Response.Redirect("Login.aspx");
            }
        }
        private void LoadCartItems(int userID)
        {
            string sql = @"
                SELECT 
                    ci.CartItemID,
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
                    u.UserID = "+ userID +";";

            DataTable dt = DBContext.GetData(sql);
            if (dt != null && dt.Rows.Count > 0)
            {
                CartItems.DataSource = dt;
                CartItems.DataBind();
                Checkout.Visible = true;
            }
            else
            {
                Notify.Text = "Không có sản phẩm trong giỏ hàng";
            }
        }

        protected void MinusButton_Click(object sender, EventArgs e)
        {
            int cartItemId = int.Parse(((Button)sender).CommandArgument.ToString());
            int change = -1;

            UpdateQuantity(cartItemId, change);
        }
        protected void PlusButton_Click(object sender, EventArgs e)
        {
            int cartItemId = int.Parse(((Button)sender).CommandArgument.ToString());
            int change = 1;

            UpdateQuantity(cartItemId, change);
        }
        private void UpdateQuantity(int cartItemId, int change)
        {
            string updateQuantitysql = "UPDATE CartItem SET Quantity = Quantity +" + change +" WHERE CartItemID =" + cartItemId;

            int rowsAffected = DBContext.Update(updateQuantitysql);

            if (rowsAffected > 0)
            {
                // SQL query to update price based on quantity
                string updatePriceSql = @"
                    UPDATE CartItem
                    SET Price = p.Price * ci.Quantity
                    FROM CartItem ci
                    INNER JOIN Products p ON ci.ProductID = p.ProductID
                    WHERE ci.CartItemID =" + cartItemId;

                int rowsAffectedPrice = DBContext.Update(updatePriceSql);

                if (rowsAffectedPrice > 0)
                {
                    // Reload the cart items to reflect the updated quantities and prices
                    int userID = UserContext.GetCurrentUserId(HttpContext.Current);
                    LoadCartItems(userID);
                }
                else
                {
                    Notify.Text = "Error updating price.";
                }
            }
            else
            {
                Notify.Text = "Error updating quantity.";
            }
        }
        protected void DeleteButton_Click(object sender, ImageClickEventArgs e)
        {
            int cartItemId = int.Parse(((ImageButton)sender).CommandArgument);

            // SQL query to delete the item from CartItem table
            string deleteSql = "DELETE FROM CartItem WHERE CartItemID =" + cartItemId;

            int rowsAffected = DBContext.Update(deleteSql);

            if (rowsAffected > 0)
            {
                // Reload the cart items to reflect the updated list
                int userID = UserContext.GetCurrentUserId(HttpContext.Current);
                LoadCartItems(userID);
            }
            else
            {
                Notify.Text = "Error deleting item.";
            }
        }

        protected void BuyButton_Click(object sender, EventArgs e)
        {
            List<int> selectedCartItems = new List<int>();

            // Loop through each row in GridView to find selected items
            foreach (GridViewRow row in CartItems.Rows)
            {
                CheckBox checkBox = (CheckBox)row.FindControl("CheckBox1");
                if (checkBox.Checked)
                {
                    ImageButton imageButton = (ImageButton)row.FindControl("Delete");
                    int cartItemId = int.Parse(imageButton.CommandArgument);
                    selectedCartItems.Add(cartItemId);
                }
            }

            if (selectedCartItems.Count > 0)
            {
                // Store selectedCartItems in Session
                Session["SelectedCartItems"] = selectedCartItems;

                // Redirect to Checkout.aspx
                Response.Redirect("Checkout.aspx");
            }
            else
            {
                // No items selected, show alert
                string script = "alert('No items selected.');";
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", script, true);
            }
        }

    }
}
