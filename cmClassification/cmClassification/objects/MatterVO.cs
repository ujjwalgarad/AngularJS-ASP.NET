using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cmClassification.objects
{
    public class MatterVO
    {
        public string MatterNumber { get; set; }

        public string MatterName { get; set; }

        public string PracticeName { get; set; }

        public List<MiniBadgeVO> Badges { get; set; }

        public string Status { get; set; }
    }
}