using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class FavoritesEventType
{
    public int IdFavoritesEvents { get; set; }

    public int? IdUser { get; set; }

    public int? IdEventType { get; set; }

    public int? IdEventSubType { get; set; }

    public virtual EventSubType? IdEventSubTypeNavigation { get; set; }

    public virtual EventType? IdEventTypeNavigation { get; set; }

    public virtual User? IdUserNavigation { get; set; }
}
