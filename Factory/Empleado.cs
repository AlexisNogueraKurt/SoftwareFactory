using System;
using System.Linq;
using System.Collections.Generic;
namespace Factory
{
    public class Empleado
    {
        public List<Empleado> empleados;
        public int Cuil { get; set; }
        public string Nombre { get; set ; }
        public string Apellido { get; set; }
        public DateTime Contratacion { get; set; }
        public Tarea tarea { get; set; }
        

    }
}