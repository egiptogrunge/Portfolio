using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace BoraLa.api.Models;

public partial class BoraLaContext : DbContext
{
    public BoraLaContext()
    {
    }

    public BoraLaContext(DbContextOptions<BoraLaContext> options)
        : base(options)
    {
    }

    public virtual DbSet<ActiveEvent> ActiveEvents { get; set; }

    public virtual DbSet<ActivePromoter> ActivePromoters { get; set; }

    public virtual DbSet<ActiveUser> ActiveUsers { get; set; }

    public virtual DbSet<ChangeLog> ChangeLogs { get; set; }

    public virtual DbSet<Credential> Credentials { get; set; }

    public virtual DbSet<Error> Errors { get; set; }

    public virtual DbSet<Event> Events { get; set; }

    public virtual DbSet<EventSubType> EventSubTypes { get; set; }

    public virtual DbSet<EventType> EventTypes { get; set; }

    public virtual DbSet<EventsRating> EventsRatings { get; set; }

    public virtual DbSet<EventsReport> EventsReports { get; set; }

    public virtual DbSet<FavoritesEventType> FavoritesEventTypes { get; set; }

    public virtual DbSet<FavoritesSpace> FavoritesSpaces { get; set; }

    public virtual DbSet<Notification> Notifications { get; set; }

    public virtual DbSet<PastEvent> PastEvents { get; set; }

    public virtual DbSet<Picture> Pictures { get; set; }

    public virtual DbSet<Promoter> Promoters { get; set; }

    public virtual DbSet<PromoterCategory> PromoterCategories { get; set; }

    public virtual DbSet<RegisteredSpace> RegisteredSpaces { get; set; }

    public virtual DbSet<ReportsType> ReportsTypes { get; set; }

    public virtual DbSet<ShowSchedule> ShowSchedules { get; set; }

    public virtual DbSet<Space> Spaces { get; set; }

    public virtual DbSet<SpacesRating> SpacesRatings { get; set; }

    public virtual DbSet<SpacesReport> SpacesReports { get; set; }

