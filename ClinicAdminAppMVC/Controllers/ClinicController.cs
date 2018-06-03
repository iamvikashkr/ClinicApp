using ClinicAdminApp.Data.Models;
using ClinicAdminAppMVC.Models;
using ClinicAdminAppMVC.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace ClinicAdminAppMVC.Controllers
{
    public class ClinicController : Controller
    {

        Clinic clinic = new Clinic();
        

        public ActionResult Doctor()
        {

            if (Session["user"] != null)
            {

                if (Convert.ToString(Session["RoleID"]) == "2")
                {
                    int ID = Convert.ToInt16(Session["ID"]);
                    var data = clinic.Doctor(ID);
                    List<SelectListItem> objitem = new List<SelectListItem>();
                    foreach (spDocDrop_Result item in data)
                    {
                        objitem.Add(new SelectListItem { Text = item.UserID + ", " + item.FirstName + " " + item.LastName, Value = item.UserID.ToString() });
                    }
                    TempData["DropDownDoc"] = objitem;
                }
                else
                {
                    var data1 = clinic.DocAppointment(2);
                    List<SelectListItem> objitem1 = new List<SelectListItem>();
                    foreach (spDocDetails_Result item in data1)
                    {
                        objitem1.Add(new SelectListItem { Text = item.UserID + "," + item.FirstName + " " + item.LastName, Value = item.UserID.ToString() });
                    }
                    TempData["DropDownDoc"] = objitem1;
                }
            }
            return View();
        }


        [HttpPost]
        public ActionResult Doctor(string DropDownDoc)
        {
            int ID = Convert.ToInt16(DropDownDoc);
            var data = clinic.GetDoctor(ID);

            List<spDocInfo_Result> list = new List<spDocInfo_Result>();
            foreach (spDocInfo_Result item in data)
            {
                list.Add(item);
            }
            return View("Doctor", list);

        }



        public ActionResult Appointment()
        {
            if (Session["user"] != null)
            {
                var data1 = clinic.DocAppointment(2);
                List<SelectListItem> objitem1 = new List<SelectListItem>();
                foreach (spDocDetails_Result item in data1)
                {
                    objitem1.Add(new SelectListItem { Text = item.UserID + "," + item.FirstName + " " + item.LastName, Value = item.UserID.ToString() });
                }
                TempData["DocDetails"] = objitem1;


                var data2 = clinic.PatAppointment(3);
                List<SelectListItem> objitem2 = new List<SelectListItem>();
                foreach (spPatientDetails_Result item in data2)
                {
                    objitem2.Add(new SelectListItem { Text = item.UserID + "," + item.FirstName + " " + item.LastName, Value = item.UserID.ToString() });
                }
                TempData["PatDetails"] = objitem2;

                return View();
            }
            return View();
        }
        [HttpPost]
        public ActionResult Appointment(string PatDetails, string DocDetails, DateTime AppDate)
        {
            int res;
            try
            {
                if (Session["user"] != null)
                {
                    res = clinic.GetAppointment(Convert.ToInt16(PatDetails), Convert.ToInt16(DocDetails), AppDate);
                    if(res>0)
                    {
                        TempData["data"] = "success";
                        return RedirectToAction("Appointment");
                    }
                    else
                    {
                        TempData["data"] = "error";
                        ViewBag.Error = "Something Went wrong.....";
                        return RedirectToAction("Appointment");
                    }
                }
            }
            catch (Exception ex)
            {
                TempData["data"] = "exception";
                return RedirectToAction("Appointment");
            }

            
            return View("Appointment");
        }
        public ActionResult patient()
        {
            if (Session["user"] != null)
            {
                if (Convert.ToString(Session["RoleID"]) == "3")
                {
                    int ID = Convert.ToInt16(Session["ID"]);
                    var data = clinic.Patient(ID);
                    List<SelectListItem> objitem = new List<SelectListItem>();
                    foreach (spPatDrop_Result item in data)
                    {
                        objitem.Add(new SelectListItem { Text = item.UserID + "," + item.FirstName + " " + item.LastName, Value = item.UserID.ToString() });

                    }
                    TempData["DropDownPat"] = objitem;
                    return View();
                }
                else
                {
                    var data2 = clinic.PatAppointment(3);
                    List<SelectListItem> objitem2 = new List<SelectListItem>();
                    foreach (spPatientDetails_Result item in data2)
                    {
                        objitem2.Add(new SelectListItem { Text = item.UserID + "," + item.FirstName + " " + item.LastName, Value = item.UserID.ToString() });
                    }
                    TempData["DropDownPat"] = objitem2;
                }
            }
            return View();

        }

        [HttpPost]
        public ActionResult patient(string DropDownPat)
        {
            List<spPatInfo_Result> list = new List<spPatInfo_Result>();
            int ID = Convert.ToInt16(DropDownPat);
            var data = clinic.GetPatient(ID);
            foreach (spPatInfo_Result item in data)
            {
                list.Add(item);
            }
            return View("patient", list);
        }

        public JsonResult Update(int AppID,string Diagnosis,string Remarks)
        {
            int ID = AppID;
            string Diagnosis1 = Diagnosis;
            string Remarks1 = Remarks;
            clinic.update(ID,Diagnosis1,Remarks1);
            return Json(1);
        }

      
    }
}