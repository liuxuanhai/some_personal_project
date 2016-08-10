using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace 桌面元搜索引擎的开发与设计
{
    public partial class FormMain : Form
    {
        public FormMain()
        {
            InitializeComponent();
        }

        #region 临时浏览器的事件
        /// <summary>
        /// 临时浏览器状态变化事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void tempBrowser_StatusTextChanged(object sender, EventArgs e)
        {
            WebBrowser myBrowser = (WebBrowser)sender;
            if (myBrowser != getCurrentBrowser())
            {
                return;
            }
            else
            {
                toolStripStatusLabel1.Text = myBrowser.StatusText;
            }
        }

        #endregion
        #region 常用方法
        /// <summary>
        /// 设置前进、后退按钮状态
        /// </summary>
        private void setStatusButton()
        {
            btngoback.Enabled = getCurrentBrowser().CanGoBack;
            btnforword.Enabled = getCurrentBrowser().CanGoForward;
        }
        /// <summary>
        /// 输入关键字进行搜索
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tscburl_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                toolStripButton2_Click(null, null);  // 搜索
            }
        }

        /// <summary>
        /// 临时浏览器产生新窗体事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void tempBrowser_NewWindow(object sender, CancelEventArgs e)
        {
            //使外部无法捕获此事件
            e.Cancel = true;
        }
        /// <summary>
        /// 临时浏览器产生新窗体事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void tempBrowser_NewWindow1(object sender, CancelEventArgs e)
        {
            //使外部无法捕获此事件
            e.Cancel = false;
        }

        /// <summary>
        /// 新建一个空白页面
        /// </summary>
        private void newPage(string name)
        {
            //tscburl.Text = "about:blank";
            TabPage mypage = new TabPage();
            WebBrowser tempBrowser = new WebBrowser();
            tempBrowser.ScriptErrorsSuppressed = true;  // 不提示页面脚本错误
            if (name.IndexOf("百度") >= 0)
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowserBaidu_ProgressChanged);
            else if (name.IndexOf("搜狗") >= 0)
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowserSougou_ProgressChanged);
            else if (name.IndexOf("360") >= 0)
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowser360_ProgressChanged);
            else if (name.IndexOf("网易") >= 0)
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowserWangyi_ProgressChanged);
            else if (name.IndexOf("必应") >= 0)
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowserBiying_ProgressChanged);
            else if (name.IndexOf("雅虎") >= 0)
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowserYahu_ProgressChanged);
            else
                tempBrowser.ProgressChanged += new WebBrowserProgressChangedEventHandler(tempBrowser_ProgressChanged);
            tempBrowser.StatusTextChanged += new EventHandler(tempBrowser_StatusTextChanged);
            tempBrowser.Dock = DockStyle.Fill;
            mypage.Controls.Add(tempBrowser);
            tabControl1.TabPages.Add(mypage);
            mypage.Text = name;
        }

        /// <summary>
        /// 控制进度条变化
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void tempBrowser_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            toolStripProgressBar1.Visible = true;
            toolStripProgressBar1.Maximum = (int)e.MaximumProgress;
            toolStripProgressBar1.Value = (int)e.CurrentProgress;
            toolStripProgressBar1.Visible = false;
            setStatusButton();
        }

        void tempBrowserBaidu_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            progressBar1.Visible = true;
            progressBar1.Maximum = (int)e.MaximumProgress;
            progressBar1.Value = (int)e.CurrentProgress;
            setStatusButton();
        }
        void tempBrowserSougou_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            progressBar2.Visible = true;
            progressBar2.Maximum = (int)e.MaximumProgress;
            progressBar2.Value = (int)e.CurrentProgress;
            setStatusButton();
        }
        void tempBrowser360_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            progressBar3.Visible = true;
            progressBar3.Maximum = (int)e.MaximumProgress;
            progressBar3.Value = (int)e.CurrentProgress;
            setStatusButton();
        }
        void tempBrowserWangyi_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            progressBar4.Visible = true;
            progressBar4.Maximum = (int)e.MaximumProgress;
            progressBar4.Value = (int)e.CurrentProgress;
            setStatusButton();
        }
        void tempBrowserBiying_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            progressBar5.Visible = true;
            progressBar5.Maximum = (int)e.MaximumProgress;
            progressBar5.Value = (int)e.CurrentProgress;
            setStatusButton();
        }
        void tempBrowserYahu_ProgressChanged(object sender, WebBrowserProgressChangedEventArgs e)
        {
            progressBar6.Visible = true;
            progressBar6.Maximum = (int)e.MaximumProgress;
            progressBar6.Value = (int)e.CurrentProgress;
            setStatusButton();
        }

        /// <summary>
        /// 获取当前的浏览器
        /// </summary>
        /// <returns></returns>
        private WebBrowser getCurrentBrowser()
        {
            WebBrowser currentBrowser = (WebBrowser)tabControl1.SelectedTab.Controls[0];
            return currentBrowser;
        }

        /// <summary>
        /// 处理地址栏中的字符串
        /// </summary>
        /// <param name="address"></param>
        /// <returns></returns>
        private Uri getUrl(string address)
        {
            string tempaddress = address;
            if ((!address.StartsWith("http://")) && (!address.StartsWith("https://")) && (!address.StartsWith("ftp://")))
            {
                tempaddress = "http://" + address;
            }
            Uri myurl;
            try
            {
                myurl = new Uri(tempaddress);
            }
            catch
            {
                myurl = new Uri("about:blank");
            }
            return myurl;
        }
        #endregion

        // 初始化界面
        private void FormMain_Load(object sender, EventArgs e)
        {
            comboBox1.SelectedIndex = 0; // 选择网页
            // 搜索引擎全选  初始化搜索引擎为空白页面
            for (int i = 0; i < checkedListBox1.Items.Count; ++i)
            {
                this.checkedListBox1.SetItemChecked(i, true);
                newPage(checkedListBox1.Items[i].ToString());
            }
        }

        // 搜索
        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            if (tscburl.Text.Trim().Length < 1)
            {
                MessageBox.Show("请输入搜索关键词");
                return;
            }
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                if (tabControl1.TabPages[i].Text.IndexOf("百度") >= 0)
                    if (checkedListBox1.GetItemChecked(i - 1))
                    { 
                        switch(comboBox1.SelectedItem.ToString())
                        {
                            case "网页":
                                currentBrowser.Navigate(getUrl("https://www.baidu.com/s?wd=" + tscburl.Text.Trim()));
                                break;
                            case "图片":
                                currentBrowser.Navigate(getUrl("http://image.baidu.com/search/index?tn=baiduimage&ie=utf-8&word=" + tscburl.Text.Trim()));
                                break;
                            case "视频":
                                currentBrowser.Navigate(getUrl("http://v.baidu.com/v?ie=utf-8&word=" + tscburl.Text.Trim()));
                                break;
                            case "新闻":
                                currentBrowser.Navigate(getUrl("http://news.baidu.com/ns?word=" + tscburl.Text.Trim()));
                                break;
                        }
                    }
                    else
                        currentBrowser.Navigate(getUrl("about:blank"));
                if (tabControl1.TabPages[i].Text.IndexOf("搜狗") >= 0)
                    if(checkedListBox1.GetItemChecked(i-1))
                    {
                        switch(comboBox1.SelectedItem.ToString())
                        {
                            case "网页":
                                currentBrowser.Navigate(getUrl("https://www.sogou.com/web?query=" + tscburl.Text.Trim()));
                                break;
                            case "图片":
                                currentBrowser.Navigate(getUrl("http://pic.sogou.com/pics?query=" + tscburl.Text.Trim()));
                                break;
                            case "视频":
                                currentBrowser.Navigate(getUrl("http://v.sogou.com/v?query=" + tscburl.Text.Trim()));
                                break;
                            case "新闻":
                                currentBrowser.Navigate(getUrl("http://news.sogou.com/news?query=" + tscburl.Text.Trim()));
                                break;
                        }
                    } 
                    else
                        currentBrowser.Navigate(getUrl("about:blank"));
                if (tabControl1.TabPages[i].Text.IndexOf("360") >= 0)
                    if(checkedListBox1.GetItemChecked(i-1))
                    {
                        switch(comboBox1.SelectedItem.ToString())
                        {
                            case "网页":
                                currentBrowser.Navigate(getUrl("https://www.so.com/s?q=" + tscburl.Text.Trim()));
                                break;
                            case "图片":
                                currentBrowser.Navigate(getUrl("http://image.so.com/i?q=" + tscburl.Text.Trim()));
                                break;
                            case "视频":
                                currentBrowser.Navigate(getUrl("http://video.so.com/v?q=" + tscburl.Text.Trim()));
                                break;
                            case "新闻":
                                currentBrowser.Navigate(getUrl("http://news.so.com/ns?q=" + tscburl.Text.Trim()));
                                break;
                        }
                    }    
                    else
                        currentBrowser.Navigate(getUrl("about:blank"));
                if (tabControl1.TabPages[i].Text.IndexOf("必应") >= 0)
                    if(checkedListBox1.GetItemChecked(i-1))
                    {
                        switch(comboBox1.SelectedItem.ToString())
                        {
                            case "网页":
                                currentBrowser.Navigate(getUrl("http://cn.bing.com/search?q=" + tscburl.Text.Trim()));
                                break;
                            case "图片":
                                currentBrowser.Navigate(getUrl("http://cn.bing.com/images/search?q=" + tscburl.Text.Trim()));
                                break;
                            case "视频":
                                currentBrowser.Navigate(getUrl("http://cn.bing.com/videos/search?q=" + tscburl.Text.Trim()));
                                break;
                            case "新闻":
                                currentBrowser.Navigate(getUrl("http://cn.bing.com/search?q=新闻 " + tscburl.Text.Trim()));
                                break;
                        }
                    }   
                    else
                        currentBrowser.Navigate(getUrl("about:blank"));
                if (tabControl1.TabPages[i].Text.IndexOf("网易") >= 0)
                    if (checkedListBox1.GetItemChecked(i - 1))
                    {
                        switch (comboBox1.SelectedItem.ToString())
                        {
                            case "网页":
                                currentBrowser.Navigate(getUrl("http://www.youdao.com/search?q=" + tscburl.Text.Trim()));
                                break;
                            case "图片":
                                currentBrowser.Navigate(getUrl("http://image.youdao.com/search?q=" + tscburl.Text.Trim()));
                                break;
                            case "视频":
                                currentBrowser.Navigate(getUrl("http://video.youdao.com/search?q=" + tscburl.Text.Trim()));
                                break;
                            case "新闻":
                                currentBrowser.Navigate(getUrl("http://news.youdao.com/search?q=" + tscburl.Text.Trim()));
                                break;
                        }
                    }
                    else
                        currentBrowser.Navigate(getUrl("about:blank"));
                if (tabControl1.TabPages[i].Text.IndexOf("雅虎") >= 0)
                    if (checkedListBox1.GetItemChecked(i - 1))
                    {
                        switch (comboBox1.SelectedItem.ToString())
                        {
                            case "网页":
                                currentBrowser.Navigate(getUrl("https://sg.search.yahoo.com/search?p=" + tscburl.Text.Trim()));
                                break;
                            case "图片":
                                currentBrowser.Navigate(getUrl("https://sg.images.search.yahoo.com/search/images?p=" + tscburl.Text.Trim()));
                                break;
                            case "视频":
                                currentBrowser.Navigate(getUrl("https://sg.video.search.yahoo.com/search/video?p=" + tscburl.Text.Trim()));
                                break;
                            case "新闻":
                                currentBrowser.Navigate(getUrl("https://sg.news.search.yahoo.com/search?p=" + tscburl.Text.Trim()));
                                break;
                        }
                    }
                    else
                        currentBrowser.Navigate(getUrl("about:blank"));
            }
        }

        // 新搜索
        private void btnNew_Click(object sender, EventArgs e)
        {
            tscburl.Text = "";
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                currentBrowser.Navigate(getUrl("about:blank"));
            }
            tabControl1.SelectedIndex = 0;
        }

        // 停止
        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                currentBrowser.Stop();
            }
        }

        // 停止
        private void btnStop_Click(object sender, EventArgs e)
        {
            toolStripButton3_Click(null,null);
        }

        // 百度停止
        private void button1_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("百度") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Stop();
                }
            }
        }

        // 搜狗停止
        private void button4_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("搜狗") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Stop();
                }
            }
        }

        //360停止
        private void button6_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("360") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Stop();
                }
            }
        }

        // 网易停止
        private void button8_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("网易") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Stop();
                }
            }
        }

        // 百度刷新
        private void button2_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("百度") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Refresh();
                }
            }
        }

        // 搜狗刷新
        private void button3_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("搜狗") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Refresh();
                }
            }
        }
        
        // 360刷新
        private void button5_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("360") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Refresh();
                }
            }
        }

        // 网易刷新
        private void button7_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("网易") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Refresh();
                }
            }
        }

        // 必应停止
        private void button10_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("必应") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Stop();
                }
            }
        }
        // 必应刷新
        private void button9_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("必应") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Refresh();
                }
            }
        }
        // 雅虎停止
        private void button12_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("雅虎") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Stop();
                }
            }
        }
        // 雅虎刷新
        private void button11_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                if (tabControl1.TabPages[i].Text.IndexOf("雅虎") >= 0)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.Refresh();
                }
            }
        }

        // 开始搜索
        private void btnsearch_Click(object sender, EventArgs e)
        {
            toolStripButton2_Click(null,null);
        }

        // 开始搜索
        private void 开始搜索ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStripButton2_Click(null, null);
        }

        //停止搜索
        private void 停止搜索ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStripButton3_Click(null,null);
        }

        // 退出系统
        private void 退出系统ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        // 全部刷新
        private void btnrefresh_Click(object sender, EventArgs e)
        {
            for (int i = 1; i < tabControl1.TabPages.Count; ++i)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                currentBrowser.Refresh();
            }
        }

        // 打印
        private void btnprint_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[tabControl1.SelectedIndex].Controls[0];
                currentBrowser.ShowPrintDialog();
            }
        }

        // 打印预览
        private void toolStripButton4_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[tabControl1.SelectedIndex].Controls[0];
                currentBrowser.ShowPrintPreviewDialog();//.ShowPrintDialog();
            }
        }

        // 打印预览
        private void 打印预览ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStripButton4_Click(null,null);
        }

        // 打印
        private void 打印ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            btnprint_Click(null,null);
        }
        private void 页面设置ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[tabControl1.SelectedIndex].Controls[0];
                currentBrowser.ShowPageSetupDialog();
            }
        }

        // 保存
        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[tabControl1.SelectedIndex].Controls[0];
                currentBrowser.ShowSaveAsDialog();
            }
        }

        // 查看工具栏
        private void 工具栏ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStrip1.Visible = 工具栏ToolStripMenuItem.Checked;
        }

        private void 搜索栏ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStrip2.Visible = 工具栏ToolStripMenuItem.Checked;
        }

        // 后退
        private void btngoback_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                setStatusButton();
                getCurrentBrowser().GoBack();
            } 
        }

        // 前进
        private void btnforword_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                setStatusButton();
                getCurrentBrowser().GoForward();
            } 
        }

        // 属性
        private void 属性ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex > 0)
            {
                setStatusButton();
                getCurrentBrowser().ShowPropertiesDialog();
            } 
        }

        // 系统关于
        private void 关于系统ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormAbout about = new FormAbout();
            about.ShowDialog();
        }

        private void toolStripButton5_Click(object sender, EventArgs e)
        {
            if (toolStripButton5.Text.IndexOf("允许弹窗")>=0)
            {
                toolStripButton5.Text = "禁止弹窗";
                for (int i = 1; i < tabControl1.TabPages.Count; ++i)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.NewWindow += tempBrowser_NewWindow;
                }
            }
            else if (toolStripButton5.Text == "禁止弹窗")
            {
                toolStripButton5.Text = "允许弹窗";
                for (int i = 1; i < tabControl1.TabPages.Count; ++i)
                {
                    WebBrowser currentBrowser = (WebBrowser)tabControl1.TabPages[i].Controls[0];
                    currentBrowser.NewWindow += tempBrowser_NewWindow1;
                }
            }
        }

        

    }
}
