-- _______________________________________PROCEDIMIENTOS CAÑETE_____________________________________________________

-- 1. Pacientes_MostrarTodos : muestra todos los pacientes registrados en la base de datos.

DELIMITER //
create procedure Pacientes_MostrarTodos()
begin
    select 
		* 
	from pacientes;
end //
delimiter ;



-- 2. Pacientes_BuscarPorID : busca un paciente utilizando su identificador único.

DELIMITER //
create procedure Pacientes_BuscarPorID(in id int)
begin
	select 
		*
	from pacientes
    where id_paciente = id ;
end //
delimiter ;



-- 3. Pacientes_BuscarPorDNI : busca un paciente mediante su número de documento.

DELIMITER //
create procedure Pacientes_BuscarPorDNI(in P_DNI int)
begin
	select * from pacientes
    where DNI = P_DNI;
end //
delimiter ;


-- 4. Pacientes_BuscarPorNombre : muestra los pacientes que coinciden con un nombre determinado.

DELIMITER //
create procedure Pacientes_BuscarPorNombre(in P_Nombre varchar(100))
begin
	select * from pacientes
    where nombre = P_Nombre;
end //
delimiter ;

-- 5. Pacientes_BuscarPorApellido : busca pacientes por su apellido.

DELIMITER //
create procedure Pacientes_BuscarPorApellido(in P_Apellido varchar(100))
begin
	select * from pacientes
    where apellido = P_Apellido;
end //
delimiter ;

-- 6. Pacientes_BuscarPorEmail : localiza un paciente utilizando su correo electrónico.

DELIMITER //
create procedure Pacientes_BuscarPorEmail(in P_Email varchar(100))
begin
	select * from pacientes
    where Email = P_Email;
end //
delimiter ;

-- 7. Pacientes_Registrar : registra un nuevo paciente con sus datos personales y médicos.

DELIMITER //
create procedure Pacientes_Registrar(in P_Nombre varchar(100) ,in P_Apellido varchar(100),in P_DNI int ,in P_Email varchar(100) ,in P_Fecha_Nacimiento varchar(100) ,in P_Direccion varchar(100) ,in P_Genero varchar(100) ,in P_Seguro_Medico varchar(100) ,in P_Numero_Afiliado varchar(100) ,in P_Grupo_Sanguineo varchar(100),in P_Lista_Historial varchar(100))
begin
	INSERT INTO pacientes (Nombre, Apellido, DNI, Email, Fecha_Nacimiento, Direccion, Genero, Seguro_Medico, Numero_Afiliado, Grupo_Sanguineo, Lista_Historial) VALUES
	(P_Nombre, P_Apellido, P_DNI, P_Email, P_Fecha_Nacimiento, P_Direccion, P_Genero, P_Seguro_Medico, P_Numero_Afiliado, P_Grupo_Sanguineo, P_Lista_Historial);
end //
delimiter ;


-- 8. Pacientes_ActualizarDatos : modifica los datos personales de un paciente existente.

DELIMITER //
create procedure Pacientes_ActualizarDatos(in P_id_paciente varchar(100),in P_Nombre varchar(100) ,in P_Apellido varchar(100),in P_DNI int ,in P_Email varchar(100) ,in P_Fecha_Nacimiento varchar(100) ,in P_Direccion varchar(100) ,in P_Genero varchar(100) ,in P_Seguro_Medico varchar(100) ,in P_Numero_Afiliado varchar(100) ,in P_Grupo_Sanguineo varchar(100),in P_Lista_Historial varchar(100))
begin
	Update pacientes
    set nombre = P_Nombre,
    apellido = P_Apellido,
    DNI = P_DNI,
    Email = Email,
    Fecha_Nacimiento = P_Fecha_Nacimiento,
    Direccion = P_Direccion,
    Genero = P_Genero,
    Seguro_Medico = P_Seguro_Medico,
    Numero_Afiliado = P_Numero_Afiliado,
    Grupo_Sanguineo = P_Grupo_Sanguineo,
    Lista_Historial = P_Lista_Historial
    where id_paciente = P_id_paciente;
    
end //
delimiter ;


-- call Pacientes_ActualizarDatos(1,"1","2",12345678,"4","5","6","7","8","9","0","0");

-- select * from pacientes;
    
-- 9. Pacientes_Eliminar : elimina un paciente identificado por su ID, cuando las relaciones de la base de datos lo permiten.
	
DELIMITER //
create procedure Pacientes_Eliminar(in id_P int)
begin
	Delete from pacientes
    where id_paciente = id_P;
end //
delimiter ;

-- 10. Pacientes_ContarTotal : devuelve la cantidad total de pacientes registrados.

DELIMITER //
create procedure Pacientes_ContarTotal()
begin
	select count(*) from pacientes;
end //
delimiter ;

