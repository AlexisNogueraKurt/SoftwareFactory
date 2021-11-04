/*Antes de hacer un Insert en Tarea, si la calificación del empleado es menor a la complejidad del requerimiento no se tiene que permitir el Insert y se tiene que mostrar la leyenda “Calificación insuficiente”*/
DELIMITER $$
DROP TRIGGER IF EXISTS befInsTarea;
CREATE TRIGGER befInsTarea BEFORE INSERT ON tarea
FOR EACH ROW
BEGIN
      IF((SELECT *
            FROM experiencia
            JOIN requerimiento USING (idTecnologia)
            WHERE calificacion < complejidad
            AND cuil = NEW.cuil
            AND idRequerimiento = NEW.idRequerimiento
            )) THEN
                  SIGNAL SQLSTATE '45000'
                  SET MESSAGE_TEXT = 'Calificacion Insuficiente';
	      END IF;
END $$

/*Realizar un trigger para que al ingresar un usuario, le asigne por defecto experiencia en todas las tecnologías disponibles con calificación igual*/
DELIMITER $$
DROP TRIGGER IF EXISTS aftInsUsuario;
CREATE TRIGGER aftInsUsuario AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
INSERT INTO softwarefactory.experiencia (cuil,idTecnologia,calificacion)
            SELECT cuil.NEW,idTecnologia,0
            WHERE softwarefactory.tecnologia;
END $$