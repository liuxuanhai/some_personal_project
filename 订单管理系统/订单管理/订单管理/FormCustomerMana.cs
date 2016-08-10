using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using Microsoft.Office;
using System.IO;
namespace 订单管理
{
    public partial class FormCustomerMana : Form
    {
        public FormCustomerMana()
        {
            InitializeComponent();
        }

        private void 退出ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FormCustomerMana_Load(object sender, EventArgs e)
        {
            refreshdata();
        }
        public void refreshdata()
        {
            try
            {
                string strsql =//创建SQL字符串
                "select * from 客户表 where 单位名称 like '%" + toolStripTextBox1.Text.Trim()+"%' and 电话 like '%"+toolStripTextBox1.Text.Trim()+ "%' order by 添加时间";
                dataGridView1.DataSource= ClassDB.getDataSet(strsql).Tables[0];
                
            }
            catch (Exception ex)
            {
                MessageBox.Show("数据库错误\r\n" + ex.Message);
            }
        }

        private void 添加ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormCustomerInfo info = new FormCustomerInfo();
            info.Text = "添加客户";
            info.ShowDialog();
            refreshdata();
        }

        private void 修改ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count < 1)
            {
                MessageBox.Show("请选择需要修改的客户");
                return;
            }

            FormCustomerInfo info = new FormCustomerInfo();
            info.Text = "修改客户";
            info.name = dataGridView1.SelectedRows[0].Cells["单位名称"].Value.ToString();
            info.ShowDialog();
            refreshdata();
        }

        private void 删除ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count < 1)
            {
                MessageBox.Show("请选择需要修改的客户");
                return;
            }
            if (MessageBox.Show("是否确定要删除客户" + dataGridView1.SelectedRows[0].Cells["单位名称"].Value.ToString() + "？\r\n删除不可恢复！", "确认", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No) return;
            try
            {
                string sql = "delete from 客户表 where 单位名称='" + dataGridView1.SelectedRows[0].Cells["单位名称"].Value.ToString() + "'";
                ClassDB.ExcuteSql(sql);
                refreshdata();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error Info:" + ex.Message);
            }
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            refreshdata();
        }

        private void dataGridView1_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            修改ToolStripMenuItem_Click( sender,  e);
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
                    int i, j;  // 用于遍历
                    string[,] dataArray = new string[dataGridView1.Rows.Count + 1, dataGridView1.Columns.Count];   // 行列缓存
                    for (i = 0; i < dataGridView1.Columns.Count; i++) dataArray[0, i] = dataGridView1.Columns[i].Name;
                    for (i = 0; i < dataGridView1.Rows.Count; i++)
                        for (j = 0; j < dataGridView1.Columns.Count; j++) 
                            dataArray[i + 1, j] = dataGridView1.Rows[i].Cells[j].Value.ToString();

                    //表内容赋值
                    ws.Range[ws.Cells[1, 1], ws.Cells[dataArray.GetLength(0), dataArray.GetLength(1)]].Value2 = dataArray;
                    // 表列名加粗
                    ws.Range[ws.Cells[1, 1], ws.Cells[1, dataArray.GetLength(1)]].Font.Bold = true;
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

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            // 导出数据
            Thread th = new Thread(threadExport);
            th.SetApartmentState(ApartmentState.STA);
            th.Start();
        }
    }
}
