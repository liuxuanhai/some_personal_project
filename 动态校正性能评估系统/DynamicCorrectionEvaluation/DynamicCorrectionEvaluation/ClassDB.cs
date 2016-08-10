using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Windows.Forms;
using System.Data.OleDb;
namespace DynamicCorrectionEvaluation
{
    class ClassDB
    {
        public static OleDbConnection getConn()
        {
            string datapath = Application.StartupPath.ToString();  // 获得工程目录
            string connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" +
                Application.StartupPath.ToString() + @"\data.accdb";
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
    }
}
