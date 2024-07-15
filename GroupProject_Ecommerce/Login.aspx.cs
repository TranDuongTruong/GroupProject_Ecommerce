using GroupProject_Ecommerce.Scripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GroupProject_Ecommerce
{
    public partial class Login : System.Web.UI.Page
    {
        DBContext kn = new DBContext();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click1(object sender, EventArgs e)
        {
            string user = txtUsername.Text;
            string password = txtPassword.Text;

            string sql = "select * from Users where Username= '"
              + user + "' and Password = '" + password + "' ";
            DataTable dt = kn.GetData(sql);
            if (dt.Rows.Count > 0)
            {
                Session["username"] = user;
                Response.Redirect("Default.aspx");
            }
        }
    }
}