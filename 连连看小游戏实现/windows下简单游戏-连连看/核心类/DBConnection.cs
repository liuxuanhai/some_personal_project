using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;//引用SQL命名空间

namespace windows下简单游戏_连连看
{
    class DBConnection
    {
        public static SqlConnection MyConnection()
        {
            return new SqlConnection(//创建数据库连接对象
            "Data Source=(local);database=连连看;Trusted_Connection=SSPI");//数据库连接字符串
        }
    }
}
