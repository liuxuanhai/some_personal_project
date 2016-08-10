using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Threading;

//引入emguCV库  操作图片 主要用到Image<>图片操作
using Emgu.CV;
using Emgu.CV.CvEnum;
using Emgu.CV.Structure;
using Emgu.CV.Util;
using Emgu.CV.VideoSurveillance;
using Emgu.Util;
using System.Runtime.InteropServices;
/*
 * 默认只能显示9个通道 待扩展（好像库提供64个通道）
 * 默认只处理模拟设备（因为你给我的是模拟的，没有数字设备可以试验），如果通道超过9个的话，只显示9个
 * 默认只对选中设备的第一个通道做动作检测  你可以扩展成多个通道的
 */
namespace 基于海康威视网络摄像头的监控系统
{
    public partial class FormMain : Form
    {
        //构造函数
        public FormMain()
        {
            InitializeComponent();
            //sdk初始化
            m_bInitSDK = CHCNetSDK.NET_DVR_Init();  // 初始化
            CHCNetSDK.NET_DVR_SetConnectTime(500,1);  // 连接超时时间
            if (m_bInitSDK == false)
            {
                MessageBox.Show("NET_DVR_Init error!");
                return;
            }
            else
            {
                //保存SDK日志 To save the SDK log
                CHCNetSDK.NET_DVR_SetLogToFile(3, "C:\\SdkLog\\", true);  // 日志 否管
                for (int i = 0; i < 64; i++)
                {
                    iChannelNum[i] = -1;
                }
            }
        }

        private bool m_bInitSDK = false; // 是否初始化
        private uint dwAChanTotalNum = 0; //数字设备通道
        private uint dwDChanTotalNum = 0; // 模拟设备通道
        public Int32 m_lUserID = -1;  //连接返回参数
        private uint iLastErr = 0;  // 错误代码
        public Int32[] m_lRealHandle = new Int32[9] { -1, -1, -1, -1, -1, -1, -1, -1, -1 }; // 预览  最多9个
        public bool[] m_bRecord = new bool[9] { false, false, false, false, false, false, false, false, false };  //是否在录像
        public int[] iChannelNum = new int[96];  //通道　　最多96个 这里最多9个  
        public CHCNetSDK.NET_DVR_DEVICEINFO_V30 DeviceInfo;  // 设备信息
        public CHCNetSDK.NET_DVR_IPPARACFG_V40 m_struIpParaCfgV40;
        public CHCNetSDK.NET_DVR_STREAM_MODE m_struStreamMode;
        public CHCNetSDK.NET_DVR_IPCHANINFO m_struChanInfo;
        public CHCNetSDK.NET_DVR_IPCHANINFO_V40 m_struChanInfoV40;

        
        PictureBox[] box;  // 初始化9个图片控件 用于预览9个通道
        ContextMenuStrip cms;  // 右键菜单 每个通道均有右键菜单用于录像 抓图的
        
        // 加载界面时
        private void FormMain_Load(object sender, EventArgs e)
        {
            box = new PictureBox[9];  // 初始化9个图片控件
            cms=new ContextMenuStrip();
            cms.Items.Add("抓图");
            cms.Items.Add("录像");
            cms.Items[0].Click += new EventHandler(cmsZT_Click);
            cms.Items[1].Click +=new EventHandler(cmsLX_Click);
            for (int i = 0; i < 9; ++i)
            {
                box[i]=new PictureBox();
                box[i].BackColor = Color.Black;
                box[i].Name = i.ToString();
                panelMonitor.Controls.Add(box[i]);             
                box[i].ContextMenuStrip = cms;
            }    
            switchUI("liveview");  //初始化实时预览
            th = new Thread(threadCapture);
            th.Start();  //启动移动监测的线程
        }

