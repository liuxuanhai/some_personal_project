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
    public partial class FormLogin : Form
    {
        public FormLogin()
        {
            InitializeComponent();
        }
        // 重置
        private void buttonCancel_Click(object sender, EventArgs e)
        {
            username.Text = "";
            userpassword.Text = "";
        }

        // 确认
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
                MessageBox.Show("密码不能为空");
                userpassword.Focus();
                return;
            }
            string type = "普通用户";
            if (radioButton2.Checked) type = "管理员";  // 管理员
            //验证用户是否存在
            string sql = "select * from 权限表 where 用户名='" + username.Text.Trim() + "' and 用户类型='"+type+"'";
            DataSet dt = ClassDB.getDataSet(sql);
            if (dt.Tables[0].Rows.Count < 1)
            {
                MessageBox.Show("用户" + username.Text.Trim() + "不存在");
                username.Focus();
                username.SelectAll();
                return;
            }

            //验证密码是否正确
            sql = "select * from 权限表 where 用户名='" + username.Text.Trim() + "' and 用户密码='" + userpassword.Text.Trim() +
                "' and 用户类型='" + type + "'";
            dt = ClassDB.getDataSet(sql);
            if (dt.Tables[0].Rows.Count < 1)
            {
                MessageBox.Show("用户" + username.Text.Trim() + "的密码错误，请确认");
                userpassword.Focus();
                userpassword.SelectAll();
                return;
            }

            //验证通过  隐藏登录界面 显示主界面
            this.Hide();

            FormMain main = new FormMain();
            main.username = username.Text.Trim();
            main.usertype = type;
            main.Show();
        }


        // 响应回车键
        private void username_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == 13)
            {
                buttonOK_Click(sender, e);
            }
        }
        // 响应回车键
        private void userpassword_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == 13)
            {
                buttonOK_Click(sender, e);
            }
        }

        // 显示登录界面
        private void FormLogin_Load(object sender, EventArgs e)
        {
            //加载皮肤  使用皮肤非常卡
            skinEngine1.SkinFile = Application.StartupPath.ToString() + @"/MidsummerColor2.ssk";


            // 初始化
           // username.Text = "admin";
            //userpassword.Text = "138791";
            //radioButton2.Checked = true;
        }
    }
}