-- 11. Pacientes_MostrarPorGenero : muestra los pacientes que pertenecen a un género determinado.

DELIMITER //
create procedure Pacientes_MostrarPorGenero(in P_Genero varchar(100))
begin
	select
		* 
    from pacientes
    Where Genero = P_Genero;
    
end //
delimiter ;

-- 12. Pacientes_MostrarPorSeguro : lista los pacientes que tienen una obra social o seguro médico específico.

DELIMITER //
create procedure Pacientes_MostrarPorSeguro(in P_Seguro varchar(100))
begin
	select
		* 
    from pacientes
    Where Seguro_Medico = P_Seguro;
    
end //
delimiter ;

-- 13. Pacientes_BuscarPorNumeroAfiliado : busca pacientes mediante su número de afiliado.

DELIMITER //
create procedure Pacientes_BuscarPorNumeroAfiliado(in P_Numero varchar(100))
begin
	select
		* 
    from pacientes
    Where Numero_Afiliado = P_Numero;
end //
delimiter ;

-- 14. Pacientes_MostrarPorGrupoSanguineo : filtra los pacientes según su grupo sanguíneo.

DELIMITER //
create procedure Pacientes_MostrarPorGrupoSanguineo(in P_grupo_sanguineo varchar(100))
begin
	select
		* 
    from pacientes
    Where Grupo_Sanguineo = P_grupo_sanguineo;
    
end //
delimiter ;

-- 15. Pacientes_ActualizarEmail : modifica únicamente el correo electrónico de un paciente.

DELIMITER //
create procedure Pacientes_ActualizarEmail(in P_id_paciente varchar(100),in P_Email varchar(100))
begin
	Update pacientes
    set Email = P_Email
    where id_paciente = P_id_paciente;
end //
delimiter ;

-- 16. Pacientes_ActualizarDireccion : actualiza el domicilio registrado de un paciente.

DELIMITER //
create procedure Pacientes_ActualizarDireccion(in P_id_paciente varchar(100),in P_Direccion varchar(100))
begin
	Update pacientes
    set Direccion = P_Direccion
    where id_paciente = P_id_paciente;
end //
delimiter ;


-- 17. Pacientes_ActualizarSeguro : modifica el seguro médico de un paciente.

DELIMITER //
create procedure Pacientes_ActualizarSeguro(in P_id_paciente varchar(100),in P_Seguro_Medico varchar(100))
begin
	Update pacientes
    set Seguro_Medico = P_Seguro_Medico
    where id_paciente = P_id_paciente;
end //
delimiter ;

-- 18. Pacientes_ActualizarNumeroAfiliado : cambia el número de afiliado de un paciente.

DELIMITER //
create procedure Pacientes_ActualizarNumeroAfiliado(in P_id_paciente varchar(100),in P_Numero_Afiliado varchar(100))
begin
	Update pacientes
    set Numero_Afiliado = P_Numero_Afiliado
    where id_paciente = P_id_paciente;
end //
delimiter ;

-- 19. Pacientes_ActualizarGrupoSanguineo : actualiza el grupo sanguíneo registrado.

DELIMITER //
create procedure Pacientes_ActualizarGrupoSanguineo(in P_id_paciente varchar(100),in P_Grupo_Sanguineo varchar(100))
begin
	Update pacientes
    set Grupo_Sanguineo = P_Grupo_Sanguineo
    where id_paciente = P_id_paciente;
end //
delimiter ;

-- 20. Pacientes_ActualizarListaHistorial : modifica el texto del historial almacenado en el campo Lista_Historial.

DELIMITER //
create procedure Pacientes_ActualizarListaHistorial(in P_id_paciente varchar(100),in P_Lista_Historial varchar(100))
begin
	Update pacientes
    set Lista_Historial = P_Lista_Historial
    where id_paciente = P_id_paciente;
end //
delimiter ;

-- 21. Pacientes_VerificarExistenciaDNI : comprueba si existe un paciente con el DNI indicado.

DELIMITER //
create procedure Pacientes_VerificarExistenciaDNI(in P_DNI int, out Respuesta Varchar(100))
begin
	
    declare cantidad int;
    
	select
		count(*) into cantidad
	from pacientes
    where DNI = P_DNI;
	
    if cantidad = 1 then	
		set Respuesta = "Existe un paciente con ese DNI";
	else 
		set Respuesta = "No existe un paciente con ese DNI";
    end if ;
end //
delimiter ;


SET @v_PacientesDNI = ''; 

call Pacientes_VerificarExistenciaDNI(12431243,@v_PacientesDNI);


-- 22. Pacientes_VerificarExistenciaEmail : comprueba si un correo electrónico ya está registrado.

