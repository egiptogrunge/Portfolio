using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class ReportsType
{
    public int IdReportType { get; set; }

    public string Type { get; set; } = null!;

    public string Description { get; set; } = null!;

    public virtual ICollection<EventsReport> EventsReports { get; set; } = new List<EventsReport>();

    public virtual ICollection<SpacesReport> SpacesReports { get; set; } = new List<SpacesReport>();
}
