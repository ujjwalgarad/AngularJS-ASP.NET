using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using cmClassification.intra.chsservice;

namespace cmClassification
{
    public partial class editor : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //LoginUser = ((BasePage)this.Page).loginUser;

            string cmNumber = Request.QueryString["cmNumber"];

            if (!String.IsNullOrEmpty(cmNumber))
            {
                long x = 0;
                if (cmNumber.Contains("-"))
                {
                    // this is client-matter number
                    string[] words = cmNumber.Split(new[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                    // make sure all the input is digital

                    if (Int64.TryParse(words[0], out x))
                    {
                        ClientNumber = words[0];
                        if (Int64.TryParse(words[1], out x))
                        {
                            MatterNumber = words[1];
                        }
                    }
                }
                else
                {

                    if (Int64.TryParse(cmNumber, out x))
                    {
                        ClientNumber = cmNumber;
                    }
                }
            }
        }

        public PersonVO LoginUser;
        public string ClientNumber;

        public string MatterNumber;
    }
}