DELIMITER //
create procedure Pacientes_VerificarExistenciaEmail(in P_Email int, out Respuesta Varchar(100))
begin
	
    declare cantidad int;
    
	select
		count(*) into cantidad
	from pacientes
    where Email = P_Email;
	
    if cantidad = 1 then	
		set Respuesta = "Existe un paciente con ese Email";
	else 
		set Respuesta = "No existe un paciente con ese Email";
    end if ;
end //
delimiter ;

SET @v_PacientesEmail = ''; 

call Pacientes_VerificarExistenciaEmail("gonzalezmartin94@gmail.com",@v_PacientesEmail);

select @v_PacientesEmail ;


-- 23. Pacientes_MostrarOrdenadosPorApellido : muestra los pacientes ordenados alfabéticamente por apellido.

DELIMITER //
create procedure Pacientes_MostrarOrdenadosPorApellido()
begin
   
    select 
		* 
	from pacientes
    order by apellido asc;
end //
delimiter ;


-- 24. Pacientes_MostrarSinNumeroAfiliado: Muestra lso pacientes sin numero afiliado.

DELIMITER //
create procedure Pacientes_MostrarSinNumeroAfiliado()
begin
    select 
		* 
	from pacientes
    where Numero_Afiliado is null;
end //
delimiter ;

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

delimiter ;

/*49*/
delimiter //
create procedure Medicamentos_MostrarTodos()
begin
	select * from Medicamentos;
end//
delimiter ;

/*50*/
delimiter //
create procedure Medicamentos_BuscarPorID(id int)
begin
	select * from Medicamentos m where m.id_medicamento = id;
end//
delimiter ;

/*51*/
delimiter //
create procedure Medicamentos_BuscarPorNombre(nombre varchar(100))
begin
	select * from medicamentos m where m.nombre = nombre;
end//
delimiter ;

/*52*/
delimiter //
create procedure Medicamentos_BuscarPorTipo(tipo varchar(50))
begin
	select * from medicamentos m where m.tipo = tipo;
end//
delimiter ;

/*53*/
delimiter //
create procedure Medicamentos_BuscarPorGrupoAnatomico(grupo varchar(100))
begin
	select * from medicamentos m where m.Grupo_Anatomico = grupo;
end//
delimiter ;

/*54*/
delimiter //
create procedure Medicamentos_BuscarPorCondicionVenta(condicion varchar(50))
begin
	select * from medicamentos m where m.condicion_venta = condicion;
end//
delimiter ;

/*55*/
DELIMITER //

CREATE PROCEDURE Medicamentos_Registrar(
    IN p_nombre VARCHAR(100), 
    IN p_grupo_anatomico VARCHAR(100), 
    IN p_tipo VARCHAR(50), 
    IN p_condicion_venta VARCHAR(50), 
    IN p_forma_farmaceutica VARCHAR(50), 
    IN p_categoria_subtipo VARCHAR(50), 
    IN p_via_administracion VARCHAR(50), 
    IN p_dosis_unidad VARCHAR(50), 
    IN p_dosis_cantidad INT
)
BEGIN
    INSERT INTO medicamentos(
        nombre, 
        grupo_anatomico, 
        tipo, 
        condicion_venta, 
        forma_farmaceutica, 
        Categoria_Subtipo, 
        Via_Administracion, 
        Dosis_Unidad, 
        dosis_cantidad
    ) 
    VALUES(
        p_nombre, 
        p_grupo_anatomico, 
        p_tipo, 
        p_condicion_venta, 
        p_forma_farmaceutica, 
        p_categoria_subtipo, 
        p_via_administracion, 
        p_dosis_unidad, 
        p_dosis_cantidad
    );
END //

/*56*/
delimiter //
create procedure Medicamentos_Actualizar(id int,nombre_ varchar(100), grupo_ varchar(100), tipo_ varchar(50), condicion_venta_ varchar(50), forma_farmaceutica_ varchar(50), Categoria_Subtipo_ varchar(50), Via_Administracion_ varchar(50), Dosis_unidad_ varchar(50), dosis_cantidad_ int)
begin
	update medicamentos m set nombre = nombre_, Grupo_Anatomico = grupo_, tipo = tipo_, condicion_venta = condicion_venta_, forma_farmaceutica = forma_farmaceutica_, Categoria_Subtipo = Categoria_Subtipo_,Via_Administracion = Via_Administracion_, Dosis_unidad = Dosis_unidad_, dosis_cantidad = dosis_cantidad_
    where m.id_medicamento = id;
end //
delimiter ;

/*57*/
delimiter //
create procedure Medicamentos_Eliminar(id int)
begin
	delete from medicamentos where id_medicamento = id;
end //
delimiter ;

/*58*/
delimiter //
create procedure Medicamentos_ContarTotal()
begin
	select count(*) as cantidad_de_medicamentos from medicamentos;
end //
delimiter ;

