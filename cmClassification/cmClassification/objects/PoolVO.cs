using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cmClassification.objects
{
    public class PoolVO
    {
        public int CategoryId { get; set; }

        public string CategoryName { get; set; }

        public string ColorCode { get; set; }

        public string type { get; set; }

        public List<BadgeVO> Badges { get; set; }
    }
}