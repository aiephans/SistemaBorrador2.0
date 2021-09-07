using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SistemaBorrador2._0.Models
{
    public class UsuarioListaModel
    {
        public int Id { get; set; }
        public string nombreUsuario { get; set; }
        public string nombres { get; set; }
        public string apellidos { get; set; }
        public int RolId { get; set; }
    }
}
