using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Threading;
using System.Resources;
using System.Reflection;
using System.Media;
namespace windows下简单游戏_连连看
{
    public partial class FormGame : Form
    {
        public FormGame()
        {
            InitializeComponent();
        }
        const int widths = 12; // 宽
        const int heights = 8;  // 高
        int[] gmap = new int[widths * heights];    // 实际的图片矩阵10*6
        public int picnums, picshownums;  // 初始化时简单 级别 12张图片 8次重复
        Image[] img = new Image[30];               // 加载到内存中的图片 一共有39种  加载30足够了 16张就够了
        Graphics g;
        ClassKernel kernel;  // 核心算法类
        public int type1, type2;  // 游戏模式 游戏难度

        // 界面加载时 初始化参数
        private void FormMainMain_Load(object sender, EventArgs e)
        {
            picnums = 12; picshownums = 8;
            if (type2 == 1)  // 复杂模式
            {
                picnums = 16; picshownums = 6;
            }
            // 加载图片
            for (int i = 0; i < 30; i++)
            {
                img[i] =(System.Drawing.Image) Properties.Resources.ResourceManager.GetObject("_"+(i+1).ToString());
            }
            g = this.CreateGraphics();  // 获得绘图句柄
            // 第一个人还没有结束
            score1 = -1;
            first = false; 
            initGame(); // 初始化游戏
        }

        private void initGame() // 初始化游戏
        {
            // 初始化矩阵
            int n = 0;
            for (int i = 0; i < picnums; ++i)
                for (int j = 0; j < picshownums; ++j)
                    if (n < widths * heights)
                        gmap[n++] = i + 1;
            // 乱序
            byte[] keys = new byte[widths * heights];
            (new Random()).NextBytes(keys);
            Array.Sort(keys, gmap);
            // 初始化核心类
            kernel = new ClassKernel(ref gmap); 
 
            pbvalue = 90;  // 限时
            progressBar1.Value = pbvalue;  //pbvalue=90s可以用
            score = 0;  // 初始分数
            refreshnum = 2;  //只能刷新两次
            this.Invalidate();  // 重绘
            timer1.Start();  // 开始计时
        }

        private void FormGame_FormClosing(object sender, FormClosingEventArgs e)
        {
            timer1.Stop();
            ((FormMain)this.Owner).Show();  //显示设置页面
        }

        // 绘图
        private void FormGame_Paint(object sender, PaintEventArgs e)
        {
            //g = this.CreateGraphics();
            for (int i = 0; i < widths; i++)
                for (int j = 0; j < heights; j++)
                {
                    if (gmap[i * heights + j] != 0)
                    {
                        g.DrawImage(img[gmap[i * heights + j] - 1], i * 31, j * 34); //图片宽度是31  高度是34
                    }
                }
        }
        //选中 擦除 刷新的音乐 
        SoundPlayer selectplayer = new SoundPlayer("Sounds\\select.wav");
        SoundPlayer eraseplayer = new SoundPlayer("Sounds\\erase.wav");
        SoundPlayer refreshplayer = new SoundPlayer("Sounds\\refresh.wav");

