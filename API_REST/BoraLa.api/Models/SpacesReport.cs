using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class SpacesReport
{
    public int IdSpaceReport { get; set; }

    public int IdUser { get; set; }

    public int IdSpace { get; set; }

    public int IdReportType { get; set; }

    public DateOnly Date { get; set; }

    public string? Comment { get; set; }

    public virtual ReportsType IdReportTypeNavigation { get; set; } = null!;

    public virtual Space IdSpaceNavigation { get; set; } = null!;

    public virtual User IdUserNavigation { get; set; } = null!;
}