        /*
        (1)开辟静态内存，对图像进行初始化准备采集；
        (2)采集图像，定义参数k，作为图像序列计数。采集第1幅图像时，则根据第一帧的大小信息进行矩阵、图像的初始化，并且将第一帧图像进行灰度化处理，并转化为矩阵，作为背景图像及矩阵；如果k不等于1则把当前帧进行灰度化处理，并转化为矩阵，作为当前帧的图像及矩阵。用当前帧的图像矩阵和背景帧的图像矩阵做差算出前景图矩阵并对其进行二值化以便计算它与背景帧差别较大的像素个数，也就是二值化后零的个数。
        当第一帧的异物大于1W个像数点则需要将当前帧存储为第一帧，并且将系统的状态转为1——采集第二帧；
        第一帧和第二帧的异物都大于1W个像数点时，将当前帧存储为第二帧，通过判断第一帧和第二帧的差值来确定两帧是否连续，若连续则将系统状态转为2——采集第三帧，若不连续则报警，并把系统状态转为0——采集背景帧；
        当第一帧和第二帧的异物都大于1W个像数点,而第三帧没有时则报警；
        若连续3帧的异物都大于1W个像数点时，将当前帧存储为第三帧，通过判断第二帧和第三帧的差值来确定两帧是否连续，若连续则将更新背景，若不连续则报警。然后把系统状态转为0——采集背景帧。
        注意其中有一个0－1－2－0....的状态机。
         */

