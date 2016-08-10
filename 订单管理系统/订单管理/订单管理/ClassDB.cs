using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Windows.Forms;
using System.Data.OleDb;
using System.Security.Cryptography;
using System.IO;
namespace 订单管理
{
    class ClassDB
    {
        public static OleDbConnection getConn()
        {
            string datapath = Application.StartupPath.ToString();  // 获得工程目录
            string connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" +
                Application.StartupPath.ToString() + @"\订单管理.accdb";
            //MessageBox.Show(connstr); 
            OleDbConnection tempconn = new OleDbConnection(connstr);
            return(tempconn);
        }
        
        //获得dataset  select 查询
        public static System.Data.DataSet getDataSet(string sqlstr)
        {
            System.Data.DataSet mydataset; //定义DataSet
            try
            {
                OleDbConnection conn = getConn(); //getConn():得到连接对象
                OleDbDataAdapter adapter = new OleDbDataAdapter();
                mydataset = new System.Data.DataSet();
                adapter.SelectCommand = new OleDbCommand(sqlstr, conn);
                adapter.Fill(mydataset);
                conn.Close();
            }
            catch (Exception e)
            {
                MessageBox.Show("数据库出错:" + e.Message);
                mydataset = null;
            }
            return mydataset;
        }

        //执行更新类语句 插入  删除 更新
        public static Boolean ExcuteSql(string sqlstr)
        {
            Boolean tempvalue = false;
            //连接数据库
            try
            {
                OleDbConnection conn = getConn(); //getConn():得到连接对象
                conn.Open();
                //定义command对象，并执行相应的SQL语句
                OleDbCommand myCommand = new OleDbCommand(sqlstr, conn);
                myCommand.ExecuteNonQuery();
                conn.Close();
                tempvalue = true;
            }
            catch (Exception e)
            {
                throw (new Exception("数据库更新出错:" + sqlstr + "\r" + e.Message));
            }
            return tempvalue;
        }
        public static void bindlistbox(string table,string col,ListBox lb)
        {
            string sql = "select " + col + " from " + table +" order by 编号";
            DataSet ds = getDataSet(sql);
            lb.Items.Clear();
            int i = 0;
            while (i < ds.Tables[0].Rows.Count) 
                lb.Items.Add(ds.Tables[0].Rows[i++][col].ToString());
        }

        public static void bindCombobox(string table, string col, ComboBox cb)
        {
            string sql = "select " + col + " from " + table +" order by 编号";
            DataSet ds = getDataSet(sql);
            cb.Items.Clear();
            int i = 0;
            while (i < ds.Tables[0].Rows.Count)
                cb.Items.Add(ds.Tables[0].Rows[i++][col].ToString());
        }
        public static void bindCombobox1(string table, string col, ComboBox cb)
        {
            string sql = "select distinct " + col + " from " + table;// +" order by 编号";
            DataSet ds = getDataSet(sql);
            cb.Items.Clear();
            int i = 0;
            while (i < ds.Tables[0].Rows.Count)
                cb.Items.Add(ds.Tables[0].Rows[i++][col].ToString());
        }


        // 字符串解密加密
        static string encryptKey = "jly5";    //定义密钥 1  
        /// <summary> /// 加密字符串   
        /// </summary>  
        /// <param name="str">要加密的字符串</param>  
        /// <returns>加密后的字符串</returns>  
        public static string Encrypt(string str)
        {
            DESCryptoServiceProvider descsp = new DESCryptoServiceProvider();   //实例化加/解密类对象   

            byte[] key = Encoding.Unicode.GetBytes(encryptKey); //定义字节数组，用来存储密钥    

            byte[] data = Encoding.Unicode.GetBytes(str);//定义字节数组，用来存储要加密的字符串  

            MemoryStream MStream = new MemoryStream(); //实例化内存流对象      

            //使用内存流实例化加密流对象   
            CryptoStream CStream = new CryptoStream(MStream, descsp.CreateEncryptor(key, key), CryptoStreamMode.Write);

            CStream.Write(data, 0, data.Length);  //向加密流中写入数据      

            CStream.FlushFinalBlock();              //释放加密流      

            return Convert.ToBase64String(MStream.ToArray());//返回加密后的字符串  
        }

        /// <summary>  
        /// 解密字符串   
        /// </summary>  
        /// <param name="str">要解密的字符串</param>  
        /// <returns>解密后的字符串</returns>  
        public static string Decrypt(string str)
        {
            DESCryptoServiceProvider descsp = new DESCryptoServiceProvider();   //实例化加/解密类对象    

            byte[] key = Encoding.Unicode.GetBytes(encryptKey); //定义字节数组，用来存储密钥    

            byte[] data = Convert.FromBase64String(str);//定义字节数组，用来存储要解密的字符串  

            MemoryStream MStream = new MemoryStream(); //实例化内存流对象      

            //使用内存流实例化解密流对象       
            CryptoStream CStream = new CryptoStream(MStream, descsp.CreateDecryptor(key, key), CryptoStreamMode.Write);

            CStream.Write(data, 0, data.Length);      //向解密流中写入数据     

            CStream.FlushFinalBlock();               //释放解密流      

            return Encoding.Unicode.GetString(MStream.ToArray());       //返回解密后的字符串  
        }
    }
}
