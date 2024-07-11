using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject_Ecommerce.Scripts
{
    public class UserContext
    {
        public static bool CheckLoginStatus(HttpContext context)
        {
            if (context.Session["username"] == null)
            {
                return false;
            }
            return true;
        }
        public static void Logout(HttpContext context)
        {
            context.Session.Clear();
            context.Response.Redirect("Login.aspx");
        }
    }
}