        #region 移动监测算法  线程
        // 蜂鸣器发音
        [DllImport("kernel32.dll")]
        public static extern bool Beep(int frequency, int duration);
        Thread th;  // 线程
        Image<Gray, Byte> bgimage,image1,image2,image3;  // 背景灰度图  3帧图
        int status = 0;  // 判断当前状态
        public Boolean threadRunning=true;   //标识线程是否运行
        //下面均对当前设备的第一个有效通道进行移动监测
        private void threadCapture()  // 判断线程
        {
            //定义JPEG图像质量
            CHCNetSDK.NET_DVR_JPEGPARA JpegPara = new CHCNetSDK.NET_DVR_JPEGPARA();  
            JpegPara.wPicQuality = 1;  
            JpegPara.wPicSize = 9;
            byte[] Jpeg = new byte[200 * 1024];
            uint len = 200 * 1024;// 200 * 1024;
            uint Ret = 0;
            bool capture;
            Image<Bgr, Byte> tempimage;  // 缓存图片
            Image<Gray, Byte> grayimage,diffimage;  //灰度缓存图片
            MemoryStream ms;  // 内存流
            uint counts,threadcounts=8000;  //异常点数目 和 阈值
            while(true)
            {
                if (m_lUserID < 0 || !threadRunning || !motiondetectonoff)   // 不运行
                {
                    Thread.Sleep(1000);
                    continue;
                }
                capture = CHCNetSDK.NET_DVR_CaptureJPEGPicture_NEW(m_lUserID, iChannelNum[0], ref JpegPara, Jpeg, len, ref Ret);
                if (!capture)
                {
                    this.Invoke((EventHandler)(delegate
                    {
                        toolStripStatusLabel6.Text = "捕捉帧失败，错误代码" + CHCNetSDK.NET_DVR_GetLastError().ToString();
                    }));
                    return;
                }
                ms = new MemoryStream(Jpeg);  //读取内存
                tempimage = new Image<Bgr, byte>((Bitmap)System.Drawing.Image.FromStream(ms));　//构造图片
                grayimage = tempimage.Convert<Gray, Byte>();
                if (status==0)
                { // 获得背景
                    this.Invoke((EventHandler)(delegate
                    {
                        toolStripStatusLabel6.Text = "正常预览中...";
                    }));
                    bgimage = grayimage;
                    status++;  // 下一帧
                    
                }else{
                    switch (status)
                    {
                        case 1:  // 处理第一帧
                            diffimage = bgimage.AbsDiff(grayimage);
                            diffimage = diffimage.ThresholdBinary(new Gray(128), new Gray(255));
                            counts  = countWhite(diffimage);  // 计算当前帧与背景帧的异常点个数
                            if (counts > threadcounts)
                            {  // 异常点个数大于1万 保存为第一帧
                                image1 = grayimage;
                                status++;
                            }
                            break;
                        case 2:  // 处理第二帧
                            diffimage = bgimage.AbsDiff(grayimage);
                            diffimage = diffimage.ThresholdBinary(new Gray(128), new Gray(255));
                            counts  = countWhite(diffimage);  // 计算当前帧与背景帧的异常点个数
                            if (counts > threadcounts)
                            {  // 异常点个数大于1万 保存为第2帧
                                image2 = grayimage;
                                diffimage = image1.AbsDiff(image2);  // 计算第一帧第二帧是否连续
                                diffimage = diffimage.ThresholdBinary(new Gray(128), new Gray(255));
                                counts  = countWhite(diffimage);
                                if (counts > threadcounts)
                                {  // 不连续 直接报警就行了
                                    // 报警
                                    status = 0;
                                    this.Invoke((EventHandler)(delegate // 跨线程访问
                                    {
                                        toolStripStatusLabel6.Text = "检测到移动物体";
                                        startRecord();  // 开始录像
                                    }));
                                    
                                } 
                                else  // 连续的话 就直接采集第三帧了
                                    status++;
                            }
                            break;
                        case 3:
                            diffimage = bgimage.AbsDiff(grayimage);
                            diffimage = diffimage.ThresholdBinary(new Gray(128), new Gray(255));
                            counts  = countWhite(diffimage);  // 计算当前帧与背景帧的异常点个数
                            if (counts < threadcounts)
                            {  //第三帧 小于10000 那么就报警吧
                                // 报警
                                status = 0;
                                this.Invoke((EventHandler)(delegate
                                {
                                    toolStripStatusLabel6.Text = "检测到移动物体";
                                    startRecord();  // 开始录像
                                }));
                                
                            }
                            else  //判断第三帧和第二帧是否连续
                            {
                                image3 = grayimage;
                                diffimage = image3.AbsDiff(image2);  // 计算第3帧第二帧是否连续
                                diffimage = diffimage.ThresholdBinary(new Gray(128), new Gray(255));
                                counts = countWhite(diffimage);
                                if (counts > 10000)
                                {  // 不连续 直接报警就行了
                                    // 报警
                                    status = 0;
                                    this.Invoke((EventHandler)(delegate
                                    {
                                        toolStripStatusLabel6.Text = "检测到移动物体";
                                        startRecord();  // 开始录像
                                    })); 
                                }
                               // 连续的话 就直接采集第三帧了
                                status = 0;
                            }
                            break;
                        default:  
                            status=0;  // 采集背景
                            break;
                    }
                    /*this.Invoke((EventHandler)(delegate
                    {
                        toolStripStatusLabel7.Text ="报警";
                        diffimage = diffimage.Resize(box[1].Width, box[1].Height, 0);
                        box[1].Image = diffimage.ToBitmap();
                    }));*/
                }                
                Thread.Sleep(10);
            }  
        }
        // 计算阈值二值化后的异常点个数
        private uint countWhite(Image<Gray, Byte> img)
        {
            uint n = 0;
            for(int i=0;i<img.Rows;++i)
                for(int j=0;j<img.Cols;++j)
                    if(img.Data[i,j,0]>0) n++;
            return n;
        }

