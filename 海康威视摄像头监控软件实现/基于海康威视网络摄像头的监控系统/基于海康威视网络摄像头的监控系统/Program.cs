using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace 基于海康威视网络摄像头的监控系统
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FormMain());
        }
    }
}
