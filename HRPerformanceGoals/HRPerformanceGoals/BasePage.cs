using HRPerformanceGoals.intra;
using HRPerformanceGoals.intra.chsService;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace HRPerformanceGoals
{
    public class BasePage : System.Web.UI.Page
    {

        // common code for all workflows
        public CHSService service = new CHSService();
        public PersonVO loginUser = new PersonVO();
        public int PermissionId = 0;
        public Boolean hasPermission = false;
        //public Boolean isAdmin = false;
        public Boolean isManager = false;
        public Boolean isHR = false;

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
        }

        // all post back data received, can also get viewstate
        protected override void OnPreLoad(EventArgs e)
        {



            switch (PermissionId)
            {
                case 1: // HR user
                    hasPermission = true;
                    isHR = true;
                    break;
                case 5: // Manager User
                    hasPermission = true;
                    isManager = true;
                    break;
                //case 10: // Admin User
                //    isAdmin = true;
                //    hasPermission = true;
                //    break;
                default: //rest of the users
                    hasPermission = true;
                    //isAdmin = false;
                    isManager = true;
                    isHR = false;
                    break;
            }

                    base.OnPreLoad(e);

            if (Page.IsPostBack) return;
        }
        public override void VerifyRenderingInServerForm(Control control)
        {

        }

    }
}