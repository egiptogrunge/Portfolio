using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class Promoter
{
    public int IdPromoter { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public int? IdCredential { get; set; }

    public int? IdPromoterCategory { get; set; }

    public virtual ICollection<Event> Events { get; set; } = new List<Event>();

    public virtual Credential? IdCredentialNavigation { get; set; }

    public virtual PromoterCategory? IdPromoterCategoryNavigation { get; set; }

    public virtual ICollection<Picture> Pictures { get; set; } = new List<Picture>();
}
