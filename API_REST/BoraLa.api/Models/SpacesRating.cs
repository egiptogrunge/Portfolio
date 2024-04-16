using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class SpacesRating
{
    public int IdSpaceRating { get; set; }

    public string Title { get; set; } = null!;

    public int Rating { get; set; }

    public string? Comment { get; set; }

    public DateTime Date { get; set; }

    public int IdUser { get; set; }

    public int IdSpace { get; set; }

    public virtual Space IdSpaceNavigation { get; set; } = null!;

    public virtual User IdUserNavigation { get; set; } = null!;
}
