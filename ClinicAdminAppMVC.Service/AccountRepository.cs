using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClinicAdminApp.Data.Models;
using System.Web.Mvc;
namespace ClinicAdminAppMVC.Service
{
    public class AccountRepository : IUserService
    {
        private ModelStateDictionary _modelState;
        public AccountRepository()
        {
        }

        AccountRepository(ModelStateDictionary modelstate)
        {
            _modelState = modelstate;
        }
        public bool AddUser(tblRegister reg)
        {
           
            bool result = false;
      

            if (reg.FirstName.Trim().Length == 0)
            {
                result = false;
            }

            else if (reg.LastName.Trim().Length == 0)
            {
                result = false;
            }
            else if (reg.Email.Length < 0)
            {
                result = false;
            }
            else if(!reg.MobileNumber.HasValue)
            {
                result = false;
            }
            else
            {
                result= true;
            }

            return result;
          


        }


        public bool GetUser(tblUser sign)
        {
            bool result = false;


            if (sign.Email.Trim().Length< 4)
            {
                result = false;
            }

            else if (sign.Password.Trim().Length == 0)
            {
                result = false;
            }
            
            else
            {
                result = true;
            }

            return result;

        }

       

        public bool SignOut()
        {
            throw new NotImplementedException();
        }







    }
}
