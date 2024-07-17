using System;
using System.Data.SqlClient;
using GroupProject_Ecommerce.Scripts;

namespace GroupProject_Ecommerce
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                // Check if user is logged in
                if (Session["userId"] == null)
                {
                    // Redirect to login page if not logged in
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Get user ID from session
                int userId = Convert.ToInt32(Session["userId"]);
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string message = txtMessage.Text.Trim();
                DateTime sentDate = DateTime.Now;

                string sql = "INSERT INTO ContactMessages (UserID, Subject, Message, SentDate) VALUES (@UserID, @Subject, @Message, @SentDate)";

                DBContext dbContext = new DBContext();
                SqlCommand cmd = new SqlCommand(sql);
                cmd.Parameters.AddWithValue("@UserID", userId);  // Use userId from session
                cmd.Parameters.AddWithValue("@Subject", fullName + " - " + email);
                cmd.Parameters.AddWithValue("@Message", message);
                cmd.Parameters.AddWithValue("@SentDate", sentDate);

                int result = dbContext.ExecuteCommand(cmd);
                if (result > 0)
                {
                    lblMessage.Text = "Gửi liên hệ thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblMessage.Text = "Đã có lỗi xảy ra, vui lòng thử lại.";
                }
            }
        }
    }
}
