-- 1. evita que se ingresen años de experiencia negativos en la tabla medicos, forzando el valor a cero si es necesario.
create trigger tr_medicos_antes_insertar_experiencia
before insert on medicos
for each row
begin
    if new.años_experiencia < 0 then
        set new.años_experiencia = 0;
    end if;
end //

-- 2. estandariza los nombres y apellidos de los medicos para que siempre comiencen con mayuscula al registrarse.
create trigger tr_medicos_formato_nombre
before insert on medicos
for each row
begin
    set new.nombre = concat(upper(left(new.nombre, 1)), lower(substring(new.nombre, 2)));
    set new.apellido = concat(upper(left(new.apellido, 1)), lower(substring(new.apellido, 2)));
end //

-- 3. busca el nombre y apellido del medico usando su matricula si el campo se deja vacio al agendar un turno.
create trigger tr_turnos_autocompletar_nombre_medico
before insert on turnos
for each row
begin
    if new.nombre_completomedico is null or new.nombre_completomedico = '' then
        select concat(nombre, ' ', apellido) into @nombre_medico 
        from medicos 
        where numero_matricula = new.matricula_medico;
        
        set new.nombre_completomedico = @nombre_medico;
    end if;
end //

-- 4. asigna automaticamente el estado 'pendiente' a un nuevo turno si no se especifica ninguno en la insercion.
create trigger tr_turnos_estado_defecto
before insert on turnos
for each row
begin
    if new.estado is null or new.estado = '' then
        set new.estado = 'pendiente';
    end if;
end //

-- 5. asocia de forma automatica la especialidad correcta al turno basandose en la especialidad real del medico asignado.
create trigger tr_turnos_sincronizar_especialidad
before insert on turnos
for each row
begin
    select especialidad into @especialidad_medico 
    from medicos 
    where numero_matricula = new.matricula_medico;
    
    set new.especialidad = @especialidad_medico;
end //

-- 6. cancela la insercion de un turno si el numero de la sala medica es menor o igual a cero, lanzando un mensaje de error.
create trigger tr_turnos_validar_sala
before insert on turnos
for each row
begin
    if new.sala <= 0 then
        signal sqlstate '45000' 
        set message_text = 'error: el numero de sala asignado al turno no es valido.';
    end if;
end //

-- 7. impide la modificacion de la matricula de un medico si este ya cuenta con un historial de turnos programados en el sistema.
create trigger tr_medicos_bloquear_cambio_matricula
before update on medicos
for each row
begin
    if old.numero_matricula <> new.numero_matricula then
        select count(*) into @total_turnos from turnos where matricula_medico = old.numero_matricula;
        if @total_turnos > 0 then
            signal sqlstate '45000' 
            set message_text = 'no se puede modificar la matricula del medico porque tiene turnos asociados.';
        end if;
    end if;
end //

-- 8. verifica rudimentariamente que el correo del medico tenga una estructura valida con arroba y punto antes de guardarlo.
create trigger tr_medicos_validar_email
before insert on medicos
for each row
begin
    if new.email not like '%@%.%' then
        signal sqlstate '45000' 
        set message_text = 'error: el formato del correo electronico ingresado no es valido.';
    end if;
end //

-- 9. establece la cadena 'consulta medica general' de forma automatica si se crea un turno sin detallar el motivo.
create trigger tr_turnos_motivo_defecto
before insert on turnos
for each row
begin
    if new.motivoconsulta is null or new.motivoconsulta = '' then
        set new.motivoconsulta = 'consulta medica general';
    end if;
end //

-- 10. fuerza la propiedad del tipo de turno a 'presencial' si el campo llega vacio desde el formulario del jframe.
create trigger tr_turnos_validar_tipo
before insert on turnos
for each row
begin
    if new.tipoturno is null or new.tipoturno = '' then
        set new.tipoturno = 'presencial';
    end if;
end //

-- 1. Estandarizar nombre a MAYÚSCULAS antes de guardar
CREATE TRIGGER Trg_Med_Nombre_Mayuscula BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN
    SET NEW.nombre = UPPER(NEW.nombre);
END //

-- 2. Evitar precios negativos (pone cero por defecto si se equivocan)
CREATE TRIGGER Trg_Med_Prevenir_Precio_Negativo BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN 
    IF NEW.precio < 0 THEN 
        SET NEW.precio = 0; 
    END IF; 
