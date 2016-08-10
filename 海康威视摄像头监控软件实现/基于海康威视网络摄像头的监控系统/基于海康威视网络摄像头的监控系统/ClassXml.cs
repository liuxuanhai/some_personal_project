using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Windows.Forms;
namespace 基于海康威视网络摄像头的监控系统
{
    class ClassXml
    {

        //添加设备
        public static void AddXml(string name, string ip, string port, string username, string pwd)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("devices.xml");
            XmlNode root = xmlDoc.SelectSingleNode("devices");//查找<images>  
            XmlElement xe1 = xmlDoc.CreateElement(name);//创建一个<thumb>节点  
            xe1.SetAttribute("ip", ip);//设置ip  
            xe1.SetAttribute("port", port);//设置端口
            xe1.SetAttribute("username", username);//设置ip  
            xe1.SetAttribute("pwd", pwd);//设置端口
            root.AppendChild(xe1);//添加到<images>节点中  
            xmlDoc.Save("devices.xml");
        }

        // 判断设备是否存在
        public static Boolean findNameXml(string name)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("devices.xml");
            XmlNode root = xmlDoc.SelectSingleNode("devices");//查找<images>  
            XmlNode n = root.SelectSingleNode(name);
            if (n == null) return false;
            else return true;  //存在
        }

        // 判断设备ip是否存在
        public static Boolean findIpXml(string ip)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("devices.xml");
            XmlNodeList list = xmlDoc.SelectSingleNode("devices").ChildNodes;
            foreach (XmlNode xn in list)//遍历所有子节点
            {
                if (xn.Attributes[0].Value.ToString() == ip)
                    return true;  // 存在
            }
            return false;  // 不存在
        }

        // 删除设备
        public static void deleteXml(string name)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("devices.xml");
            XmlNode root = xmlDoc.SelectSingleNode("devices");//查找<images>  
            XmlNode n = root.SelectSingleNode(name);
            if (n != null)
                root.RemoveChild(n);            
            xmlDoc.Save("devices.xml");
        }

        // 读取所有设备信息
        public static List<string[]> readXml()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("devices.xml");
            XmlNodeList list = xmlDoc.SelectSingleNode("devices").ChildNodes;
            List<string[]> ll = new List<string[]>();
            foreach (XmlNode xn in list)//遍历所有子节点
            { 
                string []d=new string[5];
                d[0] = xn.Name.ToString();
                d[1] = xn.Attributes[0].Value.ToString();
                d[2] = xn.Attributes[1].Value.ToString();
                d[3] = xn.Attributes[2].Value.ToString();
                d[4] = xn.Attributes[3].Value.ToString();
                ll.Add(d);
            }
            return ll;
        }

        //获得指定设备的信息
        public static string[] getDeviceXml(string name)
        { 
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("devices.xml");
            XmlNode root = xmlDoc.SelectSingleNode("devices");//查找<images>  
            XmlNode xn = root.SelectSingleNode(name);
            if (xn == null) return null;
            else { 
                string [] d=new string[5];
                d[0] = xn.Name.ToString();
                d[1] = xn.Attributes[0].Value.ToString();
                d[2] = xn.Attributes[1].Value.ToString();
                d[3] = xn.Attributes[2].Value.ToString();
                d[4] = xn.Attributes[3].Value.ToString();
                return d;
            }
        }

        // 获得设置信息
        public static string[] getSetInfo()
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("set.xml");
            XmlNode root = xmlDoc.SelectSingleNode("set");//查找<images> 
            string[] d = new string[4];
            XmlNode xn = root.SelectSingleNode("capture");
            if (xn == null) d[0]="";
            else
            {
                d[0] = xn.Attributes[0].Value.ToString();
            }
            xn = root.SelectSingleNode("record");
            if (xn == null) d[1] = "";
            else
            {
                d[1] = xn.Attributes[0].Value.ToString();
            }
            xn = root.SelectSingleNode("sound");
            if (xn == null) d[2] = "";
            else
            {
                d[2] = xn.Attributes[0].Value.ToString();
            }

            xn = root.SelectSingleNode("motiondetect");
            if (xn == null) d[3] = "";
            else
            {
                d[3] = xn.Attributes[0].Value.ToString();
            }
            return d;
        }
        public static void saveSetXml(string name,string set)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("set.xml");
            XmlNode root = xmlDoc.SelectSingleNode("set");//查找<images> 
            XmlNode xn = root.SelectSingleNode(name);
            if (xn != null)
            {
                xn.Attributes[0].Value = set;  // 设置属性
            }
            xmlDoc.Save("set.xml");
        }
        public static string getSetXml(string name)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("set.xml");
            XmlNode root = xmlDoc.SelectSingleNode("set");//查找<images> 
            string[] d = new string[3];
            XmlNode xn = root.SelectSingleNode(name);
            if (xn != null)
            {
                return xn.Attributes[0].Value.ToString();  // 设置属性
            }
            return "";
        }
    }
}