/*59*/
delimiter //
create procedure Medicamentos_BuscarPorFormaFarmaceutica(forma varchar(50))
begin
	select * from medicamentos where forma_farmaceutica = forma;
end //
delimiter ;

/*60*/
delimiter //
create procedure Medicamentos_BuscarPorVidaAdministracion(via varchar(50))
begin
	select * from medicamentos where Via_Administracion = via;
end //
delimiter ;

/*61*/
delimiter //
create procedure Medicamentos_ActualizarDosis(id int, Dosis_unidad varchar(50))
begin
	update medicamentos set Dosis_Unidad = Dosis_unidad where id_medicamento = id;
end //
delimiter ;

/*62*/
delimiter //
create procedure Medicamentos_MostrarOrdenadorPorNombre()
begin
	select * from medicamentos
    order by nombre
    asc;
end //
delimiter ;

/*63*/
delimiter //
create procedure Enfermedades_MostrarTodas()
begin
	select * from enfermedades;
end //
delimiter ;

/*64*/
delimiter //
create procedure Enfermedades_BuscarPorID(id int)
begin
	select * from enfermedades where id_enfermedad = id;
end //
delimiter ;

/*65*/
delimiter //
create procedure Enfermedades_BuscarPorNombre(nombre varchar(100))
begin
	select * from enfermedades e where e.nombre = nombre;
end //
delimiter ;

/*66*/
delimiter //
create procedure Enfermedades_BuscarPorCategoria(categoria varchar(50))
begin
	select * from enfermedades e where e.categoria = categoria;
end //
delimiter ;

/*67*/
DELIMITER //
CREATE PROCEDURE Enfermedades_Registrar(
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_categoria VARCHAR(50),
    IN p_lista_sintomas VARCHAR(100),
    IN p_lista_tratamientos VARCHAR(100),
    IN p_observaciones VARCHAR(100)
)
BEGIN
    INSERT INTO enfermedades(nombre, descripcion, categoria, Lista_Sintomas, Lista_Tratamientos, observaciones)
    VALUES(p_nombre, p_descripcion, p_categoria, p_lista_sintomas, p_lista_tratamientos, p_observaciones);
END //
DELIMITER ;

/*68*/
delimiter //
CREATE PROCEDURE Enfermedades_Actualizar(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_categoria VARCHAR(50),
    IN p_lista_sintomas VARCHAR(100),
    IN p_lista_tratamientos VARCHAR(100),
    IN p_observaciones VARCHAR(100)
)
BEGIN
    UPDATE enfermedades 
    SET nombre = p_nombre, 
        descripcion = p_descripcion, 
        categoria = p_categoria, 
        Lista_Sintomas = p_lista_sintomas, 
        Lista_Tratamientos = p_lista_tratamientos, 
        observaciones = p_observaciones
    WHERE id_enfermedad = p_id;
END //
DELIMITER ;

/*69*/
delimiter //
create procedure Enfermedades_Eliminar(id int)
begin
	delete from enfermedades where id_enfermedad = id;
end //
delimiter ;

/*70*/
delimiter //
create procedure Enfermedades_ContarTotal()
begin
	select count(*) as cantidad_enfermedades from enfermedades;
end //
delimiter ;

/*71*/
delimiter //
create procedure Enfermedades_ActualizarDescripcion(id int,descripcion varchar(100))
begin
	update enfermedades e set e.descripcion = descripcion;
end //
delimiter ;

/*72*/
delimiter //
create procedure Enfermedades_ActualizarObservaciones(id int, observacion varchar(100))
begin
	update enfermedades e set e.observacion = obervacion;
end //
delimiter ;

-- 73. Muestra todos los registros del historial médico.
DELIMITER //
CREATE PROCEDURE Historial_MostrarTodos()
BEGIN
    SELECT * FROM historial_medico;
END //


-- 74. Busca un registro del historial mediante su ID.
DELIMITER //
CREATE PROCEDURE Historial_BuscarPorID(IN p_id_historial INT)
BEGIN
    SELECT *
    FROM historial_medico
    WHERE id_historial = p_id_historial;
END //


-- 75. Muestra los registros asociados al DNI de un paciente.
DELIMITER //
CREATE PROCEDURE Historial_BuscarPorDNI(IN p_DNI_Paciente INT)
BEGIN
    SELECT *
    FROM historial_medico
    WHERE DNI_Paciente = p_DNI_Paciente;
END //


