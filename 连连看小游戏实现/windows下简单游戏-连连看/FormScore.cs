using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace windows下简单游戏_连连看
{
    public partial class FormScore : Form
    {
        public FormScore()
        {
            InitializeComponent();
        }
        public int type2;  // 游戏难度

        //加载页面  初始化分数列表显示
        private void FormScore_Load(object sender, EventArgs e)
        {
            this.Text = "单人-简单-历史分数";
            if (type2 == 1)
                this.Text="单人-复杂-历史分数";
            listView1.Columns.Add("时间", 150, HorizontalAlignment.Left); listView1.Columns.Add("分数", 130, HorizontalAlignment.Left);
            DBOperate db = new DBOperate();
            int max = 0,t;
            DataSet dt = db.GetTable("select * from t_score where type='"+type2.ToString()+"' order by scoretime desc");
            for (int i = 0; i < dt.Tables[0].Rows.Count; ++i)
            {
                ListViewItem lvi = new ListViewItem();
                lvi.Text = dt.Tables[0].Rows[i][0].ToString();
                lvi.SubItems.Add(dt.Tables[0].Rows[i][1].ToString());
                listView1.Items.Add(lvi);
                t = int.Parse(dt.Tables[0].Rows[i][1].ToString());
                if (max < t) max = t;
            }
            label2.Text = "历史最高分为:" + max.ToString();
        }
    }
}
