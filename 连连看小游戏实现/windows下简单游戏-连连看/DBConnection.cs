using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;//引用SQL命名空间

namespace 排课系统.DBClass
{
    class DBConnection
    {
        public static SqlConnection MyConnection()
        {
            return new SqlConnection(//创建数据库连接对象
            "Data Source=(local);database=排课系统数据库;uid=sa;pwd=55555");//数据库连接字符串
        }
    }
}