        // 开始录像  
        private void startRecord()
        {
            threadRunning = false;  // 线程空运行
            if (soundonoff)  // 如果发出警报
                Beep(600,1000);  // 发出警告声音
            // 开始录像
            if (m_lRealHandle[0] >= 0)  // 如果在预览
            {
                string path = ClassXml.getSetXml("record");
                if (!Directory.Exists(path)) Directory.CreateDirectory(path);
                //图片名称 年月日 时分秒
                string FileName = System.DateTime.Now.ToString("yyMMddhhmmss");
                FileName = path + "\\" + FileName + ".mp4";

                //mp4录像 
                if (m_bRecord[0] == false)    //开始录像
                {
                    //强制I帧 Make one key frame
                    int lChannel = iChannelNum[0]; //通道号 Channel number
                    CHCNetSDK.NET_DVR_MakeKeyFrame(m_lUserID, lChannel);

                    //开始录像 Start recording
                    if (!CHCNetSDK.NET_DVR_SaveRealData(m_lRealHandle[0], FileName))
                    {
                        iLastErr = CHCNetSDK.NET_DVR_GetLastError();
                        toolStripStatusLabel6.Text = "录像失败，错误代码" + iLastErr.ToString();
                        return;
                    }
                    else
                    {
                        toolStripStatusLabel6.Text = "开始录像，保存文件名为" + FileName;
                        m_bRecord[0] = true;
                        recordFrm[0] = new FormRecord();
                        recordFrm[0].index = 0;
                        recordFrm[0].Owner = this;
                        recordFrm[0].path = FileName;
                        recordFrm[0].Show();  // 显示录像界面
                    }
                }
                else  //打开录像界面
                {
                    if (recordFrm[0] != null)
                    {
                        recordFrm[0].WindowState = FormWindowState.Normal;
                    }
                }
            }
        }
        #endregion

        #region 右键菜单抓图 录像
        // 抓图点击时 开始抓图
        private void cmsZT_Click(object sender, EventArgs e)
        {
            PictureBox pic = (PictureBox)(cms.SourceControl);
            int index = int.Parse(pic.Name);
            if (m_lRealHandle[index] >= 0)  // 抓图
            {
                string path = ClassXml.getSetXml("capture");
                if (!Directory.Exists(path)) Directory.CreateDirectory(path);
                //图片名称 年月日 时分秒
                string sBmpPicFileName=System.DateTime.Now.ToString("yyMMddhhmmss");
                sBmpPicFileName =path +"\\"+ sBmpPicFileName + ".bmp";
                //BMP抓图 Capture a BMP picture
                if (!CHCNetSDK.NET_DVR_CapturePicture(m_lRealHandle[index], sBmpPicFileName))
                {
                    iLastErr = CHCNetSDK.NET_DVR_GetLastError();
                    toolStripStatusLabel6.Text = "抓图失败，错误代码" + iLastErr.ToString();
                }
                else
                {
                    toolStripStatusLabel6.Text = "抓图成功，保存文件名为" + sBmpPicFileName;
                }
            }
        }
        private FormRecord[] recordFrm=new FormRecord[9];  //9 个录像界面
        // 录像点击时 开始录像
        private void cmsLX_Click(object sender, EventArgs e)
        {
            PictureBox pic = (PictureBox)(cms.SourceControl);
            int index = int.Parse(pic.Name);
            if (index == 0) threadRunning = false;  // 线程空运行  只对第一个通道做处理
            if (m_lRealHandle[index] >= 0)  // 如果在预览
            {
                string path = ClassXml.getSetXml("record");
                if (!Directory.Exists(path)) Directory.CreateDirectory(path);
                //图片名称 年月日 时分秒
                string FileName = System.DateTime.Now.ToString("yyMMddhhmmss");
                FileName = path + "\\" + FileName + ".mp4";

                //mp4录像 
                if (m_bRecord[index] == false)    //开始录像
                {
                    //强制I帧 Make one key frame
                    int lChannel = iChannelNum[index]; //通道号 Channel number
                    CHCNetSDK.NET_DVR_MakeKeyFrame(m_lUserID, lChannel);

                    //开始录像 Start recording
                    if (!CHCNetSDK.NET_DVR_SaveRealData(m_lRealHandle[index],FileName))
                    {
                        iLastErr = CHCNetSDK.NET_DVR_GetLastError();
                        toolStripStatusLabel6.Text = "录像失败，错误代码" + iLastErr.ToString();
                        return;
                    }
                    else
                    {
                        toolStripStatusLabel6.Text = "开始录像，保存文件名为" +FileName;
                        m_bRecord[index] = true;
                        recordFrm[index] = new FormRecord();
                        recordFrm[index].index = index;
                        recordFrm[index].Owner = this;
                        recordFrm[index].path = FileName;
                        recordFrm[index].Show();  // 显示录像界面
                    }
                }
                else  //打开录像界面
                {
                    if (recordFrm[index] != null)
                    {
                        recordFrm[index].WindowState = FormWindowState.Normal;                 
                    }
                    //停止录像 Stop recording
                    /*CHCNetSDK.NET_DVR_StopSaveRealData(m_lRealHandle[index]);
                    m_bRecord[index] = false;   */
                }
            }
        }
        #endregion


