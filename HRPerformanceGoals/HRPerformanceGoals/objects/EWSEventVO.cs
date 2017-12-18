using HRPerformanceGoals.intra.chsService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPerformanceGoals.objects
{
    public class EWSEventVO
    {
        public string ItemId { get; set; }

        public string SlotId { get; set; }

        public PersonVO person { get; set; } //login user


        public string StartDateTime { get; set; } // for outlook

        public string EndDateTime { get; set; } // for outlook

        public string Subject { get; set; }

        public string Body { get; set; }

        public string ShortBody { get; set; }

        public string Location { get; set; }

        public string Attendees { get; set; }

        public int NumOfAttendees { get; set; }

        //public List<EventAttendee> arrAttendees { get; set; }

        // below properties are for slot info
        public string date { get; set; } // for booked event start date
        public string time { get; set; } // for booked event time period
        public string room { get; set; } // for booked event location
        public string fday { get; set; } // for booked event start date - firebase
        public string ftime { get; set; } // for booked event time period - firebase

        public string groupId { get; set; }

        public string prjId { get; set; }
    }
}