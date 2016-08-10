using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DynamicCorrectionEvaluation
{
    public partial class FormLogin : Form
    {
        public FormLogin()
        {
            InitializeComponent();
            //this.skinEngine1.SkinFile = "Longhorn.ssk";   //添加皮肤
        }
        public void clear()
        { 
            //清空
            username.Text = "";
            userpassword.Text = "";
            radioButton1.Checked = true;
        }
        private void buttonCancel_Click(object sender, EventArgs e)
        {
            clear();
        }

        private void FormLogin_Load(object sender, EventArgs e)
        {
            username.Text = "chen";
            userpassword.Text = "000000";
            radioButton2.Checked = true;
            clear();
            label4.Text = "登录遇到问题?" + System.Environment.NewLine + "请联系系统管理员";
        }

        private void buttonOK_Click(object sender, EventArgs e)
        {
            if (username.Text.Trim() == "")
            {
                MessageBox.Show("用户名不能为空");
                username.Focus();
                return;
            }
            if (userpassword.Text.Trim() == "")
            {
                MessageBox.Show("用户名不能为空");
                userpassword.Focus();
                return;
            }

            string type = "common";
            if (radioButton2.Checked) type = "admin";    //管理员选中

            //验证用户是否存在
            string sql = "select * from t_user where username='" + username.Text.Trim() + "' and usertype='" + type + "'";
            DataSet dt = ClassDB.getDataSet(sql);
            if (dt.Tables[0].Rows.Count <1)
            {
                MessageBox.Show("用户" + username.Text.Trim() + "不存在");
                username.Focus();
                username.SelectAll();
                return;
            }

            //验证密码是否正确
            sql = "select * from t_user where username='" + username.Text.Trim() + "' and userpassword='" + userpassword.Text.Trim() +
                "' and usertype='" + type + "'";
            dt = ClassDB.getDataSet(sql);
            if (dt.Tables[0].Rows.Count < 1)
            {
                MessageBox.Show("用户" + username.Text.Trim() + "密码错误，请确认");
                userpassword.Focus();
                userpassword.SelectAll();
                return;
            }

            //验证通过  隐藏登录界面 显示主界面
            this.Hide();
            
            FormMain main = new FormMain();
            main.usertype = type;
            main.username = username.Text;
            main.login = this;
            main.Show();
        }

        private void username_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == 13) {
                buttonOK_Click(sender,e);
            }
        }

        private void userpassword_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == 13)
            {
                buttonOK_Click(sender, e);
            }
        }

        private void FormLogin_Resize(object sender, EventArgs e)
        {
            panel1.Height = ClientSize.Height * 4 / 7;
            panel2.Width = panel1.Width / 2;
        }

        private void username_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Back)
                e.Handled = false;
            else
                if (((e.KeyChar >= '0' && e.KeyChar <= '9') || (e.KeyChar >= 'A' && e.KeyChar <= 'Z') || (e.KeyChar >= 'a' && e.KeyChar <= 'z') || (e.KeyChar == 8) || (e.KeyChar == '_')) && username.Text.Length < 20)
                    e.Handled = false;
                else
                    e.Handled = true;
        }
    }
}