        // 切换界面
        void switchUI(string s)
        {
            panelLiveView.Visible = false;
            panelDeviceMana.Visible = false;
            panelSet.Visible = false;
            switch (s)
            {
                case "liveview":
                    panelLiveView.Visible = true;
                    panelLiveView.Dock = DockStyle.Fill;
                    devicelistREfresh();
                    break;
                case "devicemana":
                    panelDeviceMana.Visible = true;
                    panelDeviceMana.Dock = DockStyle.Fill;
                    devicelistREfresh();  // 刷新列表
                    break;
                case "systemset":
                    panelSet.Visible = true;
                    panelSet.Dock = DockStyle.Fill;
                    break;
                default:
                    panelLiveView.Visible = true;
                    panelLiveView.Dock = DockStyle.Fill;
                    break;
            }
        }
        Boolean motiondetectonoff, soundonoff;
        //刷新设备列表
        private void devicelistREfresh()
        {
            closeDevice();
            if (panelDeviceMana.Visible)  // 设备管理
            {
                listView1.Items.Clear();
                string DVRIPAddress; //设备IP地址或者域名 Device IP
                Int16 DVRPortNumber;//设备服务端口号 Device Port
                string DVRUserName;//设备登录用户名 User name to login
                string DVRPassword;//设备登录密码 Password to login
                Int32 m_lUserID;
                string status = "", xuliehao = "";
                string[] s;
                List<string[]> list = ClassXml.readXml();
                for (int i = 0; i < list.Count; ++i)
                {
                    s = list[i];
                    if (s.Length > 0)
                    {

                        DVRIPAddress = s[1]; //设备IP地址或者域名 Device IP
                        DVRPortNumber = Int16.Parse(s[2]);//设备服务端口号 Device Port
                        DVRUserName = s[3];//设备登录用户名 User name to login
                        DVRPassword = s[4];//设备登录密码 Password to login
                        //登录设备 Login the device
                        m_lUserID = CHCNetSDK.NET_DVR_Login_V30(DVRIPAddress, DVRPortNumber, DVRUserName, DVRPassword, ref DeviceInfo);
                        if (m_lUserID < 0)
                        {
                            status = "连接无效";
                            xuliehao = "";
                        }
                        else
                        {
                            status = "连接有效";
                            xuliehao = System.Text.Encoding.Default.GetString(DeviceInfo.sSerialNumber);
                            CHCNetSDK.NET_DVR_Logout(m_lUserID);  // 关闭连接
                        }
                        ListViewItem lvi = new ListViewItem(s[0]);
                        lvi.SubItems.Add(s[1]);
                        lvi.SubItems.Add(xuliehao);
                        lvi.SubItems.Add(status);
                        listView1.Items.Add(lvi);
                    }
                }
            }
            else if (panelLiveView.Visible)
            {
                motiondetectonoff = false; soundonoff = false;
                if (ClassXml.getSetXml("motiondetect") == "是") motiondetectonoff = true;
                if (ClassXml.getSetXml("sound") == "是") soundonoff = true;
                treeView2.Nodes.Clear();
                string[] s;
                List<string[]> list = ClassXml.readXml();
                for (int i = 0; i < list.Count; ++i)
                {
                    s = list[i];
                    if (s.Length > 0)
                    {
                        treeView2.Nodes.Add("监控点"+(i+1).ToString()+"_"+s[0]);
                    }
                }
                if (treeView2.Nodes.Count > 0) // 启动第一个设备
                    treeView2.SelectedNode = treeView2.Nodes[0];
            }
        }

