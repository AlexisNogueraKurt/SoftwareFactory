using System;
using System.Collections.Generic;
using System.Linq;
namespace Factory
{
    public class Requerimiento
    {
        public List<Requerimiento> requerimientos;
        public int Id { get; set; }
        public Proyecto proyecto { get; set; }
        public Tecnologia tecnologia { get; set; }
        public string descripcion { get; set; }
        public int complejidad { get; set; }
    }
}