END //

-- 3. Controlar que no se inserte stock negativo inicial
CREATE TRIGGER Trg_Med_Stock_Minimo BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN 
    IF NEW.stock < 0 THEN 
        SET NEW.stock = 0; 
    END IF; 
END //

-- 4. Registrar auditoría cuando cambia el precio de un remedio
CREATE TRIGGER Trg_Med_Log_Precio AFTER UPDATE ON Medicamentos
FOR EACH ROW 
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Med ', NEW.nombre, ' cambió precio de ', OLD.precio, ' a ', NEW.precio));
    END IF;
END //

-- 5. Registrar cuando un medicamento se queda sin stock (Stock = 0)
CREATE TRIGGER Trg_Med_Alerta_ZeroStock AFTER UPDATE ON Medicamentos
FOR EACH ROW 
BEGIN
    IF NEW.stock = 0 AND OLD.stock > 0 THEN
        INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('URGENTE: ', NEW.nombre, ' se quedó sin unidades.'));
    END IF;
END //

-- 6. Bloquear el borrado de medicamentos caros (Protección de activos)
CREATE TRIGGER Trg_Med_Bloquear_Borrado_Caro BEFORE DELETE ON Medicamentos
FOR EACH ROW 
BEGIN
    IF OLD.precio > 50000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se permite borrar medicamentos de alto costo del sistema.';
    END IF;
END //

-- 7. Guardar un log histórico cuando un medicamento se elimina por completo
CREATE TRIGGER Trg_Med_Log_Eliminacion AFTER DELETE ON Medicamentos
FOR EACH ROW 
BEGIN
    INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Eliminado físicamente el medicamento: ', OLD.nombre));
END //

-- 8. Validar longitud mínima del nombre del medicamento (Evitar errores como "X")
CREATE TRIGGER Trg_Med_Validar_Longitud BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN
    IF LENGTH(NEW.nombre) < 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del medicamento es demasiado corto.';
    END IF;
END //

-- 9. Prevenir que se reduzca el precio más de un 50% de un solo golpe (Seguridad de negocio)
CREATE TRIGGER Trg_Med_Descuento_Maximo BEFORE UPDATE ON Medicamentos
FOR EACH ROW 
BEGIN
    IF NEW.precio < (OLD.precio * 0.5) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se permite una baja de precio mayor al 50%.';
    END IF;
END //

-- 10. Colocar un tipo por defecto si el campo viene vacío
CREATE TRIGGER Trg_Med_Tipo_Defecto BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN
    IF NEW.tipo IS NULL OR NEW.tipo = '' THEN 
        SET NEW.tipo = 'General'; 
    END IF;
END //

DELIMITER ;
-- 1. Listado exclusivo de enfermedades Crónicas
CREATE VIEW Vista_Enf_Cronicas AS
SELECT id, nombre, tipo FROM Enfermedades WHERE es_cronica = TRUE;

-- 2. Listado exclusivo de enfermedades Agudas / Temporales
CREATE VIEW Vista_Enf_Agudas AS
SELECT id, nombre, tipo FROM Enfermedades WHERE es_cronica = FALSE;

-- 3. Conteo de enfermedades clasificadas por su tipo (Infecciosas, Mentales, etc.)
CREATE VIEW Vista_Enf_Por_Tipo AS
SELECT tipo, COUNT(*) AS Cantidad FROM Enfermedades GROUP BY tipo;

-- 4. Enfermedades ordenadas alfabéticamente para vademécum
CREATE VIEW Vista_Enf_Orden_Alfabetico AS
SELECT id, nombre, es_cronica FROM Enfermedades ORDER BY nombre ASC;

-- 5. Enfermedades con nombres largos o compuestos (Análisis clínico)
CREATE VIEW Vista_Enf_Nombres_Complejos AS
SELECT id, nombre FROM Enfermedades WHERE LENGTH(nombre) > 20;

-- 6. Porcentaje de cronicidad global en la base de datos
CREATE VIEW Vista_Enf_Porcentaje_Cronicas AS
SELECT es_cronica, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Enfermedades) AS Porcentaje FROM Enfermedades GROUP BY es_cronica;

