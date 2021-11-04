/*Administrador: puede ver todo desde cualquier lado, dar de alta Proyectos, Tecnologías, Clientes y Empleados. También puede actualizar todo respecto a la tabla Proyecto.*/
DROP USER IF EXISTS 'Administrador'@'%';
CREATE USER IF NOT EXISTS 'Administrador'@'%' IDENTIFIED BY 'passAdministrado';
GRANT SELECT ON softwarefactory.* TO 'Administrador'@'%';
GRANT INSERT ON softwarefactory.proyecto TO 'Administrador'@'%';
GRANT INSERT ON softwarefactory.tecnologia TO 'Administrador'@'%';
GRANT INSERT ON softwarefactory.cliente TO 'Administrador'@'%';
GRANT INSERT ON softwarefactory.empleado TO 'Administrador'@'%';
GRANT UPDATE(idProyecto,cuit,descripcion,presupuesto,inicio,fin) ON softwarefactory.proyecto TO 'Administrador'@'%';
/*PM: desde la red 10.3.45.xxx puede
Ver todas las tablas.
Insertar (todo) y modificar (la calificación) de las Experiencias.
Dar de alta Empleados.
Insertar Requerimientos.
Insertar Tareas y modificar solo su fin.*/

DROP USER IF EXISTS 'PM'@'10.3.45.%';
CREATE USER IF NOT EXISTS 'PM'@'10.3.45.%' IDENTIFIED BY 'passPM';
GRANT SELECT ON softwarefactory.* TO 'PM'@'10.3.45.%';
GRANT INSERT(cuil,idTecnologia,calificacion),UPDATE(calificacion) ON softwarefactory.experiencia TO 'PM'@'10.3.45.%';
GRANT INSERT ON softwarefactory.empleado TO 'PM'@'10.3.45.%';
GRANT INSERT ON softwarefactory.requerimiento TO 'PM'@'10.3.45.%';
GRANT INSERT,UPDATE(fin) ON softwarefactory.tarea TO 'PM'@'10.3.45.%';

/*Empleado:  desde la red 10.3.45.xxx puede ver todas las tablas.*/
DROP USER IF EXISTS 'Empleado'@'10.3.45.%';
CREATE USER IF NOT EXISTS 'Empleado'@'10.3.45.%' IDENTIFIED BY 'passEmpleado';
GRANT SELECT ON softwarefactory.* TO 'Empleado'@'10.3.45.%';

