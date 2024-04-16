using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class FavoritesSpace
{
    public int IdFavoritesSpaces { get; set; }

    public int? IdUser { get; set; }

    public int? IdSpace { get; set; }

    public virtual Space? IdSpaceNavigation { get; set; }

    public virtual User? IdUserNavigation { get; set; }
}
