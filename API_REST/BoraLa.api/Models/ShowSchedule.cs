using System;
using System.Collections.Generic;

namespace BoraLa.api.Models;

public partial class ShowSchedule
{
    public int IdSpace { get; set; }

    public int WeekDay { get; set; }

    public TimeOnly OpenHour { get; set; }

    public TimeOnly CloseHour { get; set; }
}
