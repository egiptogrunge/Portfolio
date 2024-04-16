//using WebApplication1.api.Models; na aula usei isto antes do namespace

using BoraLa.api.Models;

namespace BoraLa.api.DTOs

{
    public class ReportTypeDTO
    {
        public int IdReportType { get; set; }
        public string Type { get; set; } = null!;
        public string Description { get; set; } = null!;

        public ReportsType DtoToReportTypeModel()
        {
            ReportsType reportType = new ReportsType
            {
                IdReportType = this.IdReportType,
                Type = this.Type,
                Description = this.Description
            };

            return reportType;
        }

        public ReportTypeDTO ReportTypeModelToDTO(ReportsType reportType)
        {
            ReportTypeDTO dto = new ReportTypeDTO
            {
                IdReportType = reportType.IdReportType,
                Type = reportType.Type,
                Description = reportType.Description
            };

            return dto;
        
        }
    }
}
