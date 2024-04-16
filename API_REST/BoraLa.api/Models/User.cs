using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class User
{
    public int IdUser { get; set; }

    public string Name { get; set; } = null!;

    public DateOnly BirthDate { get; set; }

    public string? ProfilePicture { get; set; }

    public int? IdCredential { get; set; }

    public virtual ICollection<EventsRating> EventsRatings { get; set; } = new List<EventsRating>();

    public virtual ICollection<EventsReport> EventsReports { get; set; } = new List<EventsReport>();

    public virtual ICollection<FavoritesEventType> FavoritesEventTypes { get; set; } = new List<FavoritesEventType>();

    public virtual ICollection<FavoritesSpace> FavoritesSpaces { get; set; } = new List<FavoritesSpace>();

    public virtual Credential? IdCredentialNavigation { get; set; }

    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();

    public virtual ICollection<Picture> Pictures { get; set; } = new List<Picture>();

    public virtual ICollection<SpacesRating> SpacesRatings { get; set; } = new List<SpacesRating>();

    public virtual ICollection<SpacesReport> SpacesReports { get; set; } = new List<SpacesReport>();
}
