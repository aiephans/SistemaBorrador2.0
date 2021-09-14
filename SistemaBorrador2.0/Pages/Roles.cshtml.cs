using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaBorrador2._0.Models;
using SistemaBorrador2._0.Repositorios;

namespace SistemaBorrador2._0.Pages
{
    public class RolesModel : PageModel
    {
        public List<RolListaModelo> Roles { get; set; }
        public IActionResult OnGet()
        {
            var idSession = HttpContext.Session.GetString("idSession");
            //var session = HttpContext.Session;
            if (string.IsNullOrEmpty(idSession))
            {
                return RedirectToPage("./Index");
            }

            var repo = new RolRepositorio();
            this.Roles = repo.obtenerRoles();

            return Page();
        }
    }
}