-- 76. Registra una consulta médica con sus datos clínicos y diagnóstico.
DELIMITER //
CREATE PROCEDURE Historial_Registrar(
    IN p_DNI_Paciente INT,
    IN p_id_medico VARCHAR(30),
    IN p_nombreDeLaEnfermedad VARCHAR(100),
    IN p_nombreMedicamento VARCHAR(100),
    IN p_fecha_cita VARCHAR(100),
    IN p_peso INT,
    IN p_altura INT,
    IN p_razon_cita VARCHAR(100),
    IN p_diagnostico VARCHAR(100),
    IN p_lista_sintomas VARCHAR(100)
)
BEGIN
    INSERT INTO historial_medico (
        DNI_Paciente,
        id_medico,
        nombreDeLaEnfermedad,
        nombreMedicamento,
        fecha_cita,
        peso,
        altura,
        razon_cita,
        diagnostico,
        lista_sintomas
    )
    VALUES (
        p_DNI_Paciente,
        p_id_medico,
        p_nombreDeLaEnfermedad,
        p_nombreMedicamento,
        p_fecha_cita,
        p_peso,
        p_altura,
        p_razon_cita,
        p_diagnostico,
        p_lista_sintomas
    );
END //


-- 77. Modifica todos los datos de un registro del historial médico.
DELIMITER //
CREATE PROCEDURE Historial_Actualizar(
    IN p_id_historial INT,
    IN p_DNI_Paciente INT,
    IN p_id_medico VARCHAR(30),
    IN p_nombreDeLaEnfermedad VARCHAR(100),
    IN p_nombreMedicamento VARCHAR(100),
    IN p_fecha_cita VARCHAR(100),
    IN p_peso INT,
    IN p_altura INT,
    IN p_razon_cita VARCHAR(100),
    IN p_diagnostico VARCHAR(100),
    IN p_lista_sintomas VARCHAR(100)
)
BEGIN
    UPDATE historial_medico
    SET DNI_Paciente = p_DNI_Paciente,
        id_medico = p_id_medico,
        nombreDeLaEnfermedad = p_nombreDeLaEnfermedad,
        nombreMedicamento = p_nombreMedicamento,
        fecha_cita = p_fecha_cita,
        peso = p_peso,
        altura = p_altura,
        razon_cita = p_razon_cita,
        diagnostico = p_diagnostico,
        lista_sintomas = p_lista_sintomas
    WHERE id_historial = p_id_historial;
END //


-- 78. Elimina un registro del historial identificado por su ID.
DELIMITER //
CREATE PROCEDURE Historial_Eliminar(IN p_id_historial INT)
BEGIN
    DELETE FROM historial_medico
    WHERE id_historial = p_id_historial;
END //


-- 79. Lista los registros médicos asociados a una matrícula médica.
DELIMITER //
CREATE PROCEDURE Historial_MostrarPorMedico(IN p_matricula_medico VARCHAR(30))
BEGIN
    SELECT *
    FROM historial_medico
    WHERE id_medico = p_matricula_medico;
END //


-- 80. Muestra los registros vinculados a una enfermedad específica.
DELIMITER //
CREATE PROCEDURE Historial_MostrarPorEnfermedad(IN p_nombre_enfermedad VARCHAR(100))
BEGIN
    SELECT *
    FROM historial_medico
    WHERE nombreDeLaEnfermedad = p_nombre_enfermedad;
END //


-- 81. Lista los registros asociados a un medicamento determinado.
DELIMITER //
CREATE PROCEDURE Historial_MostrarPorMedicamento(IN p_nombre_medicamento VARCHAR(100))
BEGIN
    SELECT *
    FROM historial_medico
    WHERE nombreMedicamento = p_nombre_medicamento;
END //


-- 82. Muestra los registros correspondientes a una fecha de consulta exacta.
DELIMITER //
CREATE PROCEDURE Historial_MostrarPorFecha(IN p_fecha_cita VARCHAR(100))
BEGIN
    SELECT *
    FROM historial_medico
    WHERE fecha_cita = p_fecha_cita;
END //


-- 83. Busca registros cuyo diagnóstico contenga el texto indicado.
DELIMITER //
CREATE PROCEDURE Historial_BuscarPorDiagnostico(IN p_diagnostico VARCHAR(100))
BEGIN
    SELECT *
    FROM historial_medico
    WHERE diagnostico LIKE CONCAT('%', p_diagnostico, '%');
END //


-- 84. Modifica el diagnóstico de un registro médico.
DELIMITER //
CREATE PROCEDURE Historial_ActualizarDiagnostico(
    IN p_id_historial INT,
    IN p_diagnostico VARCHAR(100)
)
BEGIN
    UPDATE historial_medico
    SET diagnostico = p_diagnostico
    WHERE id_historial = p_id_historial;
END //


-- 85. Modifica el motivo de consulta registrado.
DELIMITER //
CREATE PROCEDURE Historial_ActualizarRazonCita(
    IN p_id_historial INT,
    IN p_razon_cita VARCHAR(100)
)
BEGIN
    UPDATE historial_medico
    SET razon_cita = p_razon_cita
    WHERE id_historial = p_id_historial;
END //


