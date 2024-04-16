using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class PastEvent
{
    public string Name { get; set; } = null!;

    public DateOnly Date { get; set; }

    public TimeOnly? Time { get; set; }

    public string EventTypeName { get; set; } = null!;

    public string EventSubTypeName { get; set; } = null!;
}
