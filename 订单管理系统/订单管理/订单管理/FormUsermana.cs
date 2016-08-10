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
    public partial class FormUsermana : Form
    {
        public FormUsermana()
        {
            InitializeComponent();
        }

        private void FormUsermana_Load(object sender, EventArgs e)
        {
            type.SelectedIndex = 0;
            ShowUserInfo();
        }
        // 用户管理
        // 显示用户信息
        private void ShowUserInfo()
        {
            string getUser =//创建SQL字符串
                "select 用户名,'*****' as 用户密码,用户类型 from 权限表";
            try
            {
                DataSet ds = ClassDB.getDataSet(getUser);
                dataGridView1.DataSource = ds.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show("数据库错误\r\n" + ex.Message);
                return;
            }
            try
            {
                dataGridView1.Columns[0].Width = (dataGridView1.Width - 30) / 3;//设置列宽度
                dataGridView1.Columns[1].Width = dataGridView1.Columns[0].Width;//设置列宽度
                dataGridView1.Columns[2].Width = dataGridView1.Columns[1].Width;
            }
            catch { }

            txtOPwd.Text = "";//清除文本内容
            txtOUser.Text = "";//清除文本内容
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (txtOUser.Text.Trim() == "" || txtOPwd.Text.Trim() == "")
            {
                MessageBox.Show("请填写完整用户信息！", "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtOUser.Focus();
                return;//退出事件
            }
            try
            {
                string str =//创建SQL字符串
                    "select * from 权限表 where 用户名='" + txtOUser.Text.Trim() + "'";
                DataSet ds = ClassDB.getDataSet(str);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show("用户已存在！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtOUser.Focus();
                    return;//退出事件
                }
                else
                {
                    if (txtOPwd.Text.Length < 6)
                    {
                        MessageBox.Show("请确保密码大于6位字符");
                        txtOPwd.Focus();
                        return;
                    }
                    str =//创建SQL字符串
                        "insert into 权限表 values('" + txtOUser.Text.Trim() + "','" + txtOPwd.Text.Trim() + "','" + type.SelectedItem.ToString() + "')";
                    ClassDB.ExcuteSql(str);
                    MessageBox.Show("添加成功！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    
                    ShowUserInfo();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("添加用户失败！" + ex.Message, "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedCells.Count == 0)
            {
                MessageBox.Show("请选择要删除的用户", "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;//退出事件
            }
            else
            {
                try
                {
                    string username1 = dataGridView1.SelectedCells[0].Value.ToString();//得到用户名
                    string strsql =//创建SQL字符串
                    "delete from 权限表 where 用户名='" + username1 + "'";
                    ClassDB.ExcuteSql(strsql);//删除数据库中指定记录
                    MessageBox.Show("删除成功！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    ShowUserInfo();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("数据库错误\r\n" + ex.Message);
                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (txtOUser.Text.Trim() == "" || txtOPwd.Text.Trim() == "")
            {
                MessageBox.Show("请填写完整用户信息！", "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtOUser.Focus();
                return;//退出事件
            }

            if (txtOPwd.Text.Length < 6)
            {
                MessageBox.Show("请确保密码大于6位字符");
                txtOPwd.Focus();
                return;
            }
            try
            {
                string str =//创建SQL字符串
                "select * from 权限表 where 用户名='" + txtOUser.Text.Trim() + "'";
                DataSet ds = ClassDB.getDataSet(str);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str =//创建SQL字符串
                        "update 权限表 set 用户密码='" + txtOPwd.Text.Trim() + "',用户类型='" + type.SelectedItem.ToString() + "' where 用户名='" + txtOUser.Text.Trim() + "'";
                    ClassDB.ExcuteSql(str);//更新数据库信息
                    MessageBox.Show("修改成功！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    ShowUserInfo();
                }
                else
                {
                    MessageBox.Show("指定用户不存在！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtOUser.Focus();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("数据库错误\r\n" + ex.Message);
            }
        }
    }
}