        int two = 0;//用来计算点击块的次数,最大为2
        Point fpoint;//记录第一次点击的位置
        private void FormGame_MouseDown(object sender, MouseEventArgs e)
        {
            //计算点击的图片位置
            int curx = e.X / 31;
            int cury = e.Y / 34;

            if (curx >= widths || cury >= heights)  //非图片区域 返回
                return;
            if (gmap[curx * heights+ cury] != 0)  //如果图片已经被消除了  不处理
            {
                selectplayer.Play();  // 选择音乐  选择的图片边框加黑
                Pen pen = new Pen(new SolidBrush(this.BackColor));
                g.DrawRectangle(pen, new Rectangle(curx * 31, cury * 34, 31, 34));

                two++;  // 记录选择的点
                switch (two)
                {
                    case 1:  // 第一个点
                        fpoint = new Point(curx, cury);
                        break;
                    case 2:  // 两个点
                        //如果两个点符合规则可以消除
                        if (kernel.IsLink(fpoint.X, fpoint.Y, curx, cury))
                        {
                            two = 0;
                            eraseplayer.Play();  // 擦除音乐

                            //获得拐点数目和位置,做画线处理
                            ProcessCorner(fpoint, new Point(curx, cury));

                            if (CheckWin(ref gmap))  //判断是否还有剩余的图片
                            {
                                timer1.Stop();
                                MessageBox.Show("恭喜满分过关!\r\n你的分数为:"+score.ToString());
                                saveScore();  // 保存分数
                                //this.Close();  //关闭游戏
                                if (type1 == 0)  // 单人模式 直接关闭
                                    this.Close();
                                else
                                {  // 比赛模式
                                    if (!first)  // 第一个人
                                    {
                                        MessageBox.Show("下一个用户开始游戏...");
                                        first = true;
                                        initGame(); // 初始化游戏
                                    }
                                    else
                                    {  // 第二个人
                                        int id = 1;
                                        if (score > score1) id = 2;
                                        MessageBox.Show("比赛结果分数\r\n用户1:" + score1.ToString() + "\r\n用户2:" + score.ToString() + "\r\n胜者:用户" + id.ToString());
                                        this.Close();
                                    }
                                }
                            }

                        }
                        else  // 重新选择
                        {
                            two = 1;
                            fpoint = new Point(curx, cury);
                        }
                        break;
                    default:
                        break;
                }

            }
        }
        int score = 0;
        //此方法用做处理画线和消去
        private void ProcessCorner(Point p1, Point p2)
        {
            Point[] corner = new Point[3];
            corner = kernel.GetPoints();
            Pen pen = new Pen(new SolidBrush(Color.Red), 5);//线画笔
            Pen bkpen = new Pen(new SolidBrush(this.BackColor), 5);//擦去画笔

            //pbvalue += 1;  // 每次小一个就增加一些时长

            switch (corner[2].X)
            {
                case 1:
                    score += 10;//一个拐点加10;
                    g.DrawLine(pen, new Point(p1.X * 31 + 15, p1.Y * 34 + 17), new Point(corner[0].X * 31 + 15, corner[0].Y * 34 + 17));
                    g.DrawLine(pen, new Point(p2.X * 31 + 15, p2.Y * 34 + 17), new Point(corner[0].X * 31 + 15, corner[0].Y * 34 + 17));
                    Thread.Sleep(100);
                    EraseBlock(g, p1, p2);

                    g.DrawLine(bkpen, new Point(p1.X * 31 + 15, p1.Y * 34 + 17), new Point(corner[0].X * 31 + 15, corner[0].Y * 34 + 17));
                    g.DrawLine(bkpen, new Point(p2.X * 31 + 15, p2.Y * 34 + 17), new Point(corner[0].X * 31 + 15, corner[0].Y * 34 + 17));
                    break;
                case 2:
                    score += 15;//两个拐点加15
                    Point[] ps = { new Point(p1.X * 31 + 15, p1.Y * 34 + 17), new Point(corner[1].X * 31 + 15, corner[1].Y * 34 + 17), new Point(corner[0].X * 31 + 15, corner[0].Y * 34 + 17), new Point(p2.X * 31 + 15, p2.Y * 34 + 17) };
                    g.DrawLines(pen, ps);
                    Thread.Sleep(100);
                    EraseBlock(g, p1, p2);
                    g.DrawLines(bkpen, ps);
                    break;
                case 0:
                    score += 5;//直连加5
                    g.DrawLine(pen, new Point(p1.X * 31 + 15, p1.Y * 34 + 17), new Point(p2.X * 31 + 15, p2.Y * 34 + 17));
                    Thread.Sleep(100);
                    EraseBlock(g, p1, p2);
                    g.DrawLine(bkpen, new Point(p1.X * 31 + 15, p1.Y * 34 + 17), new Point(p2.X * 31 + 15, p2.Y * 34 + 17));
                    break;
                default: break;
            }
            label2.Text = score.ToString();  // 更新分数
        }
        // 擦除图片
        private void EraseBlock(Graphics g, Point p1, Point p2)
        {
            g.FillRectangle(new SolidBrush(this.BackColor), new Rectangle(p1.X * 31, p1.Y * 34, 31, 34));
            g.FillRectangle(new SolidBrush(this.BackColor), new Rectangle(p2.X * 31, p2.Y * 34, 31, 34));
            gmap[p1.X*heights+p1.Y] = 0;
            gmap[p2.X * heights + p2.Y] = 0;
            kernel.GiveMapValue(p1.X, p1.Y, 0);
            kernel.GiveMapValue(p2.X, p2.Y, 0);
        }

        //判断是否赢了
        private bool CheckWin(ref int[] map)
        {
            bool Win = true;
            for (int i = 0; i < widths; i++)
                for (int j = 0; j < heights; j++)
                    if (map[i*heights+ j] != 0)
                        Win = false;
            return Win;
        }

        // 0.5s定时器
        int pbvalue=90;
        private void timer1_Tick(object sender, EventArgs e)
        {
            --pbvalue;  // 减1
            if (pbvalue > 90)
                pbvalue = 90;
            if (pbvalue == 0)
            {
                timer1.Stop();  // 关闭定时器
                MessageBox.Show("时间到，你的分数是"+score.ToString());
                saveScore();  // 保存分数
                if (type1 == 0)  // 单人模式 直接关闭
                    this.Close();
                else {  // 比赛模式
                    if (!first)  // 第一个人
                    {
                        MessageBox.Show("下一个用户开始游戏...");
                        first = true;
                        initGame(); // 初始化游戏
                    }
                    else {  // 第二个人
                        int id = 1;
                        if (score > score1) id = 2;
                        MessageBox.Show("比赛结果分数\r\n用户1:" + score1.ToString() + "\r\n用户2:" + score.ToString() + "\r\n胜者:用户" + id.ToString());
                        this.Close();
                    }
                }
            }
            else
                progressBar1.Value = pbvalue;
        }
        int refreshnum = 2;  //只能刷新两次
        private void FormGame_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            
        }

        int score1;   // 第1 2个人的分数
        bool first;  // 标识第一个用户是否已经玩了
        private void saveScore()  // 保存分数
        {
            if (type1 == 0)  // 单人模式才保存分数
            {
                DBOperate db = new DBOperate();
                db.OperateData("insert into t_score values('" + System.DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + "'," + score.ToString() + ",'" + type2.ToString() + "')");
            }
            else {
                if (!first)
                {
                    score1 = score; //保存上一个人的分数
                }
            }
        }

        // 刷新 重新排列
        private void label4_Click(object sender, EventArgs e)
        {
            if (refreshnum > 0)
            {
                // 刷新音乐
                refreshplayer.Play();
                // 乱序
                byte[] keys = new byte[widths * heights];
                (new Random()).NextBytes(keys);
                Array.Sort(keys, gmap);
                for (int i = 0; i < widths; i++)
                    for (int j = 0; j < heights; j++)
                    {
                        kernel.GiveMapValue(i, j, gmap[i * heights + j]);
                    }
                this.Invalidate();
                --refreshnum;
                if(refreshnum==0)
                    label4.Visible = false;
            }
        }
    }
}
