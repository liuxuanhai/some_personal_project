using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;
using System.IO;
namespace 订单管理
{
    public partial class FormDataBaseMana : Form
    {
        public FormDataBaseMana()
        {
            InitializeComponent();
        }
        
        private void button1_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("是否确定要清空数据库？", "确认", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No) return;
            try
            {
                string sql = "delete from 订单表 wher";
                ClassDB.ExcuteSql(sql);
                sql = "delete from 订单详单表";
                ClassDB.ExcuteSql(sql);
                MessageBox.Show("清空完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error Info:" + ex.Message);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                SaveFileDialog saveFileDialog1 = new SaveFileDialog();
                saveFileDialog1.Title = "备份access数据库";
                saveFileDialog1.Filter = "access数据库(*.accdb) |*.accdb";
                saveFileDialog1.InitialDirectory = "C:\\";
                saveFileDialog1.FilterIndex = 2;
                saveFileDialog1.RestoreDirectory = true;
                if (saveFileDialog1.ShowDialog() != DialogResult.OK) return;
                string localFilePath = saveFileDialog1.FileName.ToString(); //获得文件路径 
                //if (File.Exists(localFilePath)) {
                //    File.Delete(localFilePath);
                // }
                File.Copy(Application.StartupPath.ToString() + @"\订单管理.accdb", localFilePath, true);
                MessageBox.Show("备份完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error Info:" + ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog OpenFileDialog1 = new OpenFileDialog();
                OpenFileDialog1.Title = "恢复access数据库";
                OpenFileDialog1.Filter = "access数据库(*.accdb) |*.accdb";
                OpenFileDialog1.InitialDirectory = "C:\\";
                OpenFileDialog1.RestoreDirectory = true;
                if (OpenFileDialog1.ShowDialog() != DialogResult.OK) return;
                string localFilePath = OpenFileDialog1.FileName.ToString(); //获得文件路径 
                if (!File.Exists(localFilePath)) return;
                File.Copy(localFilePath,Application.StartupPath.ToString() + @"\订单管理.accdb", true);
                MessageBox.Show("恢复完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error Info:" + ex.Message);
            }
        }

        private void FormDataBaseMana_Load(object sender, EventArgs e)
        {
            if (((FormMain)this.Owner).usertype == "普通用户")
            {
                button1.Enabled = false;
                button3.Enabled = false;
            }
        }
    }
}
