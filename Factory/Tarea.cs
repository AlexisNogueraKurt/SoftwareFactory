using System;
using System.Collections.Generic;
using System.Linq;
namespace Factory
{
    public class Tarea
    {
        public List<Tarea> tareas;
        public int idTecnologia { get; set; }
        public int cuil { get; set; }
        public DateTime inicio { get; set; }
        public DateTime fin { get; set; }
    }
}