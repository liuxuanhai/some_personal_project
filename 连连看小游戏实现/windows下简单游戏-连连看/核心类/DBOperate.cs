using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data.SqlClient;
using System.Windows.Forms;
using System.Data;
using System.IO;
namespace windows下简单游戏_连连看
{
    class DBOperate
    {
        SqlConnection conn = DBConnection.MyConnection();//得到数据库连接对象

        /// <summary>
        /// 操作数据库，执行各种SQL语句
        /// </summary>
        /// <param name="strSql">SQL语句</param>
        /// <returns>方法返回受影响的行数</returns>
        public int OperateData(string strSql)
        {

            if (conn.State != ConnectionState.Open)
                conn.Open();//打开数据库连接
            SqlCommand cmd = new SqlCommand(strSql, conn);//创建命令对象
            int i = (int)cmd.ExecuteNonQuery();//执行SQL命令
            conn.Close();//关闭数据库连接

            return i;//返回数值
        }


        /// <summary>
        /// 查找指定数据表的人数
        /// </summary>
        /// <param name="strsql">SQL语句</param>
        /// <returns>方法返回指定记录的数量</returns>
        public int HumanNum(string strsql)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();//打开数据库连接
            SqlCommand cmd = new SqlCommand(strsql, conn);//创建命令对象
            int i = (int)cmd.ExecuteScalar();//执行SQL命令
            conn.Close();//关闭数据库连接
            return i;  //返回数值
        }

        /// <summary>
        /// 使用此方法可以得到数据集
        /// </summary>
        /// <param name="sql">SQL语句</param>
        /// <returns>方法返回数据集</returns>
        public DataSet GetTable(string sql)
        {
            DataSet ds = new DataSet();//创建数据集
            SqlDataAdapter sda = new SqlDataAdapter(sql, conn);//创建数据适配器对象
            sda.Fill(ds);//填充数据集
            ds.Dispose();//释放资源

            return ds;//返回数据集
        }


        /// <summary>
        /// 方法用于绑定DataGridView控件
        /// </summary>
        /// <param name="dgv">DataGridView控件</param>
        /// <param name="sql">SQL语句</param>
        public void BindDataGridView(DataGridView dgv, string sql)
        {
            SqlDataAdapter sda = new SqlDataAdapter(sql, conn);//创建数据适配器对象
            DataSet ds = new DataSet();//创建数据集对象
            sda.Fill(ds);//填充数据集
            dgv.DataSource = ds.Tables[0];//绑定到数据表
            ds.Dispose();//释放资源
        }


        /// <summary>
        /// //绑定下拉列表
        /// </summary>
        /// <param name="strTable">数据库表名</param>
        /// <param name="cb">ComboBox对象</param>
        /// <param name="i">指定数据列索引</param>
        public void BindDropdownlist(string strTable, ComboBox cb, int i)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();//打开数据库连接
            SqlCommand cmd = new SqlCommand(//创建命令对象
                "select * from " + strTable, conn);
            SqlDataReader sdr = cmd.ExecuteReader();//得到数据读取器
            while (sdr.Read())
            {
                cb.Items.Add(sdr[i].ToString());//添加信息
            }
            conn.Close();//关闭数据库连接
        }
    }
}
