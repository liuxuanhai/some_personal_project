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
    public partial class FormSysSet : Form
    {
        public FormSysSet()
        {
            InitializeComponent();
        }

        private void FormSysSet_Load(object sender, EventArgs e)
        {
            try
            {
                bingCPLB("");
            }
            catch (Exception ex) {
                MessageBox.Show(ex.Message);
            }
        }
        public void bingCPLB(string show)
        {
            if (tabControl1.SelectedIndex==2)
            {
                string sql = "select 产品类别 from 产品类别 order by 编号";
                DataSet ds = ClassDB.getDataSet(sql);
                int i = 0;
                comboBox1.Items.Clear();
                while (i < ds.Tables[0].Rows.Count)
                    comboBox1.Items.Add(ds.Tables[0].Rows[i++]["产品类别"].ToString());
                comboBox1.SelectedIndex = comboBox1.Items.Count > 0 ? 0 : -1;
                if (comboBox1.Items.IndexOf(show)>=0)
                    comboBox1.SelectedIndex = comboBox1.Items.IndexOf(show);
            }
            bingdata();
        }
        private void bingdata()
        {
            switch (tabControl1.SelectedIndex)
            {
                case 0:
                    ClassDB.bindlistbox("订货单位", "订货单位", listBoxDHDW);   // 绑定订货单位
                    break;
                case 1:
                    ClassDB.bindlistbox("产品类别", "产品类别", listBox6);   // 绑定订货单位
                    break;
                case 2:
                    //产品名称
                    string sql = "select 产品名称 from 产品名称 where 产品类别='" + comboBox1.SelectedItem.ToString() + "' order by 编号";
                    DataSet ds = ClassDB.getDataSet(sql);
                    listBox1.Items.Clear();
                    int i = 0;
                    while (i < ds.Tables[0].Rows.Count)
                        listBox1.Items.Add(ds.Tables[0].Rows[i++]["产品名称"].ToString());
                    groupBox2.Text = "类别" + comboBox1.SelectedItem.ToString() + "的所有产品名称";
                    break;
                case 3:
                    ClassDB.bindlistbox("产品单位", "产品单位", listBox5);   // 绑定订货单位
                    break;
                case 4:
                    ClassDB.bindlistbox("订货渠道", "订货渠道", listBox2);   // 绑定订货单位
                    break;
                case 5:
                    ClassDB.bindlistbox("经办人", "经办人", listBox3);   // 绑定订货单位
                    break;
                case 6:
                    ClassDB.bindlistbox("提货方式", "提货方式", listBox4);   // 绑定订货单位
                    break;
            }               
        }
        private void buttonAdd_Click(object sender, EventArgs e)
        {
            if (textBoxDHDW.Text.Trim() == "") {
                MessageBox.Show("不能为空");
                textBoxDHDW.SelectAll();
                    textBoxDHDW.Focus();
                return;
            }
            
            try
            {
                string sql = "select * from 订货单位 where 订货单位='" + textBoxDHDW.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0) {
                    MessageBox.Show(textBoxDHDW.Text.Trim()+" 已存在，请修改");
                    textBoxDHDW.SelectAll();
                    textBoxDHDW.Focus();
                    return;
                }
                sql= "insert into 订货单位(订货单位) values('" + textBoxDHDW.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                textBoxDHDW.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex) {
                MessageBox.Show(ex.Message);
            }
        }

        private void buttonDelete_Click(object sender, EventArgs e)
        {
            if (listBoxDHDW.SelectedIndex < 0) {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 订货单位 where 订货单位='" + listBoxDHDW.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
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
            if (comboBox1.SelectedIndex < 0) {
                MessageBox.Show("请选择产品类别"); return;
            }
            try
            {
                string sql = "select * from 产品名称 where 产品名称='" + textBox1.Text.Trim() + "' and 产品类别='" + comboBox1.SelectedItem.ToString()+"'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox1.Text.Trim() + " 已存在，请修改");
                    textBox1.SelectAll();
                    textBox1.Focus();
                    return;
                }
                sql = "insert into 产品名称(产品名称,产品类别) values('" + textBox1.Text.Trim() + "','" + comboBox1.SelectedItem.ToString() + "')";
                ClassDB.ExcuteSql(sql);
                textBox1.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (listBox1.SelectedIndex < 0)
            {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 产品名称 where 产品名称='" + listBox1.SelectedItem.ToString() + "' and 产品类别='" + comboBox1.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (textBox2.Text.Trim() == "")
            {
                MessageBox.Show("不能为空");
                textBox2.SelectAll();
                textBox2.Focus();
                return;
            }

            try
            {
                string sql = "select * from 订货渠道 where 订货渠道='" + textBox2.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox2.Text.Trim() + " 已存在，请修改");
                    textBox2.SelectAll();
                    textBox2.Focus();
                    return;
                }
                sql = "insert into 订货渠道(订货渠道) values('" + textBox2.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                textBox2.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (listBox2.SelectedIndex < 0)
            {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 订货渠道 where 订货渠道='" + listBox2.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            if (textBox3.Text.Trim() == "")
            {
                MessageBox.Show("不能为空");
                textBox3.SelectAll();
                textBox3.Focus();
                return;
            }

            try
            {
                string sql = "select * from 经办人 where 经办人='" + textBox3.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox3.Text.Trim() + " 已存在，请修改");
                    textBox3.SelectAll();
                    textBox3.Focus();
                    return;
                }
                sql = "insert into 经办人(经办人) values('" + textBox3.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                textBox3.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            if (listBox3.SelectedIndex < 0)
            {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 经办人 where 经办人='" + listBox3.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            if (textBox4.Text.Trim() == "")
            {
                MessageBox.Show("不能为空");
                textBox4.SelectAll();
                textBox4.Focus();
                return;
            }

            try
            {
                string sql = "select * from 提货方式 where 提货方式='" + textBox4.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox4.Text.Trim() + " 已存在，请修改");
                    textBox4.SelectAll();
                    textBox4.Focus();
                    return;
                }
                sql = "insert into 提货方式(提货方式) values('" + textBox4.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                textBox4.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (listBox4.SelectedIndex < 0)
            {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 提货方式 where 提货方式='" + listBox4.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex >= 0) {
                //产品名称
                string sql = "select 产品名称 from 产品名称 where 产品类别='" + comboBox1.SelectedItem.ToString() + "' order by 编号";
                DataSet ds = ClassDB.getDataSet(sql);
                listBox1.Items.Clear();
                int i = 0;
                while (i < ds.Tables[0].Rows.Count)
                    listBox1.Items.Add(ds.Tables[0].Rows[i++]["产品名称"].ToString());
                groupBox2.Text = "类别" + comboBox1.SelectedItem.ToString() + "的所有产品名称";
            }
        }

        private void 添加产品类别ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormCPLB cplb = new FormCPLB();
            cplb.Owner = this;
            cplb.ShowDialog();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            if (textBox5.Text.Trim() == "")
            {
                MessageBox.Show("不能为空");
                textBox5.SelectAll();
                textBox5.Focus();
                return;
            }

            try
            {
                string sql = "select * from 产品单位 where 产品单位='" + textBox5.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox5.Text.Trim() + " 已存在，请修改");
                    textBox5.SelectAll();
                    textBox5.Focus();
                    return;
                }
                sql = "insert into 产品单位(产品单位) values('" + textBox5.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                textBox5.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            if (listBox5.SelectedIndex < 0)
            {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 产品单位 where 产品单位='" + listBox5.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button12_Click(object sender, EventArgs e)
        {
            if (textBox6.Text.Trim() == "")
            {
                MessageBox.Show("不能为空");
                textBox6.SelectAll();
                textBox6.Focus();
                return;
            }

            try
            {
                string sql = "select * from 产品类别 where 产品类别='" + textBox6.Text.Trim() + "'";
                if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0)
                {
                    MessageBox.Show(textBox6.Text.Trim() + " 已存在，请修改");
                    textBox6.SelectAll();
                    textBox6.Focus();
                    return;
                }
                sql = "insert into 产品类别(产品类别) values('" + textBox6.Text.Trim() + "')";
                ClassDB.ExcuteSql(sql);
                textBox6.Text = "";
                bingdata();
                MessageBox.Show("添加完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button11_Click(object sender, EventArgs e)
        {
            if (listBox6.SelectedIndex < 0)
            {
                MessageBox.Show("请选择需要删除的一项");
                return;
            }
            try
            {
                string sql = "delete from 产品类别 where 产品类别='" + listBox6.SelectedItem.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                bingdata();
                MessageBox.Show("删除完成");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            bingCPLB("");
        }
    }
}
