using HRPerformanceGoals.intra;
using HRPerformanceGoals.intra.chsService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPerformanceGoals
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser = ((BasePage)this.Page).loginUser;
            HasPermission = ((BasePage)this.Page).hasPermission;
            //IsAdmin = ((BasePage)this.Page).isAdmin;
            IsHR = ((BasePage)this.Page).isHR;
            IsManager = ((BasePage)this.Page).isManager;
            PermissionId = ((BasePage)this.Page).PermissionId;

            lblFullName.Text = LoginUser.FullName;

            if (Page.IsPostBack) return;
        }
        public PersonVO LoginUser;

        public bool HasPermission { get; private set; }
        public bool IsHR { get; private set; }
        //public bool IsAdmin { get; private set; }
        public bool IsManager { get; private set; }
        public int PermissionId { get; private set; }
    }
}