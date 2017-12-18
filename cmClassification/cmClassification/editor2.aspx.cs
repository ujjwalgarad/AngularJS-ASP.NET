using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using cmClassification.intra.chsservice;

namespace cmClassification
{
    public partial class editor2 : BasePage
    {

        //This is a lab page, not a live page
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser = ((BasePage)this.Page).loginUser;
        }
        public PersonVO LoginUser;
    }
}