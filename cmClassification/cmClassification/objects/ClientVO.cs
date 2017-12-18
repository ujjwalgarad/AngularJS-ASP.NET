
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cmClassification.objects
{
    public class ClientVO
    {
        public string ClientNumber { get; set; }

        public string ClientName { get; set; }

        public string OrgAttyName { get; set; }

        public string OrgAttyTkid { get; set; }

        public string Status { get; set; }

        public List<MatterVO> Matters { get; set; }

        public List<MiniBadgeVO> Badges { get; set; }

        public int MatterCount { get; set; }
        public int MatchingMattersCount { get; set; }


    }
}