-- 7. Vista rápida para la app médica (ID y Nombre únicamente)
CREATE VIEW Vista_Enf_Simplificada AS
SELECT id, nombre FROM Enfermedades;

-- 8. Enfermedades del sistema respiratorio (Filtro temático común)
CREATE VIEW Vista_Enf_Respiratorias AS
SELECT id, nombre, es_cronica FROM Enfermedades WHERE tipo LIKE '%respiratorio%' OR tipo LIKE '%pulmonar%';

-- 9. Enfermedades raras o huérfanas (Tipos con un solo registro asociado)
CREATE VIEW Vista_Enf_Tipos_Raros AS
SELECT tipo FROM Enfermedades GROUP BY tipo HAVING COUNT(*) = 1;

-- 10. Vista de control de ID pares (Técnica para particiones o auditorías de sistemas)
CREATE VIEW Vista_Enf_ID_Pares AS
SELECT id, nombre, tipo FROM Enfermedades WHERE MOD(id, 2) = 0;

DELIMITER //

-- 1. Forzar primera letra en mayúscula y el resto en minúscula (Formato Nombre Propio)
CREATE TRIGGER Trg_Enf_Formato_Nombre BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    SET NEW.nombre = CONCAT(UPPER(SUBSTRING(NEW.nombre,1,1)), LOWER(SUBSTRING(NEW.nombre,2)));
END //

-- 2. Impedir registrar nombres vacíos en las patologías
CREATE TRIGGER Trg_Enf_Prevenir_Vacio BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    IF NEW.nombre = '' OR NEW.nombre IS NULL THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La enfermedad debe tener un nombre válido.';
    END IF;
END //

-- 3. Auditoría automática al agregar una nueva patología al sistema
CREATE TRIGGER Trg_Enf_Log_Insercion AFTER INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Nueva patología añadida: ', NEW.nombre));
END //

-- 4. Alerta si se cambia una enfermedad de Aguda a Crónica
CREATE TRIGGER Trg_Enf_Alerta_Cronica AFTER UPDATE ON Enfermedades
FOR EACH ROW 
BEGIN
    IF OLD.es_cronica = FALSE AND NEW.es_cronica = TRUE THEN
        INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Alerta: ', NEW.nombre, ' fue reclasificada como CRÓNICA.'));
    END IF;
END //

-- 5. Bloquear la eliminación total de cualquier enfermedad crónica (Historial médico protegido)
CREATE TRIGGER Trg_Enf_Proteger_Cronicas BEFORE DELETE ON Enfermedades
FOR EACH ROW 
BEGIN
    IF OLD.es_cronica = TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Por seguridad epidemiológica, no podés borrar enfermedades crónicas.';
    END IF;
END //

-- 6. Logear cambios de nombre en enfermedades (Evitar confusiones de diagnóstico)
CREATE TRIGGER Trg_Enf_Log_Modificacion AFTER UPDATE ON Enfermedades
FOR EACH ROW 
BEGIN
    IF OLD.nombre <> NEW.nombre THEN
        INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Corrección de diagnóstico: ', OLD.nombre, ' ahora se llama ', NEW.nombre));
    END IF;
END //

-- 7. Clasificar automáticamente el tipo si se incluye la palabra "Virus" o "Bacteria"
CREATE TRIGGER Trg_Enf_Auto_Tipo BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    IF NEW.nombre LIKE '%virus%' OR NEW.nombre LIKE '%viral%' THEN 
        SET NEW.tipo = 'Infecciosa/Viral';
    ELSEIF NEW.nombre LIKE '%bacteria%' THEN 
        SET NEW.tipo = 'Infecciosa/Bacteriana';
    END IF;
END //

-- 8. Validar que el tipo de enfermedad no contenga números (Evitar códigos extraños)
CREATE TRIGGER Trg_Enf_Validar_Tipo_Texto BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    IF NEW.tipo REGEXP '[0-9]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de enfermedad no puede contener caracteres numéricos.';
    END IF;
END //

-- 9. Registrar en auditoría cuando una enfermedad es dada de baja del catálogo
CREATE TRIGGER Trg_Enf_Log_Eliminar AFTER DELETE ON Enfermedades
FOR EACH ROW 
BEGIN
    INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Enfermedad eliminada del catálogo: ', OLD.nombre));
