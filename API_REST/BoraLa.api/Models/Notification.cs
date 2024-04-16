using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class Notification
{
    public int IdNotification { get; set; }

    public int? IdUser { get; set; }

    public int? IdEvent { get; set; }

    public string? Description { get; set; }

    public virtual Event? IdEventNavigation { get; set; }

    public virtual User? IdUserNavigation { get; set; }
}
