using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ClinicAdminAppMVC.Models
{
    public class Register
    {

        public string fname { get; set; }
        public string lname { get; set; }
        public DateTime BirthDate { get; set; }
        public string gender { get; set; }
        public int role { get; set; }
        public string email { get; set; }
        public string Specialization { get; set; }
        public string Availability { get; set; }
        public string password { get; set; }
        public string Confirmpassword { get; set; }
        public long mobile { get; set; }
        public int Age { get; set; }
        public bool IsActive{ get; set; }
        public bool IsDelete{ get; set; }

    }
}