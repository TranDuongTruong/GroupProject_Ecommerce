using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GroupProject_Ecommerce.Scripts.Models
{
    public class UserViewModel
    {
        public int UserID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public string DisplayName { get; set; }
        public string Avatar { get; set; }
        public int Gender { get; set; }


    }
}