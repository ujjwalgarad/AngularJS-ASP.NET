using cmClassification.intra.chsservice;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cmClassification
{
    public partial class _default : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //LoginUser = ((BasePage)this.Page).loginUser;

        }
        public PersonVO LoginUser;

    }
}