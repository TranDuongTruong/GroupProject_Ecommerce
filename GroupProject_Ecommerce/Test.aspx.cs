using GroupProject_Ecommerce.Scripts.Models;
using GroupProject_Ecommerce.Scripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GroupProject_Ecommerce
{
    public partial class Test : System.Web.UI.Page
    {
        DBContext dBContext = new DBContext();
        UserViewModel user;
        public static string ImageName { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (!UserContext.CheckLoginStatus(HttpContext.Current))
            {
                Response.Redirect("Login.aspx");
            }



            //  if (!UserContext.CheckLoginStatus(HttpContext.Current)) return;
            int userId = UserContext.GetCurrentUserId(HttpContext.Current);
            // userId = ;
            string sql = "select * from Users where UserID =" + userId;
            user = dBContext.GetObjectByQuery<UserViewModel>(sql);

            if (user != null)
            {
                ImageName = user.Avatar.ToString();
                Image1.ImageUrl = "Content/Images/AvatarOfUser/" + user.Avatar;
                UserName.Text = user.DisplayName.ToString();
                txtDisplayName.Text = user.DisplayName.ToString();
                txtPhoneNumber.Text = (user.PhoneNumber != null) ? user.PhoneNumber.ToString() : "Unknow";
                txtAddress.Text = (user.PhoneNumber != null) ? user.Address.ToString() : "Unknow";
                UpdateImage.ImageUrl = "Content/Images/AvatarOfUser/" + user.Avatar;
                txtEmail.Text = user.Email.ToString();

                if (user.Gender == 0)
                {
                    rbMale.Checked = true;
                }
                else if (user.Gender == 1)
                {
                    rbFemale.Checked = true;

                }
                else rbOther.Checked = true;
              
            }


        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    // Get the file extension
                    string fileExtension = Path.GetExtension(fileUpload.FileName).ToLower();
                    // Validate the file extension
                    if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif")
                    {
                        // Define the path to save the uploaded file
                        string savePath = Server.MapPath("~/Content/Images/AvatarOfUser/") + fileUpload.FileName;


                        // Save the file to sever
                        ImageName = fileUpload.FileName;
                        fileUpload.SaveAs(savePath);
                        // Update the image control to show the newly uploaded image
                        UpdateImage.ImageUrl = "Content/Images/AvatarOfUser/" + fileUpload.FileName;


                    }
                    else
                    {
                        // Display an error message for invalid file types
                        Response.Write("Only images (.jpg, .png, .gif) can be uploaded.");
                    }
                }
                catch (Exception ex)
                {
                    // Handle the exception
                    Response.Write("File upload failed: " + ex.Message);
                }
            }
            else
            {
                // Display a message when no file is selected
                Response.Write("Please select a file to upload.");
            }

        }
       

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string name = txtDisplayName.Text;
            string email = txtEmail.Text;
            string phoneNumber = txtPhoneNumber.Text;
            string address = txtAddress.Text;
            int gender = 3;

            if (rbMale.Checked)
            {
                gender = 0;
            }
            else if (rbFemale.Checked)
            {
                gender = 1;
            }


            //Update DB
            string sql = "UPDATE Users SET    Username = '" + username + "', DisplayName = '" + name + "', Email='" + email + "',PhoneNumber=' " + phoneNumber + "',Address='" + address + "', Gender='" + gender + "',Avatar='," + ImageName + "'  WHERE UserID = " + UserContext.GetCurrentUserId(HttpContext.Current);

            //string sql = "UPDATE Users SET    Username = '" + username + "', DisplayName = '" + name + "', Email='" + email + "',PhoneNumber=' " + phoneNumber + "',Address='" + address + "', Avatar='" + ImageName + "', Gender=" + gender + "  WHERE UserID = 1";

            //Update DB
            //string sql = "update Users set Avatar = '" + fileUpload.FileName + "' where UserID =" + UserContext.GetCurrentUserId(HttpContext.Current);
            int result = dBContext.ExecuteCommand(sql);
            if (result == 0)
            {
                Response.Write("There is a error with database");
                return;

            }
            else
            {
                Response.Write("Profile updated successfully!");
                txtUsername.Text = username.ToString();
                txtDisplayName.Text = name.ToString();
                txtEmail.Text = email.ToString();
                txtPhoneNumber.Text = phoneNumber.ToString();
                txtAddress.Text = address.ToString();
                if (gender == 0)
                {
                    rbMale.Checked = true;
                }
                else if (gender == 1)
                {
                    rbFemale.Checked = true;

                }
                else rbOther.Checked = true;
            }


        }

       

        }

    }