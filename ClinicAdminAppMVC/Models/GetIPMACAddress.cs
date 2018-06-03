using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Web;

namespace ClinicAdminAppMVC.Models
{
    public class GetIPMACAddress
    {

        public string GetMacAddress()
        {
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            string strMacAddress = string.Empty;
            foreach (NetworkInterface adapter in nics)
            {
                if (strMacAddress == String.Empty)
                {
                    IPInterfaceProperties properties = adapter.GetIPProperties();
                    strMacAddress = adapter.GetPhysicalAddress().ToString();
                }

            }
            return strMacAddress;

        }

        public string GetIpAddress()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                {
                    return ip.ToString();
                }
            }
            throw new Exception(" No Network Adapters with an IPv4 address in the system");
        }
    }
}