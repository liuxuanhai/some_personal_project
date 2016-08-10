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
    public partial class FormOrderInfo : Form
    {
        public FormOrderInfo()
        {
            InitializeComponent();
        }
        FormOrderMana parent;
        private void buttonCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void LXFS_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!System.Char.IsNumber(e.KeyChar)&&e.KeyChar!=8) e.Handled = true;
        }

        public DataTable dt;
        public string orderid;
        private void FormOrderInfo_Load(object sender, EventArgs e)
        {
            parent = (FormOrderMana)this.Owner;
            try
            {
                ClassDB.bindCombobox("订货单位", "订货单位", DHDW);   // 绑定订货单位
                ClassDB.bindCombobox("订货渠道", "订货渠道", DHQD);   // 绑定订货单位
                ClassDB.bindCombobox("经办人", "经办人", JBR);   // 绑定订货单位
                ClassDB.bindCombobox("提货方式", "提货方式", THFS);   // 绑定订货单位
                dt = new DataTable();
                dt.Columns.Add("产品类别", Type.GetType("System.String"));
                dt.Columns.Add("产品名称", Type.GetType("System.String"));
                dt.Columns.Add("数量", Type.GetType("System.String"));
                dt.Columns.Add("产品单位", Type.GetType("System.String"));
                
                //DDBH.Text = string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
                if (this.Text=="修改订单"||this.Text=="查看订单") {
                    DDBH.ReadOnly = true;  // 修改订单 单号不能改变
                    //修改订单\
                    DDBH.Text = orderid;
                    string sql = "select * from 订单表 where 订单编号='" + orderid+"'";
                    DataSet ds=ClassDB.getDataSet(sql);
                    if(ds.Tables[0].Rows.Count<1) {
                         MessageBox.Show("打开订单失败,请重试");
                         this.Close();
                    }
                    DHDW.Text = ds.Tables[0].Rows[0]["订货单位"].ToString();
                    SHR.Text = ds.Tables[0].Rows[0]["收货人"].ToString();
                    LXFS.Text = ds.Tables[0].Rows[0]["联系方式"].ToString();
                    SHDZ.Text = ds.Tables[0].Rows[0]["送货地址"].ToString();
                    DHQD.Text = ds.Tables[0].Rows[0]["订货渠道"].ToString();
                    THFS.Text= ds.Tables[0].Rows[0]["提货方式"].ToString();
                    JBR.Text = ds.Tables[0].Rows[0]["经办人"].ToString();
                    BZ.Text = ds.Tables[0].Rows[0]["备注"].ToString();
                    DHSJ.Value = DateTime.Parse(ds.Tables[0].Rows[0]["订货时间"].ToString());
                    sql = "select 产品类别,产品名称,数量,产品单位 from 订单详单表 where 订单编号='" + orderid + "'";
                    ds = ClassDB.getDataSet(sql);
                    dt=ds.Tables[0];
                }
                dataGridView1.DataSource = dt;
                if (this.Text == "查看订单")
                {
                    button1.Visible = false;
                    button2.Visible = false;
                    buttonOK.Visible = false;
                   
                    buttonCancel.Text = "关闭";
                    dataGridView1.ReadOnly = true;
                    DHDW.Enabled = false;
                    SHR.Enabled = false;
                    LXFS.Enabled = false;
                    SHDZ.Enabled = false;
                    DHQD.Enabled = false;
                    DHSJ.Enabled = false;
                    THFS.Enabled = false;
                    JBR.Enabled = false;
                    BZ.Enabled = false;
                    DDBH.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void buttonOK_Click(object sender, EventArgs e)
        {
            if (DDBH.Text.Trim() == "") {
                MessageBox.Show("订货编号不能空");
                DDBH.Focus();
                return;
            }
            if (DHDW.Text.Trim() == "") {
                MessageBox.Show("订货单位不能空");
                DHDW.Focus();
                return;
            }
            if (dt.Rows.Count<1)
            {
                MessageBox.Show("产品详单不能空");
                return;
            }

            if (SHR.Text.Trim() == "")
            {
                MessageBox.Show("收货人不能空");
                SHDZ.Focus();
                return;
            }


            if (LXFS.Text.Trim() == "")
            {
                MessageBox.Show("联系方式不能空");
                LXFS.Focus();
                return;
            }
            if (DHQD.Text.Trim() == "")
            {
                MessageBox.Show("订货渠道不能空");
                DHQD.Focus();
                return;
            }

            if (JBR.Text.Trim() == "")
            {
                MessageBox.Show("经办人不能空");
                JBR.Focus();
                return;
            }
            if (THFS.Text.Trim() == "")
            {
                MessageBox.Show("提货方式不能空");
                THFS.Focus();
                return;
            }
            try
            {
                int counts = 0;
                string sql;
                int i = 0;
                if (this.Text == "修改订单")
                {
                    sql = "delete from 订单表 where 订单编号='" + DDBH.Text.Trim() + "'";
                    ClassDB.ExcuteSql(sql);
                    sql = "delete from 订单详单表 where 订单编号='" + DDBH.Text.Trim() + "'";
                    ClassDB.ExcuteSql(sql);
                }
                else if (this.Text == "添加订单")
                {
                    sql = "select 订单编号 from 订单表 where 订单编号='" + DDBH.Text.Trim() + "'";
                    if (ClassDB.getDataSet(sql).Tables[0].Rows.Count > 0) {
                        MessageBox.Show("订单流水号已经被使用过，请修改");
                        return;
                    }
                }

                while (i < dataGridView1.Rows.Count)
                {
                    sql = "insert into 订单详单表 values('" + DDBH.Text.Trim() + "','" + dataGridView1.Rows[i].Cells["产品类别"].Value.ToString() + "','" +
                        dataGridView1.Rows[i].Cells["产品名称"].Value.ToString() + "','" + dataGridView1.Rows[i].Cells["数量"].Value.ToString() + "','" + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + "','" + dataGridView1.Rows[i].Cells["产品单位"].Value.ToString() + "')";
                    ClassDB.ExcuteSql(sql); //更新订单
                    counts += int.Parse(dataGridView1.Rows[i].Cells["数量"].Value.ToString());
                    i++;
                }

                sql= "insert into 订单表(订单编号,订货单位,订货时间,送货地址,收货人,联系方式,产品合计,订货渠道,经办人,提货方式,备注) values('" +
                    DDBH.Text.Trim() + "','" +
                    DHDW.Text.Trim() + "','" +
                    DHSJ.Value.ToString("yyyy-MM-dd hh:mm:ss") + "','" +
                    SHDZ.Text.Trim() + "','" +
                    SHR.Text.Trim() + "','" +
                    LXFS.Text.Trim() + "','" +
                    counts.ToString() + "','" +
                    DHQD.Text.Trim() + "','" +
                    JBR.Text.Trim() + "','" +
                    THFS.Text.Trim() + "','" +
                    BZ.Text.Trim() +
                    "')";
                ClassDB.ExcuteSql(sql); //更新订单
                parent.refresh();
                MessageBox.Show("提交完成");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FormAddCP add = new FormAddCP();
            add.Owner = this;
            add.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count < 1)
            {
                MessageBox.Show("请选择需要删除的订单");
                return;
            }
            dataGridView1.Rows.Remove(dataGridView1.SelectedRows[0]);
            //dt.Rows.Remove(dataGridView1.SelectedRows[0]);
            
        }


    }
}
