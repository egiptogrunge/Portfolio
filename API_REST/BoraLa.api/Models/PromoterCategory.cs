using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class PromoterCategory
{
    public int IdPromoterCategory { get; set; }

    public string Name { get; set; } = null!;

    public string ServiceDescription { get; set; } = null!;

    public decimal? Fee { get; set; }

    public virtual ICollection<Promoter> Promoters { get; set; } = new List<Promoter>();
}
