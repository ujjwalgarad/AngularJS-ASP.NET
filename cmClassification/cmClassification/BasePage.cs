using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Web.UI;
using System.Net.Mail;
using System.Threading;
using System.Web;
using cmClassification.intra.chsservice;

namespace cmClassification
{
    public class BasePage : System.Web.UI.Page
    {
        // common code for all workflows
        //public CHSService service = new CHSService();
        //public PersonVO loginUser = new PersonVO();

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


            if (Page.IsPostBack) return;
        }


        // utility
        public string UppercaseFirst(string s)
        {
            // Check for empty string.
            if (string.IsNullOrEmpty(s))
            {
                return string.Empty;
            }
            // Return char and concat substring.
            return char.ToUpper(s[0]) + s.Substring(1);
        }



        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
            // to prevent the must runat=server error when rendering gridview into an html table
        }
    }
}