END //

-- 10. Evitar duplicar el tipo "General" usando variaciones (Estandarización estricta)
CREATE TRIGGER Trg_Enf_Limpiar_Tipo BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    IF LOWER(NEW.tipo) = 'general' OR NEW.tipo = 'otro' THEN 
        SET NEW.tipo = 'No Clasificada'; 
    END IF;
END //

DELIMITER ;

-- Tabla historial_medico

-- 1. Valida el peso
DELIMITER //
CREATE TRIGGER TR_Historial_ValidarPeso
BEFORE INSERT ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.peso <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El peso debe ser mayor a cero';
    END IF;
END //
DELIMITER ;


-- 2.Valida la altura
DELIMITER //
CREATE TRIGGER TR_Historial_ValidarAltura
BEFORE INSERT ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.altura <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La altura debe ser mayor a cero';
    END IF;
END //
DELIMITER ;


-- 3.Valida el diagnóstico
DELIMITER //
CREATE TRIGGER TR_Historial_ValidarDiagnostico
BEFORE INSERT ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.diagnostico IS NULL OR TRIM(NEW.diagnostico) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El diagnostico no puede estar vacio';
    END IF;
END //
DELIMITER ;


-- 4.Valida la razón de la cita
DELIMITER //
CREATE TRIGGER TR_Historial_ValidarRazon
BEFORE INSERT ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.razon_cita IS NULL OR TRIM(NEW.razon_cita) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La razon de la cita es obligatoria';
    END IF;
END //
DELIMITER ;


-- 5.Valida el peso antes de actualizar
DELIMITER //
CREATE TRIGGER TR_Historial_ActualizarPeso
BEFORE UPDATE ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.peso <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede actualizar con un peso invalido';
    END IF;
END //
DELIMITER ;


-- 6.Valida la altura antes de actualizar
DELIMITER //
CREATE TRIGGER TR_Historial_ActualizarAltura
BEFORE UPDATE ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.altura <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede actualizar con una altura invalida';
    END IF;
END //
DELIMITER ;


-- 7.Evita diagnóstico vacío antes de actualizar
DELIMITER //
CREATE TRIGGER TR_Historial_ActualizarDiagnostico
BEFORE UPDATE ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.diagnostico IS NULL OR TRIM(NEW.diagnostico) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El diagnostico no puede quedar vacio';
    END IF;
END //
DELIMITER ;


-- 8.Impide borrar historiales sin diagnóstico
DELIMITER //
CREATE TRIGGER TR_Historial_EliminarDiagnostico
BEFORE DELETE ON historial_medico
FOR EACH ROW
BEGIN
    IF OLD.diagnostico IS NULL OR TRIM(OLD.diagnostico) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar un historial sin diagnostico';
    END IF;
END //
DELIMITER ;


-- 9.Valida la fecha de la cita
DELIMITER //
CREATE TRIGGER TR_Historial_ValidarFecha
BEFORE INSERT ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.fecha_cita IS NULL OR TRIM(NEW.fecha_cita) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita es obligatoria';
    END IF;
END //
DELIMITER ;


-- 10.Valida los síntomas
DELIMITER //
CREATE TRIGGER TR_Historial_ValidarSintomas
BEFORE UPDATE ON historial_medico
FOR EACH ROW
BEGIN
    IF NEW.lista_sintomas IS NULL OR TRIM(NEW.lista_sintomas) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Debe existir al menos un sintoma';
    END IF;
END //
DELIMITER ;



-- Tabla Usuarios

-- 1. Valida el correo
DELIMITER //
CREATE TRIGGER TR_Usuarios_ValidarEmail
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Email IS NULL OR TRIM(NEW.Email) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electronico es obligatorio';
    END IF;
END //
DELIMITER ;


-- 2. Valida el formato del correo
DELIMITER //
CREATE TRIGGER TR_Usuarios_FormatoEmail
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Email NOT LIKE '%_@_%._%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El formato del correo electronico no es valido';
    END IF;
END //
DELIMITER ;


-- 3.Valida la contraseña
DELIMITER //
CREATE TRIGGER TR_Usuarios_ValidarContraseña
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Contraseña IS NULL OR TRIM(NEW.Contraseña) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña no puede estar vacia';
    END IF;
END //
DELIMITER ;


