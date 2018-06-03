using ClinicAdminApp.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicAdminAppMVC.Service
{
    public interface IUserService
    {
        bool AddUser(tblRegister reg);
        bool GetUser(tblUser sign);
        bool SignOut();

    }
}
