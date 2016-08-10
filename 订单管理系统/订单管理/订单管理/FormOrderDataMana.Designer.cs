namespace 订单管理
{
    partial class FormOrderDataMana
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle7 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle8 = new System.Windows.Forms.DataGridViewCellStyle();
            this.查询条件 = new System.Windows.Forms.GroupBox();
            this.button3 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.DHSJEnd = new System.Windows.Forms.DateTimePicker();
            this.CPLB = new System.Windows.Forms.ComboBox();
            this.label12 = new System.Windows.Forms.Label();
            this.CPMC = new System.Windows.Forms.ComboBox();
            this.label8 = new System.Windows.Forms.Label();
            this.DHDW = new System.Windows.Forms.ComboBox();
            this.JBR = new System.Windows.Forms.ComboBox();
            this.label11 = new System.Windows.Forms.Label();
            this.DHSJ = new System.Windows.Forms.DateTimePicker();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.DHQD = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.查询条件.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // 查询条件
            // 
            this.查询条件.Controls.Add(this.button3);
            this.查询条件.Controls.Add(this.button2);
            this.查询条件.Controls.Add(this.button1);
            this.查询条件.Controls.Add(this.label3);
            this.查询条件.Controls.Add(this.DHSJEnd);
            this.查询条件.Controls.Add(this.CPLB);
            this.查询条件.Controls.Add(this.label12);
            this.查询条件.Controls.Add(this.CPMC);
            this.查询条件.Controls.Add(this.label8);
            this.查询条件.Controls.Add(this.DHDW);
            this.查询条件.Controls.Add(this.JBR);
            this.查询条件.Controls.Add(this.label11);
            this.查询条件.Controls.Add(this.DHSJ);
            this.查询条件.Controls.Add(this.label2);
            this.查询条件.Controls.Add(this.label1);
            this.查询条件.Controls.Add(this.DHQD);
            this.查询条件.Controls.Add(this.label5);
            this.查询条件.Dock = System.Windows.Forms.DockStyle.Top;
            this.查询条件.Location = new System.Drawing.Point(0, 0);
            this.查询条件.Name = "查询条件";
            this.查询条件.Size = new System.Drawing.Size(863, 90);
            this.查询条件.TabIndex = 1;
            this.查询条件.TabStop = false;
            this.查询条件.Text = "筛选条件";
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(764, 54);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 23);
            this.button3.TabIndex = 48;
            this.button3.Text = "导出";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(664, 54);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 47;
            this.button2.Text = "检索";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(566, 56);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 46;
            this.button1.Text = "重置";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(198, 26);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(53, 12);
            this.label3.TabIndex = 45;
            this.label3.Text = "————";
            // 
            // DHSJEnd
            // 
            this.DHSJEnd.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.DHSJEnd.Location = new System.Drawing.Point(257, 18);
            this.DHSJEnd.Name = "DHSJEnd";
            this.DHSJEnd.Size = new System.Drawing.Size(107, 21);
            this.DHSJEnd.TabIndex = 44;
            // 
            // CPLB
            // 
            this.CPLB.FormattingEnabled = true;
            this.CPLB.Location = new System.Drawing.Point(79, 56);
            this.CPLB.Name = "CPLB";
            this.CPLB.Size = new System.Drawing.Size(106, 20);
            this.CPLB.TabIndex = 43;
            this.CPLB.SelectedIndexChanged += new System.EventHandler(this.CPLB_SelectedIndexChanged);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(20, 64);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(53, 12);
            this.label12.TabIndex = 42;
            this.label12.Text = "产品类别";
            // 
            // CPMC
            // 
            this.CPMC.FormattingEnabled = true;
            this.CPMC.Location = new System.Drawing.Point(258, 56);
            this.CPMC.Name = "CPMC";
            this.CPMC.Size = new System.Drawing.Size(106, 20);
            this.CPMC.TabIndex = 41;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(199, 64);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(53, 12);
            this.label8.TabIndex = 40;
            this.label8.Text = "产品名称";
            // 
            // DHDW
            // 
            this.DHDW.FormattingEnabled = true;
            this.DHDW.Location = new System.Drawing.Point(452, 16);
            this.DHDW.Name = "DHDW";
            this.DHDW.Size = new System.Drawing.Size(90, 20);
            this.DHDW.TabIndex = 24;
            // 
            // JBR
            // 
            this.JBR.FormattingEnabled = true;
            this.JBR.Location = new System.Drawing.Point(452, 56);
            this.JBR.Name = "JBR";
            this.JBR.Size = new System.Drawing.Size(90, 20);
            this.JBR.TabIndex = 30;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(405, 64);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(41, 12);
            this.label11.TabIndex = 29;
            this.label11.Text = "经办人";
            // 
            // DHSJ
            // 
            this.DHSJ.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.DHSJ.Location = new System.Drawing.Point(78, 20);
            this.DHSJ.Name = "DHSJ";
            this.DHSJ.Size = new System.Drawing.Size(107, 21);
            this.DHSJ.TabIndex = 28;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(19, 29);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 12);
            this.label2.TabIndex = 25;
            this.label2.Text = "订货时间";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(397, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 12);
            this.label1.TabIndex = 23;
            this.label1.Text = "订货单位";
            // 
            // DHQD
            // 
            this.DHQD.FormattingEnabled = true;
            this.DHQD.Location = new System.Drawing.Point(623, 16);
            this.DHQD.Name = "DHQD";
            this.DHQD.Size = new System.Drawing.Size(90, 20);
            this.DHQD.TabIndex = 27;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(564, 24);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 12);
            this.label5.TabIndex = 26;
            this.label5.Text = "订货渠道";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.dataGridView1);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(0, 90);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(863, 306);
            this.groupBox2.TabIndex = 5;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "汇总信息";
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            dataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle7.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle7.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            dataGridViewCellStyle7.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle7.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle7.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle7.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle7;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(3, 17);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersVisible = false;
            dataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle8.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dataGridView1.RowsDefaultCellStyle = dataGridViewCellStyle8;
            this.dataGridView1.RowTemplate.Height = 23;
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(857, 286);
            this.dataGridView1.TabIndex = 0;
            // 
            // FormOrderDataMana
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(863, 396);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.查询条件);
            this.Name = "FormOrderDataMana";
            this.ShowIcon = false;
            this.Text = "订单数据管理";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.FormOrderDataMana_Load);
            this.查询条件.ResumeLayout(false);
            this.查询条件.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox 查询条件;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.DateTimePicker DHSJEnd;
        private System.Windows.Forms.ComboBox CPLB;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.ComboBox CPMC;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.ComboBox DHDW;
        private System.Windows.Forms.ComboBox JBR;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.DateTimePicker DHSJ;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox DHQD;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.DataGridView dataGridView1;

    }
}