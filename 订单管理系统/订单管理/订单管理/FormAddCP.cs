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
    public partial class FormAddCP : Form
    {
        public FormAddCP()
        {
            InitializeComponent();
        }

        private void FormAddCP_Load(object sender, EventArgs e)
        {
            parent = (FormOrderInfo)this.Owner;
            try
            {
                ClassDB.bindCombobox("产品类别", "产品类别", CPLB);   // 绑定订货单位
                ClassDB.bindCombobox("产品单位", "产品单位", CPDW);   // 绑定产品单位
                CPLB_SelectedIndexChanged(sender, e);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        FormOrderInfo parent;
        private void buttonCancel_Click(object sender, EventArgs e)
        {

            this.Close();
        }

        private void CPLB_SelectedIndexChanged(object sender, EventArgs e)
        {
            //产品名称
            string sql = "select 产品名称 from 产品名称 where 产品类别='" + CPLB.Text.ToString() + "' order by 编号";
            DataSet ds = ClassDB.getDataSet(sql);
            CPMC.Items.Clear();
            int i = 0;
            while (i < ds.Tables[0].Rows.Count)
                CPMC.Items.Add(ds.Tables[0].Rows[i++]["产品名称"].ToString());
            CPMC.Text = "";
        }

        private void buttonOK_Click(object sender, EventArgs e)
        {
            if (CPLB.Text.ToString().Trim() == "" || CPMC.Text.ToString().Trim() == "" || CPSL.Text.Trim() == ""||CPDW.Text.Trim()=="") {
                MessageBox.Show("请填写完整信息");
                return;
            }
            DataRow r = parent.dt.NewRow();
            r["产品类别"] = CPLB.Text.Trim();
            r["产品名称"] = CPMC.Text.Trim();
            r["数量"] = CPSL.Text.Trim();
            r["产品单位"] = CPDW.Text.Trim();
            parent.dt.Rows.Add(r);
            CPMC.Text = "";
            CPSL.Text = "";
            MessageBox.Show("添加完成，请继续");
        }

        private void CPSL_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!System.Char.IsNumber(e.KeyChar) && e.KeyChar != 8) e.Handled = true;
        }
    }
}
