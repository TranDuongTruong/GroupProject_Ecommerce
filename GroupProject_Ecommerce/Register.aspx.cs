using System;
using System.Web.UI;
using GroupProject_Ecommerce.Scripts;

namespace GroupProject_Ecommerce
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtUsername.Text;
                string password = txtPassword.Text;
                string email = txtEmail.Text;
                string displayName = txtDisplayName.Text;
                string address = txtAddress.Text;
                string phoneNumber = txtPhoneNumber.Text;
                string gender = ddlGender.SelectedValue;

                string query = $"INSERT INTO Users (Username, Password, Email, DisplayName, Address, PhoneNumber, Gender) " +
                               $"VALUES ('{username}', '{password}', '{email}', '{displayName}', '{address}', '{phoneNumber}', '{gender}')";

                DBContext dbContext = new DBContext();
                int result = dbContext.ExecuteCommand(query);

                if (result > 0)
                {
                    lblMessage.Text = "Registration successful!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblMessage.Text = "Registration failed. Please try again.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
