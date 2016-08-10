using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using Microsoft.Office;  // 操作excel 首先添加引用 COM  Microsoft Excel 11.0 Object Library 确定
using System.IO;
using System.Collections;//在C#中使用ArrayList必须引用Collections类
namespace 订单管理
{
    public partial class FormOrderDataMana : Form
    {
        public FormOrderDataMana()
        {
            InitializeComponent();
        }

        private void FormOrderDataMana_Load(object sender, EventArgs e)
        {
            button1_Click(sender, e);
            CPLB_SelectedIndexChanged(sender, e);
            refresh();  // 刷新
        }
        public void refresh()
        {
            try
            {
                ClassDB.bindCombobox1("订单表", "订货单位", DHDW);   // 绑定订货单位
                ClassDB.bindCombobox1("订单表", "订货渠道", DHQD);   // 绑定订货单位
                ClassDB.bindCombobox1("订单表", "经办人", JBR);   // 绑定订货单位
                ClassDB.bindCombobox1("订单详单表", "产品类别", CPLB);   // 绑定订货单位
                string 
                sql = "select 订单表.订单编号,订货单位,订货时间,送货地址,产品类别,产品名称,数量,收货人,联系方式,订货渠道,经办人 from 订单表 left join 订单详单表 on 订单表.订单编号=订单详单表.订单编号 "
                       +"where (订货时间 Between #" + DHSJ.Value.ToString("yyyy-MM-dd hh:mm:ss") + "# and #" + DHSJEnd.Value.ToString("yyyy-MM-dd hh:mm:ss") + "#) and 订货单位 like '%"
                       + DHDW.Text.Trim() + "%' and 订货渠道 like '%" + DHQD.Text.Trim() + "%' and 经办人 like '%" + JBR.Text.Trim() + "%' and  产品类别 like '%"
                    + CPLB.Text.Trim() + "%' and 产品名称 like '%" + CPMC.Text.Trim() + "%' order by 订货时间 desc";
                DataSet ds = ClassDB.getDataSet(sql);
                dataGridView1.DataSource = ds.Tables[0];
                int nums=0;
                for (int i = 0; i < dataGridView1.Rows.Count; i++)
                    nums += int.Parse(dataGridView1.Rows[i].Cells["数量"].Value.ToString());
                groupBox2.Text = "产品信息(合计:"+nums.ToString()+")";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DHSJ.Value = System.DateTime.Now.AddMonths(-3);  // 3个月前
            DHSJEnd.Value = System.DateTime.Now.AddMonths(1);
            DHDW.Text = "";
            DHQD.Text = "";
            CPLB.Text = "";
            CPMC.Text = "";
            JBR.Text = "";
        }

        private void CPLB_SelectedIndexChanged(object sender, EventArgs e)
        {
            //产品名称
            string sql = "select distinct 产品名称 from 订单详单表 where 产品类别='" + CPLB.Text.ToString() + "'";// order by 添加时间";
            DataSet ds = ClassDB.getDataSet(sql);
            CPMC.Items.Clear();
            int i = 0;
            while (i < ds.Tables[0].Rows.Count)
                CPMC.Items.Add(ds.Tables[0].Rows[i++]["产品名称"].ToString());
            CPMC.Text = "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            refresh();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            // 导出数据
            Thread th = new Thread(threadExport);

            th.SetApartmentState(ApartmentState.STA);
            th.Start();
        }

        private void threadExport()
        {
            try
            {
                // 导出吧
                SaveFileDialog saveFileDialog1 = new SaveFileDialog();
                saveFileDialog1.Title = "导出数据到excel表格";
                saveFileDialog1.Filter = "excel文件(*.xls) |*.xls|excel 文件(*.xlsx)|*.xlsx";
                saveFileDialog1.FilterIndex = 2;
                saveFileDialog1.RestoreDirectory = true;
                if (saveFileDialog1.ShowDialog() != DialogResult.OK) return;
                string localFilePath = saveFileDialog1.FileName.ToString(); //获得文件路径 
                if (File.Exists(localFilePath)) File.Delete(localFilePath);
                // 操作excel的类
                Microsoft.Office.Interop.Excel.Application xlApp = new Microsoft.Office.Interop.Excel.Application();
                if (xlApp == null)
                {
                    throw new Exception("excel启动失败，可能未安装");
                }
                // 不显示更改提示
                xlApp.DisplayAlerts = false;
                xlApp.AlertBeforeOverwriting = false;
                Microsoft.Office.Interop.Excel.Workbook xlBook = xlApp.Workbooks.Add(true);
                Microsoft.Office.Interop.Excel.Worksheet ws = xlBook.Worksheets[1];
                ws.Name = "订单详情";
                try
                {
                    // 准备数据  从选中任务获得每个设备的数据 
                    int i, j,nums=0;  // 用于遍历
                    ArrayList alldata = new ArrayList();  // 存储所有数据
                    string[] dataArray = new string[dataGridView1.Columns.Count];   // 行列缓存
                    for (i = 0; i < dataGridView1.Columns.Count; i++)
                        dataArray[i] = dataGridView1.Columns[i].HeaderText;
                    alldata.Add(dataArray);
                    for (i = 0; i < dataGridView1.Rows.Count; i++)
                    {
                        dataArray = new string[dataGridView1.Columns.Count];   // 行列缓存
                        for (j = 0; j < dataGridView1.Columns.Count; j++)
                            dataArray[j] = dataGridView1.Rows[i].Cells[j].Value.ToString();
                        alldata.Add(dataArray);
                        nums += int.Parse(dataGridView1.Rows[i].Cells["数量"].Value.ToString());
                    }
                    String[,] alldatatemp = new String[alldata.Count+1, dataGridView1.Columns.Count];
                    string[] dataArray2 = new string[11];   // 行列缓存
                    for (i = 0; i < alldata.Count; i++)
                    {
                        dataArray2 = (string[])alldata[i];
                        for (j = 0; j < dataGridView1.Columns.Count; j++)
                            alldatatemp[i, j] = dataArray2[j];
                    }
                    alldatatemp[alldata.Count, 0] = "产品数量合计:" + nums.ToString();
                    //表内容赋值
                    ws.Range[ws.Cells[1, 1], ws.Cells[alldata.Count+1, dataGridView1.Columns.Count]].Value2 = alldatatemp;
                    // 表列名加粗
                    ws.Range[ws.Cells[1, 1], ws.Cells[1, dataGridView1.Columns.Count]].Font.Bold = true;

                    // 合并最后一列
                    ws.Range[ws.Cells[alldata.Count + 1, 1], ws.Cells[alldata.Count + 1, dataGridView1.Columns.Count]].Merge();
                    ws.Range[ws.Cells[alldata.Count + 1, 1], ws.Cells[alldata.Count + 1, dataGridView1.Columns.Count]].Font.Bold = true;

                    // 居中显示
                    ws.Cells.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
                    // 自适应单元格大小
                    ws.Cells.EntireColumn.AutoFit();

                    xlBook.SaveCopyAs(localFilePath);  // 保存
                    xlBook.Close();

                    this.Invoke((EventHandler)(delegate
                    {
                        MessageBox.Show("导出完成\r\n保存路径为:" + localFilePath);
                    }));
                }
                catch
                {
                    throw;  // 再次抛出
                }
                finally
                {
                    xlApp.Quit();
                    //杀掉Excel进程。
                    GC.Collect();
                }
            }
            catch (Exception ex)
            {

                this.Invoke((EventHandler)(delegate
                {
                    MessageBox.Show("导出失败\r\n" + ex.Message);
                }));
            }
        }
    }
}
