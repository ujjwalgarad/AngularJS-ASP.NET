using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cmClassification.objects
{
    public class BadgeVO
    {
        public int ItemId { get; set; }

        public string type { get; set; }

        public string name { get; set; }

        public string BadgeDisplayName { get; set; }

        //public string selected { get { return null; } }

        public List<BadgeVO> list { get; set; }

        public List<BadgeVO> children { get { return list; } }

        public List<BadgeVO> subType { get; set; }

        public int Level { get; set; }

        public int ParentItemId { get; set; }

        public int CategoryId { get; set; }

        public string CategoryName { get; set; }
    }
}