        // 选择画面时
        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            if (treeView1.SelectedNode == null) return;
            toolStripStatusLabel1.Text = "视图：" + treeView1.SelectedNode.Text;
            switch (treeView1.SelectedNode.Text)
            {
                case "1-画面":
                    for (int i = 0; i < 9; ++i) box[i].Visible = true;
                    for (int i = 1; i < 9;++i) box[i].Visible=false;
                    box[0].Size = new Size(panelMonitor.Width, panelMonitor.Height);
                    box[0].Location = new Point(0,0);
                        break;
                case "4-画面":
                        {
                            for (int i = 0; i < 9; ++i) box[i].Visible = true;
                            for (int i = 4; i < 9; ++i) box[i].Visible = false;
                            int width = panelMonitor.Width / 2, height = panelMonitor.Height / 2;
                            for (int i = 0; i < 2; ++i)
                                for (int j = 0; j < 2; ++j)
                                {
                                    box[i * 2 + j].Size = new Size(width - 1, height - 1);
                                    box[i * 2 + j].Location = new Point(j * width + 1, i * height + 1);
                                }
                        }
                        break;
                case "9-画面":
                        {
                            for (int i = 0; i < 9; ++i) box[i].Visible = true;
                            int width = panelMonitor.Width / 3, height = panelMonitor.Height / 3;
                            for (int i = 0; i < 3; ++i)
                                for (int j = 0; j < 3; ++j)
                                {
                                    box[i * 3 + j].Size = new Size(width - 1, height - 1);
                                    box[i * 3 + j].Location = new Point(j * width + 1, i * height + 1);
                                }
                        }
                        break;
                default: 
                    for (int i = 0; i < 9; ++i) box[i].Visible = true;
                    for (int i = 1; i < 9;++i) box[i].Visible=false;
                    box[0].Size = new Size(panelMonitor.Width, panelMonitor.Height);
                    box[0].Location = new Point(0,0);
                    break;
            }
        }

        // 窗口大小改变时 预览窗口也改变
        private void FormMain_SizeChanged(object sender, EventArgs e)
        {
            try {
                treeView1_AfterSelect(null, null);
            }
            catch { }
        }

        // 添加设备
        private void buttonAdd_Click(object sender, EventArgs e)
        {
            FormDeviceAdd add = new FormDeviceAdd();
            add.ShowDialog();
            devicelistREfresh();  // 刷新
        }


