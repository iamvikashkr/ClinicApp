using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicAdminAppMVC.Service
{
    interface IAppointmentService:IDisposable
    {
        void AddAppointment();
        void GetAppointment();
    }
}