-- 86. Actualiza la lista de síntomas de una consulta.
DELIMITER //
CREATE PROCEDURE Historial_ActualizarListaSintomas(
    IN p_id_historial INT,
    IN p_lista_sintomas VARCHAR(100)
)
BEGIN
    UPDATE historial_medico
    SET lista_sintomas = p_lista_sintomas
    WHERE id_historial = p_id_historial;
END //


-- 87. Devuelve la cantidad de registros asociados al DNI de un paciente.
DELIMITER //
CREATE PROCEDURE Historial_ContarPorPaciente(IN p_DNI_Paciente INT)
BEGIN
    SELECT COUNT(*) AS cantidad_registros
    FROM historial_medico
    WHERE DNI_Paciente = p_DNI_Paciente;
END //


-- 88. Muestra todos los síntomas registrados.
DELIMITER //
CREATE PROCEDURE Sintomas_MostrarTodos()
BEGIN
    SELECT * FROM Sintoma;
END //


-- 89. Busca un síntoma mediante su nombre.
DELIMITER //
CREATE PROCEDURE Sintomas_BuscarPorNombre(IN p_nombre VARCHAR(100))
BEGIN
    SELECT *
    FROM Sintoma
    WHERE Nombre = p_nombre;
END //


-- 90. Registra un nuevo síntoma con sus características y descripción.
DELIMITER //
CREATE PROCEDURE Sintomas_Registrar(
    IN p_nombre VARCHAR(100),
    IN p_descripcion VARCHAR(100),
    IN p_durabilidad VARCHAR(100),
    IN p_caracteristicas_tratamiento VARCHAR(100),
    IN p_cirujia VARCHAR(20),
    IN p_tratable VARCHAR(20),
    IN p_nivel_severidad VARCHAR(50),
    IN p_escala_dolor INT,
    IN p_requiere_monitoreo VARCHAR(20),
    IN p_altera_consciencia VARCHAR(20),
    IN p_riesgo_secuela VARCHAR(20),
    IN p_tipo_intervencion VARCHAR(100)
)
BEGIN
    INSERT INTO Sintoma (
        Nombre,
        Descripcion,
        Durabilidad,
        Caracteristicas_Tratamiento,
        Cirujia,
        Tratable,
        Nivel_Severidad,
        Escala_Dolor,
        Requiere_Monitoreo,
        Altera_Consciencia,
        Riesgo_Secuela,
        Tipo_Intervencion
    )
    VALUES (
        p_nombre,
        p_descripcion,
        p_durabilidad,
        p_caracteristicas_tratamiento,
        p_cirujia,
        p_tratable,
        p_nivel_severidad,
        p_escala_dolor,
        p_requiere_monitoreo,
        p_altera_consciencia,
        p_riesgo_secuela,
        p_tipo_intervencion
    );
END //


-- 91. Modifica los datos de un síntoma existente, identificado por su ID.
DELIMITER //
CREATE PROCEDURE Sintomas_Actualizar(
    IN p_id_sintoma INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion VARCHAR(100),
    IN p_durabilidad VARCHAR(100),
    IN p_caracteristicas_tratamiento VARCHAR(100),
    IN p_cirujia VARCHAR(20),
    IN p_tratable VARCHAR(20),
    IN p_nivel_severidad VARCHAR(50),
    IN p_escala_dolor INT,
    IN p_requiere_monitoreo VARCHAR(20),
    IN p_altera_consciencia VARCHAR(20),
    IN p_riesgo_secuela VARCHAR(20),
    IN p_tipo_intervencion VARCHAR(100)
)
BEGIN
    UPDATE Sintoma
    SET Nombre = p_nombre,
        Descripcion = p_descripcion,
        Durabilidad = p_durabilidad,
        Caracteristicas_Tratamiento = p_caracteristicas_tratamiento,
        Cirujia = p_cirujia,
        Tratable = p_tratable,
        Nivel_Severidad = p_nivel_severidad,
        Escala_Dolor = p_escala_dolor,
        Requiere_Monitoreo = p_requiere_monitoreo,
        Altera_Consciencia = p_altera_consciencia,
        Riesgo_Secuela = p_riesgo_secuela,
        Tipo_Intervencion = p_tipo_intervencion
    WHERE Id_sintoma = p_id_sintoma;
END //


-- 92. Elimina un síntoma identificado por su nombre.
delimiter //

create procedure sintomas_eliminar(in p_id_sintoma int)
begin
    delete from sintoma 
    where Id_sintoma = p_id_sintoma;
end //

-- 93. Filtra los síntomas según su nivel de severidad.
DELIMITER //
CREATE PROCEDURE Sintomas_MostrarPorSeveridad(IN p_nivel_severidad VARCHAR(50))
BEGIN
    SELECT *
    FROM Sintoma
    WHERE Nivel_Severidad = p_nivel_severidad;
END //


