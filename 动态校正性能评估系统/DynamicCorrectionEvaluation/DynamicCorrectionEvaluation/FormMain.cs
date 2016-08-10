using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace DynamicCorrectionEvaluation
{
    public partial class FormMain : Form
    {
        public FormMain()
        {
            
            InitializeComponent();
            this.skinEngine2.SkinFile = "Longhorn.ssk";   //添加皮肤
        }
        #region 参数

        public string username, usertype;  // 用户名 用户类型
        public FormLogin login = new FormLogin();


        private const double cv = 3e8;  //光速
        private static double f;  // 频率
        private const int N = 16;
        private static int Mbit = 5, M;  //打码数 阵元数
        private static int i, j;  // 遍历常量  常用

        //阵元坐标px,py,pz
        private Matrix px = new Matrix(N, 1);
        private Matrix py = new Matrix(N, 1);
        private Matrix pz = new Matrix(N, 1);

        //阵元初相值
        private Matrix Betax0d = new Matrix(N, 1);

        //监测点位置  四个点
        private static double theta0, theta1, theta2, theta3;//%deg
        private static double phi0, phi1, phi2, phi3;     //%deg

        private bool isXHGeneral = false;  //指示是否已经进行信号生成
        #endregion
        private void FormMain_Load(object sender, EventArgs e)
        {
            skinEngine2.AddForm(this);  //只加载皮肤在本窗体
            // 初始化参数
            initParameter();

            // 主页面状态栏初始化
            toolStripStatusLabel1.Text = "当前用户：" + getUser();  //显示用户名
            toolStripStatusLabel3.Text = "当前操作：登录";
            toolStripStatusLabel5.Text = getNow();   // 获得时间
            if (usertype != "admin")
            {
                toolStripButton4.Visible = false;
                tabPage2.Parent = null;
            }

            //主页面主主语不显示内容
            switchOperator(0);

            // 一些表格初始化
            dt_Betadecd = new DataTable("Betadecd");
            dt_Betadecd.Columns.Add("序号", Type.GetType("System.Int32"));
            dt_Betadecd.Columns.Add("相位/度", Type.GetType("System.Double"));
            dt_Yua = new DataTable("Betadecd");
            dt_Yua.Columns.Add("序号", Type.GetType("System.Int32"));
            dt_Yua.Columns.Add("理论值/度", Type.GetType("System.Double"));
            dt_Yua.Columns.Add("检测值/度", Type.GetType("System.Double"));

            for (i = 1; i <= N; i++)
            {
                DataRow r0 =dt_Betadecd.NewRow();
                r0[0] = i;
                dt_Betadecd.Rows.Add(r0);
                DataRow r1 = dt_Yua.NewRow();
                r1[0] = i;
                dt_Yua.Rows.Add(r1);
            }
        }

        #region 系统函数
        // 切换显示操作
        private void switchOperator(int i)
        {
            panel1.Dock = DockStyle.Fill;
            panel2.Dock = DockStyle.Fill;
            panel3.Dock = DockStyle.Fill;
            panel4.Dock = DockStyle.Fill;
            panel5.Dock = DockStyle.Fill;
            panel6.Dock = DockStyle.Fill;
            panel7.Dock = DockStyle.Fill;
            panel8.Dock = DockStyle.Fill;
            panel9.Dock = DockStyle.Fill;

            panel1.Visible = false;
            panel2.Visible = false;
            panel3.Visible = false;
            panel4.Visible = false;
            panel5.Visible = false;
            panel6.Visible = false;
            panel7.Visible = false;
            panel8.Visible = false;
            panel9.Visible = false;
            panelBack.Visible = false;
            switch (i)
            {
                case 1: //修改密码
                    panel1.Visible = true;
                    panel1.Dock = DockStyle.Fill;
                    old.Focus();
                    break;
                case 2: //用户管理
                    panel2.Visible = true;
                    panel2.Dock = DockStyle.Fill;
                    break;
                case 3: //参数配置
                    panel3.Visible = true;
                    panel3.Dock = DockStyle.Fill;
                    break;
                case 4: //信号生成
                    panel4.Visible = true;
                    panel4.Dock = DockStyle.Fill;
                    break;
                case 5: //信号输出 
                    panel5.Visible = true;
                    panel5.Dock = DockStyle.Fill;
                    break;
                case 6: //单点监测
                    panel6.Visible = true;
                    panel6.Dock = DockStyle.Fill;
                    break;
                case 7: //联合处理
                    panel7.Visible = true;
                    panel7.Dock = DockStyle.Fill;
                    break;
                case 8: //查看日志
                    panel8.Visible = true;
                    panel8.Dock = DockStyle.Fill;
                    break;
                case 9: //查看历史
                    panel9.Visible = true;
                    panel9.Dock = DockStyle.Fill;
                    break;
                default:
                    panelBack.Visible = true;
                    panelBack.Dock = DockStyle.Fill;
                    break;
            }
        }

        // 初始化参数
        private void initParameter()
        {
            // 初始化频率
            f = 2094e6;

            //初始化阵元坐标px,py,pz
            double[] px1 = new double[N] { 0, 0.2482, 0, -0.2482, -0.2482, 0, 0.2482, 0.4964, 0.2482, 0, -0.2482, -0.4964, -0.4964, -0.4964, -0.2482, 0 };
            double[] py1 = new double[N] { 0, 0.1433, 0.2866, 0.1433, -0.1433, -0.2866, -0.1433, 0.2866, 0.4299, 0.5732, 0.4299, 0.2866, 0, -0.2866, -0.4299, -0.5732 };
            double[] pz1 = new double[N] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

            for (i = 0; i < N; i++)
            {
                px[i, 0] = px1[i];
                py[i, 0] = py1[i];
                pz[i, 0] = pz1[i];
            }
            // 初始化//阵元初相值
            //常值初始化 matlab参考值
            //double[] Betax0dt = new double[16] { -10, -17, 0, -9, 10, 20, 9, 15, -3, -6, 6, 12, -12, 14.5, 4, -5 };
            //for (i = 0; i < N; i++)
            //    Betax0d[i, 0] = Betax0dt[i];
            // 随机初始化
            for (i = 0; i < N; i++)
                //Betax0d[i, 0] = Math.Round(NextDouble(_random, -20, 20), 4);
                Betax0d[i, 0] = Math.Round(NextDouble(_random, -180, 180), 4);


            //波束指向初始化
            theta0 = 4.898;
            phi0 = 299.105;

            // 监测点位置初始化
            theta1 = 6.185;
            phi1 = 268.74;
            theta2 = 5.877;
            phi2 = 328.64;
            theta3 = 7.607;
            phi3 = 307.382;
        }
        // 产生随机数
        public Random _random = new Random();
        private double NextDouble(Random random, double miniDouble, double maxiDouble)
        {
            if (random != null)
            {
                return random.NextDouble() * (maxiDouble - miniDouble) + miniDouble;
            }
            else
            {
                return 0.0d;
            }
        }
        //获得精确日期时间
        private string getNow()
        {  //获得星期几
            string ss = DateTime.Now.ToString("yyyy年MM月dd日  hh:mm:ss  ");
            switch (DateTime.Now.DayOfWeek.ToString())
            {
                case "Monday":
                    ss += "星期一";
                    break;
                case "Tuesday":
                    ss += "星期二";
                    break;
                case "Wednesday":
                    ss += "星期三";
                    break;
                case "Thursday":
                    ss += "星期四";
                    break;
                case "Friday":
                    ss += "星期五";
                    break;
                case "Saturday":
                    ss += "星期六";
                    break;
                case "Sunday":
                    ss += "星期日";
                    break;
            }
            return ss;
        }

        // 获得用户信息
        private string getUser()
        {
            string user;
            user = username;
            if (usertype == "admin") user += "(超级用户)";
            else user += "(普通用户)";
            return user;
        }


        // 定时器
        private void timer1_Tick(object sender, EventArgs e)
        {
            toolStripStatusLabel5.Text = getNow();   // 获得时间
        }
        Boolean exit_flag = true;  //默认是退出
        // 注销登录
        private void pictureBox3_Click(object sender, EventArgs e)
        {
            if (DialogResult.OK == MessageBox.Show("确实要注销当前用户吗？", "提醒", MessageBoxButtons.OKCancel))
            {
                exit_flag = false;  // 不是退出时注销
                this.Close(); //注销
            }
        }
        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (exit_flag)
            {
                if (DialogResult.OK == MessageBox.Show("确实要退出系统吗？", "提醒", MessageBoxButtons.OKCancel))
                {
                    Environment.Exit(0);
                }
                else e.Cancel = true;
            }
            else login.Show();  //注销而已了
        }

        private void FormMain_SizeChanged(object sender, EventArgs e)
        {
            try
            {
                { // 表格大小设置
                    dataGridView10.Columns[0].Width = 40;
                    dataGridView10.Columns[1].Width = (dataGridView10.Width - 70);
                    dataGridView11.Columns[0].Width = 40;
                    dataGridView11.Columns[1].Width = (dataGridView11.Width - 70) / 2;
                    dataGridView11.Columns[2].Width = (dataGridView11.Width - 70) / 2;
                }

                panelL.Width = panelMain.Width / 20;
                panelR.Width = panelL.Width;
                panelT.Height = panelMain.Height / 17;
                panelB.Height = panelT.Height;
                {  //用户管理
                    panelUserManaRight.Width = panel2.Width / 6;
                    panelUserManaLeft.Width = panel2.Width / 6;
                    panelUserManaTop.Height = panel2.Height / 7;
                    panelUserManaBottom.Height = panel2.Height / 7;
                    if (dataGridView1.Columns.Count > 0)
                    {
                        dataGridView1.Columns[0].Width = (dataGridView1.Width - 50) / 3;//设置列宽度
                        dataGridView1.Columns[1].Width = dataGridView1.Columns[0].Width;//设置列宽度
                        dataGridView1.Columns[2].Width = dataGridView1.Columns[0].Width;//设置列宽度
                    }
                }
                {  //参数设置
                    if (panelCanShuSetLeft.Height - panelF.Height - groupBox2.Height - groupBox3.Height - groupBox4.Height > 0)
                    {
                        panelCanShuSetLeft1.Height = (panelCanShuSetLeft.Height - panelF.Height - groupBox2.Height - groupBox3.Height - groupBox4.Height) / 5;
                        panelCanShuSetLeft2.Height = panelCanShuSetLeft1.Height;
                        panelCanShuSetLeft3.Height = panelCanShuSetLeft1.Height;
                        panelCanShuSetLeft4.Height = panelCanShuSetLeft1.Height;
                        panelCanshuSetRitherTop.Height = panelCanShuSetLeft1.Height + 30;
                        panelCanshuSetRitherBottom.Height = panelCanShuSetLeft1.Height;
                    }


                    panelCanshuSetGJLeft1.Height = (panelCanshuGJLEft.Height - panelCanshuSetGJLeft2.Height - groupBox5.Height) / 7;
                    panelCanshuSetGJLeft3.Height = panelCanshuSetGJLeft1.Height * 2;

                    panelCanshuSetGJFG.Width = panelCanshuSetGJCenter.Width / 9;
                    panelCanshuSetGJCenterTop.Height = panelCanshuSetGJLeft1.Height;
                    panelCanshuSetGJCenterBottom.Height = panelCanshuSetGJLeft1.Height;
                    if (dataGridView3.Columns.Count > 0)
                    {
                        dataGridView3.Columns[0].Width = 40;
                        dataGridView3.Columns[1].Width = dataGridView3.Width - 70;
                    }
                    if (dataGridView2.Columns.Count > 0)
                    {
                        dataGridView2.Columns[0].Width = 40;
                        dataGridView2.Columns[1].Width = (dataGridView2.Width - 70) / 3;
                        dataGridView2.Columns[2].Width = dataGridView2.Columns[1].Width;
                        dataGridView2.Columns[3].Width = dataGridView2.Columns[1].Width;
                    }
                }

                {  //日至查看
                    if (dataGridView5.Columns.Count > 0)
                    {
                        dataGridView5.Columns[0].Width = dataGridView5.Width / 4 - 20;//设置列宽度
                        dataGridView5.Columns[1].Width = dataGridView5.Width / 2;//设置列宽度
                        dataGridView5.Columns[2].Width = dataGridView5.Width / 4 - 20;//设置列宽度
                    }
                }
                {  //查看历史
                    if (dataGridView6.Columns.Count > 0)
                    {
                        dataGridView6.Columns[6].Width = 200;//设置列宽度
                        dataGridView6.Columns[0].Width = (dataGridView6.Width - 230) / 7;
                        dataGridView6.Columns[1].Width = (dataGridView6.Width - 230) / 7;
                        dataGridView6.Columns[2].Width = (dataGridView6.Width - 230) / 7;
                        dataGridView6.Columns[3].Width = (dataGridView6.Width - 230) / 7;
                        dataGridView6.Columns[4].Width = (dataGridView6.Width - 230) / 7;
                        dataGridView6.Columns[5].Width = (dataGridView6.Width - 230) / 7;
                    }
                }

            }
            catch { }
        }

        #endregion



        #region 修改密码页面
        //修改密码
        private void pictureBox2_Click(object sender, EventArgs e)
        {
            switchOperator(1);  //主页显示修改密码
            toolStripStatusLabel3.Text = "当前操作：修改密码";
        }
        //修改密码
        private void button1_Click(object sender, EventArgs e)
        {
            if (old.Text == "" || newp.Text == "" || newpagain.Text == "")
            {
                MessageBox.Show("输入不能为空"); return;
            }

            string sql = "select * from t_user where username='" + username + "' and userpassword='" + old.Text.Trim() + "'";
            DataSet ds = ClassDB.getDataSet(sql);
            if (ds.Tables[0].Rows.Count <= 0)
            {
                MessageBox.Show("原密码错误，请重新输入");
                old.Text = "";
                old.Focus();
                return;
            }

            if (newp.Text != newpagain.Text)
            {
                MessageBox.Show("两次密码输入不相同"); newpagain.Focus(); return;
            }
            if (newp.Text.Length < 6)
            {
                MessageBox.Show("请确保密码长度大于6"); newp.Focus(); return;
            }
            if (newp.Text.Length > 20)
            {
                MessageBox.Show("请确保密码长度小于20"); newp.Focus(); return;
            }

            sql = "update t_user set userpassword='" + newp.Text.Trim() + "' where  username='" + username + "'";
            ClassDB.ExcuteSql(sql);
            MessageBox.Show("修改完成");
            insertLog("修改密码");
            old.Text = ""; newp.Text = ""; newpagain.Text = "";
        }
        #endregion




        #region  用户管理页面
        //用户管理
        private void pictureBox1_Click(object sender, EventArgs e)
        {
            switchOperator(2);  //主页显示用户管理
            toolStripStatusLabel3.Text = "当前操作：用户管理";
            ShowUserInfo();
        }
        //初始化用户管理页面
        private void ShowUserInfo()
        {
            string getUser =//创建SQL字符串
                "select username as 用户名,'*****' as 用户密码 ,usertype as 用户类型  from  t_user";
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
            dataGridView1.Columns[0].Width = (dataGridView1.Width-50)/3;//设置列宽度
            dataGridView1.Columns[1].Width = dataGridView1.Columns[0].Width;//设置列宽度
            dataGridView1.Columns[2].Width = dataGridView1.Columns[0].Width;//设置列宽度

            txtOPwd.Text = "";//清除文本内容
            txtOUser.Text = "";//清除文本内容
            comboBox1.SelectedIndex = 0;//设置默认选择项
            txtOUser.Focus();
        }
        // 删除用户
        private void button3_Click(object sender, EventArgs e)
        {
            //dataGridView1.SelectedCells[0].v
            if (dataGridView1.SelectedCells.Count == 0)
            {
                MessageBox.Show("请选择要删除的用户", "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;//退出事件
            }
            else
            {

                if (username.Length < 1)
                {
                    MessageBox.Show("未选中");
                    return;
                }
                try
                {
                    string username1 = dataGridView1.SelectedCells[0].Value.ToString();//得到用户名
                    string strsql =//创建SQL字符串
                    "delete from t_user where username='" + username1 + "'";
                    ClassDB.ExcuteSql(strsql);//删除数据库中指定记录
                    MessageBox.Show("删除成功！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    ShowUserInfo();
                    insertLog("删除用户：" + username1);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("数据库错误\r\n" + ex.Message);
                }
            }
        }
        //增加用户
        private void button2_Click(object sender, EventArgs e)
        {
            if (txtOUser.Text.Trim() == "" || txtOPwd.Text.Trim() == "" || comboBox1.Text.Trim() == "")
            {
                MessageBox.Show("请填写完整用户信息！", "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtOUser.Focus();
                return;//退出事件
            }
            try
            {
                string str =//创建SQL字符串
                    "select * from t_user where username='" + txtOUser.Text.Trim() + "'";
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
                    string type = "common";
                    if (comboBox1.SelectedIndex == 1) type = "admin";
                    str =//创建SQL字符串
                        "insert into t_user values('" + txtOUser.Text.Trim() + "','" + txtOPwd.Text.Trim() + "','" + type + "')";
                    ClassDB.ExcuteSql(str);
                    MessageBox.Show("添加成功！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    insertLog("添加用户：" + txtOUser.Text.Trim());
                    ShowUserInfo();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("添加用户失败！" + ex.Message, "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        //修改用户
        private void button4_Click(object sender, EventArgs e)
        {
            if (txtOUser.Text.Trim() == "" || txtOPwd.Text.Trim() == "" || comboBox1.Text.Trim() == "")
            {
                MessageBox.Show("请填写完整用户信息！", "提示",//弹出消息对话框
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtOUser.Focus();
                return;//退出事件
            }
            if (txtOUser.Text.Trim() == username)
            {
                MessageBox.Show("不能修改本人信息");
                txtOUser.Focus();
                return;
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
                "select * from t_user where username='" + txtOUser.Text.Trim() + "'";
                DataSet ds = ClassDB.getDataSet(str);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string type = "common";
                    if (comboBox1.SelectedIndex == 1) type = "admin";
                    string updatestr =//创建SQL字符串
                        "update t_user set userpassword='" + txtOPwd.Text.Trim() + "',usertype='" + type + "' where username='" + txtOUser.Text.Trim() + "'";
                    ClassDB.ExcuteSql(updatestr);//更新数据库信息
                    MessageBox.Show("修改成功！", "提示",//弹出消息对话框
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    insertLog("修改了用户" + txtOUser.Text.Trim() + "的密码和用户类型");
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

        //保证用户名为数字或字母
        private void txtOUser_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Back)
                e.Handled = false;
            else
                if (((e.KeyChar >= '0' && e.KeyChar <= '9') || (e.KeyChar >= 'A' && e.KeyChar <= 'Z') || (e.KeyChar >= 'a' && e.KeyChar <= 'z') || (e.KeyChar == 8) || (e.KeyChar == '_')) && txtOUser.Text.Length < 20)
                    e.Handled = false;
                else
                    e.Handled = true;
        }
        #endregion




        #region 查看日志
        int pages, nowpage;
        const int pageRows = 30;  //一页55行
        DataTable alllog;  //所有日志
        private void pictureBox4_Click(object sender, EventArgs e)
        {
            toolStripStatusLabel3.Text = "当前操作：查看日志";
            switchOperator(8);  //主页显示用户管理
            ShowLog();  //查看日志
        }
        //查看页面
        private void ShowLog()
        {
            string getlog =//创建SQL字符串
                "select username as 用户,operator as 执行操作 ,time as 操作时间  from  t_log order by time desc";
            try
            {
                alllog = ClassDB.getDataSet(getlog).Tables[0];
                nowpage = 1;
                pages=alllog.Rows.Count/pageRows;

                if (alllog.Rows.Count%pageRows!=0)
                {
                    pages+= 1; 
                }
                if (pages == 0) pages = 1;
                gotoPage();                
            }
            catch (Exception ex)
            {
                MessageBox.Show("数据库错误\r\n" + ex.Message);
                return;
            }
            dataGridView5.Columns[0].Width = dataGridView5.Width/4-20;//设置列宽度
            dataGridView5.Columns[1].Width = dataGridView5.Width / 2;//设置列宽度
            dataGridView5.Columns[2].Width = dataGridView5.Width / 4 - 20;//设置列宽度
        }
        void gotoPage()
        {
            labelPage.Text = "当前为：第" + nowpage.ToString() + "页，共" + pages.ToString() + "页。";
            DataTable dt = new DataTable();
            dt.Columns.Add("用户", Type.GetType("System.String"));
            dt.Columns.Add("执行操作", Type.GetType("System.String"));
            dt.Columns.Add("操作时间", Type.GetType("System.String"));
            DataRow row;
            for (i = (nowpage - 1) * pageRows; i < nowpage * pageRows && i < alllog.Rows.Count && i >= 0; i++)
            {
                row = dt.NewRow();
                row[0] = alllog.Rows[i][0].ToString();
                row[1] = alllog.Rows[i][1].ToString();
                row[2] = alllog.Rows[i][2].ToString();
                dt.Rows.Add(row);
            }
            dataGridView5.DataSource = dt;
        }
        private void buttonPrie_Click(object sender, EventArgs e)
        {
            if (nowpage == 1) {
                MessageBox.Show("已经是首页");
                return;
            }
            nowpage--;
            gotoPage();
        }

        private void buttonNext_Click(object sender, EventArgs e)
        {
            if (nowpage == pages)
            {
                MessageBox.Show("已经是尾页");
                return;
            }
            nowpage++;
            gotoPage();
        }
        void insertLog(string ope)
        { //向日志数据库插入ope操作
            //插入日志 用户登录操作
            string sql = "insert into t_log values('"
                + getUser() + "','"
                + ope + "','"
                + System.DateTime.Now.ToString() + "')"
                ;
            try
            {
                ClassDB.ExcuteSql(sql);  //执行插入*/
            }
            catch { }
        }
        private void buttonCleacRZ_Click(object sender, EventArgs e)
        {
            if (DialogResult.Cancel == MessageBox.Show("确实要清空所有日志记录吗？", "提醒", MessageBoxButtons.OKCancel))
            {
                return;
            }
            ClassDB.ExcuteSql("delete from t_log");         //执行删除
            pictureBox4_Click(sender,e);                    //重新加载
        }
        #endregion

        


        #region  查看历史页面

        private void pictureBox5_Click(object sender, EventArgs e)
        {
            toolStripStatusLabel3.Text = "当前操作：查看历史";
            switchOperator(9);  //主页显示用户管理
            tabControl3.SelectedIndex = 0;  //选中第一页
            comboBox8.SelectedIndex = 0;  //站点选中1
            comboBox7.SelectedIndex = 0;  // 阵元选中1
            show_a_c_s_Delta_r_gama();
        }
        //选择站点时
        private void comboBox8_SelectedIndexChanged(object sender, EventArgs e)
        {
            show_a_c_s_Delta_r_gama();
        }
        //选择阵元时
        private void comboBox7_SelectedIndexChanged(object sender, EventArgs e)
        {
            show_a_c_s_Delta_r_gama();
        }
        //将a_c_s_Delta_r_gama显示在页面上
        private void show_a_c_s_Delta_r_gama()
        {
            if (comboBox7.SelectedIndex >= 0 && comboBox8.SelectedIndex >= 0)
            {
                string sql = "select a,c,s,Delta,r,gama,time as 信号生成时间 from t_a_c_s_Delta_r_gama where REV_station='" + (comboBox8.SelectedIndex + 1).ToString() + "' and N='" + (comboBox7.SelectedIndex + 1).ToString() + "'";
                DataSet dt = ClassDB.getDataSet(sql);
                dataGridView6.DataSource = dt.Tables[0];
                dataGridView6.Columns[6].Width = 200;//设置列宽度
                dataGridView6.Columns[0].Width = (dataGridView6.Width-230) / 7;
                dataGridView6.Columns[1].Width = (dataGridView6.Width - 230) / 7;
                dataGridView6.Columns[2].Width = (dataGridView6.Width - 230) / 7;
                dataGridView6.Columns[3].Width = (dataGridView6.Width - 230) / 7;
                dataGridView6.Columns[4].Width = (dataGridView6.Width - 230) / 7;
                dataGridView6.Columns[5].Width = (dataGridView6.Width - 230) / 7;
            }
        }
        // 查看历史页面的tabpage切换
        private void tabControl3_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sql;
            DataSet dt;
            switch (tabControl3.SelectedIndex)
            {
                case 0:   //a_c_s_Delta_r_gama显示在页面上
                    comboBox8.SelectedIndex = 0;  //站点选中1
                    comboBox7.SelectedIndex = 0;  // 阵元选中1
                    show_a_c_s_Delta_r_gama();
                    break;
                case 1:  //显示ADk  B_inv
                    //显示ADk
                    sql = "select * from t_ADk";
                    dt = ClassDB.getDataSet(sql);
                    dataGridView7.DataSource = dt.Tables[0];
                    dataGridView7.Columns[9].Width = 200;//设置列宽度

                    //显示B_inv
                    sql = "select * from t_BInv";
                    dt = ClassDB.getDataSet(sql);
                    dataGridView8.DataSource = dt.Tables[0];
                    dataGridView8.Columns[9].Width = 200;//设置列宽度
                    showADkBInvSeleted(); // 显示选中的ADk BInv以矩阵形式显示
                    break;
                case 2:  //显示Yua
                    //显示B_inv
                    sql = "select * from t_Yua";
                    dt = ClassDB.getDataSet(sql);
                    dataGridView9.DataSource = dt.Tables[0];
                    dataGridView9.Columns[48].Width = 200;//设置列宽度
                    showSelectedYua();  // 显示选中的Yua以矩阵形式显示
                    break;
                default: break;
            }
        }
        //显示选中的ADk和B_inv以矩阵形式显示
        private void dataGridView8_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            showADkBInvSeleted();
        }
        //显示选中的ADk和B_inv以矩阵形式显示
        private void dataGridView7_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            showADkBInvSeleted();
        }
        //显示选中的ADk和B_inv以矩阵形式显示
        private void showADkBInvSeleted()
        {
            textBoxSelectADk.Text = "";
            labeltime1.Text = "";
            if (dataGridView7.SelectedCells.Count > 0)
            {
                string ss = "";
                for (i = 0; i < 3; i++)
                {
                    for (j = 0; j < 3; j++)
                        ss += string.Format("{0,10} ", dataGridView7.SelectedCells[i * 3 + j].Value.ToString());
                    ss += "\r\n";
                }
                textBoxSelectADk.Text = ss;
                labeltime1.Text = "生成信号时间(" + dataGridView7.SelectedCells[9].Value.ToString() + ")";
            }
            textBoxSelectBInv.Text = "";
            labeltime2.Text = "";
            if (dataGridView8.SelectedCells.Count > 0)
            {
                string ss = "";
                for (i = 0; i < 3; i++)
                {
                    for (j = 0; j < 3; j++)
                        ss += string.Format("{0,10} ", dataGridView8.SelectedCells[i * 3 + j].Value.ToString());
                    ss += "\r\n";
                }
                textBoxSelectBInv.Text = ss;
                labeltime2.Text = "生成信号时间(" + dataGridView8.SelectedCells[9].Value.ToString() + ")";
            }
        }
        // 显示选中的Yua以矩阵形式显示
        private void dataGridView9_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            showSelectedYua();
        }
        // 显示选中的Yua以矩阵形式显示
        private void showSelectedYua()
        {
            textBoxSelectYua.Text = "";
            labeltime4.Text = "";
            if (dataGridView9.SelectedCells.Count > 0)
            {
                string ss = "";
                for (i = 0; i < 16; i++)
                {
                    for (j = 0; j < 3; j++)
                        ss += string.Format("{0,10} ", dataGridView9.SelectedCells[i * 3 + j].Value.ToString());
                    ss += "\r\n";
                }
                textBoxSelectYua.Text = ss;
                labeltime4.Text = "无噪声下的检测值Yua" + System.Environment.NewLine + "信号生成时间(" + dataGridView9.SelectedCells[48].Value.ToString() + ")";
            }
        }
        private void buttonD1_Click(object sender, EventArgs e)
        {
            if (DialogResult.Cancel == MessageBox.Show("确实要清空所有记录吗？", "提醒", MessageBoxButtons.OKCancel))
            {
                return;
            }
            ClassDB.ExcuteSql("delete from t_a_c_s_Delta_r_gama");         //执行删除
            tabControl3_SelectedIndexChanged(sender, e);                   //重新加载
        }

        private void buttonD2_Click(object sender, EventArgs e)
        {
            if (DialogResult.Cancel == MessageBox.Show("确实要清空所有记录吗？", "提醒", MessageBoxButtons.OKCancel))
            {
                return;
            }
            ClassDB.ExcuteSql("delete from t_ADk");         //执行删除
            tabControl3_SelectedIndexChanged(sender, e);                   //重新加载
        }

        private void buttonD3_Click(object sender, EventArgs e)
        {
            if (DialogResult.Cancel == MessageBox.Show("确实要清空所有记录吗？", "提醒", MessageBoxButtons.OKCancel))
            {
                return;
            }
            ClassDB.ExcuteSql("delete from t_BInv");         //执行删除
            tabControl3_SelectedIndexChanged(sender, e);                   //重新加载
        }

        private void buttonD4_Click(object sender, EventArgs e)
        {
            if (DialogResult.Cancel == MessageBox.Show("确实要清空所有记录吗？", "提醒", MessageBoxButtons.OKCancel))
            {
                return;
            }
            ClassDB.ExcuteSql("delete from t_Yua");         //执行删除
            tabControl3_SelectedIndexChanged(sender, e);                   //重新加载
        }
        #endregion




        #region 参数设置页面
        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            initSetting();   //初始化设置页面
            switchOperator(3);
            tabControl1.SelectedIndex = 0;  //选中第一页
            toolStripStatusLabel3.Text = "当前操作：参数配置";
            FormMain_SizeChanged(sender, e);
        }
        //初始化参数配置页面
        DataTable dt_Betax0d, dt_pxyz;  //阵元初相值  阵元坐标 数据表声明
        private void initSetting()
        {
                //获取现在的参数值显示
                //Mbit
                textBoxMbit.Text = Mbit.ToString();

                // 频率
                textBoxF.Text = f.ToString();

                //波束指向
                textBoxtheta0.Text = theta0.ToString();
                textBoxphi0.Text = phi0.ToString();

                //监测点位置
                textBoxtheta1.Text = theta1.ToString();
                textBoxphi1.Text = phi1.ToString();
                textBoxtheta2.Text = theta2.ToString();
                textBoxphi2.Text = phi2.ToString();
                textBoxtheta3.Text = theta3.ToString();
                textBoxphi3.Text = phi3.ToString();

                //定义阵元初相值数据表
                dt_Betax0d = new DataTable();
                dt_Betax0d.Columns.Add("N", Type.GetType("System.Int32"));
                dt_Betax0d.Columns.Add("初相值", Type.GetType("System.Double"));
                dt_Betax0d.Columns[0].ReadOnly = true;

                //定义阵元坐标数据表
                dt_pxyz = new DataTable();
                dt_pxyz.Columns.Add("N", Type.GetType("System.Int32"));
                dt_pxyz.Columns.Add("px", Type.GetType("System.Double"));
                dt_pxyz.Columns.Add("py", Type.GetType("System.Double"));
                dt_pxyz.Columns.Add("pz", Type.GetType("System.Double"));
                dt_pxyz.Columns[0].ReadOnly = true;

                // 初始化阵元初相值  阵元坐标 
                DataRow row;
                for (int i = 0; i < N; i++)
                {
                    row = dt_Betax0d.NewRow();
                    row["N"] = i + 1;
                    row["初相值"] = Betax0d[i, 0];
                    dt_Betax0d.Rows.Add(row);

                    row = dt_pxyz.NewRow();
                    row["N"] = i + 1;
                    row["px"] = px[i, 0];
                    row["py"] = py[i, 0];
                    row["pz"] = pz[i, 0];
                    dt_pxyz.Rows.Add(row);
                }
            try{
                // 绑定阵元初相值  阵元坐标  进行显示
                dataGridView3.DataSource = dt_Betax0d;
                dataGridView3.Columns[0].Width = 30;
                dataGridView3.Columns[1].Width = dataGridView3.Width - 60; ;
                dataGridView2.DataSource = dt_pxyz;
                dataGridView2.Columns[0].Width = 50;
                dataGridView2.Columns[1].Width = (dataGridView2.Width - 90) / 3;
                dataGridView2.Columns[2].Width = dataGridView2.Columns[1].Width;
                dataGridView2.Columns[3].Width = dataGridView2.Columns[1].Width;
            }
            catch { }
                showZJL();
                chart4.Series[0].Points.Clear();
                chart4.Series[0].Points.DataBind(dt_Betax0d.AsEnumerable(), "N", "初相值", "");
        }
        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            FormMain_SizeChanged(sender,e);
        }
        //实时显示中间量
        private void showZJL()  
        {
            // 由当前参数获得局部的中间变量 来计算信号生成的过程量
            double result;
            //将设置的值写回去 
            double f1 = f;
            //频率
            if (double.TryParse(textBoxF.Text, out result))
                f1 = result;

            int Mbit1 = Mbit;
            //Mbit
            if (double.TryParse(textBoxMbit.Text, out result))
                Mbit1 = (int)result;

            double theta01 = theta0, theta11 = theta1, theta21 = theta2, theta31 = theta3, phi01 = phi0, phi11 = phi1, phi21 = phi2, phi31 = phi3;
            //波束指向
            if (double.TryParse(textBoxtheta0.Text, out result))
                theta01 = result;

            if (double.TryParse(textBoxphi0.Text, out result))
                phi01 = result;

            //监测点位置
            if (double.TryParse(textBoxtheta1.Text, out result))
                theta11 = result;
            if (double.TryParse(textBoxphi1.Text, out result))
                phi11 = result;
            if (double.TryParse(textBoxtheta2.Text, out result))
                theta21 = result;
            if (double.TryParse(textBoxphi2.Text, out result))
                phi21 = result;
            if (double.TryParse(textBoxtheta3.Text, out result))
                theta31 = result;
            if (double.TryParse(textBoxphi3.Text, out result))
                phi31 = result;

            Matrix px1 = new Matrix(px), py1 = new Matrix(py), pz1 = new Matrix(pz), Betax0d1 = new Matrix(Betax0d);
            //阵元初相值  阵元坐标 
            for (int i = 0; i < N; i++)
            {
                if (double.TryParse(dt_pxyz.Rows[i]["px"].ToString(), out result))
                    px1[i, 0] = result;
                if (double.TryParse(dt_pxyz.Rows[i]["py"].ToString(), out result))
                    py1[i, 0] = result;
                if (double.TryParse(dt_pxyz.Rows[i]["pz"].ToString(), out result))
                    pz1[i, 0] = result;
                if (double.TryParse(dt_Betax0d.Rows[i]["初相值"].ToString(), out result))
                    Betax0d1[i, 0] = result;
            }

            //下面计算参数产生的过程变量并显示
            double lam = cv / f1;  //波长
            double k = 2 * Math.PI / lam;  // 波数
            int M1 = (int)Math.Pow(2, Mbit1);

                        
            // px py pz为阵元坐标  超级用户可改 普通用户定死
            Matrix pe = new Matrix(N, 3);
            for (i = 0; i < N; i++)
            {
                pe[i, 0] = px[i, 0];
                pe[i, 1] = py[i, 0];
                pe[i, 2] = pz[i, 0];
            }

            Matrix pej = pe / 100;
            Matrix pex = pe + pej;


            //检测点方向余弦
            Matrix AD0 = My_Dcosine(theta01, phi01);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A0 = k * pex * AD0;

            Matrix AD1 = My_Dcosine(theta11, phi11);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A1 = k * pex * AD1;

            Matrix AD2 = My_Dcosine(theta21, phi21);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A2 = k * pex * AD2;

            Matrix AD3 = My_Dcosine(theta31, phi31);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A3 = k * pex * AD3;

            //下面开始显示中间过程变量
            // 显示波长 波数 打码数 阵元数
            textBoxlam.Text = Math.Round(lam, 4).ToString();
            //textBoxk.Text = Math.Round(k, 4).ToString();
            textBoxM.Text = M1.ToString();

            //显示方向余弦
            textBoxAD0.Text = AD0.ToString();
            textBoxAD1.Text = AD1.ToString();
            textBoxAD2.Text = AD2.ToString();
            textBoxAD3.Text = AD3.ToString();
            //显示波程差
            textBoxalfa_A1.Text = alfa_A1.ToString();
            textBoxalfa_A2.Text = alfa_A2.ToString();
            textBoxalfa_A3.Text = alfa_A3.ToString();
        }

        #region 编辑框输入有效性检测
        private void textBoxF_KeyPress(object sender, KeyPressEventArgs e)
        {
            //只允许输入数字
            if (char.IsNumber(e.KeyChar) || e.KeyChar == (char)Keys.Back)
                e.Handled = false;
            else
                e.Handled = true;
        }

        private void textBoxMbit_KeyPress(object sender, KeyPressEventArgs e)
        {
            //只允许输入数字
            if (char.IsNumber(e.KeyChar) || e.KeyChar == (char)Keys.Back)
                e.Handled = false;
            else
                e.Handled = true;
        }
        //自定义编辑框按键事件  这里保证编辑框输入为浮点数 四位数
        private void textBox_KeyPress(KeyPressEventArgs e, TextBox dgvTxt)
        {
            if (char.IsNumber(e.KeyChar) || e.KeyChar == '.' || e.KeyChar == (char)Keys.Back)
            {
                e.Handled = false;       //让操作生效
                int j = 0;
                int k = 0;
                bool flag = false;
                if (dgvTxt.Text.Length == 0)
                {
                    if (e.KeyChar == '.')
                    {
                        e.Handled = true;             //让操作失效
                    }
                }
                for (int i = 0; i < dgvTxt.Text.Length; i++)
                {
                    if (dgvTxt.Text[i] == '.')
                    {
                        j++;
                        flag = true;
                    }
                    if (flag)
                    {
                        if (char.IsNumber(dgvTxt.Text[i]) && e.KeyChar != (char)Keys.Back)
                        {
                            k++;
                        }
                    }
                    if (j >= 1)
                    {
                        if (e.KeyChar == '.')
                        {
                            e.Handled = true;             //让操作失效
                        }
                    }
                    if (k == 4)
                    {
                        if (char.IsNumber(dgvTxt.Text[i]) && e.KeyChar != (char)Keys.Back)
                        {
                            if (dgvTxt.Text.Length - dgvTxt.SelectionStart < 3)
                            {
                                if (dgvTxt.SelectedText != dgvTxt.Text)
                                {
                                    e.Handled = true;             ////让操作失效
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                e.Handled = true;
            }
        }

        //下面保证编辑框输入为4位数的小数
        private void textBoxtheta1_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxtheta1);
        }

        private void textBoxtheta2_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxtheta2);
        }

        private void textBoxtheta3_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxtheta3);
        }

        private void textBoxtheta0_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxtheta0);
        }

        private void textBoxphi0_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxphi0);
        }

        private void textBoxphi1_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxphi1);
        }

        private void textBoxphi2_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxphi2);
        }

        private void textBoxphi3_KeyPress(object sender, KeyPressEventArgs e)
        {
            textBox_KeyPress(e, textBoxphi3);
        }

        // 判断角度是否为有效值
        private void judezuobiao(TextBox t)
        {
            if (t.Text == "") t.Text = "0";
            if (double.Parse(t.Text) < 0 || double.Parse(t.Text) > 360)
            {
                t.Text = "0";
                MessageBox.Show("无效值，必须在0~360之间");
            }
            showZJL();       //实时显示中间量
            updateFthetaphi();   // 实时监测点
        }
        private void textBoxF_KeyUp(object sender, KeyEventArgs e)
        {
            showZJL(); //实时显示中间量
            updateFthetaphi();   // 实时更新频率
        }
        private void textBoxMbit_KeyUp(object sender, KeyEventArgs e)
        {
            if (textBoxMbit.Text == "") textBoxMbit.Text = "0";
            if (int.Parse(textBoxMbit.Text) > 25) {
                textBoxMbit.Text = "5";
                MessageBox.Show("Mbit不能超过25");
            }
            showZJL(); //实时显示中间量
        }
        // 下面保证所有编辑框在有效值之间0-360
        private void textBoxtheta1_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxtheta1);
        }

        private void textBoxphi1_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxphi1);
        }

        private void textBoxtheta2_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxtheta2);
        }

        private void textBoxphi2_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxphi2);
        }

        private void textBoxtheta3_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxtheta3);
        }

        private void textBoxphi3_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxphi3);
        }

        private void textBoxphi0_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxphi0);
        }

        private void textBoxtheta0_KeyUp(object sender, KeyEventArgs e)
        {
            judezuobiao(textBoxtheta0);
        }
        #endregion
        #region 保证datagrid输入为有效值
        //下面保证datagrid输入为有效值
        // 声明 一个 CellEdit
        public DataGridViewTextBoxEditingControl dgvTxt = null;
        // 自定义事件KeyPress事件  
        private void Cells_KeyPress(object sender, KeyPressEventArgs e)
        {
            keyPressXS(e, dgvTxt);
        }
        //自定义按键事件  这里保证编辑框输入为浮点数 四位数
        public static void keyPressXS(KeyPressEventArgs e, DataGridViewTextBoxEditingControl dgvTxt)
        {
            //允许输入数字、小数点、删除键和负号 
            if (e.KeyChar == 8)
            {
                e.Handled = false;
                return;
            }
            if ((e.KeyChar < 48 || e.KeyChar > 57) && e.KeyChar != 8 && e.KeyChar != (char)('.') && e.KeyChar != (char)('-'))
            {
                //dgvTxt.Text = "";
                e.Handled = true;
                return;
            }
            if (e.KeyChar == (char)('-'))
            {
                if (dgvTxt.Text.IndexOf("-") >= 0) e.Handled = true;
            }
            //小数点只能输入一次  
            if (e.KeyChar == (char)('.') && dgvTxt.Text.IndexOf(".") >= dgvTxt.SelectionStart)
            {
                //dgvTxt.Text = "";
                e.Handled = true;
            }
            if (dgvTxt.Text.IndexOf(".") >= 0 && dgvTxt.Text.IndexOf(".") < dgvTxt.SelectionStart)
            {   //存在小数点的话
                if (e.KeyChar == '.')  //不能有两个小数点 
                    e.Handled = true;             //让操作失效

                if (dgvTxt.Text.Length - dgvTxt.Text.IndexOf(".") - dgvTxt.SelectionLength > 4 && e.KeyChar != (char)Keys.Back)  //如果达到四位小数和不是删除键
                    e.Handled = true;             ////让操作失效
            }
            //第一位不能为小数点  
            if (e.KeyChar == (char)('.') && dgvTxt.Text == "")
            {
                //dgvTxt.Text = "";
                e.Handled = true;
            }
            //第一位是0，第二位必须为小数点  
            if (e.KeyChar != (char)('.') && dgvTxt.Text == "0")
            {
                //dgvTxt.Text = "";
                e.Handled = true;
            }
            //第一位是负号，第二位不能为小数点  
            if (dgvTxt.Text == "-" && e.KeyChar == (char)('.'))
            {
                //dgvTxt.Text = "";
                e.Handled = true;
            }
        }
        // 自定义事件KeyUp事件  
        private void Cells_KeyUp1(object sender, KeyEventArgs e)
        {
            if (dgvTxt.Text != "-" && dgvTxt.Text != "")
            {
                double rr;
                if (double.TryParse(dgvTxt.Text, out rr))
                {
                    if (Math.Abs(rr) >= 1)
                    {
                        dgvTxt.Text = "0";
                        MessageBox.Show("无效参数，应该设置为绝对值小于1的浮点数");
                    }
                }
                else
                {
                    dgvTxt.Text = "0";
                    MessageBox.Show("无效参数");
                }
            }
        }
        private void dataGridView2_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            dgvTxt = (DataGridViewTextBoxEditingControl)e.Control; // 赋值     
            dgvTxt.SelectAll();
            dgvTxt.KeyPress += Cells_KeyPress; // 绑定到事件
            dgvTxt.KeyUp += Cells_KeyUp1;
        }
        // 自定义事件KeyUp事件  
        private void Cells_KeyUp2(object sender, KeyEventArgs e)
        {
            
            if (dgvTxt.Text != "-" && dgvTxt.Text != "")
            {
                double rr;
                if (double.TryParse(dgvTxt.Text, out rr))
                {
                    if (Math.Abs(rr) > 180)
                    {
                        dgvTxt.Text = "0";
                        MessageBox.Show("无效参数，应该设置为绝对值小于180的浮点数");
                    }
                }
                else
                {
                    dgvTxt.Text = "0";
                    MessageBox.Show("无效参数");
                }
                dataGridView3.CommitEdit(DataGridViewDataErrorContexts.Commit);  //提交更新
                updateFthetaphi();   // 实时更新阵元初相
                //显示绘图
                chart4.Series[0].Points.Clear();
                chart4.Series[0].Points.DataBind(dt_Betax0d.AsEnumerable(), "N", "初相值", "");
            }
            
        }
        private void dataGridView3_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            dgvTxt = (DataGridViewTextBoxEditingControl)e.Control; // 赋值     
            dgvTxt.SelectAll();
            dgvTxt.KeyPress += Cells_KeyPress; // 绑定到事件
            dgvTxt.KeyUp += Cells_KeyUp2;
        }

        #endregion
        //更新频率f  监测点 thetaphi  阵元初相
        void updateFthetaphi()  
        {
            double result;
            //将设置的值写回去 
            //频率
            if (double.TryParse(textBoxF.Text, out result))
                f = result;
            //监测点位置
            if (double.TryParse(textBoxtheta1.Text, out result))
                theta1 = result;
            if (double.TryParse(textBoxphi1.Text, out result))
                phi1 = result;
            if (double.TryParse(textBoxtheta2.Text, out result))
                theta2 = result;
            if (double.TryParse(textBoxphi2.Text, out result))
                phi2 = result;
            if (double.TryParse(textBoxtheta3.Text, out result))
                theta3 = result;
            if (double.TryParse(textBoxphi3.Text, out result))
                phi3 = result;
            //阵元初相值  阵元坐标 
            for (int i = 0; i < N; i++)
            {
                if (double.TryParse(dt_Betax0d.Rows[i]["初相值"].ToString(), out result))
                    Betax0d[i, 0] = result;
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            if (usertype == "admin")  //管理员改变参数
                if (DialogResult.Cancel == MessageBox.Show("是否确认修改参数？可能引起错误！", "提醒", MessageBoxButtons.OKCancel))
                    return;
            dataGridView2.CommitEdit(DataGridViewDataErrorContexts.Commit);

            double result;
            //将设置的值写回去 
            //Mbit
            if (double.TryParse(textBoxMbit.Text, out result))
                Mbit = (int)result;

            //波束指向
            if (double.TryParse(textBoxtheta0.Text, out result))
                theta0 = result;
            if (double.TryParse(textBoxphi0.Text, out result))
                phi0 = result;


            //阵元初相值  阵元坐标 
            for (int i = 0; i < N; i++)
            {
                if (double.TryParse(dt_pxyz.Rows[i]["px"].ToString(), out result))
                    px[i, 0] = result;
                if (double.TryParse(dt_pxyz.Rows[i]["py"].ToString(), out result))
                    py[i, 0] = result;
                if (double.TryParse(dt_pxyz.Rows[i]["pz"].ToString(), out result))
                    pz[i, 0] = result;
            }
            MessageBox.Show("修改完成");
            insertLog("修改了高级参数");
        }
        #endregion




        #region 信号生成
        //下面矩阵声明  存储需要后面用到的数据  结果变量
        Matrix Beta1exptemsump;  //站点1  N行M列  即N个阵元  每一行表示一个阵元的数据
        Matrix Beta2exptemsump;  //站点2  N行M列  即N个阵元  每一行表示一个阵元的数据
        Matrix Beta3exptemsump;  //站点3  N行M列  即N个阵元  每一行表示一个阵元的数据

        Matrix ADk;                                  //联合处理矩阵系数
        Matrix B_inv;                                //联合处理矩阵结果
        Matrix Yua;                                  //联合处理值
        Matrix Beta1decd, Beta2decd, Beta3decd;      //单点监测结果点
        public void Calculate()
        {
            double lam = cv / f;  //波长
            double k = 2 * Math.PI / lam;  // 波数
            M = (int)Math.Pow(2, Mbit);
            Matrix pha_seqd = new Matrix(1, M); //打码的相位值（角度）
            for (i = 0; i < M; i++) pha_seqd[0, i] = i * 360.0 / (double)M;
            Matrix pha_seq = pha_seqd.deg2rad();  // 变为弧度

            //声明三个矩阵传地址进函数获得函数结果
            Matrix cos_t = new Matrix(1, M);
            Matrix sin_t = new Matrix(1, M);
            Matrix A_c_inv = new Matrix(3, 3);
            My_a_c(pha_seq, M, ref A_c_inv, ref cos_t, ref sin_t);  //传址方式
            // px py pz为阵元坐标  超级用户可改 普通用户定死

            Matrix pe = new Matrix(N, 3);
            for (i = 0; i < N; i++)
            {
                pe[i, 0] = px[i, 0];
                pe[i, 1] = py[i, 0];
                pe[i, 2] = pz[i, 0];
            }

            Matrix pej = pe / 100;
            Matrix pex = pe + pej;

            Matrix pe1 = new Matrix(1, 3); // 存储pe第一行元素
            pe1[0, 0] = pe[0, 0];
            pe1[0, 1] = pe[0, 1];
            pe1[0, 2] = pe[0, 2];
            Matrix ped = pe - Matrix.ones(N, 1) * pe1;


            Matrix Betax0rad = Betax0d.deg2rad();
            Matrix Betax0exp = Betax0rad * Matrix.ones(1, M);
            Matrix Betaxd = Betax0d - Betax0d[0, 0];
            Matrix Betaxrad = Betaxd.deg2rad();

            //检测点方向余弦
            Matrix AD0 = My_Dcosine(theta0, phi0);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A0 = k * pex * AD0;

            Matrix AD1 = My_Dcosine(theta1, phi1);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A1 = k * pex * AD1;

            Matrix AD2 = My_Dcosine(theta2, phi2);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A2 = k * pex * AD2;

            Matrix AD3 = My_Dcosine(theta3, phi3);  //检测点的Ax Ay Az方向余弦
            Matrix alfa_A3 = k * pex * AD3;


            //三站联合处理的矩阵系数
            Matrix ADk01 = k * (AD0 - AD1);
            Matrix ADk02 = k * (AD0 - AD2);
            Matrix ADk03 = k * (AD0 - AD3);
            ADk = new Matrix(3, 3);
            for (i = 0; i < 3; i++)
                ADk[i, 0] = ADk01[i, 0];
            for (i = 0; i < 3; i++)
                ADk[i, 1] = ADk02[i, 0];
            for (i = 0; i < 3; i++)
                ADk[i, 2] = ADk03[i, 0];
            ADk = ADk.Transpose();     //转置


            Matrix B = new Matrix(3, 3);
            for (i = 0; i < 3; i++)
                B[i, 0] = 1;
            for (i = 0; i < 3; i++)
                B[i, 1] = ADk[i, 0];
            for (i = 0; i < 3; i++)
                B[i, 2] = ADk[i, 1];
            B_inv = Matrix.converse(B);//求逆  


            Matrix Beta1 = Betaxrad + alfa_A0 - alfa_A1;
            Matrix Beta2 = Betaxrad + alfa_A0 - alfa_A2;
            Matrix Beta3 = Betaxrad + alfa_A0 - alfa_A3;

            Matrix a_c_s_Delta_r_gama = new Matrix(N, 6);  //N个阵元的六个中间变量  
            //REV_station1
            Matrix Beta1exp = Beta1 * Matrix.ones(1, M);
            Matrix Beta1dec = new Matrix(N, 1);
            //自定义函数  后两个参数为返回值
            Beta1exptemsump = REV_station(Beta1exp, pha_seq, cos_t, sin_t, ref Beta1dec, ref a_c_s_Delta_r_gama);
            Beta1decd = Beta1dec.rad2deg();
            write_a_c_s_Delta_r_gama(1, a_c_s_Delta_r_gama);  //将站点1的中间变量 a_c_s_Delta_r_gama写入数据库中

            //REV_station2
            Matrix Beta2exp = Beta2 * Matrix.ones(1, M);
            Matrix Beta2dec = new Matrix(N, 1);
            Beta2exptemsump = REV_station(Beta2exp, pha_seq, cos_t, sin_t, ref Beta2dec, ref a_c_s_Delta_r_gama);
            Beta2decd = Beta2dec.rad2deg();
            write_a_c_s_Delta_r_gama(2, a_c_s_Delta_r_gama);  //将站点2的中间变量 a_c_s_Delta_r_gama写入数据库中

            //REV_station3
            Matrix Beta3exp = Beta3 * Matrix.ones(1, M);
            Matrix Beta3dec = new Matrix(N, 1);
            Beta3exptemsump = REV_station(Beta3exp, pha_seq, cos_t, sin_t, ref Beta3dec, ref a_c_s_Delta_r_gama);
            Beta3decd = Beta3dec.rad2deg();
            write_a_c_s_Delta_r_gama(3, a_c_s_Delta_r_gama);  //将站点3的中间变量 a_c_s_Delta_r_gama写入数据库中

            //无噪声下的检测值
            Beta1dec = Beta1dec - ped * ADk01;
            Beta2dec = Beta2dec - ped * ADk02;
            Beta3dec = Beta3dec - ped * ADk03;
            Matrix BetaHB = new Matrix(N, 3);
            for (i = 0; i < N; i++)
                BetaHB[i, 0] = Beta1dec[i, 0];
            for (i = 0; i < N; i++)
                BetaHB[i, 1] = Beta2dec[i, 0];
            for (i = 0; i < N; i++)
                BetaHB[i, 2] = Beta3dec[i, 0];
            BetaHB = BetaHB.Transpose();  //转置
            Matrix BetaHB1 = new Matrix(3, 1); //BetaHB的第一列
            for (i = 0; i < 3; i++)
                BetaHB1[i, 0] = BetaHB[i, 0];
            Matrix BetaHBx = BetaHB1 * Matrix.ones(1, N);
            BetaHB = BetaHB - BetaHBx;
            Matrix Yu = B_inv * BetaHB;
            Yu = Yu.Transpose();  // 转置
            Yua = Yu.rad2deg();

            //写ADk_B_inv_Yua到数据库中
            write_ADk_B_inv_Yua(ADk, B_inv, Yua);


            //ZhenyuanYua初始化
            for (i = 0; i < N; i++)
            {
                //初始化text显示
                dt_Yua.Rows[i][1] = Math.Round(Betax0d[i, 0] - Betax0d[0, 0],4);
                dt_Yua.Rows[i][2] = Math.Round(Yua[i, 0],4);
            }
        }

        //写ADk_B_inv_Yua到数据库中
        private void write_ADk_B_inv_Yua(Matrix ADk, Matrix B_inv, Matrix Yua)
        {
            try
            {
                //写入B_inv
                string sql = "insert into t_BInv values('"
                    + Math.Round(B_inv[0, 0], 4).ToString() + "','"
                    + Math.Round(B_inv[0, 1], 4).ToString() + "','"
                    + Math.Round(B_inv[0, 2], 4).ToString() + "','"
                    + Math.Round(B_inv[1, 0], 4).ToString() + "','"
                    + Math.Round(B_inv[1, 1], 4).ToString() + "','"
                    + Math.Round(B_inv[1, 2], 4).ToString() + "','"
                    + Math.Round(B_inv[2, 0], 4).ToString() + "','"
                    + Math.Round(B_inv[2, 1], 4).ToString() + "','"
                    + Math.Round(B_inv[2, 2], 4).ToString() + "','"
                    + System.DateTime.Now.ToString() + "')"
                    ;
                ClassDB.ExcuteSql(sql);

                //写入ADk
                sql = "insert into t_ADk values('"
                   + Math.Round(ADk[0, 0], 4).ToString() + "','"
                   + Math.Round(ADk[0, 1], 4).ToString() + "','"
                   + Math.Round(ADk[0, 2], 4).ToString() + "','"
                   + Math.Round(ADk[1, 0], 4).ToString() + "','"
                   + Math.Round(ADk[1, 1], 4).ToString() + "','"
                   + Math.Round(ADk[1, 2], 4).ToString() + "','"
                   + Math.Round(ADk[2, 0], 4).ToString() + "','"
                   + Math.Round(ADk[2, 1], 4).ToString() + "','"
                   + Math.Round(ADk[2, 2], 4).ToString() + "','"
                   + System.DateTime.Now.ToString() + "')"
                   ;
                ClassDB.ExcuteSql(sql);

                //写入Yua
                //写入ADk
                sql = "insert into t_Yua values('"
                   + Math.Round(Yua[0, 0], 4).ToString() + "','"
                   + Math.Round(Yua[0, 1], 4).ToString() + "','"
                   + Math.Round(Yua[0, 2], 4).ToString() + "','"
                   + Math.Round(Yua[1, 0], 4).ToString() + "','"
                   + Math.Round(Yua[1, 1], 4).ToString() + "','"
                   + Math.Round(Yua[1, 2], 4).ToString() + "','"
                   + Math.Round(Yua[2, 0], 4).ToString() + "','"
                   + Math.Round(Yua[2, 1], 4).ToString() + "','"
                   + Math.Round(Yua[2, 2], 4).ToString() + "','"
                   + Math.Round(Yua[3, 0], 4).ToString() + "','"
                   + Math.Round(Yua[3, 1], 4).ToString() + "','"
                   + Math.Round(Yua[3, 2], 4).ToString() + "','"
                   + Math.Round(Yua[4, 0], 4).ToString() + "','"
                   + Math.Round(Yua[4, 1], 4).ToString() + "','"
                   + Math.Round(Yua[4, 2], 4).ToString() + "','"
                   + Math.Round(Yua[5, 0], 4).ToString() + "','"
                   + Math.Round(Yua[5, 1], 4).ToString() + "','"
                   + Math.Round(Yua[5, 2], 4).ToString() + "','"
                   + Math.Round(Yua[6, 0], 4).ToString() + "','"
                   + Math.Round(Yua[6, 1], 4).ToString() + "','"
                   + Math.Round(Yua[6, 2], 4).ToString() + "','"
                   + Math.Round(Yua[7, 0], 4).ToString() + "','"
                   + Math.Round(Yua[7, 1], 4).ToString() + "','"
                   + Math.Round(Yua[7, 2], 4).ToString() + "','"
                   + Math.Round(Yua[8, 0], 4).ToString() + "','"
                   + Math.Round(Yua[8, 1], 4).ToString() + "','"
                   + Math.Round(Yua[8, 2], 4).ToString() + "','"
                   + Math.Round(Yua[9, 0], 4).ToString() + "','"
                   + Math.Round(Yua[9, 1], 4).ToString() + "','"
                   + Math.Round(Yua[9, 2], 4).ToString() + "','"
                   + Math.Round(Yua[10, 0], 4).ToString() + "','"
                   + Math.Round(Yua[10, 1], 4).ToString() + "','"
                   + Math.Round(Yua[10, 2], 4).ToString() + "','"
                   + Math.Round(Yua[11, 0], 4).ToString() + "','"
                   + Math.Round(Yua[11, 1], 4).ToString() + "','"
                   + Math.Round(Yua[11, 2], 4).ToString() + "','"
                   + Math.Round(Yua[12, 0], 4).ToString() + "','"
                   + Math.Round(Yua[12, 1], 4).ToString() + "','"
                   + Math.Round(Yua[12, 2], 4).ToString() + "','"
                   + Math.Round(Yua[13, 0], 4).ToString() + "','"
                   + Math.Round(Yua[13, 1], 4).ToString() + "','"
                   + Math.Round(Yua[13, 2], 4).ToString() + "','"
                   + Math.Round(Yua[14, 0], 4).ToString() + "','"
                   + Math.Round(Yua[14, 1], 4).ToString() + "','"
                   + Math.Round(Yua[14, 2], 4).ToString() + "','"
                   + Math.Round(Yua[15, 0], 4).ToString() + "','"
                   + Math.Round(Yua[15, 1], 4).ToString() + "','"
                   + Math.Round(Yua[15, 2], 4).ToString() + "','"
                   + System.DateTime.Now.ToString() + "')"
                   ;
                ClassDB.ExcuteSql(sql);
            }
            catch { }
        }
        //写入站点REV_station的中间变量a_c_s_Delta_r_gama到数据库中
        private void write_a_c_s_Delta_r_gama(int REV_station, Matrix a_c_s_Delta_r_gama)
        {
            string sql;
            for (i = 0; i < N; i++)
            {
                sql = "insert into t_a_c_s_Delta_r_gama values('"
                    + REV_station.ToString() + "','"
                    + (i + 1).ToString() + "','"
                    + Math.Round(a_c_s_Delta_r_gama[i, 0], 4).ToString() + "','"
                    + Math.Round(a_c_s_Delta_r_gama[i, 1], 4).ToString() + "','"
                    + Math.Round(a_c_s_Delta_r_gama[i, 2], 4).ToString() + "','"
                    + Math.Round(a_c_s_Delta_r_gama[i, 3], 4).ToString() + "','"
                    + Math.Round(a_c_s_Delta_r_gama[i, 4], 4).ToString() + "','"
                    + Math.Round(a_c_s_Delta_r_gama[i, 5], 4).ToString() + "','"
                    + System.DateTime.Now.ToString() + "')";
                try
                {
                    ClassDB.ExcuteSql(sql);  //插入数据库中
                }
                catch { }
            }
        }
        //%%功率值模拟
        static public Matrix REV_station(Matrix Beta1exp, Matrix pha_seq, Matrix cos_t, Matrix sin_t, ref Matrix Beta1dec, ref Matrix a_c_s_Delta_r_gama)
        {
            Matrix Betaexptemsump = new Matrix(N, M);
            for (int Beta1ind = 0; Beta1ind < N; Beta1ind++)  //Beta1ind表示当前阵元
            {
                Matrix Beta1exp_tem = new Matrix(Beta1exp);
                for (j = 0; j < M; j++)
                    Beta1exp_tem[Beta1ind, j] += pha_seq[0, j];

                // 复数
                Matrix Beta1exp_temCos = Beta1exp_tem.cos();
                Matrix Beta1exp_temSin = Beta1exp_tem.sin();
                Matrix Beta1exp_temsumCos = new Matrix(1, M);
                Matrix Beta1exp_temsumSin = new Matrix(1, M);
                //复数运算
                for (i = 0; i < M; i++)
                    for (j = 0; j < N; j++)
                    {
                        Beta1exp_temsumCos[0, i] += Beta1exp_temCos[j, i];
                        Beta1exp_temsumSin[0, i] += Beta1exp_temSin[j, i];
                    }

                Matrix Beta1exptemsump = new Matrix(1, M);
                for (i = 0; i < M; i++)  // 复数共轭相乘
                {
                    Beta1exptemsump[0, i] = Beta1exp_temsumSin[0, i] * Beta1exp_temsumSin[0, i] + Beta1exp_temsumCos[0, i] * Beta1exp_temsumCos[0, i];
                    Betaexptemsump[Beta1ind, i] = Math.Round(Beta1exptemsump[0, i], 4);  //最终结果  一个N*M的矩阵
                }

                double a = 2 * Beta1exptemsump.mean();
                double c = 2 * (Beta1exptemsump ^ cos_t).mean();
                double s = 2 * (Beta1exptemsump ^ sin_t).mean();
                double Delta = Math.Atan2(-s, c);
                double r = Math.Sqrt((a + 2 * Math.Sqrt(c * c + s * s)) / (a - 2 * Math.Sqrt(c * c + s * s)));
                double gama = (r - 1) / (r + 1);

                Beta1dec[Beta1ind, 0] = Math.Atan2(Math.Sin(Delta), Math.Cos(Delta) + gama);

                //存储中间变量
                a_c_s_Delta_r_gama[Beta1ind, 0] = a;
                a_c_s_Delta_r_gama[Beta1ind, 1] = c;
                a_c_s_Delta_r_gama[Beta1ind, 2] = s;
                a_c_s_Delta_r_gama[Beta1ind, 3] = Delta;
                a_c_s_Delta_r_gama[Beta1ind, 4] = r;
                a_c_s_Delta_r_gama[Beta1ind, 5] = gama;
            }
            Beta1dec = Beta1dec - Beta1dec[0, 0];
            return Betaexptemsump;
        }
        #region  功能函数
        static public void My_a_c(Matrix phi_scope, int Num_Rev, ref Matrix A_c_inv, ref Matrix cos_t, ref Matrix sin_t)
        {
            cos_t = phi_scope.cos();
            sin_t = phi_scope.sin();
            Matrix A_c = new Matrix(3, 3);
            A_c[0, 0] = Num_Rev;
            A_c[0, 1] = cos_t.sum();
            A_c[0, 2] = sin_t.sum();
            Matrix ret = new Matrix(cos_t.Row, cos_t.Col);  //存储向量乘积 不是矩阵
            for (i = 0; i < cos_t.Row; i++)
                for (j = 0; j < cos_t.Col; j++)
                    ret[i, j] = cos_t[i, j] * cos_t[i, j];
            A_c[1, 1] = ret.sum();
            for (i = 0; i < cos_t.Row; i++)
                for (j = 0; j < cos_t.Col; j++)
                    ret[i, j] = cos_t[i, j] * sin_t[i, j];
            A_c[1, 2] = ret.sum();
            for (i = 0; i < cos_t.Row; i++)
                for (j = 0; j < cos_t.Col; j++)
                    ret[i, j] = sin_t[i, j] * sin_t[i, j];
            A_c[2, 2] = ret.sum();

            A_c[1, 0] = A_c[0, 1];
            A_c[2, 0] = A_c[0, 2];
            A_c[2, 1] = A_c[1, 2];
            A_c_inv = Matrix.converse(A_c);//求逆
        }
        //function [Ax Ay Az]=My_Dcosine(Theta,Beta)
        //Ax=sind(Theta).*cosd(Beta);%在x方向的方向余弦
        //Ay=sind(Theta).*sind(Beta);%在y方向的方向余弦
        //Az=cosd(Theta);%在z方向的方向余弦
        static public Matrix My_Dcosine(double Theta, double Beta)
        {
            Matrix ret = new Matrix(3, 1);
            ret[0, 0] = Math.Sin(Theta * Math.PI / 180) * Math.Cos(Beta * Math.PI / 180);
            ret[1, 0] = Math.Sin(Theta * Math.PI / 180) * Math.Sin(Beta * Math.PI / 180);
            ret[2, 0] = Math.Cos(Theta * Math.PI / 180);
            return ret;
        }
        #endregion

        //信号生成
        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            toolStripStatusLabel3.Text = "当前操作：信号生成";

            Calculate();  //开始重新计算
            isXHGeneral = true;  //信号已经生成  可以进行信号输出了
            switchOperator(4);
            comboBox2.SelectedIndex = 0;     //默认站点1
            showBetaexptemsumpData();
            insertLog("进行了信号生成");
        }
        //切换显式站点
        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpData();
        }
        private void showBetaexptemsumpData()
        {
            if (comboBox2.SelectedIndex >= 0)
            {
                //定义阵元初相值数据表
                DataTable dt_Betaexptemsump = new DataTable();
                dt_Betaexptemsump.Columns.Add("阵元号N", Type.GetType("System.Int32"));
                for (i = 0; i < M; i++) //建立M列 存储M个数据
                    dt_Betaexptemsump.Columns.Add("Bsump" + i.ToString(), Type.GetType("System.Double"));
                DataRow row;
                switch (comboBox2.SelectedIndex)
                {
                    case 0:  //站点1  显示Beta1exptemsump
                        for (i = 0; i < N; i++)
                        {
                            row = dt_Betaexptemsump.NewRow();
                            row[0] = i;
                            for (j = 0; j < M; j++)
                            {
                                row[j + 1] = Beta1exptemsump[i, j];
                            }
                            dt_Betaexptemsump.Rows.Add(row);
                        }
                        break;
                    case 1: //站点2 显示Beta2exptemsump
                        for (i = 0; i < N; i++)
                        {
                            row = dt_Betaexptemsump.NewRow();
                            row[0] = i;
                            for (j = 0; j < M; j++)
                            {
                                row[j + 1] = Beta2exptemsump[i, j];
                            }
                            dt_Betaexptemsump.Rows.Add(row);
                        }
                        break;
                    case 2://站点3 显示Beta3exptemsump
                        for (i = 0; i < N; i++)
                        {
                            row = dt_Betaexptemsump.NewRow();
                            row[0] = i;
                            for (j = 0; j < M; j++)
                            {
                                row[j + 1] = Beta3exptemsump[i, j];
                            }
                            dt_Betaexptemsump.Rows.Add(row);
                        }
                        break;
                    default: break;
                }
                dataGridView4.DataSource = dt_Betaexptemsump;
                
            }
        }
        #endregion




        #region  信号输出
        List<double> listX = new List<double>();   //绘图存储横坐标
        List<double> listY = new List<double>(); //绘图存储纵坐标
        private void toolStripButton6_Click(object sender, EventArgs e)
        {
            if (!isXHGeneral)
            {
                MessageBox.Show("请先进行信号生成");
                return;
            }
            toolStripStatusLabel3.Text = "当前操作：信号输出";
            switchOperator(5);          // 显示信号输出页面
            comboBox3.SelectedIndex = 0;     //默认站点1
            checkBox1.Checked = true;  //默认第一个阵元
            InitBetaexptemsumpChart();  // 初始化图标
        }
        //全选或取消
        private void checkBox17_CheckStateChanged(object sender, EventArgs e)
        {
            checkBox1.Checked = checkBox17.Checked;
            checkBox2.Checked = checkBox17.Checked;
            checkBox3.Checked = checkBox17.Checked;
            checkBox4.Checked = checkBox17.Checked;
            checkBox5.Checked = checkBox17.Checked;
            checkBox6.Checked = checkBox17.Checked;
            checkBox7.Checked = checkBox17.Checked;
            checkBox8.Checked = checkBox17.Checked;
            checkBox9.Checked = checkBox17.Checked;
            checkBox10.Checked = checkBox17.Checked;
            checkBox11.Checked = checkBox17.Checked;
            checkBox12.Checked = checkBox17.Checked;
            checkBox13.Checked = checkBox17.Checked;
            checkBox14.Checked = checkBox17.Checked;
            checkBox15.Checked = checkBox17.Checked;
            checkBox16.Checked = checkBox17.Checked;
            showBetaexptemsumpChart();
        }

        private void comboBox3_SelectedIndexChanged(object sender, EventArgs e)
        {
            InitBetaexptemsumpChart();  //重新初始化
        }

        string[] series = new string[N] { "阵元1", "阵元2", "阵元3", "阵元4", "阵元5", "阵元6", "阵元7", "阵元8", "阵元9", "阵元10", "阵元11", "阵元12", "阵元13", "阵元14", "阵元15", "阵元16" };
        //初始化所有图标
        List<double> []NlistX = new List<double>[N];   //绘图存储横坐标
        List<double>[] NlistY = new List<double>[N]; //绘图存储纵坐标
        private void  InitBetaexptemsumpChart() {
            chart1.Series.Clear();  //清空原先的所有图标
            if (comboBox3.SelectedIndex >= 0) {
                for (j = 0; j < N; j++)  //N阵元
                {
                    //新建阵元i的图标chart
                    chart1.Series.Add(series[j]);
                    NlistX[j]=new List<double>();
                    NlistY[j] = new List<double>();
                    switch (comboBox3.SelectedIndex)
                    {
                        case 0:  //站点1  显示Beta1exptemsump
                            for (i = 0; i < M; i++)  //M个数据
                            {
                                NlistX[j].Add(i);
                                NlistY[j].Add(Beta1exptemsump[j, i]);  //阵元j的 M个数据
                            }
                            break;
                        case 1: //站点2 显示Beta2exptemsump
                            for (i = 0; i < M; i++)
                            {
                                NlistX[j].Add(i);
                                NlistY[j].Add(Beta2exptemsump[j, i]);
                            }
                            break;
                        case 2://站点3 显示Beta3exptemsump
                            for (i = 0; i < M; i++)
                            {
                                NlistX[j].Add(i);
                                NlistY[j].Add(Beta3exptemsump[j, i]);
                            }
                            break;
                        default: break;
                    }
                    chart1.Series[series[j]].ChartType = SeriesChartType.FastLine;
                    chart1.Series[series[j]].BorderWidth = 3;
                    chart1.Series[series[j]].Points.DataBindXY(NlistX[j], NlistY[j]);

                    //设置最大值最小值
                    int mini = 0, maxi = 0;
                    getmax(NlistY[j], ref maxi);
                    getmin(NlistY[j], ref mini);
                                     
                    chart1.Series.Add(series[j]+"MM");
                    chart1.Series[series[j] + "MM"].ChartType = SeriesChartType.Point;
                    chart1.Series[series[j] + "MM"].MarkerSize = 8;
                    chart1.Series[series[j] + "MM"].Color = Color.Red;
                    //显示最值点
                    chart1.Series[series[j] + "MM"].Points.Clear();
                    chart1.Series[series[j] + "MM"].Points.AddXY(NlistX[j][mini], NlistY[j][mini]);
                    chart1.Series[series[j] + "MM"].Points.AddXY(NlistX[j][maxi], NlistY[j][maxi]);
                    chart1.Series[series[j] + "MM"].Points[0].IsValueShownAsLabel = true;
                    chart1.Series[series[j] + "MM"].Points[0].Label = "(" + Math.Round(NlistX[j][mini], 4).ToString() + "," + Math.Round(NlistY[j][mini], 4).ToString() + ")";
                    chart1.Series[series[j] + "MM"].Points[1].IsValueShownAsLabel = true;
                    chart1.Series[series[j] + "MM"].Points[1].Label = "(" + Math.Round(NlistX[j][maxi], 4).ToString() + "," + Math.Round(NlistY[j][maxi], 4).ToString() + ")";
                }
                setBetaexptemsumpChartColor();  //设置颜色
                showBetaexptemsumpChart();  //显示
            }
        }
        //显示波形
        private void showBetaexptemsumpChart()
        {
            chart1.Series[series[0]].Enabled = checkBox1.Checked;
            chart1.Series[series[0]+"MM"].Enabled = checkBox1.Checked;
            
            chart1.Series[series[1]].Enabled = checkBox2.Checked;
            chart1.Series[series[1] + "MM"].Enabled = checkBox2.Checked;

            chart1.Series[series[2]].Enabled = checkBox3.Checked;
            chart1.Series[series[2] + "MM"].Enabled = checkBox3.Checked;

            chart1.Series[series[3]].Enabled = checkBox4.Checked;
            chart1.Series[series[3] + "MM"].Enabled = checkBox4.Checked;

            chart1.Series[series[4]].Enabled = checkBox5.Checked;
            chart1.Series[series[4] + "MM"].Enabled = checkBox5.Checked;

            chart1.Series[series[5]].Enabled = checkBox6.Checked;
            chart1.Series[series[5] + "MM"].Enabled = checkBox6.Checked;

            chart1.Series[series[6]].Enabled = checkBox7.Checked;
            chart1.Series[series[6] + "MM"].Enabled = checkBox7.Checked;

            chart1.Series[series[7]].Enabled = checkBox8.Checked;
            chart1.Series[series[7] + "MM"].Enabled = checkBox8.Checked;

            chart1.Series[series[8]].Enabled = checkBox9.Checked;
            chart1.Series[series[8] + "MM"].Enabled = checkBox9.Checked;

            chart1.Series[series[9]].Enabled = checkBox10.Checked;
            chart1.Series[series[9] + "MM"].Enabled = checkBox10.Checked;

            chart1.Series[series[10]].Enabled = checkBox11.Checked;
            chart1.Series[series[10] + "MM"].Enabled = checkBox11.Checked;

            chart1.Series[series[11]].Enabled = checkBox12.Checked;
            chart1.Series[series[11] + "MM"].Enabled = checkBox12.Checked;

            chart1.Series[series[12]].Enabled = checkBox13.Checked;
            chart1.Series[series[12] + "MM"].Enabled = checkBox13.Checked;

            chart1.Series[series[13]].Enabled = checkBox14.Checked;
            chart1.Series[series[13] + "MM"].Enabled = checkBox14.Checked;

            chart1.Series[series[14]].Enabled = checkBox15.Checked;
            chart1.Series[series[14] + "MM"].Enabled = checkBox15.Checked;

            chart1.Series[series[15]].Enabled = checkBox16.Checked;
            chart1.Series[series[15] + "MM"].Enabled = checkBox16.Checked;
            double YMax = -1000000, YMin = 10000000,TMax,TMin;
            int maxi=0, mini=0;
            for (i = 0; i < N; i++)
            {
                if (chart1.Series[series[i]].Enabled) {   //如果显示
                    //则计算对应的最大值 最小值
                    TMax = getmax(NlistY[i], ref maxi);
                    TMin = getmin(NlistY[i], ref mini);
                    if (TMax > YMax) YMax = TMax;
                    if (TMin < YMin) YMin = TMin;
                  }
            }
            chart1.ChartAreas["ChartArea1"].AxisY.Maximum = YMax + (YMax - YMin)*3 / M;
            chart1.ChartAreas["ChartArea1"].AxisY.Minimum = YMin - (YMax - YMin)*2 / M;

            for (i = 0; i < N; i++) chart1.Series[series[i] + "MM"].IsVisibleInLegend = false;  //最大值最小值图标不显示legend
        }
        private void setBetaexptemsumpChartColor()
        {
            chart1.Series[series[0]].Color = label30.BackColor;
            chart1.Series[series[1]].Color = label40.BackColor;
            chart1.Series[series[2]].Color = label41.BackColor;
            chart1.Series[series[3]].Color = label42.BackColor;
            chart1.Series[series[4]].Color = label44.BackColor;
            chart1.Series[series[5]].Color = label45.BackColor;
            chart1.Series[series[6]].Color = label47.BackColor;
            chart1.Series[series[7]].Color = label48.BackColor;
            chart1.Series[series[8]].Color = label53.BackColor;
            chart1.Series[series[9]].Color = label57.BackColor;
            chart1.Series[series[10]].Color = label58.BackColor;
            chart1.Series[series[11]].Color = label59.BackColor;
            chart1.Series[series[12]].Color = label60.BackColor;
            chart1.Series[series[13]].Color = label61.BackColor;
            chart1.Series[series[14]].Color = label62.BackColor;
            chart1.Series[series[15]].Color = label63.BackColor;
        }
        private void checkBox1_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox2_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox3_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox4_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox5_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox6_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox7_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox8_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox9_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox10_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox11_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox12_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox13_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox14_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox15_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }

        private void checkBox16_CheckStateChanged(object sender, EventArgs e)
        {
            showBetaexptemsumpChart();
        }
        private double getmin(List<double> l1, ref int i) // 获取最小值
        {
            double y = 10000000;
            int n = l1.Count - 1;
            i = n;
            while (n >= 0)  // 遍历取最小值
            {
                if (l1[n] < y)
                {
                    y = l1[n];
                    i = n;  //记录最小值位置
                }
                n--;
            }
            return y;
        }
        private double getmax(List<double> l1, ref int i) // 获取最大值
        {
            double y = -10000000;
            int n = l1.Count - 1;
            i = n;
            while (n >= 0)  // 遍历取最小值
            {
                if (l1[n] > y)
                {
                    y = l1[n];
                    i = n;
                }
                n--;
            }
            return y;
        }
        #endregion




        #region  单点监测
        private void toolStripButton9_Click(object sender, EventArgs e)
        {
            if (!isXHGeneral)
            {
                MessageBox.Show("请先进行信号生成");
                return;
            }
            
            toolStripStatusLabel3.Text = "当前操作：单点监测";
            switchOperator(6);          // 显示信号输出页面
            comboBox5.SelectedIndex = 0;     //默认站点1
        }
        DataTable dt_Betadecd;
        private void comboBox5_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox5.SelectedIndex >= 0)
            {
                listX.Clear();
                listY.Clear();
                switch (comboBox5.SelectedIndex)
                {
                    case 0:  //站点1  显示Beta1decd
                        for (i = 0; i < N; i++)
                        {
                            listX.Add(i);
                            listY.Add(Beta1decd[i, 0]);
                            dt_Betadecd.Rows[i][1] = Math.Round(Beta1decd[i, 0],4);
                        }
                        break;
                    case 1: //站点2 显示Beta2decd
                        for (i = 0; i < N; i++)
                        {
                            listX.Add(i);
                            listY.Add(Beta2decd[i, 0]);
                            dt_Betadecd.Rows[i][1] = Math.Round(Beta2decd[i, 0], 4);
                        }
                        break;
                    case 2://站点3 显示Beta3decd
                        for (i = 0; i < N; i++)
                        {
                            listX.Add(i);
                            listY.Add(Beta3decd[i, 0]);
                            dt_Betadecd.Rows[i][1] = Math.Round(Beta3decd[i, 0], 4);
                        }
                        break;
                    default: break;
                }
                dataGridView10.DataSource = dt_Betadecd;
                //绑定数据源
                //设置坐标范围
                /*chart2.Series[0].Points.DataBindXY(listX, listY);
                int mini = 0, maxi = 0;
                chart2.ChartAreas["ChartArea1"].AxisY.Maximum = getmax(listY, ref maxi) + (getmax(listY, ref  maxi) - getmin(listY, ref mini)) * 3 / listY.Count;
                chart2.ChartAreas["ChartArea1"].AxisY.Minimum = getmin(listY, ref mini) - (getmax(listY, ref maxi) - getmin(listY, ref mini)) * 2 / listY.Count;
                //显示绘图结果的最大值和最小值坐标
                chart2.Series["Series1"]["LabelStyle"] = "TopRight";
                chart2.Series["Series1"].Points[mini].IsValueShownAsLabel = true;
                chart2.Series["Series1"].Points[mini].Label = "(" + Math.Round(listX[mini], 4).ToString() + "," + Math.Round(listY[mini], 4).ToString() + ")";
                chart2.Series["Series1"].Points[maxi].IsValueShownAsLabel = true;
                chart2.Series["Series1"].Points[maxi].Label = "(" + Math.Round(listX[maxi], 4).ToString() + "," + Math.Round(listY[maxi], 4).ToString() + ")";

                //显示最值
                chart2.Series["Series2"].Points.Clear();
                chart2.Series["Series2"].Points.AddXY(listX[mini], listY[mini]);
                chart2.Series["Series2"].Points.AddXY(listX[maxi], listY[maxi]);*/
                chart2.Series[0].Points.Clear();
                chart2.Series[0].Points.DataBind(dt_Betadecd.AsEnumerable(), "序号", "相位/度", "");
            }
        }
        #endregion




        #region  联合处理
        private void toolStripButton10_Click(object sender, EventArgs e)
        {
            if (!isXHGeneral)
            {
                MessageBox.Show("请先进行信号生成");
                return;
            }
            
            toolStripStatusLabel3.Text = "当前操作：联合处理";
            switchOperator(7);          // 显示信号输出页面
            comboBox6_SelectedIndexChanged(sender,e);
        }
        DataTable dt_Yua;
        private void comboBox6_SelectedIndexChanged(object sender, EventArgs e)
        {

                listX.Clear();
                listY.Clear();
                {
                    for (i = 0; i < N; i++)
                    {
                        //绘图
                        listX.Add(i);
                        listY.Add(Yua[i, 0]);
                    }
                       
                }
                dataGridView11.DataSource = dt_Yua;
                
                //绑定数据源
                //设置坐标范围
                /*chart3.Series[0].Points.DataBindXY(listX, listY);
                int mini = 0, maxi = 0;
                chart3.ChartAreas["ChartArea1"].AxisY.Maximum = getmax(listY, ref maxi) + (getmax(listY, ref  maxi) - getmin(listY, ref mini)) * 3 / listY.Count;
                chart3.ChartAreas["ChartArea1"].AxisY.Minimum = getmin(listY, ref mini) - (getmax(listY, ref maxi) - getmin(listY, ref mini)) * 2 / listY.Count;
                //显示绘图结果的最大值和最小值坐标
                chart3.Series["Series1"]["LabelStyle"] = "TopRight";
                chart3.Series["Series1"].Points[mini].IsValueShownAsLabel = true;
                chart3.Series["Series1"].Points[mini].Label = "(" + Math.Round(listX[mini], 4).ToString() + "," + Math.Round(listY[mini], 4).ToString() + ")";
                chart3.Series["Series1"].Points[maxi].IsValueShownAsLabel = true;
                chart3.Series["Series1"].Points[maxi].Label = "(" + Math.Round(listX[maxi], 4).ToString() + "," + Math.Round(listY[maxi], 4).ToString() + ")";

                //显示最值
                chart3.Series["Series2"].Points.Clear();
                chart3.Series["Series2"].Points.AddXY(listX[mini], listY[mini]);
                chart3.Series["Series2"].Points.AddXY(listX[maxi], listY[maxi]);*/
                chart3.Series[0].Points.Clear();
                chart3.Series[0].Points.DataBind(dt_Yua.AsEnumerable(), "序号", "检测值/度", "");
            
        }
        #endregion         


    }
}
