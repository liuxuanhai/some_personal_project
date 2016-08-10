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
    public partial class FormMain : Form
    {
        public FormMain()
        {
            InitializeComponent();
            skinEngine1.SkinFile = Application.StartupPath.ToString() + @"\MidsummerColor2.ssk";  // 加载皮肤
        }

        //加载界面
        private void FormMain_Load(object sender, EventArgs e)
        {
            skinEngine1.AddForm(this);
        }

        //进入游戏
        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            FormGame game = new FormGame();
            game.Owner = this;
            // 默认单人 简单
            game.type1 = 0;
            game.type2=0;
            if (radioButton2.Checked)  // 比赛模式
                game.type1 = 1;
            if (radioButton3.Checked)//复杂级别
                game.type2 = 1;
            game.ShowDialog();
        }

        // 查看分数
        private void button2_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                FormScore score = new FormScore();
                skinEngine1.AddForm(score);
                score.type2 = 0;
                if (radioButton3.Checked)  // 复杂级别
                    score.type2 = 1;
                score.ShowDialog();
            }
            else {
                MessageBox.Show("比赛模式没有此功能!");
            }
            
        }

    }
}
