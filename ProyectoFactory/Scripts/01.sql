/*Realizar los SP para dar de alta todas las tablas, menos la tabla Experiencia.*/
DELIMITER $$
CREATE PROCEDURE altaCliente (unCuit INT, unaRazonSocial VARCHAR(45))
BEGIN
      INSERT INTO Cliente (cuit, razonSocail)
                  VALUES (unCuit, unaRazonSocial);
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS altaEmpleado $$
CREATE PROCEDURE altaEmpleado (unCuil INT, unNombre VARCHAR(45), unApellido VARCHAR(45), unaContratacion DATE)
BEGIN
	INSERT INTO Empleado (cuil, nombre, apellido, cotratacion)
			VALUES (unCuil, unNombre, unApellido, unaContratacion);
END$$
DELIMITER $$
DROP PROCEDURE IF EXISTS altaProyecto $$
CREATE PROCEDURE altaProyecto (unidProyecto SMALLINT, unCuit INT, unaDescripcion VARCHAR(200), unPresupuesto DECIMAL(10,2), unInicio DATE, unFin DATE)
BEGIN 
      INSERT INTO Proyecto (idProyecto, cuit, Descripcion, Presupuesto, inicio, fin)
                  VALUES (unidProyecto, unCuit, unaDescripcion, unPresupuesto, unInicio, unFin);
END $$
DELIMITER $$
DROP PROCEDURE IF EXISTS altaRequerimiento $$
CREATE PROCEDURE altaRequerimiento (unRequerimiento INT, unidProyecto SMALLINT, unidTecnologia TINYINT, unaDescripcion VARCHAR(45), unaComplejidad TINYINT)
BEGIN 
      INSERT INTO Requerimiento (idRequerimiento, idProyecto, idTecnologia, Descripcion, Complejidad)
            VALUES (unRequerimiento, unidproyecto, unidTecnologia, unaDescripcion, unaComplejidad);
END $$
DELIMITER $$
DROP PROCEDURE IF EXISTS altaTarea $$
CREATE PROCEDURE altaTarea (unidRequerimiento INT, unCuil INT, unInicio DATE, unFin DATE)
BEGIN 
	INSERT INTO Tarea (idRequerimiento, Cuil, Inicio, Fin)
	      VALUES (unidRequeriemiento, unCuil, unInicio, unFin);
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS altaTecnologia $$
CREATE PROCEDURE altaTecnologia ( unidTecnologia TINYINT, unaTecnologia VARCHAR(20), unCostoBase DECIMAL(10,2))
BEGIN
      INSERT INTO Tecnologia ( idTecnologia, tecnolgia, costoBase)
            VALUES ( unidTecnologia, unaTecnologia, unCostoBase);
END $$
/*Realizar el SP asignarExperiencia que recibe como parámetros cuil, idTecnologia y una calificación. El SP tiene que crear un registro en caso de que no exista o actualizarlo en caso de que si exista.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS asignarExperiencia $$
CREATE PROCEDURE asignarExperiencia(unCuil INT ,unidTecnologia TINYINT ,unaCalificacion TINYINT UNSIGNED)
BEGIN 
      IF (EXISTS(SELECT * 
            FROM Experiencia 
		WHERE cuil = unCuil 
            AND idTecnologia = unidTecnologia
		))THEN 
			UPDATE Experiencia
			SET Cuil = unCuil
			WHERE idTecnologia = unidTecnologia
			AND Calificacion = unaCalificacion;
      ELSE 
	      INSERT INTO Experiencia (Cuil, idTecnologia, Calificacion) 
				VALUES (unCuil, unidTecnologia, unaCalificacion);
	END IF;
END $$

/*Crear los SP finalizarTarea que reciba como parámetro un idRequerimiento, un cuil y una fecha de fin. El SP deberá actualizar la fecha de fin solamente si no tenía valor previo*/
DELIMITER $$
DROP PROCEDURE IF EXISTS finalizarTarea $$
CREATE PROCEDURE finalizarTarea (unidRequerimiento INT, uncuil INT, unafechafin DATE)
BEGIN 
      UPDATE Tarea
      SET fin = unfin 
      WHERE idRequerimiento = unidRequerimiento
      AND cuil = uncuil
      AND fin is null;
      
END $$

/*Realizar la SF complejidadPromedio que reciba como parámetro un idProyecto y devuelva un float representando el promedio de  complejidad de los requerimientos para el Proyecto pasado por parámetro.*/
DELIMITER $$
DROP FUNCTION IF EXISTS complejidadPromedio $$
CREATE FUNCTION complejidadPromedio (unidProyecto SMALLINT)
                                    RETURNS FLOAT reads sql data
BEGIN
      DECLARE Resultado FLOAT;

      SELECT AVG(Complejidad) INTO Resultado
      FROM Requerimiento
      WHERE idProyecto = unidProyecto;

      RETURN Resultado;
END $$

/*Realizar la SF sueldoMensual que en base a un cuil devuelva el sueldo a pagar (DECIMAL (10,2))para el mes en curso.
SUELDO MENSUAL = Antigüedad en años * 1000 + SUMATORIA de (calificación de la exp. * costo base de la tecnología).*/
DELIMITER $$
DROP FUNCTION IF EXISTS sueldoMensual $$
CREATE FUNCTION sueldoMensual (uncuil INT)
			RETURNS DECIMAL(10,2) reads sql data
BEGIN 
      DECLARE Resultado DECIMAL (10,2);
      
      SELECT TIMESTAMPDIFF(YEAR,Contratacion,CURDATE())* 1000 + SUM(calificacion * costoBase) INTO Resultado
      FROM Experiencia E
      INNER JOIN Tecnologia T ON T.idTecnologia = E.idTecnologia
      INNER JOIN Empleado Ep ON E.cuil = Ep.cuil
      WHERE cuil = uncuil;
      
      RETURN Resultado;
END$$
/*Realizar el SF costoProyecto que recibe como parámetro un idProyecto y devuelva el costo en DECIMAL (10,2).
COSTO PROYECTO = SUMATORIA (complejidad del requerimiento * costo base de la tecnología del Requerimiento).*/
DELIMITER $$
DROP FUNCTION IF EXISTS costoProyecto $$
CREATE FUNCTION costoProyecto (unidProyecto SMALLINT)
                              RETURNS DECIMAL(10,2) reads sql data
BEGIN
      DECLARE Resultado DECIMAL (10,2);

      SELECT SUM(complejidad * costoBase ) INTO Resultado
      FROM Tecnologia  T 
      INNER JOIN Requerimiento R ON T.idTecnologia = R.idTecnologia
      WHERE idProyecto = unidProyecto;

      RETURN Resultado;
END $$