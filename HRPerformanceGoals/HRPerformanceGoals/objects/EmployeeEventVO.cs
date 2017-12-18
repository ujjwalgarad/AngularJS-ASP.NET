using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPerformanceGoals.objects
{
    public class EmployeeEventVO
    {
        public string Tkid { get; set; }

        public string Login { get; set; }

        public string FullName { get; set; }

        public string ManagerTkid { get; set; }

        public string ManagerLogin { get; set; }

        public string ManagerFullName { get; set; }

        public string Final30RvwDate { get; set; }

        public string Final60RvwDate { get; set; }
    }
}