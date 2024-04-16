using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class Picture
{
    public int IdPicture { get; set; }

    public string Name { get; set; } = null!;

    public string Link { get; set; } = null!;

    public DateTime UploadDate { get; set; }

    public int? IdUser { get; set; }

    public int? IdPromoter { get; set; }

    public int? IdSpace { get; set; }

    public int? IdEvent { get; set; }

    public virtual Promoter? IdPromoterNavigation { get; set; }

    public virtual User? IdUserNavigation { get; set; }
}
