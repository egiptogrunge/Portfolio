using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class ChangeLog
{
    public int IdChangeLog { get; set; }

    public string LogText { get; set; } = null!;

    public DateTime? Date { get; set; }

    public string? Username { get; set; }
}
