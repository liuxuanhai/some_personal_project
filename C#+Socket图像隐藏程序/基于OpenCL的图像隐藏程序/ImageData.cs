using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Text;
using OpenCLTemplate;

namespace 基于OpenCL的图像隐藏程序
{
    /// <summary>Stores image data in OpenCL memory</summary>
    public class ImageData
    {
        /// <summary>Pixel size</summary>
        private const int PIXELSIZE = 3;

        /// <summary>OpenCL byte array that stores the image data</summary>
        public CLCalc.Program.Variable varData;
        /// <summary>Host memory image data</summary>
        public byte[] Data;

        private int width, height;

        /// <summary>Gets image width</summary>
        public int Width
        {
            get { return width; }
        }

        /// <summary>Gets image height</summary>
        public int Height
        {
            get { return height; }
        }

        /// <summary>ImageData constructor. Reads data from a bitmap</summary>
        /// <param name="bmp">Bitmap to read from</param>
        public ImageData(Bitmap bmp)
        {
            if (CLCalc.CLAcceleration == CLCalc.CLAccelerationType.Unknown) CLCalc.InitCL();

            width = bmp.Width;
            height = bmp.Height;

            //Allocates space for data
            Data = new byte[3 * width * height];
            //Reads bmp to local Data variable
            ReadToLocalData(bmp);

            //Transfer data to OpenCL device
            varData = new CLCalc.Program.Variable(Data);
        }

        /// <summary>Reads data from a bitmap.</summary>
        /// <param name="bmp">Source bitmap</param>
        public void ReadBmp(Bitmap bmp)
        {
            ReadToLocalData(bmp);
            varData.WriteToDevice(Data);
        }

        /// <summary>Returns stored data in a bitmap</summary>
        /// <param name="bmp">Reference bitmap</param>
        public Bitmap GetStoredBitmap(Bitmap bmp)
        {
            varData.ReadFromDeviceTo(Data); // 更新设备内存到现在内存中

            Bitmap resp = new Bitmap(width, height, bmp.PixelFormat);

            BitmapData bmd = resp.LockBits(new Rectangle(0, 0, bmp.Width, bmp.Height),
             System.Drawing.Imaging.ImageLockMode.ReadOnly, bmp.PixelFormat);

            //Write data
            unsafe
            {
                for (int y = 0; y < bmd.Height; y++)
                {
                    byte* row = (byte*)bmd.Scan0 + (y * bmd.Stride);

                    for (int x = 0; x < bmd.Width; x++)
                    {
                        row[x * PIXELSIZE] = Data[3 * (x + width * y)];
                        row[x * PIXELSIZE + 1] = Data[3 * (x + width * y) + 1];
                        row[x * PIXELSIZE + 2] = Data[3 * (x + width * y) + 2];
                    }
                }
            }

            //Unlock bits
            resp.UnlockBits(bmd);

            return resp;
        }

        /// <summary>Copies bitmap data to local Data</summary>
        /// <param name="bmp">Bitmap to copy</param>
        private void ReadToLocalData(Bitmap bmp)
        {
            //Lock bits
            BitmapData bmd = bmp.LockBits(new Rectangle(0, 0, bmp.Width, bmp.Height),
                             System.Drawing.Imaging.ImageLockMode.ReadOnly, bmp.PixelFormat);
            //Read data
            unsafe
            {
                for (int y = 0; y < bmd.Height; y++)
                {
                    byte* row = (byte*)bmd.Scan0 + (y * bmd.Stride);

                    for (int x = 0; x < bmd.Width; x++)
                    {
                        Data[3 * (x + width * y)] = row[x * PIXELSIZE];
                        Data[3 * (x + width * y) + 1] = row[x * PIXELSIZE + 1];
                        Data[3 * (x + width * y) + 2] = row[x * PIXELSIZE + 2];
                    }
                }
            }

            //Unlock bits
            bmp.UnlockBits(bmd);
        }
        public Boolean getTextInfo(ref string s)
        {
            s = "";
            char c;
            int tem = 0;
            int state = 0;
            for (int i = 54; i < Height*Width*3;)
            {

                tem = 0;
                // 16字节形成一个字符
                for (int k = 0; k < 16; k++)
                {
                    tem += (Data[i] & 0x01) << k;
                    i++;
                }
                c = Convert.ToChar(tem);  // 构造字符
                if (c == '#')
                    if (state == 0) {
                        state = 1;
                        continue;
                    }
                    else break;

                if (c != '#' && state != 1)
                {
                    return false;
                }
                if (c != '#' && state == 1)
                    s += c.ToString();
                if (c == '#')
                    state++;
                if (state == 2) break;
            }
            return true;
        }
    }
}
