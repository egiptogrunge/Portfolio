using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class EventsReport
{
    public int IdEventReport { get; set; }

    public int IdUser { get; set; }

    public int IdEvent { get; set; }

    public int IdReportType { get; set; }

    public DateOnly Date { get; set; }

    public string? Comment { get; set; }

    public virtual Event IdEventNavigation { get; set; } = null!;

    public virtual ReportsType IdReportTypeNavigation { get; set; } = null!;

    public virtual User IdUserNavigation { get; set; } = null!;
}