        // 实时预览
        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            switchUI("liveview");
        }

        // 设备管理
        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            switchUI("devicemana");
        }


        // 删除设备
        private void button1_Click(object sender, EventArgs e)
        {
            if (listView1.SelectedItems.Count > 0)
            {
                string devicename = listView1.SelectedItems[0].Text;
                if (MessageBox.Show("是否确定删除设备" + devicename + "?", "提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
                    return;
                ClassXml.deleteXml(devicename);
                devicelistREfresh();  // 刷新
            }
            else {
                MessageBox.Show("请选择设备！");
            }
        }
        // 修改设备
        private void button2_Click(object sender, EventArgs e)
        {
            if (listView1.SelectedItems.Count > 0)
            {
                FormDeviceAdd add = new FormDeviceAdd();
                add.devicename = listView1.SelectedItems[0].Text;
                add.ShowDialog();
                devicelistREfresh();  // 刷新
            }
            else
            {
                MessageBox.Show("请选择设备！");
            }
        }


        // 重新获得焦点时
        private void FormMain_Activated(object sender, EventArgs e)
        {
            //devicelistREfresh();  // 刷新
        }
        //双击修改
        private void listView1_DoubleClick(object sender, EventArgs e)
        {
            button2_Click(null, null);
        }


        // 关闭界面
        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            System.Environment.Exit(0);  //关闭所有环境
            closeDevice();
            CHCNetSDK.NET_DVR_Cleanup();  // 释放资源
        }

        // 关闭设备
        private void closeDevice()
        {
            //if(th.ThreadState==ThreadState.Running)
            //    th.Abort();
            //停止预览
            for (int i = 0; i < 9; ++i)
            {
                if (m_bRecord[i])
                {  //如果录像则停止
                    recordFrm[i].Close();
                    recordFrm[i] = null;
                    CHCNetSDK.NET_DVR_StopSaveRealData(m_lRealHandle[i]);
                    m_bRecord[i] = false;
                }
                if (m_lRealHandle[i] >= 0)
                {
                    CHCNetSDK.NET_DVR_StopRealPlay(m_lRealHandle[i]);
                    m_lRealHandle[i] = -1;
                }
                if(box[i].Visible)  // 刷新预览界面
                    box[i].Invalidate();
            }
            //注销登录
            if (m_lUserID >= 0)
            {
                CHCNetSDK.NET_DVR_Logout(m_lUserID);
                m_lUserID = -1;
            }
        }
        
        //选择设备时 打开所有可用通道进行预览  其实这里限制 只预览9个通道 
        private void treeView2_AfterSelect(object sender, TreeViewEventArgs e)
        {
            if (treeView2.SelectedNode == null) return;
            toolStripStatusLabel4.Text = "监控："+treeView2.SelectedNode.Text;
            string name = treeView2.SelectedNode.Text.Substring(treeView2.SelectedNode.Text.IndexOf('_') + 1);
            string[] s = ClassXml.getDeviceXml(name); // 获得监控设备的配置信息
            closeDevice();  //关闭设备
            string DVRIPAddress = s[1]; //设备IP地址或者域名 Device IP
            Int16 DVRPortNumber = Int16.Parse(s[2]);//设备服务端口号 Device Port
            string DVRUserName = s[3];//设备登录用户名 User name to login
            string DVRPassword = s[4];//设备登录密码 Password to login
            m_lUserID = CHCNetSDK.NET_DVR_Login_V30(DVRIPAddress, DVRPortNumber, DVRUserName, DVRPassword, ref DeviceInfo);
            if (m_lUserID < 0)
            {
                iLastErr = CHCNetSDK.NET_DVR_GetLastError();
                toolStripStatusLabel6.Text = "登录连接失败,错误代码" + iLastErr.ToString();
            }
            else
            {
                //登录成功
                toolStripStatusLabel6.Text = "登录连接成功";
                dwAChanTotalNum = (uint)DeviceInfo.byChanNum;  // 模拟通道
                dwDChanTotalNum = (uint)DeviceInfo.byIPChanNum + 256 * (uint)DeviceInfo.byHighDChanNum;  // 数字通道
                // 初始化通道
                for (int i = 0; i < 64; i++)
                {
                    iChannelNum[i] = -1;
                }
                if (dwDChanTotalNum > 0)  //数字通道不作处理 没设备呀
                {
                    //InfoIPChannel();  
                }
                else
                {
                    for (int i = 0; i < dwAChanTotalNum; i++)
                    {
                        iChannelNum[i] = i + (int)DeviceInfo.byStartChan;
                    }
                    //下面开始预览
                    {
                        for (int i = 0; i < 9; ++i)  // 只能9个
                        {
                            if (box[i].Visible && iChannelNum[i] != -1) {
                                CHCNetSDK.NET_DVR_PREVIEWINFO lpPreviewInfo = new CHCNetSDK.NET_DVR_PREVIEWINFO();
                                lpPreviewInfo.hPlayWnd = box[i].Handle;//预览窗口 live view window
                                lpPreviewInfo.lChannel = iChannelNum[i];//预览的设备通道 the device channel number
                                lpPreviewInfo.dwStreamType = 0;//码流类型：0-主码流，1-子码流，2-码流3，3-码流4，以此类推
                                lpPreviewInfo.dwLinkMode = 0;//连接方式：0- TCP方式，1- UDP方式，2- 多播方式，3- RTP方式，4-RTP/RTSP，5-RSTP/HTTP 
                                lpPreviewInfo.bBlocked = true; //0- 非阻塞取流，1- 阻塞取流
                                lpPreviewInfo.dwDisplayBufNum = 15; //播放库显示缓冲区最大帧数
                                IntPtr pUser = IntPtr.Zero;//用户数据 user data 
                                m_lRealHandle[i] = CHCNetSDK.NET_DVR_RealPlay_V40(m_lUserID, ref lpPreviewInfo, null/*RealData*/, pUser);
                                if (m_lRealHandle[i] < 0)
                                {
                                    iLastErr = CHCNetSDK.NET_DVR_GetLastError();
                                    toolStripStatusLabel6.Text = "预览失败，错误代码" + iLastErr.ToString();
                                    return;
                                }
                                else
                                {
                                    //预览成功
                                    toolStripStatusLabel6.Text = "正在预览...";
                                }
                            }
                        }
                    }
                }
            }
        }




    #region 系统设置
    // 系统设置
    private void toolStripButton1_Click(object sender, EventArgs e)
    {
        switchUI("systemset");
        initSet();
    }

    private void initSet()
    {
        if (panelSet.Visible)
        {
            string[] s = ClassXml.getSetInfo();  // 获得设置信息
            textBox1.Text = s[0];
            textBox2.Text = s[1];
            if (s[2] == "否")
            {
                radioButton2.Checked = true;
                soundonoff = false;
            }
            else
            {
                radioButton1.Checked = true;
                soundonoff = true;
            }
            if (s[3] == "否")
            {
                radioButton3.Checked = true;
                radioButton2.Enabled = false;
                radioButton1.Enabled = false;
                motiondetectonoff = false;
            }
            else
            {
                radioButton4.Checked = true;
                radioButton2.Enabled = true;
                radioButton1.Enabled = true;
                motiondetectonoff = true;
            }
        }
    }
        // 抓图路径选择
        private void button3_Click(object sender, EventArgs e)
        {
            string path = "";
            FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog();
            folderBrowserDialog.Description = "请选择抓图保存路径";
            folderBrowserDialog.ShowNewFolderButton = false;
            if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
            {
                path = folderBrowserDialog.SelectedPath;
                //MessageBox.Show(path);
            }
            ClassXml.saveSetXml("capture",path);
            initSet();
        }
        // 录像路径保存
        private void button4_Click(object sender, EventArgs e)
        {
            string path = "";
            FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog();
            folderBrowserDialog.Description = "请选择录像保存路径";
            folderBrowserDialog.ShowNewFolderButton = false;
            if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
            {
                path = folderBrowserDialog.SelectedPath;
                //MessageBox.Show(path);
            }
            ClassXml.saveSetXml("record", path);
            initSet();
        }

        // 是否警报
        private void radioButton1_Click(object sender, EventArgs e)
        {
            if(radioButton1.Checked)
                ClassXml.saveSetXml("sound", "是");
            else
                ClassXml.saveSetXml("sound", "否");
            initSet();
        }
        // 是否移动监测
        private void radioButton4_Click(object sender, EventArgs e)
        {
            if (radioButton4.Checked)
                ClassXml.saveSetXml("motiondetect", "是");
            else
                ClassXml.saveSetXml("motiondetect", "否");
            initSet();
        }
        private void radioButton3_Click(object sender, EventArgs e)
        {
            radioButton4_Click(null,null);
        }

        private void radioButton2_Click(object sender, EventArgs e)
        {
            radioButton1_Click(null, null);
        }
    #endregion

        //关闭系统
        private void toolStripButton4_Click(object sender, EventArgs e)
        {
            this.Close();
        }



        

       

        
    }
}
