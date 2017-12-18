using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPerformanceGoals.objects
{
    public class StageEmailVO
    {
        public string Tos { get; set; }

        public string Ccs { get; set; }

        public string Bccs { get; set; }

        public string Subject { get; set; }

        public string wfInstanceId { get; set; }

        public string Body { get; set; }

        public string CreatedBy { get; set; }

        public int StageId { get; set; }

        public int NextStageId { get; set; }

        public string CurrentStageName { get; set; }

        public string NextStageName { get; set; }

        public int ConditionId { get; set; }

        //public List<FileInfo> Attachment { get; set; }
    }
}