-- 94. Lista los síntomas según su tipo de intervención.
DELIMITER //
CREATE PROCEDURE Sintomas_MostrarPorTipoIntervencion(IN p_tipo_intervencion VARCHAR(100))
BEGIN
    SELECT *
    FROM Sintoma
    WHERE Tipo_Intervencion = p_tipo_intervencion;
END //


-- 95. Muestra los síntomas que tienen activado el requisito de monitoreo.
DELIMITER //
CREATE PROCEDURE Sintomas_MostrarQueRequierenMonitoreo()
BEGIN
    SELECT *
    FROM Sintoma
    WHERE Requiere_Monitoreo = 'Si';
END //


-- 96. Lista los síntomas que tienen registrado riesgo de secuelas.
DELIMITER //
CREATE PROCEDURE Sintomas_MostrarConRiesgoSecuela()
BEGIN
    SELECT *
    FROM Sintoma
    WHERE Riesgo_Secuela = 'Si';
END //

DELIMITER ;

24 procedimientos 

-- 97. Usuarios_MostrarTodos : muestra todos los usuarios registrados en el sistema.
delimiter $$
create procedure usuarios_mostrartodos()
begin
    select * from usuarios;
end $$


-- 98. Usuarios_BuscarPorID : busca un usuario mediante su identificador único.
delimiter $$
create procedure usuarios_buscarporid(in p_id int)
begin
    select * from usuarios
    where id = p_id;
end $$


-- 99. Usuarios_BuscarPorEmail : localiza un usuario mediante su correo electrónico.
delimiter $$
create procedure usuarios_buscarporemail(in p_email varchar(100))
begin
    select * from usuarios
    where email = p_email;
end $$


-- 100. Usuarios_Registrar : registra un nuevo usuario con su correo electrónico y contraseña almacenada.
delimiter $$
create procedure usuarios_registrar(
    in p_email varchar(100),
    in p_contrasena varchar(100)
)
begin
    insert into usuarios (email, `contraseña`)
    values (p_email, p_contrasena);
end $$


-- 101. Usuarios_ActualizarEmail : modifica el correo electrónico de un usuario.
delimiter $$
create procedure usuarios_actualizaremail(
    in p_id int,
    in p_email varchar(100)
)
begin
    update usuarios
    set email = p_email
    where id = p_id;
end $$


-- 102. Usuarios_ActualizarContrasena : actualiza la contraseña almacenada de un usuario.
delimiter $$
create procedure usuarios_actualizarcontrasena(
    in p_id int,
    in p_contrasena varchar(100)
)
begin
    update usuarios
    set `contraseña` = p_contrasena
    where id = p_id;
end $$


-- 103. Usuarios_Eliminar : elimina un usuario mediante su identificador único.
delimiter $$
create procedure usuarios_eliminar(in p_id int)
begin
    delete from usuarios
    where id = p_id;
end $$


-- 104. Usuarios_VerificarEmail : comprueba si existe una cuenta registrada con el correo electrónico indicado.
delimiter $$
create procedure usuarios_verificaremail(in p_email varchar(100))
begin
    select count(*) as cantidad
    from usuarios
    where email = p_email;
end $$


-- 105. Usuarios_ContarTotal : devuelve la cantidad total de usuarios registrados.
delimiter $$
create procedure usuarios_contartotal()
begin
    select count(*) as total_usuarios
    from usuarios;
end $$


-- 106. Pacientes_MostrarConHistorialMedico : muestra los pacientes junto con sus registros del historial médico, vinculados mediante el DNI.
delimiter $$
create procedure pacientes_mostrarconhistorialmedico()
begin
    select p.*, h.*
    from pacientes p
    left join historial_medico h
        on p.dni = h.dni_paciente;
end $$


-- 107. Pacientes_MostrarConTurnos : muestra los datos de los pacientes junto con sus turnos registrados.
delimiter $$
create procedure pacientes_mostrarconturnos()
begin
    select p.*, t.*
    from pacientes p
    left join turnos t
        on p.dni = t.codigo_paciente;
end $$


-- 108. Medicos_MostrarConTurnos : muestra los médicos junto con los turnos que tienen asignados.
delimiter $$
create procedure medicos_mostrarconturnos()
begin
    select m.*, t.*
    from medicos m
    left join turnos t
        on m.numero_matricula = t.matricula_medico;
end $$


-- 109. Turnos_MostrarConPacienteYMedico : muestra cada turno junto con los datos del paciente y del médico correspondientes.
delimiter $$
create procedure turnos_mostrarconpacienteymedico()
begin
    select t.*,
           p.nombre as nombre_paciente,
           p.apellido as apellido_paciente,
           m.nombre as nombre_medico,
           m.apellido as apellido_medico
    from turnos t
    left join pacientes p
        on t.codigo_paciente = p.dni
    left join medicos m
        on t.matricula_medico = m.numero_matricula;
