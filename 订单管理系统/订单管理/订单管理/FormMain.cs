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
    public partial class FormMain : Form
    {
        public string username,usertype;
        public FormMain()
        {
            InitializeComponent();
            //this.skinEngine1.SkinFile = Application.StartupPath.ToString() + @"\MidsummerColor2.ssk";
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            FormOrderMana order = FormOrderMana.CreateFrom() ;
            order.MdiParent = this;
            order.FormBorderStyle = FormBorderStyle.None;
            order.Dock = DockStyle.Fill;
            order.Show();
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            FormSysSet set = new FormSysSet();
            set.ShowDialog();
        }

        private void toolStripButton4_Click(object sender, EventArgs e)
        {
            FormDataBaseMana data = new FormDataBaseMana();
            data.Owner = this;
            data.ShowDialog();
        }

        // 验证是否能够通过
        private void FormMain_Load(object sender, EventArgs e)
        {
            try
            {
                toolStripStatusLabel1.Text = "    欢饮您！"+username;
                if (usertype == "普通用户") {
                    //toolStripButton4.Visible = false;
                    toolStripButton5.Visible = false;
                    //toolStripLabel5.Visible = false;
                    toolStripLabel4.Visible = false;
                }
                DataSet ds = ClassDB.getDataSet("select * from 用户表");
                // 没有用户  用户密码错误 用户次数小于1
                if (ds.Tables[0].Rows.Count < 1 || ClassDB.Decrypt(ds.Tables[0].Rows[0]["用户密码"].ToString()) != "55555" || long.Parse(ClassDB.Decrypt(ds.Tables[0].Rows[0]["次数期限"].ToString())) < 1)
                {
                    // 验证不通过
                    FormPassowrd pass = new FormPassowrd();  // 锁定
                    pass.ShowDialog();
                }
                else {
                    string sql = "update 用户表 set 次数期限='" + ClassDB.Encrypt((long.Parse(ClassDB.Decrypt(ds.Tables[0].Rows[0]["次数期限"].ToString())) - 1).ToString()) + "'";
                    ClassDB.ExcuteSql(sql);
                }
            }
            catch
            {
                FormPassowrd pass = new FormPassowrd();  // 锁定
                pass.ShowDialog();
            }
        }

        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            Environment.Exit(0);
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            toolStripStatusLabel2.Text = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
        }

        private void toolStripButton5_Click(object sender, EventArgs e)
        {
            FormUsermana user = new FormUsermana();
            user.ShowDialog();
        }

        private void toolStripButton6_Click(object sender, EventArgs e)
        {
            FormCustomerMana customer = new FormCustomerMana();

            customer.ShowDialog();
        }
    }
}
