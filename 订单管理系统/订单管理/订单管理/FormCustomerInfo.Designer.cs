namespace 订单管理
{
    partial class FormCustomerInfo
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.BZ = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.LXFS = new System.Windows.Forms.TextBox();
            this.FZR = new System.Windows.Forms.TextBox();
            this.DWDZ = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.订单信息 = new System.Windows.Forms.GroupBox();
            this.JYXM = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.DWMC = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.buttonOK = new System.Windows.Forms.Button();
            this.buttonCancel = new System.Windows.Forms.Button();
            this.订单信息.SuspendLayout();
            this.SuspendLayout();
            // 
            // BZ
            // 
            this.BZ.Location = new System.Drawing.Point(83, 134);
            this.BZ.Multiline = true;
            this.BZ.Name = "BZ";
            this.BZ.Size = new System.Drawing.Size(295, 20);
            this.BZ.TabIndex = 5;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(48, 137);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(29, 12);
            this.label9.TabIndex = 16;
            this.label9.Text = "备注";
            // 
            // LXFS
            // 
            this.LXFS.Location = new System.Drawing.Point(83, 62);
            this.LXFS.Name = "LXFS";
            this.LXFS.Size = new System.Drawing.Size(107, 21);
            this.LXFS.TabIndex = 2;
            this.LXFS.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.LXFS_KeyPress);
            // 
            // FZR
            // 
            this.FZR.Location = new System.Drawing.Point(272, 27);
            this.FZR.Name = "FZR";
            this.FZR.Size = new System.Drawing.Size(106, 21);
            this.FZR.TabIndex = 1;
            // 
            // DWDZ
            // 
            this.DWDZ.Location = new System.Drawing.Point(83, 98);
            this.DWDZ.Name = "DWDZ";
            this.DWDZ.Size = new System.Drawing.Size(295, 21);
            this.DWDZ.TabIndex = 4;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(24, 107);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(53, 12);
            this.label7.TabIndex = 10;
            this.label7.Text = "单位地址";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(24, 65);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(53, 12);
            this.label6.TabIndex = 12;
            this.label6.Text = "联系方式";
            // 
            // 订单信息
            // 
            this.订单信息.Controls.Add(this.JYXM);
            this.订单信息.Controls.Add(this.BZ);
            this.订单信息.Controls.Add(this.label9);
            this.订单信息.Controls.Add(this.LXFS);
            this.订单信息.Controls.Add(this.FZR);
            this.订单信息.Controls.Add(this.label8);
            this.订单信息.Controls.Add(this.label7);
            this.订单信息.Controls.Add(this.DWMC);
            this.订单信息.Controls.Add(this.DWDZ);
            this.订单信息.Controls.Add(this.label1);
            this.订单信息.Controls.Add(this.label5);
            this.订单信息.Controls.Add(this.label6);
            this.订单信息.Dock = System.Windows.Forms.DockStyle.Top;
            this.订单信息.Location = new System.Drawing.Point(0, 0);
            this.订单信息.Name = "订单信息";
            this.订单信息.Size = new System.Drawing.Size(405, 173);
            this.订单信息.TabIndex = 32;
            this.订单信息.TabStop = false;
            this.订单信息.Text = "客户信息";
            // 
            // JYXM
            // 
            this.JYXM.Location = new System.Drawing.Point(272, 62);
            this.JYXM.Name = "JYXM";
            this.JYXM.Size = new System.Drawing.Size(106, 21);
            this.JYXM.TabIndex = 3;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(24, 30);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(53, 12);
            this.label8.TabIndex = 29;
            this.label8.Text = "单位名称";
            // 
            // DWMC
            // 
            this.DWMC.Location = new System.Drawing.Point(83, 27);
            this.DWMC.Name = "DWMC";
            this.DWMC.Size = new System.Drawing.Size(107, 21);
            this.DWMC.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(213, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 12);
            this.label1.TabIndex = 0;
            this.label1.Text = "负责人";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(213, 70);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 12);
            this.label5.TabIndex = 14;
            this.label5.Text = "经营项目";
            // 
            // buttonOK
            // 
            this.buttonOK.Location = new System.Drawing.Point(86, 199);
            this.buttonOK.Name = "buttonOK";
            this.buttonOK.Size = new System.Drawing.Size(75, 23);
            this.buttonOK.TabIndex = 6;
            this.buttonOK.Text = "保存";
            this.buttonOK.UseVisualStyleBackColor = true;
            this.buttonOK.Click += new System.EventHandler(this.buttonOK_Click);
            // 
            // buttonCancel
            // 
            this.buttonCancel.Location = new System.Drawing.Point(226, 199);
            this.buttonCancel.Name = "buttonCancel";
            this.buttonCancel.Size = new System.Drawing.Size(75, 23);
            this.buttonCancel.TabIndex = 7;
            this.buttonCancel.Text = "取消";
            this.buttonCancel.UseVisualStyleBackColor = true;
            this.buttonCancel.Click += new System.EventHandler(this.buttonCancel_Click);
            // 
            // FormCustomerInfo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(405, 234);
            this.ControlBox = false;
            this.Controls.Add(this.buttonOK);
            this.Controls.Add(this.buttonCancel);
            this.Controls.Add(this.订单信息);
            this.Name = "FormCustomerInfo";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "客户信息";
            this.Load += new System.EventHandler(this.FormCustomerInfo_Load);
            this.订单信息.ResumeLayout(false);
            this.订单信息.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox BZ;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox LXFS;
        private System.Windows.Forms.TextBox FZR;
        private System.Windows.Forms.TextBox DWDZ;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.GroupBox 订单信息;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox DWMC;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox JYXM;
        private System.Windows.Forms.Button buttonOK;
        private System.Windows.Forms.Button buttonCancel;
    }
}