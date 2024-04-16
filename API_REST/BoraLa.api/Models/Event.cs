using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class Event
{
    public int IdEvent { get; set; }

    public string Name { get; set; } = null!;

    public decimal? AverageRating { get; set; }

    public DateOnly Date { get; set; }

    public TimeOnly? Time { get; set; }

    public TimeOnly? Duration { get; set; }

    public decimal MinPrice { get; set; }

    public decimal MaxPrice { get; set; }

    public int MinAge { get; set; }

    public bool? Acessibility { get; set; }

    public string Description { get; set; } = null!;

    public string? Observations { get; set; }

    public bool PromoterIsOwner { get; set; }

    public int IdEventSubtype { get; set; }

    public int IdPromoter { get; set; }

    public int IdSpace { get; set; }

    public virtual ICollection<EventsRating> EventsRatings { get; set; } = new List<EventsRating>();

    public virtual ICollection<EventsReport> EventsReports { get; set; } = new List<EventsReport>();

    public virtual EventSubType IdEventSubtypeNavigation { get; set; } = null!;

    public virtual Promoter IdPromoterNavigation { get; set; } = null!;

    public virtual Space IdSpaceNavigation { get; set; } = null!;

    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();
}
