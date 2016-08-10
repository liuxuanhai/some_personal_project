using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace 基于海康威视网络摄像头的监控系统
{
    public partial class FormDeviceAdd : Form
    {
        public FormDeviceAdd()
        {
            InitializeComponent();
            devicename = "";
        }
        //关闭界面
        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        //确定添加设备
        private void button1_Click(object sender, EventArgs e)
        {
            if (textBoxName.Text.Trim() == "")
            {
                MessageBox.Show("别名不能为空");
                return;
            }
            if (textBoxIP.Text.Trim() == "")
            {
                MessageBox.Show("IP不能为空");
                return;
            }
            if (textBoxPort.Text.Trim() == "")
            {
                MessageBox.Show("端口号不能为空");
                return;
            }
            if (textBoxUserName.Text.Trim() == "")
            {
                MessageBox.Show("用户名不能为空");
                return;
            }
            if (textBoxPassword.Text.Trim() == "")
            {
                MessageBox.Show("密码不能为空");
                return;
            }
            if (devicename == "") //添加
            {
                if (ClassXml.findNameXml(textBoxName.Text.Trim()))
                {
                    MessageBox.Show("此别名已经存在，请输入新别名！");
                    return;
                }
                if (ClassXml.findIpXml(textBoxIP.Text.Trim()))
                {
                    MessageBox.Show("此设备IP已经存在，请输入新IP！");
                    return;
                }
                ClassXml.AddXml(textBoxName.Text.Trim(), textBoxIP.Text.Trim(), textBoxPort.Text.Trim(), textBoxUserName.Text.Trim(), textBoxPassword.Text.Trim());
                MessageBox.Show("添加成功!");
                this.Close();
            }
            else // 修改
            {
                if (ip != textBoxIP.Text.Trim() && ClassXml.findIpXml(textBoxIP.Text.Trim()))
                {
                    MessageBox.Show("此设备IP已经存在，请输入新IP！");
                    return;
                }
                ClassXml.deleteXml(textBoxName.Text.Trim());
                ClassXml.AddXml(textBoxName.Text.Trim(), textBoxIP.Text.Trim(), textBoxPort.Text.Trim(), textBoxUserName.Text.Trim(), textBoxPassword.Text.Trim());
                MessageBox.Show("修改成功!");
                this.Close();
            }
            
        }

        //加载界面
        public string devicename,ip;  //设备名
        private void FormDeviceAdd_Load(object sender, EventArgs e)
        {
            if (devicename == "")  //添加设备
            {
                this.Text = "添加设备";
            }
            else { 　　//修改设备
                this.Text = "修改设备";
                string []s=ClassXml.getDeviceXml(devicename);
                if (s == null)
                {
                    MessageBox.Show("故障！请重新操作！");
                    this.Close();
                }
                else {
                    textBoxName.Text = s[0];
                    textBoxIP.Text = s[1];
                    ip = s[1];
                    textBoxPort.Text = s[2];
                    textBoxUserName.Text = s[3];
                    textBoxPassword.Text = s[4];
                    textBoxName.ReadOnly = true;
                }
            }
        }
        // 保证端口号是数字
        private void textBoxPort_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != 8 && !Char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void textBoxName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != 8 && !Char.IsLetter(e.KeyChar))
            {
                e.Handled = true;
            }
        }
    }
}
