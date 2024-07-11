using dotenv.net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

using Microsoft.AspNet.FriendlyUrls;

namespace GroupProject_Ecommerce
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
       

            DotEnv.Load();
            try
            {
                // Load environment variables from the .env file
                DotEnv.Load(options: new DotEnvOptions(envFilePaths: new[] { Server.MapPath("~/") + ".env" }));

                // Debugging: Log the loaded variables
                string databaseUrl = Environment.GetEnvironmentVariable("DATABASE_URL");
                Console.WriteLine($"DATABASE_URL: {databaseUrl}");
            }
            catch (Exception ex)
            {
                // Log any errors
                Console.WriteLine("Error loading .env file: " + ex.Message);
            }
              RegisterRoutes(RouteTable.Routes);

        }
        public  void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);
        }
    }
}