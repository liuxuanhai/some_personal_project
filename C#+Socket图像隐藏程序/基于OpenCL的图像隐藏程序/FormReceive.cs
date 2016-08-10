using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace 基于OpenCL的图像隐藏程序
{
    public partial class FormReceive : Form
    {
        public FormReceive()
        {
            InitializeComponent();
            path = "";
        }

        public string path;

        // 浏览图片
        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.InitialDirectory = Application.StartupPath.ToString();  // 应用路径
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            { // 打开了图片
                string path = openFileDialog1.FileName;
                textBoxPath.Text = path;
                pictureBox1.Image = (Bitmap)Image.FromFile(path);
            }
        }

        /// <summary>
        /// 路径修改时
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void textBoxPath_TextChanged(object sender, EventArgs e)
        {
            textBoxInfo.Text = "";
            if (textBoxPath.Text.Trim().Length > 0)
                label4.Visible = false;
            else
                label4.Visible = true;
        }

        // 清楚图片
        private void button3_Click(object sender, EventArgs e)
        {
            textBoxPath.Text = "";
            textBoxInfo.Text = "";
            pictureBox1.Image = null;
        }

        // 加载页面
        private void FormReceive_Load(object sender, EventArgs e)
        {
            if (path.Trim().Length > 0)  // 如果传入了图片 则打开就行了
            {
                textBoxPath.Text = path;
                pictureBox1.Image = (Bitmap)Image.FromFile(path);
            }
        }

        // 开始界面
        private void button2_Click(object sender, EventArgs e)
        {
            //readHideInfo();  // 普通方式隐藏信息的读取隐藏信息方式

            readHideInfoopencl(); // opencl隐藏信息的读取隐藏信息方式
        }

        // 普通方式隐藏信息的读取隐藏信息方式
        private void readHideInfo()
        {
            if (textBoxPath.Text.Trim().Length < 1 || pictureBox1.Image == null)
            {
                MessageBox.Show("请浏览需要读取隐藏信息的图片");
                return;
            }
            // 开始解密
            FileStream fs = new FileStream(textBoxPath.Text.Trim(), FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            fs.Seek(54L, 0);  //跳过文件头
            byte reader;
            char ch;
            int temp = 0;
            int state = 0;
            while (Convert.ToChar(temp) != '#' || state != 2)
            {
                temp = 0;
                // 16字节形成一个字符
                for (int k = 0; k < 16; k++)
                {
                    reader = br.ReadByte();  // 读取图像一个字节 共读16字节 每个字节最低位就是隐藏信息
                    temp += (reader & 0x01) << k;
                }
                ch = Convert.ToChar(temp);  // 构造字符
                if (ch != '#' && state != 1)
                {
                    MessageBox.Show("该图片没有嵌入文字信息或者信息已经被破坏", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (ch != '#' && state == 1)
                    textBoxInfo.Text += ch.ToString();
                if (ch == '#')
                    state++;
            }
            fs.Close();
            br.Close();
        }

        // opencl隐藏信息的读取隐藏信息方式
        private void readHideInfoopencl()
        {
            if (textBoxPath.Text.Trim().Length < 1 || pictureBox1.Image == null)
            {
                MessageBox.Show("请浏览需要读取隐藏信息的图片");
                return;
            }
            ImageData imgdata = new ImageData(new Bitmap(textBoxPath.Text.Trim()));
            string s="";
            if(!imgdata.getTextInfo(ref s))
            {
                MessageBox.Show("该图片没有嵌入文字信息或者信息已经被破坏", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            textBoxInfo.Text = s;
        }
    }
}
