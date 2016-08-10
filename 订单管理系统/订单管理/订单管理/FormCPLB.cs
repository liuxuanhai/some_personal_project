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
    public partial class FormCPLB : Form
    {
        public FormCPLB()
        {
            InitializeComponent();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (textBox1.Text.Trim() == "")
            {
                MessageBox.Show("不能为空");
                textBox1.SelectAll();
                textBox1.Focus();
                return;
            }

            try
            {
                string sql = "select * from 产品类别 where 产品类别='" + textBox1.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox1.Text.Trim() + " 已存在，请修改");
                    textBox1.SelectAll();
                    textBox1.Focus();
                    return;
                }
                sql = "insert into 产品类别(产品类别) values('" + textBox1.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                MessageBox.Show("添加完成");
                this.Close();
                ((FormSysSet)this.Owner).bingCPLB(textBox1.Text.Trim());
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
