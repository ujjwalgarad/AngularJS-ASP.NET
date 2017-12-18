using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPerformanceGoals.objects
{
    public class Person30DayVO
    {
        public string PersonTKID { get; set; }

        
        public string PersonFullName { get; set; }
        public string ManagerTKID { get; set; }
        public string ManagerFullName { get; set; }
        public string FormCreatedByTKID { get; set; }
        public string FormCreatedBy { get; set; }
        //public Boolean ReviewCompleted { get; set; }
        //public Boolean ReleasedToManager { get; set; }
        public string Department { get; set; }
        public string Status { get; set; }
        public int StatusID { get; set; }


        public List<GoalsVO> Goals { get; set; }
        public string HireDate { get; set; }
        public string ReviewDate { get; set; }
        public string Completed30DaysOn { get; set; }
        public string Completed60DaysOn { get; set; }
    }
}