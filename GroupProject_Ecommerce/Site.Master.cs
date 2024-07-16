using GroupProject_Ecommerce.Scripts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GroupProject_Ecommerce
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DBContext connectionClass = new DBContext();
            DataList a = new DataList();
            string sql = "select * from Users";
            a.DataSource = connectionClass.GetData(sql);
            if (UserContext.CheckLoginStatus(HttpContext.Current))
            {
                LoginIcon.Visible = false;
                LogoutIcon.Visible = true;
                RegisterIcon.Visible = false;
                UserProfileIcon.Visible = true;
                CartIcon.Visible = true;
            }
            else
            {
                LoginIcon.Visible = true;
                LogoutIcon.Visible = false;
                RegisterIcon.Visible = true;
                UserProfileIcon.Visible = false;
                CartIcon.Visible = false;
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string keyword = SearchTextBox.Text;
            if (string.IsNullOrEmpty(keyword)) return;
            Response.Redirect("Default.aspx?key=" + keyword);

        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}   