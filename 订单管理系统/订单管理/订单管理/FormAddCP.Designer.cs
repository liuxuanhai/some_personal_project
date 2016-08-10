namespace 订单管理
{
    partial class FormAddCP
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
            this.label12 = new System.Windows.Forms.Label();
            this.CPMC = new System.Windows.Forms.ComboBox();
            this.label8 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.CPSL = new System.Windows.Forms.TextBox();
            this.buttonOK = new System.Windows.Forms.Button();
            this.buttonCancel = new System.Windows.Forms.Button();
            this.CPLB = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.CPDW = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(67, 41);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(53, 12);
            this.label12.TabIndex = 33;
            this.label12.Text = "产品类别";
            // 
            // CPMC
            // 
            this.CPMC.FormattingEnabled = true;
            this.CPMC.Location = new System.Drawing.Point(126, 73);
            this.CPMC.Name = "CPMC";
            this.CPMC.Size = new System.Drawing.Size(177, 20);
            this.CPMC.TabIndex = 1;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(67, 81);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(53, 12);
            this.label8.TabIndex = 31;
            this.label8.Text = "产品名称";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(67, 119);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(29, 12);
            this.label1.TabIndex = 35;
            this.label1.Text = "数量";
            // 
            // CPSL
            // 
            this.CPSL.Location = new System.Drawing.Point(126, 110);
            this.CPSL.Name = "CPSL";
            this.CPSL.Size = new System.Drawing.Size(177, 21);
            this.CPSL.TabIndex = 2;
            this.CPSL.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.CPSL_KeyPress);
            // 
            // buttonOK
            // 
            this.buttonOK.Location = new System.Drawing.Point(105, 201);
            this.buttonOK.Name = "buttonOK";
            this.buttonOK.Size = new System.Drawing.Size(75, 23);
            this.buttonOK.TabIndex = 5;
            this.buttonOK.Text = "添加";
            this.buttonOK.UseVisualStyleBackColor = true;
            this.buttonOK.Click += new System.EventHandler(this.buttonOK_Click);
            // 
            // buttonCancel
            // 
            this.buttonCancel.Location = new System.Drawing.Point(213, 201);
            this.buttonCancel.Name = "buttonCancel";
            this.buttonCancel.Size = new System.Drawing.Size(75, 23);
            this.buttonCancel.TabIndex = 6;
            this.buttonCancel.Text = "退出";
            this.buttonCancel.UseVisualStyleBackColor = true;
            this.buttonCancel.Click += new System.EventHandler(this.buttonCancel_Click);
            // 
            // CPLB
            // 
            this.CPLB.FormattingEnabled = true;
            this.CPLB.Location = new System.Drawing.Point(126, 33);
            this.CPLB.Name = "CPLB";
            this.CPLB.Size = new System.Drawing.Size(177, 20);
            this.CPLB.TabIndex = 0;
            this.CPLB.SelectedIndexChanged += new System.EventHandler(this.CPLB_SelectedIndexChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(67, 158);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(29, 12);
            this.label2.TabIndex = 40;
            this.label2.Text = "单位";
            // 
            // CPDW
            // 
            this.CPDW.FormattingEnabled = true;
            this.CPDW.Location = new System.Drawing.Point(126, 150);
            this.CPDW.Name = "CPDW";
            this.CPDW.Size = new System.Drawing.Size(177, 20);
            this.CPDW.TabIndex = 4;
            // 
            // FormAddCP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(398, 236);
            this.ControlBox = false;
            this.Controls.Add(this.CPDW);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.CPLB);
            this.Controls.Add(this.buttonOK);
            this.Controls.Add(this.buttonCancel);
            this.Controls.Add(this.CPSL);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.CPMC);
            this.Controls.Add(this.label8);
            this.Name = "FormAddCP";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "添加产品";
            this.Load += new System.EventHandler(this.FormAddCP_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.ComboBox CPMC;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox CPSL;
        private System.Windows.Forms.Button buttonOK;
        private System.Windows.Forms.Button buttonCancel;
        private System.Windows.Forms.ComboBox CPLB;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox CPDW;
    }
}