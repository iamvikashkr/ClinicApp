using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ClinicAdminAppMVC.Models
{
    public class AppointmentModel
    {
        public int ID { get; set; }
        public string Diagnosis { get; set; }
        public string Remarks { get; set; }
    }
}