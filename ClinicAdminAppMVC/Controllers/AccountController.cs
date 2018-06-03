using ClinicAdminAppMVC.Models;
using System.Web.Mvc;
using ClinicAdminAppMVC.Service;
using ClinicAdminApp.Data.Models;
using System.Data.Entity.Core.Objects;
using System;
using System.Net.Mail;
using System.Net;

namespace ClinicAdminAppMVC.Controllers
{
    public class AccountController : Controller
    {
        AccountRepository acc = new AccountRepository();

        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(tblRegister d)
        {
            try
            {
                if (d.FirstName != null)
                {
                    bool result = acc.AddUser(d);
                    if (result)
                    {
                        Account ac = new Account();
                        ac.Register(d);
                        TempData["registered"] = "success";
                        ViewBag.Success = "Register Successfully.....Please Log In";
                        return RedirectToAction("SignIn");
                    }
                    else
                    {
                        TempData["registered"] = "error";
                        ViewBag.Error = "Something Went wrong.....";
                        return View();
                    }
                    //if (i > 0)
                    //{

                    //    TempData["registered"] = "success";
                    //    ViewBag.Success = "Register Successfully.....Please Log In";
                    //    if (Session["user"] != null)
                    //    {
                    //        return RedirectToAction("Register");

                    //    }
                    //    else
                    //    {
                    //        return RedirectToAction("SignIn");
                    //    }
                    //}
                    //else
                    //{
                    //    TempData["registered"] = "error";
                    //    ViewBag.Error = "Something Went wrong.....";
                    //    return View();
                    //}
                }
                return View();
            }

            catch (Exception ex)
            {
                TempData["registered"] = "duplicate";
                ViewBag.Error = "Something Went wrong.....";
                return View();
            }
        }



        public ActionResult Home()
        {
            return View();
        }

        public ActionResult SignIn()
        {
            return View();
        }


        [HttpPost]
        public ActionResult SignIn(tblUser sign)
        {
            GetIPMACAddress get = new GetIPMACAddress();
            string IPAddress = get.GetIpAddress();
            string MACAddress = get.GetMacAddress();

            try
            {
                if (sign.Email != null)
                {
                    bool result = acc.GetUser(sign);
                    if (result)
                    {

                        Account acc = new Account();
                        ObjectResult data = acc.SignIn(sign, IPAddress, MACAddress);
                        foreach (spSignIn_Result item in data)
                        {
                            Session["ID"] = item.ID;
                            Session["RoleID"] = item.RoleID;
                            Session["UserID"] = item.UserID;
                            Session["Firstname"] = item.FirstName;
                            Session["Lastname"] = item.LastName;
                            Session["Email"] = item.Email;
                            Session["Gender"] = item.Gender;
                            Session["MobileNumber"] = item.MobileNumber;
                            Session["Birthdate"] = item.BirthDate;
                            Session["Age"] = item.Age;
                            TempData["signin"] = "suc";

                        }
                        Session["user"] = data;


                        if (Session["user"] != null)
                        {
                            return View("Profile");
                        }
                    }
                    else
                    {
                        TempData["signin"] = "false";

                    }
                }
                else
                {
                    return View();

                }

            }
            catch (Exception ex)
            {
                TempData["signin"] = "error";
                var res = ex.Message;

            }


            return View();
        }
        public new ActionResult Profile()
        {
            return View();
        }
        public new ActionResult Signout()
        {
            Session["user"] = null;
            TempData["signout"] = "success";
            return RedirectToAction("SignIn");
        }

        public ActionResult ForgotPassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ForgotPassword(string Email)
        {
            try
            {
                if (Email != "")
                {
                    Random ran = new Random();
                    string newPass = Convert.ToString(ran.Next(100000, 1000000));

                    string RecoveryEmail = Email;
                    Account account = new Account();
                    ObjectResult data = account.ForgotPassword(newPass, RecoveryEmail);
                    foreach (string item in data)
                    {
                        Session["temp"] = item;

                    }
                    if (Session["temp"] != null)
                    {
                        var body = "<p>Email To: {0} from ({1})</p><p>Your New Password is:</p><p>{2}</p>";
                        var message = new MailMessage();
                        message.To.Add(new MailAddress(RecoveryEmail));  // replace with valid value 
                        message.From = new MailAddress("bridgelabzsolutions@gmail.com");  // replace with valid value
                        message.Subject = "Password Recovery";
                        message.Body = string.Format(body, RecoveryEmail, message.From, newPass);
                        message.IsBodyHtml = true;

                        using (var smtp = new SmtpClient())
                        {
                            var credential = new NetworkCredential
                            {
                                UserName = "bridgelabzsolutions@gmail.com",  // replace with valid value
                                Password = "bridgelabz"  // replace with valid value
                            };
                            smtp.Credentials = credential;
                            smtp.Host = "smtp.gmail.com	";
                            smtp.Port = 587;
                            smtp.EnableSsl = true;
                            smtp.Send(message);

                            TempData["msg"] = "success";
                        }
                    }
                    else
                    {
                        TempData["msg"] = "error";
                    }
                }
            }
            catch (Exception ex)
            {

                TempData["msg"] = "error";
            }

            return RedirectToAction("SignIn");
        }

        public ActionResult EditProfile()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Editprofile(Register register)
        {
            try
            {
                if (register.fname == null || register.lname == null || register.password == null)
                {
                    TempData["edit"] = "error";
                    return RedirectToAction("SignIn");

                }

                int userid = Convert.ToInt16(Session["UserID"]);
                Account account = new Account();
                int i = account.EditProfile(register.fname, register.lname, register.password, userid);
                if (i > 0)
                {
                    TempData["edit"] = "success";
                    return RedirectToAction("SignIn");
                }
                else
                {
                    TempData["edit"] = "error";
                }
            }
            catch (Exception ex)
            {

                ex.ToString();
            }


            return View();
        }


    }
}