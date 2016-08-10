using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Media;
using System.Runtime.InteropServices;

namespace windows下简单游戏_连连看
{
    class ClassKernel
    {
        private const int M = 12;
        private const int N = 8;
        private const int BLANK = 0;
        private static int[,] map = new int[M, N];
        Point[] arr1 = new Point[M*N];
        int arr1Len, arr2Len;
        Point[] arr2 = new Point[M * N];

        static Point[] corner = new Point[2];//用来存储两个拐点
        static int co = 0;//用来标识几个拐点


        public ClassKernel(ref int[] mmap)
        {
            for (int i = 0; i < M; i++)
                for (int j = 0; j < N; j++)
                    map[i, j] = mmap[i*N+ j];

            corner[0] = new Point(0, 0);
            corner[1] = new Point(0, 0);
        }
        public Point[] GetPoints()
        {
            Point[] p = new Point[3];
            p[0] = corner[0];
            p[1] = corner[1];
            p[2] = new Point(co, 0);
            return p;
        }
        public bool IsShare(ref Point[] a1, int a1Len, ref Point[] a2, int a2Len)
        {
            bool result = false;
            for (int i = 0; i < a1Len; i++)
                for (int j = 0; j < a2Len; j++)
                    if (a1[i].X == a2[j].X && a1[i].Y == a2[j].Y)
                    {
                        corner[0] = new Point(a1[i].X, a1[i].Y);
                        result = true;
                    }
            return result;
        }
        public bool IsDirectLink(int x1, int y1, int x2, int y2)
        {
            if (x1 == x2 && y1 == y2)
            {
                return false;
            }
            if (x1 == x2)
            {
                int bigger = y1 > y2 ? y1 : y2;
                int smaller = y1 > y2 ? y2 : y1;


                int miny = smaller+ 1;
                while (map[x1, miny] == BLANK)
                {
                    miny++;
                    if (miny >= N)
                        break;
                }

                if (miny == bigger)
                    return true;
                else
                    return false;

            }
            if (y1 == y2)
            {
                int bigger = x1 > x2 ? x1 : x2;
                int smaller = x1 > x2 ? x2 : x1;
                int minx = smaller + 1;
                while (map[minx, y1] == BLANK)
                {
                    minx++;
                    if (minx >= M)
                        break;
                }
                    if (minx == bigger)
                        return true;

                    else
                        return false;

            }
            return false;

        }

        public int FindEmpty(int x, int y, ref Point[] arr)
        {
            int count = 0;
            int pos = x - 1;
            while (0 <= pos && pos < M && map[pos, y] == BLANK)
            {
                arr[count].X = pos;
                arr[count].Y = y;
                pos--;
                count++;
            }

            pos = x + 1;
            while (0 <= pos && pos < M && map[pos, y] == BLANK)
            {
                arr[count].X = pos;
                arr[count].Y = y;
                pos++;
                count++;
            }

            pos = y - 1;
            while (0 <= pos && pos < N && map[x, pos] == BLANK)
            {
                arr[count].X = x;
                arr[count].Y = pos;
                pos--;
                count++;
            }

            pos = y + 1;
            while (0 <= pos && pos < N && map[x, pos] == BLANK)
            {
                arr[count].X = x;
                arr[count].Y = pos;
                pos++;
                count++;
            }

            return count;
        }


        public bool IndirectLink(int x1, int y1, int x2, int y2)
        {
            
            int pos = 0;
            Point[] ar1 = new Point[M * N];
            int ar1Len = 0;
            Point[] ar2 = new Point[M * N];
            int ar2Len = 0;

            pos = y1 - 1;
            while (0 <= pos && pos < N && map[x1,pos] == BLANK)
            {
                ar1Len = FindEmpty(x1, pos, ref ar1);
                ar2Len = FindEmpty(x2, y2, ref ar2);
                if (IsShare(ref ar1, ar1Len, ref ar2, ar2Len))
                {
                    co = 2;
                    corner[1] = new Point(x1, pos);
                    return true;
                }
                pos--;
            }
            pos = y1 + 1;
            while (0 <= pos && pos < N && map[x1,pos] == BLANK)
            {
                ar1Len = FindEmpty(x1, pos, ref ar1);
                ar2Len = FindEmpty(x2, y2, ref ar2);
                if (IsShare(ref ar1, ar1Len, ref ar2, ar2Len))
                {
                    co = 2;
                    corner[1] = new Point(x1, pos);
                    return true;
                }
                pos++;
            }


            //如果两点是左右且非直连关系
            pos = x1 - 1;
            while (0 <= pos && pos < M && map[pos,y1] == BLANK)
            {
                ar1Len = FindEmpty(pos, y1, ref ar1);
                ar2Len = FindEmpty(x2, y2, ref ar2);
                if (IsShare(ref ar1, ar1Len, ref ar2, ar2Len))
                {
                    co = 2;
                    corner[1] = new Point(pos, y1);
                    return true;
                }
                pos--;

            }
            pos = x1 + 1;
            while (0 <= pos && pos < M && map[pos,y1] == BLANK)
            {
                ar1Len = FindEmpty(pos, y1, ref ar1);
                ar2Len = FindEmpty(x2, y2, ref ar2);
                if (IsShare(ref ar1, ar1Len, ref ar2, ar2Len))
                {
                    co = 2;
                    corner[1] = new Point(pos, y1);
                    return true;
                }
                pos++;
            }

            //如果非上下非左右，即构成矩形的关系
            return false;
        }

        public bool IsLink(int x1, int y1, int x2, int y2)
        {
            if (x1 == x2 && y1 == y2)
            {
                return false;
            }
            if (map[x1,y1] == map[x2,y2])
            {
                if (IsDirectLink(x1, y1, x2, y2))
                {
                    co = 0;
                    return true;
                }
                else
                {
                    arr1Len = FindEmpty(x1, y1, ref arr1);
                    arr2Len = FindEmpty(x2, y2, ref arr2);
                    if (IsShare(ref arr1, arr1Len, ref arr2, arr2Len))
                    {
                        co = 1;
                        return true;
                    }
                    else
                    {
                        return IndirectLink(x1, y1, x2, y2);
                    }
                }
            }
            return false;
        }

        public void GiveMapValue(int XX, int YY, int value)
        {
            map[XX,YY] = value;
        }
    }
}
