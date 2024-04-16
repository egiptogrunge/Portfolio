using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class Credential
{
    public int IdCredential { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Role { get; set; } = null!;

    public virtual Promoter? Promoter { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
