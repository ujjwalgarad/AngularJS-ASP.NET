using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cmClassification.objects
{
    public class MiniBadgeVO
    {
        // this is for saving and displaying the data  in the c/m dash board
        public string CMNumber { get; set; }

        public int CMBadgeId { get; set; } // this is the id for each attached badge, use it to detach the badge

        public int ItemId { get; set; }

        public bool IsMatter { get; set; }

        public string CreatedByTkid { get; set; }

        public string CreatedByFullName { get; set; }

        public int CategoryId { get; set; }

        public int ItemChildCount { get; set; }

        public string BadgeDisplayName { get; set; } // this will the path from parent : parent > child > grandchild
    }
}