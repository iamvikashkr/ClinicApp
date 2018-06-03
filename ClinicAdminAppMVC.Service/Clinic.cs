using ClinicAdminApp.Data.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace ClinicAdminAppMVC.Service
{
    public class Clinic
    {
        ClinicAdminAppMVCEntities db = new ClinicAdminAppMVCEntities();

        public ObjectResult Doctor(int ID)
        {
            ObjectResult data = null;
            try
            {
                data = db.spDocDrop(ID);

            }
            catch (Exception ex)
            {

                ex.ToString(); ;
            }
            return data;

        }

        public ObjectResult GetDoctor(int ID)
        {
            ObjectResult data = null;
            try
            {
                data = db.spDocInfo(ID);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return data;
        }

        public ObjectResult Patient(int ID)
        {
            ObjectResult data = null;
            try
            {
                data = db.spPatDrop(ID);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return data;
        }
        public ObjectResult GetPatient(int ID)
        {
            ObjectResult data = null;
            try
            {
                data = db.spPatInfo(ID);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return data;
        }

        public ObjectResult PatAppointment(int PatID)
        {
            ObjectResult data = null;
            try
            {
                data = db.spPatientDetails(PatID);

            }
            catch (Exception ex)
            {

                ex.ToString();
            }
            return data;

        }

        public ObjectResult DocAppointment(int DocID)
        {
            ObjectResult data = null;
            try
            {
                data = db.spDocDetails(DocID);

            }
            catch (Exception ex)
            {

                ex.ToString();
            }
            return data;
        }

        public int GetAppointment(int PatID, int DocID, DateTime AppDate)
        {

            int i = db.spAppointment(PatID, DocID, AppDate, null, null, null, false);
            return i;
        }

        public void update(int ID, string Diagnosis, string Remarks)
        {
            db.updateApp(ID, Diagnosis, Remarks);
        }

    }
}
