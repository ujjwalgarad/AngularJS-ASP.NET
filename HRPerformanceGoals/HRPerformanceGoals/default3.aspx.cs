using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRPerformanceGoals.intra.chsService;

namespace HRPerformanceGoals
{
    public partial class default3 : BasePage
    {
        public CHSService service = new CHSService();
        public PersonVO loginUser = new PersonVO();
        protected void Page_Load(object sender, EventArgs e)
        {
            string PersonTKID = Request.QueryString["personTKID"];
            string managerTKID = Request.QueryString["managerTKID"];

            if (!String.IsNullOrEmpty(PersonTKID))
            {
                Person = service.GetPersonProfileByTkid(PersonTKID);

            }

            if (!String.IsNullOrEmpty(managerTKID))
            {
                Manager = service.GetPersonProfileByTkid(managerTKID);

            }

            //PersonFullName = Request.QueryString["personFullName"];
            //ManagerFullName = Request.QueryString["managerFullName"];
        }
        //public string PersonTKID;
        //public string PersonFullName;
        //public string ManagerFullName;
        public PersonVO Person;
        public PersonVO Manager;
    }
}