end $$


-- 110. Historial_MostrarConMedico : muestra cada registro del historial médico junto con los datos del médico asociado.
delimiter $$
create procedure historial_mostrarconmedico()
begin
    select h.*, m.nombre as nombre_medico,
           m.apellido as apellido_medico,
           m.numero_matricula
    from historial_medico h
    left join medicos m
        on h.id_medico = m.numero_matricula;
end $$


-- 111. Historial_MostrarConEnfermedad : muestra los registros médicos acompañados del nombre y la categoría de la enfermedad asociada.
delimiter $$
create procedure historial_mostrarconenfermedad()
begin
    select h.*, e.nombre as nombre_enfermedad,
           e.categoria
    from historial_medico h
    left join enfermedades e
        on h.nombreDeLaEnfermedad = e.nombre;
end $$


-- 112. Historial_MostrarConMedicamento : muestra los registros médicos junto con los datos de los medicamentos asociados.
delimiter $$
create procedure historial_mostrarconmedicamento()
begin
    select h.*, m.id_medicamento,
           m.nombre as nombre_medicamento,
           m.tipo, m.forma_farmaceutica,
           m.via_administracion
    from historial_medico h
    left join medicamentos m
        on h.nombreMedicamento = m.nombre;
end $$


-- 113. Enfermedades_MostrarConMedicamentosAsociados : muestra las enfermedades y los medicamentos vinculados a sus registros médicos.
delimiter $$
create procedure enfermedades_mostrarconmedicamentosasociados()
begin
    select e.nombre as enfermedad,
           e.categoria,
           m.nombre as medicamento,
           m.tipo
    from enfermedades e
    left join historial_medico h
        on e.nombre = h.nombreDeLaEnfermedad
    left join medicamentos m
        on h.nombreMedicamento = m.nombre;
end $$


-- 114. Pacientes_ContarTurnos : muestra la cantidad de turnos registrados para cada paciente.
delimiter $$
create procedure pacientes_contarturnos()
begin
    select p.dni, p.nombre, p.apellido,
           count(t.id_turno) as cantidad_turnos
    from pacientes p
    left join turnos t
        on p.dni = t.codigo_paciente
    group by p.id_paciente, p.dni, p.nombre, p.apellido;
end $$


-- 115. Medicos_ContarTurnos : muestra la cantidad de turnos asignados a cada médico.
delimiter $$
create procedure medicos_contarturnos()
begin
    select m.numero_matricula, m.nombre, m.apellido,
           count(t.id_turno) as cantidad_turnos
    from medicos m
    left join turnos t
        on m.numero_matricula = t.matricula_medico
    group by m.id_medico, m.numero_matricula,
             m.nombre, m.apellido;
end $$


-- 116. Turnos_ContarPorEspecialidad : devuelve la cantidad de turnos registrados para cada especialidad.
delimiter $$
create procedure turnos_contarporespecialidad()
begin
    select especialidad,
           count(id_turno) as cantidad_turnos
    from turnos
    group by especialidad;
end $$


-- 117. Historial_ContarPorEnfermedad : muestra la cantidad de registros del historial asociados a cada enfermedad.
delimiter $$
create procedure historial_contarporenfermedad()
begin
    select e.nombre as enfermedad,
           count(h.id_historial) as cantidad_registros
    from enfermedades e
    left join historial_medico h
        on e.nombre = h.nombreDeLaEnfermedad
    group by e.id_enfermedad, e.nombre;
end $$


-- 118. Medicamentos_ContarPorTipo : muestra la cantidad de medicamentos registrados para cada tipo.
delimiter $$
create procedure medicamentos_contarportipo()
begin
    select tipo,
           count(id_medicamento) as cantidad_medicamentos
    from medicamentos
    group by tipo;
end $$


-- 119. Enfermedades_ContarPorCategoria : muestra la cantidad de enfermedades registradas en cada categoría.
delimiter $$
create procedure enfermedades_contarporcategoria()
begin
    select categoria,
           count(id_enfermedad) as cantidad_enfermedades
    from enfermedades
    group by categoria;
end $$


-- 120. Clinica_ResumenGeneral : muestra un resumen estadístico de la clínica con el total de pacientes, médicos, turnos, medicamentos, enfermedades, historiales y usuarios.
delimiter $$
create procedure clinica_resumengeneral()
begin
    select
        (select count(*) from pacientes) as total_pacientes,
        (select count(*) from medicos) as total_medicos,
        (select count(*) from turnos) as total_turnos,
        (select count(*) from medicamentos) as total_medicamentos,
        (select count(*) from enfermedades) as total_enfermedades,
        (select count(*) from historial_medico) as total_historiales,
        (select count(*) from usuarios) as total_usuarios;
end $$

delimiter ;
