-- 4. Exige una contraseña de al menos 4 caracteres
DELIMITER //
CREATE TRIGGER TR_Usuarios_LongitudContraseña
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.Contraseña) < 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña debe tener al menos 4 caracteres';
    END IF;
END //
DELIMITER ;


-- 5.Valida el correo antes de actualizar
DELIMITER //
CREATE TRIGGER TR_Usuarios_ActualizarEmail
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Email IS NULL OR TRIM(NEW.Email) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo no puede quedar vacio';
    END IF;
END //
DELIMITER ;


-- 6.Valida el formato del correo antes de actulizar
DELIMITER //
CREATE TRIGGER TR_Usuarios_ActualizarFormatoEmail
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Email NOT LIKE '%_@_%._%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nuevo correo no tiene un formato valido';
    END IF;
END //
DELIMITER ;


-- 7.Valida la contraseña antes de actualizar
DELIMITER //
CREATE TRIGGER TR_Usuarios_ActualizarContraseña
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.Contraseña IS NULL OR TRIM(NEW.Contraseña) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña no puede quedar vacia';
    END IF;
END //
DELIMITER ;


-- 8. Exige una contraseña de al menos 4 caracteres antes de actualizar
DELIMITER //
CREATE TRIGGER TR_Usuarios_ActualizarLongitudContraseña
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.Contraseña) < 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña debe tener al menos 4 caracteres';
    END IF;
END //
DELIMITER ;


-- 9. Impide eliminar el usuario administrador
DELIMITER //
CREATE TRIGGER TR_Usuarios_ProtegerAdministrador
BEFORE DELETE ON Usuarios
FOR EACH ROW
BEGIN
    IF OLD.Email = 'admin@gmail.com' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el usuario administrador';
    END IF;
END //
DELIMITER ;


-- 10. Impide modificar el ID
DELIMITER //
CREATE TRIGGER TR_Usuarios_ProtegerID
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.id <> OLD.id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite modificar el ID del usuario';
    END IF;
END //
DELIMITER ;

-- SINTOMA

-- 1. Si el sintoma no tiene nombre, no se puede registrar

DELIMITER $$

CREATE TRIGGER validar_nombre_sintoma
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Nombre IS NULL OR NEW.Nombre = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El sintoma debe tener un nombre';
    END IF;
END $$

DELIMITER ;


-- 2. La escala de dolor debe estar entre 0 y 10

DELIMITER $$

CREATE TRIGGER validar_escala_dolor
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Escala_Dolor IS NULL OR NEW.Escala_Dolor < 0 OR NEW.Escala_Dolor > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La escala de dolor debe estar entre 0 y 10';
    END IF;
END $$

DELIMITER ;


-- 3. Si no se indica el nivel de severidad, se asigna Leve

DELIMITER $$

CREATE TRIGGER severidad_predeterminada
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Nivel_Severidad IS NULL OR NEW.Nivel_Severidad = '' THEN
        SET NEW.Nivel_Severidad = 'Leve';
    END IF;
END $$

DELIMITER ;


-- 4. El nivel de severidad solo puede tener ciertos valores

DELIMITER $$

CREATE TRIGGER validar_severidad_sintoma
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Nivel_Severidad NOT IN ('Leve', 'Moderada', 'Grave') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nivel de severidad debe ser Leve, Moderada o Grave';
    END IF;
END $$

DELIMITER ;


-- 5. El campo Cirujia solo puede tener Si o No

DELIMITER $$

CREATE TRIGGER validar_cirujia
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Cirujia NOT IN ('Si', 'No') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El campo Cirujia debe ser Si o No';
    END IF;
END $$

DELIMITER ;


-- 6. El campo Tratable solo puede tener Si o No

DELIMITER $$

CREATE TRIGGER validar_tratable
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Tratable NOT IN ('Si', 'No') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El campo Tratable debe ser Si o No';
    END IF;
END $$

DELIMITER ;


-- 7. Al actualizar un sintoma, la escala de dolor debe seguir siendo valida

DELIMITER $$

CREATE TRIGGER actualizar_escala_dolor
BEFORE UPDATE ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Escala_Dolor IS NULL OR NEW.Escala_Dolor < 0 OR NEW.Escala_Dolor > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La escala de dolor debe estar entre 0 y 10';
    END IF;
