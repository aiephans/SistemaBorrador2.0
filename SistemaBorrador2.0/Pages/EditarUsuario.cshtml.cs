using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaBorrador2._0.Repositorios;

namespace SistemaBorrador2._0.Pages
{
    public class EditarUsuarioModel : PageModel
    {
        [Display(Name = "Nombre de usuario")]
        [BindProperty]
        [Required(ErrorMessage = "El campo Nombre de usuario es requerido")]
        public string NombreUsuario { get; set; }
        [BindProperty]
        [Required(ErrorMessage = "El campo Nombres es requerido")]
        public string Nombres { get; set; }
        [BindProperty]
        [Required(ErrorMessage = "El campo Apellidos es requerido")]
        public string Apellidos { get; set; }
        [Display(Name = "Rol")]
        [BindProperty]
        [Required(ErrorMessage = "El campo Rol es requerido")]
        public int? RolId { get; set; }
        [Display(Name = "Contraseņa")]
        [BindProperty]
        [Required(ErrorMessage = "El campo Contraseņa es requerido")]
        [MinLength(8, ErrorMessage = "El campo Contraseņa debe tener al menos 8 caracteres")]
        [RegularExpression("^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$", ErrorMessage = "La contraseņa debe tener al menos una mayuscula,minusculas y digitos")]
        public string Password { get; set; }
        [Display(Name = "Repetir contraseņa")]
        [BindProperty]
        [Required(ErrorMessage = "El campo Repetir contraseņa es requerido")]
        [MinLength(8, ErrorMessage = "El campo repetir contraseņa debe tener al menos 8 caracteres")]
        [RegularExpression("^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$", ErrorMessage = "La contraseņa debe tener al menos una mayuscula,minusculas y digitos")]
        public string RePassword { get; set; }
        public void OnGet(int id)
        {
            var repo = new UsuarioRepositorio();
            var usuario = repo.obtenerUsuarioPorId(id);
            this.NombreUsuario = usuario.nombreUsuario;
            this.Nombres = usuario.nombres;
            this.Apellidos = usuario.apellidos;
            this.RolId = usuario.RolId;
        }
    }
}
