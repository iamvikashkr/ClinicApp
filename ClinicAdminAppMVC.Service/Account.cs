using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClinicAdminApp.Data.Models;
using ClinicAdminAppMVC;
using System.Web;
using System.Web.Mvc;

namespace ClinicAdminAppMVC.Service
{

    public class Account 
    {
        ClinicAdminAppMVCEntities db = new ClinicAdminAppMVCEntities();
        public IUserService service;
        public int Register(tblRegister register)
        {
            int i = 0;
            try
            {
               
                    i = db.spRegister(register.RoleID, register.FirstName, register.LastName, register.Email, register.tblUser.Password, register.Gender, Convert.ToInt32(register.MobileNumber), register.BirthDate, register.Availability, register.Specialization, register.Age, register.IsActive, false);

                    return i;
                

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public ObjectResult SignIn(tblUser sign, string IPAddress, string MACAddress)
        {
            ObjectResult data = null;
            try
            {
                if (sign.Email != null)
                {
                    data = db.spSignIn(sign.Email, sign.Password, IPAddress, MACAddress);

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }

            return data;
        }

        public ObjectResult ForgotPassword(string Password, string Email)
        {
            ObjectResult result = null;
            try
            {
                result = db.spForgotPass(Email, Password);

            }
            catch (Exception ex)
            {

                ex.ToString();
            }
            return result;
        }

        public int EditProfile(string fname, string lname, string Password, int UserID)
        {
            int i = 0;
            try
            {
                i = db.spEditProfile(UserID, fname, lname, Password);
                return i;
            }
            catch (Exception)
            {

                throw;
            }
        }


        
    }

   
}