END $$

DELIMITER ;


-- 8. No se puede actualizar un sintoma para dejarlo sin nombre

DELIMITER $$

CREATE TRIGGER actualizar_nombre_sintoma
BEFORE UPDATE ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Nombre IS NULL OR NEW.Nombre = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El sintoma debe tener un nombre';
    END IF;
END $$

DELIMITER ;


-- 9. El campo Requiere_Monitoreo solo puede tener Si o No

DELIMITER $$

CREATE TRIGGER validar_monitoreo
BEFORE INSERT ON Sintoma
FOR EACH ROW
BEGIN
    IF NEW.Requiere_Monitoreo NOT IN ('Si', 'No') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El campo Requiere_Monitoreo debe ser Si o No';
    END IF;
END $$

DELIMITER ;


-- 10. No se pueden eliminar sintomas que tengan riesgo de secuela

DELIMITER $$

CREATE TRIGGER no_eliminar_sintoma_con_secuelas
BEFORE DELETE ON Sintoma
FOR EACH ROW
BEGIN
    IF OLD.Riesgo_Secuela = 'Si' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar un sintoma con riesgo de secuela';
    END IF;
END $$

DELIMITER ;


-- TRATAMIENTO

-- 1. Si el tratamiento no tiene estado, se asigna Activo

DELIMITER $$

CREATE TRIGGER estado_predeterminado
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.estado IS NULL OR NEW.estado = '' THEN
        SET NEW.estado = 'Activo';
    END IF;
END $$

DELIMITER ;


-- 2. El costo del tratamiento no puede ser negativo

DELIMITER $$

CREATE TRIGGER validar_costo_tratamiento
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.costo < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El costo del tratamiento no puede ser negativo';
    END IF;
END $$

DELIMITER ;


-- 3. Todos los tratamientos deben tener un nombre

DELIMITER $$

CREATE TRIGGER validar_nombre_tratamiento
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.nombre IS NULL OR NEW.nombre = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El tratamiento debe tener un nombre';
    END IF;
END $$

DELIMITER ;


-- 4. Los dias de duracion no pueden ser negativos

DELIMITER $$

CREATE TRIGGER validar_duracion_tratamiento
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.dias_duracion < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los dias de duracion no pueden ser negativos';
    END IF;
END $$

DELIMITER ;


-- 5. Los dias de reposo no pueden ser negativos

DELIMITER $$

CREATE TRIGGER validar_reposo_tratamiento
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.dias_reposo < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Los dias de reposo no pueden ser negativos';
    END IF;
END $$

DELIMITER ;


-- 6. La cantidad de sesiones no puede ser negativa

DELIMITER $$

CREATE TRIGGER validar_sesiones_tratamiento
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.cantidad_sesiones < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad de sesiones no puede ser negativa';
    END IF;
END $$

DELIMITER ;


-- 7. El campo requiere_internacion solo puede tener Si o No

DELIMITER $$

CREATE TRIGGER validar_internacion
BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.requiere_internacion NOT IN ('Si', 'No') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El campo requiere_internacion debe ser Si o No';
    END IF;
END $$

DELIMITER ;


-- 8. Al actualizar un tratamiento, el costo debe seguir siendo valido

DELIMITER $$

CREATE TRIGGER actualizar_costo_tratamiento
BEFORE UPDATE ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.costo < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El costo del tratamiento no puede ser negativo';
    END IF;
END $$

DELIMITER ;


-- 9. Los tratamientos solo pueden tener ciertos estados al actualizarse

DELIMITER $$

CREATE TRIGGER validar_estado_tratamiento
BEFORE UPDATE ON Tratamiento
FOR EACH ROW
BEGIN
    IF NEW.estado NOT IN ('Activo', 'Inactivo', 'Finalizado', 'Suspendido') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El estado del tratamiento es incorrecto';
    END IF;
END $$

DELIMITER ;


-- 10. No se pueden eliminar tratamientos que esten activos

DELIMITER $$

CREATE TRIGGER no_eliminar_tratamiento_activo
BEFORE DELETE ON Tratamiento
FOR EACH ROW
BEGIN
    IF OLD.estado = 'Activo' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar un tratamiento activo';
    END IF;
END $$

DELIMITER ;
