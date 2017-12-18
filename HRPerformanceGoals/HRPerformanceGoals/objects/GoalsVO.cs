using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPerformanceGoals.objects
{
    public class GoalsVO
    {
        public int GoalId  { get; set; }
        public string Goal { get; set; }
        public string Review { get; set; }

        public string Review60Day { get; set; }

        //priority is not getting used in current version
        public int Priority { get; set; }
        public string PersonTKID { get; set; }
    }
}