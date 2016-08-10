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
    struct CPP
    {
        public string CPLB;
        public string CPMC;
        CPP(string lb, string mc)
        {
            CPLB = lb;
            CPMC = mc;
        }
    };
    public partial class FormOrderMana : Form
    {
        // 下面四步将 此界面的类改成 单例模式 在MDI窗体中使用单例模式可以有效的避免同个窗体被实例化多次
        //一.将构造函数改成private

        private FormOrderMana()
        {
            InitializeComponent();
        }
        //二.声明一个字窗体的类型的静态变量  
        private static FormOrderMana instance;

        //三.通过静态方法创建字窗体  
        public static FormOrderMana CreateFrom()
        {
            //判断是否存在该窗体,或时候该字窗体是否被释放过,如果不存在该窗体,则 new 一个字窗体  
            if (instance == null || instance.IsDisposed)
            {
                instance = new FormOrderMana();
            }
            return instance;
        }   
        // 四.MDI中的调用===通过子类的静态方法实例化窗体           
        /*
            FormOrderMana frm = FormOrderMana.CreateFrom();  
            frm.MdiParent = this;  
            frm.Show();  */
        private void 添加ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormOrderInfo order = new FormOrderInfo();
            order.Owner = this;
            order.Text = "添加订单";
            order.ShowDialog();
        }

        private void 退出ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        public void refresh()
        {
            try
            {
                ClassDB.bindCombobox1("订单表", "订货单位", DHDW);   // 绑定订货单位
                ClassDB.bindCombobox1("订单表", "订货渠道", DHQD);   // 绑定订货单位
                ClassDB.bindCombobox1("订单表", "经办人", JBR);   // 绑定订货单位
                string sql = "select 订单编号 as 订单流水号,订货单位,订货时间,送货地址,收货人,联系方式,订货渠道,经办人,提货方式,产品合计,备注 from 订单表 where (订货时间 Between #" + DHSJ.Value.ToString("yyyy-MM-dd hh:mm:ss") + "# and #" + DHSJEnd.Value.ToString("yyyy-MM-dd hh:mm:ss") + "#) and 订货单位 like '%"
                    + DHDW.Text.Trim() + "%' and 订货渠道 like '%" + DHQD.Text.Trim() + "%' and 经办人 like '%" + JBR.Text.Trim() + "%' order by 订货时间 desc";
                //MessageBox.Show(sql);
                DataSet ds = ClassDB.getDataSet(sql);
                dataGridView1.DataSource = ds.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void FormOrderMana_Load(object sender, EventArgs e)
        {
            if (((FormMain)this.MdiParent).usertype == "普通用户")
            {
                修改ToolStripMenuItem.Visible = false;
                删除ToolStripMenuItem.Visible = false;
            }
            DHSJ.Value = System.DateTime.Now.AddMonths(-2);
            DHSJEnd.Value = System.DateTime.Now.AddMonths(1);
            refresh();  // 刷新
        }

        private void 删除ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count < 1) {
                MessageBox.Show("请选择需要删除的订单");
                return;
            }
            if (MessageBox.Show("是否确定要删除订单" + dataGridView1.SelectedRows[0].Cells["订单流水号"].Value.ToString() + "？\r\n删除不可恢复！", "确认", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No) return;
            try
            {
                string sql = "delete from 订单表 where 订单编号='" + dataGridView1.SelectedRows[0].Cells["订单流水号"].Value.ToString()+"'";
                ClassDB.ExcuteSql(sql);
                sql = "delete from 订单详单表 where 订单编号='" + dataGridView1.SelectedRows[0].Cells["订单流水号"].Value.ToString()+"'";
                ClassDB.ExcuteSql(sql);
                MessageBox.Show("删除成功");
                refresh();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error Info:" + ex.Message);
            }
        }

        private void dataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            dataGridView2.DataSource = null;
            if (dataGridView1.SelectedRows.Count < 1) return;
            try
            {
                string sql = "select 产品类别,产品名称,数量&产品单位 as 产品数量 from 订单详单表 where 订单编号='" + dataGridView1.SelectedRows[0].Cells["订单流水号"].Value.ToString()
                    + "' order by 添加时间 "; 
                DataSet ds = ClassDB.getDataSet(sql);
                dataGridView2.DataSource = ds.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void 修改ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count < 1) {
                MessageBox.Show("请选择需要修改的订单");
                return;
            }
            
            FormOrderInfo order = new FormOrderInfo();
            order.Owner = this;
            order.Text = "修改订单";
            order.orderid=dataGridView1.SelectedRows[0].Cells["订单流水号"].Value.ToString();
            order.ShowDialog();
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dataGridView1.SelectedRows.Count < 1)
            {
                MessageBox.Show("请选择需要查看的订单");
                return;
            }
            FormOrderInfo order = new FormOrderInfo();
            order.Owner = this;
            order.Text = "查看订单";
            order.orderid = dataGridView1.SelectedRows[0].Cells["订单流水号"].Value.ToString();
            order.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            refresh();
        }
       
        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            FormOrderDataMana mana = new FormOrderDataMana();
            mana.ShowDialog();
        }
    }
}
