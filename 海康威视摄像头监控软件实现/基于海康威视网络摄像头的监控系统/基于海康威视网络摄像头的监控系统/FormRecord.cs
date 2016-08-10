using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace 基于海康威视网络摄像头的监控系统
{
    public partial class FormRecord : Form
    {
        public FormRecord()
        {
            InitializeComponent();
        }
        public int index;  // 标志着哪个监控点
        private FormMain parent;  // 父界面
        public string path;
        private Int32 realHandle = -1;
        private DateTime dtstart;
        private void FormRecode_Load(object sender, EventArgs e)
        {
            dtstart = System.DateTime.Now;  // 开始录像时间
            parent = (FormMain)this.Owner;  //父窗口句柄
            toolStripStatusLabel1.Text = "正在录像，保存路径为" + path;

            CHCNetSDK.NET_DVR_PREVIEWINFO lpPreviewInfo = new CHCNetSDK.NET_DVR_PREVIEWINFO();
            lpPreviewInfo.hPlayWnd = pictureBox1.Handle;//预览窗口 live view window
            lpPreviewInfo.lChannel = parent.iChannelNum[index];//预览的设备通道 the device channel number
            lpPreviewInfo.dwStreamType = 0;//码流类型：0-主码流，1-子码流，2-码流3，3-码流4，以此类推
            lpPreviewInfo.dwLinkMode = 0;//连接方式：0- TCP方式，1- UDP方式，2- 多播方式，3- RTP方式，4-RTP/RTSP，5-RSTP/HTTP 
            lpPreviewInfo.bBlocked = true; //0- 非阻塞取流，1- 阻塞取流
            lpPreviewInfo.dwDisplayBufNum = 15; //播放库显示缓冲区最大帧数
            IntPtr pUser = IntPtr.Zero;//用户数据 user data 
            realHandle=CHCNetSDK.NET_DVR_RealPlay_V40(parent.m_lUserID, ref lpPreviewInfo, null/*RealData*/, pUser);
            if (realHandle < 0) 
                toolStripStatusLabel5.Text = "录像预览失败，错误代码" + CHCNetSDK.NET_DVR_GetLastError().ToString();
        }

        // 停止录像
        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        // 关闭窗口就停止录像
        private void FormRecord_FormClosing(object sender, FormClosingEventArgs e)
        {
            CHCNetSDK.NET_DVR_StopSaveRealData(parent.m_lRealHandle[index]);
            parent.m_bRecord[index] = false;
            if (index == 0) parent.threadRunning = true;
        }
        // 定时器 计算录像时间
        private void timer1_Tick(object sender, EventArgs e)
        {
            TimeSpan monitorTime = System.DateTime.Now - dtstart;  // 计算已经监测时长
            toolStripStatusLabel3.Text ="录像时长 "+ monitorTime.ToString(@"hh\:mm\:ss");
        }
    }
}
