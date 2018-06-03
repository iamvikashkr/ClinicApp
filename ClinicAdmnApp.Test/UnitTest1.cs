using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClinicAdminAppMVC.Controllers;
using ClinicAdminApp.Data.Models;
using MvcContrib.TestHelper;
using System.Web.Mvc;
using ClinicAdminAppMVC.Models;

namespace ClinicAdmnApp.Test
{
    [TestClass]
    public class UnitTest1
    {
        TestControllerBuilder builder = new TestControllerBuilder();

        [TestMethod]
        public void Register()
        {
            tblRegister obj = new tblRegister();
            obj.RoleID = 1;
            obj.FirstName = "Vikash";
            obj.LastName = "kumar";
            obj.Gender = "Male";
            obj.Email = "vikash@gmail.com";
            obj.MobileNumber = 11;
            obj.BirthDate = Convert.ToDateTime("10/10/2017");


            // Arrange
            AccountController controller = new AccountController();
            ActionResult result= controller.Register(obj);
            // Act


            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void SignIn()
        {
            tblUser obj = new tblUser();
            obj.Email = "vikash@gmail.com";
            obj.Password = "qq";
            AccountController controller = new AccountController();

            ActionResult result = controller.SignIn(obj);

            Assert.IsNotNull(result);
        }
    }
}
