using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Threading; 

namespace 基于OpenCL的图像隐藏程序
{
    public partial class FormMain : Form
    {
        public FormMain()
        {
            InitializeComponent();
        }

        //浏览图片
        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.InitialDirectory = Application.StartupPath.ToString() + @"\素材";//System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            { // 打开了图片
                string path = openFileDialog1.FileName;
                textBoxPath.Text = path;
                pictureBox1.Image=(Bitmap)Image.FromFile(path);
            }
        }
        // 图片路径修改时
        private void textBoxPath_TextChanged(object sender, EventArgs e)
        {
            if (textBoxPath.Text.Trim().Length > 0)
                label4.Visible = false;
            else
                label4.Visible = true;
        }

        // 清除
        private void button3_Click(object sender, EventArgs e)
        {
            textBoxPath.Text = "";
            pictureBox1.Image = null;
            
        }

        int port = 5000;  // 默认端口号是5000
        // 发送并保存
        private void button2_Click(object sender, EventArgs e)
        {
            if (textBoxPath.Text.Trim().Length < 1)
            {
                MessageBox.Show("请浏览需要发送的图片文件");
                return;
            }
            if (textBoxInfo.Text.Trim().Length < 1)
            {
                MessageBox.Show("请输入需要发送的隐藏信息");
                return;
            }
            if (textBoxIP.Text.Trim().Length < 1)
            {
                MessageBox.Show("请输入IP信息");
                return;
            }

            // 判断ip是否有效
            IPAddress ip;
            if(!IPAddress.TryParse(textBoxIP.Text.Trim(), out ip))
            {
                MessageBox.Show("请输入有效的IP信息");
                return;
            }
            //if (hideInfoToBMP())  // 普通方式隐藏
            if (hideInfoToBMPOpenCL())  // 使用opencl加速隐藏
            {
                //开启文件传输子线程   
                Thread sendThread = new Thread(new ThreadStart(this.StartSend));
                sendThread.Start();  
            } 
        }

        // 隐藏信息
        Boolean hideInfoToBMP()
        {
            string ss = textBoxInfo.Text;
            char []ch = new char[ss.Length];
            for (int i = 0; i < ss.Length; i++) //获得需要隐藏的信息 转成字节
            {
                ch[i] = Convert.ToChar(ss[i]);
            }
            char []temp = new char[(ss.Length + 2) * 16];  // 将信息和两个#号一起转成16位信息
            int m, n;
            // 开始嵌入#
            for (n = 0; n < 16; n++)
                temp[n] = Convert.ToChar(0x0001 & '#' >> n);
            // 中间是隐藏信息
            for (m = 1; m < ss.Length + 1; m++)
                for (n = 0; n < 16; n++)
                    temp[16 * m + n] = Convert.ToChar(0x0001 & ch[m - 1] >> n);
            // 结束时#
            for (n = 0; n < 16; n++)
                temp[16 * m + n] = Convert.ToChar(0x0001 & '#' >> n);

            //创建一个文件对象   
            // 读取文件
            FileStream fs = new FileStream(textBoxPath.Text.Trim(), FileMode.Open, FileAccess.Read);
            // 中间缓存文件
            FileStream fs1 = new FileStream("temp.bmp", FileMode.Create, FileAccess.Write); 
            BinaryReader br = new BinaryReader(fs);
            BinaryWriter bw = new BinaryWriter(fs1);
            long size = fs.Length;
            if (size < ((ss.Length + 2) * 16 + 56))
            {
                MessageBox.Show("发送失败,文字信息的长度过长，请选择其他图片", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            byte write;
            for (int i = 1, j = 0; i <= size; i++)
            {
                write = br.ReadByte();
                if (i <= 54)  // 前面54个位文件头
                    bw.Write(write);
                else
                {
                    if (j < 16 * (ss.Length + 2)) // 最低位隐藏
                        bw.Write(Convert.ToByte((write & 0xfe) + temp[j]));
                    else
                        bw.Write(write);
                    j++;
                }
            }
            fs.Close();
            fs1.Close();
            br.Close();
            bw.Close();
            // 嵌入文件成功  可以发送了
            return true;
        }

        int PacketSize = 5000;  // 默认包大小是5000
        //发送文件的线程
        private void StartSend()
        {
            //创建一个文件对象   
            FileInfo EzoneFile = new FileInfo("temp.bmp");  // 发送缓存文件 已经是嘉隐藏了信息了的
            //打开文件流   
            FileStream EzoneStream = EzoneFile.OpenRead();

            //包的数量   
            int PacketCount = (int)(EzoneStream.Length / ((long)PacketSize));

            //最后一个包的大小   
            int LastDataPacket = (int)(EzoneStream.Length - ((long)(PacketSize * PacketCount)));

            //指向远程服务端节点   
            IPEndPoint ipep = new IPEndPoint(IPAddress.Parse(textBoxIP.Text.Trim()), port);
            try
            {
                //创建套接字   
                Socket client = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                //连接到服务器端   
                client.Connect(ipep);

                //发送[文件名]到客户端   
                TransferFiles.SendVarData(client, System.Text.Encoding.Unicode.GetBytes(EzoneFile.Name));
                //发送[包的大小]到客户端   
                TransferFiles.SendVarData(client, System.Text.Encoding.Unicode.GetBytes(PacketSize.ToString()));
                //发送[包的总数量]到客户端   
                TransferFiles.SendVarData(client, System.Text.Encoding.Unicode.GetBytes(PacketCount.ToString()));
                //发送[最后一个包的大小]到客户端   
                TransferFiles.SendVarData(client, System.Text.Encoding.Unicode.GetBytes(LastDataPacket.ToString()));

                //数据包   
                byte[] data = new byte[PacketSize];
                //开始循环发送数据包   
                for (int i = 0; i < PacketCount; i++)
                {
                    //从文件流读取数据并填充数据包   
                    EzoneStream.Read(data, 0, data.Length);
                    //发送数据包   
                    TransferFiles.SendVarData(client, data);
                }

                //如果还有多余的数据包,则应该发送完毕!   
                if (LastDataPacket != 0)
                {
                    data = new byte[LastDataPacket];
                    EzoneStream.Read(data, 0, data.Length);
                    TransferFiles.SendVarData(client, data);
                }

                //关闭套接字   
                client.Close();

                //关闭文件流   
                EzoneStream.Close();
                this.Invoke((EventHandler)(delegate
                {
                    MessageBox.Show("发送完毕!");
                    textBoxInfo.Text = "";
                }));
            }
            catch (Exception ex)
            {
                this.Invoke((EventHandler)(delegate
                {
                    MessageBox.Show("连接接收方失败，接收方是否运行？\r\n" + ex.Message);
                }));
            }
        }

        //加载界面
        private void FormMain_Load(object sender, EventArgs e)
        {
            //开启接收线程   
            Thread receiveThread = new Thread(new ThreadStart(this.StartReceive));
            receiveThread.Start();
        }

        //接收线程
        private void StartReceive()
        {
            //创建一个网络端点   
            IPEndPoint ipep = new IPEndPoint(IPAddress.Any,port);

            //创建一个套接字   
            Socket server = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

            //绑定套接字到端口   
            server.Bind(ipep);

            //开始侦听(并堵塞该线程)   
            server.Listen(10);
            while (true)
            {
                try
                {
                    Socket client = server.Accept();  // 接收到文件
                    ClientSocket = client; // 客户端套接字
                    // 创建新建文件的线程
                    Thread TempThread = new Thread(new ThreadStart(this.Create));
                    TempThread.Start();
                }
                catch
                {
                    // int k = 0;
                }
            }
        }

        Socket ClientSocket;  // 套接字声明
        // 接受并创建文件
        public void Create()
        {
            Socket client = ClientSocket;  // 获得客户端套接字
            //获得客户端节点对象   
            IPEndPoint clientep = (IPEndPoint)client.RemoteEndPoint;

            //获得[文件名]   
            string SendFileName = System.Text.Encoding.Unicode.GetString(TransferFiles.ReceiveVarData(client));
            // 根据时间生成文件名
            SendFileName = System.DateTime.Now.ToString("yyyyMMddhhmmss") + SendFileName.Substring(SendFileName.IndexOf('.'));

            //获得[包的大小]   
            string bagSize = System.Text.Encoding.Unicode.GetString(TransferFiles.ReceiveVarData(client));  

            //获得[包的总数量]   
            int bagCount = int.Parse(System.Text.Encoding.Unicode.GetString(TransferFiles.ReceiveVarData(client))); 

            //获得[最后一个包的大小]   
            string bagLast = System.Text.Encoding.Unicode.GetString(TransferFiles.ReceiveVarData(client));


            //创建一个新文件   
            FileStream MyFileStream = new FileStream(SendFileName, FileMode.Create, FileAccess.Write);

            //已发送包的个数   
            int SendedCount = 0;
            while (true)
            {

                byte[] data = TransferFiles.ReceiveVarData(client);
                if (data.Length == 0)
                {
                    break;
                }
                else
                {
                    SendedCount++;
                    //将接收到的数据包写入到文件流对象   
                    MyFileStream.Write(data, 0, data.Length);
                    //显示已发送包的个数     
                }
            }
            //关闭文件流   
            MyFileStream.Close();
            string ip = IPAddress.Parse(((IPEndPoint)client.RemoteEndPoint).Address.ToString()).ToString();
            //关闭套接字   
            client.Close();
            //文件路径
            string filepath = Application.StartupPath.ToString() + "\\" + SendFileName;
            this.Invoke((EventHandler)(delegate
            {
                if (MessageBox.Show("收到来自" + ip + "的图片，保存路径为:" + filepath + "\r\n是否打开？", "提醒", MessageBoxButtons.OKCancel) == DialogResult.OK)
                {
                    FormReceive re = new FormReceive();
                    re.path = filepath;
                    re.Show();
                }
            }));
        }

        // 关闭主窗口
        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            Environment.Exit(0);
        }

        private void 退出系统ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void 解密界面ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormReceive re = new FormReceive();
            re.Show();
        }


        //opencl方式进行 隐藏信息
        Boolean hideInfoToBMPOpenCL()
        {
            string ss = textBoxInfo.Text;
            char[] ch = new char[ss.Length];
            for (int i = 0; i < ss.Length; i++) //获得需要隐藏的信息 转成字节
            {
                ch[i] = Convert.ToChar(ss[i]);
            }
            byte[] temp = new byte[(ss.Length + 2) * 16];  // 将信息和两个#号一起转成16位信息
            int m, n;
            // 开始嵌入#
            for (n = 0; n < 16; n++)
                temp[n] = Convert.ToByte(0x0001 & '#' >> n);
            // 中间是隐藏信息
            for (m = 1; m < ss.Length + 1; m++)
                for (n = 0; n < 16; n++)
                    temp[16 * m + n] = Convert.ToByte(0x0001 & ch[m - 1] >> n);
            // 结束时#
            for (n = 0; n < 16; n++)
                temp[16 * m + n] = Convert.ToByte(0x0001 & '#' >> n);

            //创建一个文件对象   
            // 读取文件
            FileStream fs = new FileStream(textBoxPath.Text.Trim(), FileMode.Open, FileAccess.Read);
            if (fs.Length < ((ss.Length + 2) * 16 + 56))
            {
                MessageBox.Show("发送失败,文字信息的长度过长，请选择其他图片", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            fs.Close();



            /*
            string vechidetextinfo = @"
                     __kernel void
                    hidetextinfo(__global  uchar * image,
                    __global int * length,
                    __global   uchar * info)
                    {
                         for (int i = 0; i < length[0]; i++)
                            image[54+i]=image[54+i]&0xfe|info[i];
                    }";
            //初始化平台和设备
            OpenCLTemplate.CLCalc.InitCL();

            //编译源码
            OpenCLTemplate.CLCalc.Program.Compile(new string[] { vechidetextinfo });

            //得到内核句柄
            OpenCLTemplate.CLCalc.Program.Kernel VectorSum = new OpenCLTemplate.CLCalc.Program.Kernel("hidetextinfo");
            Bitmap bmp = new Bitmap(textBoxPath.Text.Trim());
            ImageData imgdata = new ImageData(bmp);// 读取字节数据

            OpenCLTemplate.CLCalc.Program.Variable varV1 = new OpenCLTemplate.CLCalc.Program.Variable(new int[] { temp.Length });
            OpenCLTemplate.CLCalc.Program.Variable varV2 = new OpenCLTemplate.CLCalc.Program.Variable(temp);
            //变量参数化
            OpenCLTemplate.CLCalc.Program.Variable[] args = new OpenCLTemplate.CLCalc.Program.Variable[] { imgdata.varData,varV1, varV2 };

            //n个worders
            int[] workers = new int[1] { 1 };

            //执行worders
            VectorSum.Execute(args, workers);
            bmp = imgdata.GetStoredBitmap(bmp);
            bmp.Save("temp.bmp");  // 保存到缓存中
            // 嵌入文件成功  可以发送了
            return true;
            */
            


            //下面是并行方式
            string vechidetextinfo = @"
                     __kernel void
                    hidetextinfo(__global  uchar * image,
                    __global   uchar * info)
                    {
                         int i=get_global_id(0);
                         image[54+i]=image[54+i]&0xfe|info[i];
                    }";
            //初始化平台和设备
            OpenCLTemplate.CLCalc.InitCL();

            //编译源码
            OpenCLTemplate.CLCalc.Program.Compile(new string[] { vechidetextinfo });

            //得到内核句柄
            OpenCLTemplate.CLCalc.Program.Kernel VectorSum = new OpenCLTemplate.CLCalc.Program.Kernel("hidetextinfo");
            Bitmap bmp = new Bitmap(textBoxPath.Text.Trim());
            ImageData imgdata = new ImageData(bmp);// 读取字节数据

            OpenCLTemplate.CLCalc.Program.Variable varV1 = new OpenCLTemplate.CLCalc.Program.Variable(temp);
            //变量参数化
            OpenCLTemplate.CLCalc.Program.Variable[] args = new OpenCLTemplate.CLCalc.Program.Variable[] { imgdata.varData, varV1 };

            //n个worders
            int[] workers = new int[1] { temp.Length };

            //执行worders
            VectorSum.Execute(args, workers);
            bmp = imgdata.GetStoredBitmap(bmp);
            bmp.Save("temp.bmp");  // 保存到缓存中
            // 嵌入文件成功  可以发送了
            return true;
            
        }
    }
}
