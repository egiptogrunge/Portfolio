using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class Space
{
    public int IdSpace { get; set; }

    public string Name { get; set; } = null!;

    public string Address { get; set; } = null!;

    public int Capacity { get; set; }

    public decimal? AverageRating { get; set; }

    public string? Schedule { get; set; }

    public virtual ICollection<Event> Events { get; set; } = new List<Event>();

    public virtual ICollection<FavoritesSpace> FavoritesSpaces { get; set; } = new List<FavoritesSpace>();

    public virtual ICollection<SpacesRating> SpacesRatings { get; set; } = new List<SpacesRating>();

    public virtual ICollection<SpacesReport> SpacesReports { get; set; } = new List<SpacesReport>();

    public virtual ICollection<SpacesSchedule> SpacesSchedules { get; set; } = new List<SpacesSchedule>();
}
