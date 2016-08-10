using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace 订单管理
{
    public partial class FormPassowrd : Form
    {
        public FormPassowrd()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (textBox1.Text.Trim() != "55555")
                {
                    MessageBox.Show("密码错误");
                    textBox1.Focus();
                    textBox1.SelectAll();
                    return;
                }
                if (ClassDB.getDataSet("select * from 用户表").Tables[0].Rows.Count>0)
                    ClassDB.ExcuteSql("update 用户表 set 用户密码='" + ClassDB.Encrypt(textBox1.Text.Trim())+"',次数期限='"+ClassDB.Encrypt(textBox2.Text.Trim())+"'");
                else ClassDB.ExcuteSql("insert into 用户表(用户密码,次数期限) values('" + ClassDB.Encrypt(textBox1.Text.Trim()) + "','" + ClassDB.Encrypt(textBox2.Text.Trim()) + "')");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Environment.Exit(0);
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
             textBox2.Enabled = !checkBox1.Checked;
             if (checkBox1.Checked) textBox2.Text = "365000000";
             else textBox2.Text = "5";
        }
    }
}
