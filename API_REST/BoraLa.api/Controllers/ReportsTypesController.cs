using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using BoraLa.api.Models;
using BoraLa.api.DTOs;

namespace BoraLa.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReportsTypesController : ControllerBase
    {
        private readonly BoraLaContext _context;

        public ReportsTypesController(BoraLaContext context)
        {
            _context = context;
        }

        //// GET: api/ReportsTypes
        //[HttpGet]
        //public async Task<ActionResult<IEnumerable<ReportsType>>> GetReportsTypes()
        //{
        //    return await _context.ReportsTypes.ToListAsync();
        //}

        // GET: api/ReportsTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ReportTypeDTO>>> GetReportsTypes()
        {
            try
            {
                List<ReportTypeDTO> list = new List<ReportTypeDTO>();
                var reportsTypes = await _context.ReportsTypes.ToListAsync();

                foreach (var reportsType in reportsTypes)
                {
                    list.Add(new ReportTypeDTO().ReportTypeModelToDTO(reportsType));
                }

                return list;
            }
            catch (Exception ex)
            {
                // Log ou manipulação de erro aqui.
                return StatusCode(500, "Erro interno do servidor."); // Retorna 500 Internal Server Error em caso de falha.
            }
        }


        // GET: api/ReportsTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ReportTypeDTO>> GetReportsType(int id)
        {
            var reportsType = await _context.ReportsTypes.FindAsync(id);

            if (reportsType == null)
            {
                return NotFound();
            }

            return new ReportTypeDTO().ReportTypeModelToDTO(reportsType);
        }

        [HttpGet("Count")]
        public async Task<ActionResult<int>> Count()
        {
            var count = await _context.ReportsTypes.CountAsync();

            return Ok(count);
        }


        //// PUT: api/ReportsTypes/5
        //public async Task<IActionResult> PutReportType(int id, ReportTypeDTO reportTypeDto)
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateReportType(int id, ReportTypeDTO reportTypeDto)
        {
            try
            {
                // Verificar se o ID na URL corresponde ao ID no DTO
                if (id != reportTypeDto.IdReportType)
                {
                    return BadRequest();
                }

                // Converter DTO para o modelo de domínio
                var reportType = reportTypeDto.DtoToReportTypeModel();

                // Atualizar o estado do objeto rastreado pelo Entity Framework
                _context.Entry(reportType).State = EntityState.Modified;

                // Tentar salvar as alterações no banco de dados
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (DbUpdateConcurrencyException)
            {
                // Lidar com exceção de concorrência
                if (!ReportsTypeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            catch (Exception ex)
            {
                // Lidar com outras exceções
                return StatusCode(500, $"Internal Server Error: {ex.Message}");
            }
        }

        // POST: api/ReportsTypes
        [HttpPost]
        public async Task<ActionResult<ReportTypeDTO>> CreateReportType(ReportTypeDTO reportTypeDto)
        {
            try
            {
                // Verificar se o DTO é válido
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                // Converter DTO para o modelo de domínio
                var reportType = reportTypeDto.DtoToReportTypeModel();

                // Adicionar o novo objeto ao contexto do Entity Framework
                _context.ReportsTypes.Add(reportType);

                // Tentar salvar as alterações no banco de dados
                await _context.SaveChangesAsync();

                // Retornar o DTO do objeto recém-criado
                var createdDto = new ReportTypeDTO().ReportTypeModelToDTO(reportType);
                return CreatedAtAction(nameof(GetReportsType), new { id = createdDto.IdReportType }, createdDto);
            }
            catch (Exception ex)
            {
                // Lidar com exceções
                return StatusCode(500, $"Internal Server Error: {ex.Message}");
            }
        }


        // DELETE: api/ReportsTypes/5
        //[HttpDelete("{id}")]
        //public async Task<IActionResult> DeleteReportsType(int id)
        //{
        //    var reportsType = await _context.ReportsTypes.FindAsync(id);
        //    if (reportsType == null)
        //    {
        //        return NotFound();
        //    }

        //    _context.ReportsTypes.Remove(reportsType);
        //    await _context.SaveChangesAsync();

        //    return NoContent();
        //}

        [HttpDelete("{id}")]
        public async Task<ActionResult<ReportTypeDTO>> DeleteReportType(int id)
        {
            try
            {
                // Encontrar o objeto pelo ID no banco de dados
                var reportType = await _context.ReportsTypes.FindAsync(id);

                // Verificar se o objeto existe
                if (reportType == null)
                {
                    return NotFound();
                }

                // Remover o objeto do contexto do Entity Framework
                _context.ReportsTypes.Remove(reportType);

                // Tentar salvar as alterações no banco de dados
                await _context.SaveChangesAsync();

                // Retornar o DTO do objeto removido
                var deletedDto = new ReportTypeDTO().ReportTypeModelToDTO(reportType);
                return Ok(deletedDto);
            }
            catch (Exception ex)
            {
                // Lidar com exceções
                return StatusCode(500, $"Internal Server Error: {ex.Message}");
            }
        }

        private bool ReportsTypeExists(int id)
        {
            return _context.ReportsTypes.Any(e => e.IdReportType == id);
        }
    }
}
