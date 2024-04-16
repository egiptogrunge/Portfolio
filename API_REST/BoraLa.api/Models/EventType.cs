using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class EventType
{
    public int IdEventType { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<EventSubType> EventSubTypes { get; set; } = new List<EventSubType>();

    public virtual ICollection<FavoritesEventType> FavoritesEventTypes { get; set; } = new List<FavoritesEventType>();
}
