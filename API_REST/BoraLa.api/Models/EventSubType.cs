using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class EventSubType
{
    public int IdEventSubType { get; set; }

    public int? IdEventType { get; set; }

    public string Name { get; set; } = null!;

    public int? TargetAge { get; set; }

    public virtual ICollection<Event> Events { get; set; } = new List<Event>();

    public virtual ICollection<FavoritesEventType> FavoritesEventTypes { get; set; } = new List<FavoritesEventType>();

    public virtual EventType? IdEventTypeNavigation { get; set; }
}
