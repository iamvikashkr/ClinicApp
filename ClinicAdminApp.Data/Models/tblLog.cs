//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ClinicAdminApp.Data.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblLog
    {
        public int ID { get; set; }
        public Nullable<int> UserID { get; set; }
        public string Token { get; set; }
        public string IPAddress { get; set; }
        public string MACAdderss { get; set; }
        public Nullable<System.DateTime> LoggedIn { get; set; }
        public Nullable<System.DateTime> LoggedOut { get; set; }
        public string Remarks { get; set; }
        public Nullable<int> RoleID { get; set; }
    
        public virtual tblUser tblUser { get; set; }
    }
}
