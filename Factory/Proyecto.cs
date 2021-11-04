using System;
using System.Collections.Generic;
using System.Linq;

namespace Factory
{
    public class Proyecto
    {
        public int Id { get; set; }
        public int Cuit { get; set; }
        public string descripcion { get; set; }
        public decimal presupuesto { get;set; }
        public DateTime inicio { get; set; }
        public DateTime fin { get; set; }
        public Requerimiento requerimiento;
        public Empleado empleado;
    }
}