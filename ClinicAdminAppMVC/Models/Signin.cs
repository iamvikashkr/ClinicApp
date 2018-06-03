using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ClinicAdminAppMVC.Models
{
    public class Signin
    {
        public int ID { get; set; }

        [Display(Name ="Email")]
        [Required(ErrorMessage ="Email is required.")]
        public string Email { get; set; }

        [Display(Name = "Password")]
        [Required(ErrorMessage = "Password is required.")]
        public string Password { get; set; }

        public string Token { get; set; }
        public string IPAddress { get; set; }
        public string MACAddress { get; set; }
        public int UserId { get; set; }
        public int RoleID { get; set; }
      
    }
}