    public virtual DbSet<SpacesSchedule> SpacesSchedules { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("name=AppConnectionString");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ActiveEvent>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("ActiveEvents");

            entity.Property(e => e.EventSubTypeName).HasMaxLength(50);
            entity.Property(e => e.EventTypeName).HasMaxLength(20);
            entity.Property(e => e.Name).HasMaxLength(150);
        });

        modelBuilder.Entity<ActivePromoter>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("ActivePromoters");
        });

        modelBuilder.Entity<ActiveUser>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("ActiveUsers");
        });

        modelBuilder.Entity<ChangeLog>(entity =>
        {
            entity.HasKey(e => e.IdChangeLog).HasName("PK__ChangeLo__DF8A26A3439AC038");

            entity.ToTable("ChangeLog");

            entity.Property(e => e.IdChangeLog).HasColumnName("ID_ChangeLog");
            entity.Property(e => e.Date)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.LogText).HasMaxLength(500);
            entity.Property(e => e.Username).HasMaxLength(50);
        });

        modelBuilder.Entity<Credential>(entity =>
        {
            entity.HasKey(e => e.IdCredential).HasName("PK__Credenti__77E51C8D2753978E");

            entity.HasIndex(e => e.Email, "UQ__Credenti__A9D10534D02644E0").IsUnique();

            entity.Property(e => e.IdCredential).HasColumnName("ID_Credential");
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(20);
            entity.Property(e => e.Role).HasMaxLength(20);
        });

        modelBuilder.Entity<Error>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("ERRORS");

            entity.Property(e => e.ErrorDateTime).HasColumnType("datetime");
            entity.Property(e => e.ErrorId)
                .ValueGeneratedOnAdd()
                .HasColumnName("ErrorID");
            entity.Property(e => e.ErrorMessage).IsUnicode(false);
            entity.Property(e => e.ErrorProcedure).IsUnicode(false);
            entity.Property(e => e.UserName)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Event>(entity =>
        {
            entity.HasKey(e => e.IdEvent).HasName("PK__Events__12A4DF3F2DBB5C75");

            entity.Property(e => e.IdEvent).HasColumnName("ID_Event");
            entity.Property(e => e.AverageRating)
                .HasDefaultValue(0m)
                .HasColumnType("decimal(2, 1)");
            entity.Property(e => e.Description).HasMaxLength(2000);
            entity.Property(e => e.IdEventSubtype).HasColumnName("ID_EventSubtype");
            entity.Property(e => e.IdPromoter).HasColumnName("ID_Promoter");
            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
            entity.Property(e => e.MaxPrice).HasColumnType("decimal(7, 2)");
            entity.Property(e => e.MinPrice).HasColumnType("decimal(7, 2)");
            entity.Property(e => e.Name).HasMaxLength(150);
            entity.Property(e => e.Observations).HasMaxLength(1000);

            entity.HasOne(d => d.IdEventSubtypeNavigation).WithMany(p => p.Events)
                .HasForeignKey(d => d.IdEventSubtype)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_EventSubtype_Events");

            entity.HasOne(d => d.IdPromoterNavigation).WithMany(p => p.Events)
                .HasForeignKey(d => d.IdPromoter)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Promoter_Events");

            entity.HasOne(d => d.IdSpaceNavigation).WithMany(p => p.Events)
                .HasForeignKey(d => d.IdSpace)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Space_Events");
        });

        modelBuilder.Entity<EventSubType>(entity =>
        {
            entity.HasKey(e => e.IdEventSubType).HasName("PK__EventSub__0F05D574659AD27F");

            entity.Property(e => e.IdEventSubType).HasColumnName("ID_EventSubType");
            entity.Property(e => e.IdEventType).HasColumnName("ID_EventType");
            entity.Property(e => e.Name).HasMaxLength(50);

            entity.HasOne(d => d.IdEventTypeNavigation).WithMany(p => p.EventSubTypes)
                .HasForeignKey(d => d.IdEventType)
                .HasConstraintName("FK__EventSubT__ID_Ev__7B4643B2");
        });

        modelBuilder.Entity<EventType>(entity =>
        {
            entity.HasKey(e => e.IdEventType).HasName("PK__EventTyp__A4901FEB06ED1CA4");

            entity.Property(e => e.IdEventType).HasColumnName("ID_EventType");
            entity.Property(e => e.Name).HasMaxLength(20);
        });

        modelBuilder.Entity<EventsRating>(entity =>
        {
            entity.HasKey(e => e.IdEventRating).HasName("PK__EventsRa__25486636DAE058BA");

            entity.ToTable(tb => tb.HasTrigger("UpdateAVGRatingEvents"));

            entity.Property(e => e.IdEventRating).HasColumnName("ID_EventRating");
            entity.Property(e => e.Comment).HasMaxLength(1000);
            entity.Property(e => e.Date)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdEvent).HasColumnName("ID_Event");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");
            entity.Property(e => e.Title).HasMaxLength(50);

            entity.HasOne(d => d.IdEventNavigation).WithMany(p => p.EventsRatings)
                .HasForeignKey(d => d.IdEvent)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Event_EventsRatings");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.EventsRatings)
                .HasForeignKey(d => d.IdUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_User_EventsRatings");
        });

        modelBuilder.Entity<EventsReport>(entity =>
        {
            entity.HasKey(e => e.IdEventReport).HasName("PK_EventsReports_ID_EventReport");

            entity.Property(e => e.IdEventReport).HasColumnName("ID_EventReport");
            entity.Property(e => e.Comment).HasMaxLength(100);
            entity.Property(e => e.IdEvent).HasColumnName("ID_Event");
            entity.Property(e => e.IdReportType).HasColumnName("ID_ReportType");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");

            entity.HasOne(d => d.IdEventNavigation).WithMany(p => p.EventsReports)
                .HasForeignKey(d => d.IdEvent)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_EventsReports_ID_Event");

            entity.HasOne(d => d.IdReportTypeNavigation).WithMany(p => p.EventsReports)
                .HasForeignKey(d => d.IdReportType)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_EventsReports_ID_ReportType");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.EventsReports)
                .HasForeignKey(d => d.IdUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_EventsReports_ID_User");
        });

        modelBuilder.Entity<FavoritesEventType>(entity =>
        {
            entity.HasKey(e => e.IdFavoritesEvents).HasName("PK_FavoritesEventTypes_ID_FavoriteEvents");

            entity.Property(e => e.IdFavoritesEvents).HasColumnName("ID_FavoritesEvents");
            entity.Property(e => e.IdEventSubType).HasColumnName("ID_EventSubType");
            entity.Property(e => e.IdEventType).HasColumnName("ID_EventType");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");

            entity.HasOne(d => d.IdEventSubTypeNavigation).WithMany(p => p.FavoritesEventTypes)
                .HasForeignKey(d => d.IdEventSubType)
                .HasConstraintName("FK_FavoritesEventTypes_ID_EventSubType");

            entity.HasOne(d => d.IdEventTypeNavigation).WithMany(p => p.FavoritesEventTypes)
                .HasForeignKey(d => d.IdEventType)
                .HasConstraintName("FK_FavoritesEventTypes_ID_EventType");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.FavoritesEventTypes)
                .HasForeignKey(d => d.IdUser)
                .HasConstraintName("FK_FavoritesEventTypes_ID_User");
        });

        modelBuilder.Entity<FavoritesSpace>(entity =>
        {
            entity.HasKey(e => e.IdFavoritesSpaces).HasName("PK_FavoritesSpace_ID_FavoriteSpaces");

            entity.Property(e => e.IdFavoritesSpaces).HasColumnName("ID_FavoritesSpaces");
            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");

            entity.HasOne(d => d.IdSpaceNavigation).WithMany(p => p.FavoritesSpaces)
                .HasForeignKey(d => d.IdSpace)
                .HasConstraintName("FK_FavoritesSpace_ID_Space");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.FavoritesSpaces)
                .HasForeignKey(d => d.IdUser)
                .HasConstraintName("FK_FavoritesSpace_ID_User");
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.IdNotification).HasName("PK_Notifications_ID_Notification");

            entity.Property(e => e.IdNotification).HasColumnName("ID_Notification");
            entity.Property(e => e.Description).HasMaxLength(100);
            entity.Property(e => e.IdEvent).HasColumnName("ID_Event");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");

            entity.HasOne(d => d.IdEventNavigation).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.IdEvent)
                .HasConstraintName("FK_Notifications_ID_Event");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.IdUser)
                .HasConstraintName("FK_Notifications_ID_User");
        });

        modelBuilder.Entity<PastEvent>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("PastEvents");

            entity.Property(e => e.EventSubTypeName).HasMaxLength(50);
            entity.Property(e => e.EventTypeName).HasMaxLength(20);
            entity.Property(e => e.Name).HasMaxLength(150);
        });

        modelBuilder.Entity<Picture>(entity =>
        {
            entity.HasKey(e => e.IdPicture).HasName("PK__Pictures__07D3030D4B06849C");

            entity.Property(e => e.IdPicture).HasColumnName("ID_Picture");
            entity.Property(e => e.IdEvent).HasColumnName("ID_Event");
            entity.Property(e => e.IdPromoter).HasColumnName("ID_Promoter");
            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");
            entity.Property(e => e.Link)
                .HasMaxLength(150)
                .IsUnicode(false);
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.UploadDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.IdPromoterNavigation).WithMany(p => p.Pictures)
                .HasForeignKey(d => d.IdPromoter)
                .HasConstraintName("FK_Event_Pictures");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.Pictures)
                .HasForeignKey(d => d.IdUser)
                .HasConstraintName("FK_User_Pictures");
        });

        modelBuilder.Entity<Promoter>(entity =>
        {
            entity.HasKey(e => e.IdPromoter).HasName("PK__Promoter__D46D10834F68A968");

            entity.HasIndex(e => e.IdCredential, "UQ__Promoter__77E51C8CFA32033B").IsUnique();

            entity.Property(e => e.IdPromoter).HasColumnName("ID_Promoter");
            entity.Property(e => e.Description).HasMaxLength(1000);
            entity.Property(e => e.IdCredential).HasColumnName("ID_Credential");
            entity.Property(e => e.IdPromoterCategory).HasColumnName("ID_PromoterCategory");
            entity.Property(e => e.Name).HasMaxLength(25);

            entity.HasOne(d => d.IdCredentialNavigation).WithOne(p => p.Promoter)
                .HasForeignKey<Promoter>(d => d.IdCredential)
                .HasConstraintName("FK__Promoters__ID_Cr__758D6A5C");

            entity.HasOne(d => d.IdPromoterCategoryNavigation).WithMany(p => p.Promoters)
                .HasForeignKey(d => d.IdPromoterCategory)
                .HasConstraintName("FK__Promoters__ID_Pr__76818E95");
        });

        modelBuilder.Entity<PromoterCategory>(entity =>
        {
            entity.HasKey(e => e.IdPromoterCategory).HasName("PK__Promoter__9DBE3F6E045A9C6C");

            entity.Property(e => e.IdPromoterCategory).HasColumnName("ID_PromoterCategory");
            entity.Property(e => e.Fee).HasColumnType("money");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.ServiceDescription).HasMaxLength(1000);
        });

        modelBuilder.Entity<RegisteredSpace>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("RegisteredSpaces");
        });

        modelBuilder.Entity<ReportsType>(entity =>
        {
            entity.HasKey(e => e.IdReportType).HasName("PK_ReportsTypes_ID_ReportType");

            entity.Property(e => e.IdReportType).HasColumnName("ID_ReportType");
            entity.Property(e => e.Description).HasMaxLength(100);
            entity.Property(e => e.Type).HasMaxLength(50);
        });

        modelBuilder.Entity<ShowSchedule>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("ShowSchedule");

            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
        });

        modelBuilder.Entity<Space>(entity =>
        {
            entity.HasKey(e => e.IdSpace).HasName("PK__Spaces__78CD1BBF3FC6C230");

            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
            entity.Property(e => e.Address).HasMaxLength(500);
            entity.Property(e => e.AverageRating)
                .HasDefaultValue(0m)
                .HasColumnType("decimal(2, 1)");
            entity.Property(e => e.Name).HasMaxLength(150);
            entity.Property(e => e.Schedule).HasColumnType("xml");
        });

        modelBuilder.Entity<SpacesRating>(entity =>
        {
            entity.HasKey(e => e.IdSpaceRating).HasName("PK__SpacesRa__49507738796B8ADB");

            entity.ToTable(tb => tb.HasTrigger("UpdateAVGRatingSpaces"));

            entity.Property(e => e.IdSpaceRating).HasColumnName("ID_SpaceRating");
            entity.Property(e => e.Comment).HasMaxLength(1000);
            entity.Property(e => e.Date)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");
            entity.Property(e => e.Title).HasMaxLength(50);

            entity.HasOne(d => d.IdSpaceNavigation).WithMany(p => p.SpacesRatings)
                .HasForeignKey(d => d.IdSpace)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Space_SpacesRatings");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.SpacesRatings)
                .HasForeignKey(d => d.IdUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_User_SpacesRatings");
        });

        modelBuilder.Entity<SpacesReport>(entity =>
        {
            entity.HasKey(e => e.IdSpaceReport).HasName("PK_SpacesReports_ID_SpaceReport");

            entity.Property(e => e.IdSpaceReport).HasColumnName("ID_SpaceReport");
            entity.Property(e => e.Comment).HasMaxLength(100);
            entity.Property(e => e.IdReportType).HasColumnName("ID_ReportType");
            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");
            entity.Property(e => e.IdUser).HasColumnName("ID_User");

            entity.HasOne(d => d.IdReportTypeNavigation).WithMany(p => p.SpacesReports)
                .HasForeignKey(d => d.IdReportType)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_SpacesReports_ID_ReportType");

            entity.HasOne(d => d.IdSpaceNavigation).WithMany(p => p.SpacesReports)
                .HasForeignKey(d => d.IdSpace)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_SpacesReports_ID_Space");

            entity.HasOne(d => d.IdUserNavigation).WithMany(p => p.SpacesReports)
                .HasForeignKey(d => d.IdUser)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_SpacesReports_ID_User");
        });

        modelBuilder.Entity<SpacesSchedule>(entity =>
        {
            entity.HasKey(e => new { e.IdSpace, e.WeekDay }).HasName("PK__SpacesSc__59FB925521FD07F6");

            entity.ToTable(tb => tb.HasTrigger("TriggerInsertSpaceSchedule"));

            entity.HasIndex(e => new { e.IdSpace, e.WeekDay }, "INDEX_SpacesSchedules");

            entity.Property(e => e.IdSpace).HasColumnName("ID_Space");

            entity.HasOne(d => d.IdSpaceNavigation).WithMany(p => p.SpacesSchedules)
                .HasForeignKey(d => d.IdSpace)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Space_SpacesSchedules");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.IdUser).HasName("PK_Users_ID_User");

            entity.Property(e => e.IdUser).HasColumnName("ID_User");
            entity.Property(e => e.IdCredential).HasColumnName("ID_Credential");
            entity.Property(e => e.Name).HasMaxLength(100);
            entity.Property(e => e.ProfilePicture).HasMaxLength(50);

            entity.HasOne(d => d.IdCredentialNavigation).WithMany(p => p.Users)
                .HasForeignKey(d => d.IdCredential)
                .HasConstraintName("FK_Crential_Users");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
