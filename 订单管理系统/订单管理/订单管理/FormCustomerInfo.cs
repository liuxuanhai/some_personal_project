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
    public partial class FormCustomerInfo : Form
    {
        public FormCustomerInfo()
        {
            InitializeComponent();
        }
        public string name;

        private void LXFS_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!System.Char.IsNumber(e.KeyChar) && e.KeyChar != 8) e.Handled = true;
        }

        private void buttonCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void buttonOK_Click(object sender, EventArgs e)
        {
            if (DWMC.Text.Trim() == "")
            {
                MessageBox.Show("单位名称不能为空");
                DWMC.Focus();
                return;
            }
            try
            {
                string sql;
                if (this.Text == "修改客户")
                {
                    sql = "delete from 客户表 where 单位名称='" + DWMC.Text.Trim() + "'";
                    ClassDB.ExcuteSql(sql);
                }
                else if (this.Text == "添加客户")
                {
                    sql = "select 单位名称 from 客户表 where 单位名称='" + DWMC.Text.Trim() + "'";
                    if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                    {
                        MessageBox.Show("客户" + DWMC.Text.Trim()+"已经存在，请修改");
                        return;
                    }
                }
                sql = "insert into 客户表 values('"+DWMC.Text.Trim()+"','"+
                    DWDZ.Text.Trim()+"','"+FZR.Text+"','"+LXFS.Text.Trim()+"','"+
                    JYXM.Text.Trim()+"','"+BZ.Text.Trim()+"','"+DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss")+"')";

                ClassDB.ExcuteSql(sql);
                MessageBox.Show("保存完成");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error Info:" + ex.Message);
            }
        }

        private void FormCustomerInfo_Load(object sender, EventArgs e)
        {
            if (this.Text == "修改客户")
            {
                DWMC.Text = name;
                DWMC.ReadOnly = true;             
                try
                {
                    string sql = "select * from 客户表 where 单位名称='" + name + "'";
                    DataSet ds = ClassDB.getDataSet(sql);
                    FZR.Text = ds.Tables[0].Rows[0]["负责人"].ToString();
                    DWDZ.Text = ds.Tables[0].Rows[0]["单位地址"].ToString();
                    LXFS.Text = ds.Tables[0].Rows[0]["电话"].ToString();
                    JYXM.Text = ds.Tables[0].Rows[0]["经营项目"].ToString();
                    BZ.Text = ds.Tables[0].Rows[0]["备注"].ToString();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Info:" + ex.Message);
                } 
            }
        }




    }
}
