drop database if exists clinica_privada;
create database clinica_privada;
use clinica_privada;

-- Cambios para el Jframe : Cambie la tabla pacientes
create table especialidades (
    id_especialidad int auto_increment primary key,
    nombre varchar(50) unique,
    descripcion text
);

create table pacientes (
    id_paciente int primary key auto_increment,
    Nombre varchar(50),
    Apellido varchar(50),
    DNI int unique,
    Email varchar(50),
    Fecha_Nacimiento varchar(100),
    Direccion varchar(100),
    Genero varchar(20),
    Seguro_Medico varchar(50),    
    Numero_Afiliado varchar(50),
    Grupo_Sanguineo varchar(10),
    Lista_Historial varchar(500)
);

create table medicos (
    id_medico int primary key auto_increment,
	Nombre varchar(50),
    Apellido varchar(50),
    DNI int unique,
    Email varchar(50),
    Fecha_Nacimiento varchar(30),
    Direccion varchar(100),
    Genero varchar(20),
    Especialidad varchar(50),
    Numero_Matricula varchar(30) unique,
    Años_Experiencia int,
	foreign key (Especialidad) references especialidades(nombre)
);

create table turnos (
    id_turno int auto_increment primary key ,
    codigo_paciente int,
    nombre_completoMedico varchar(100),
    fecha_hora varchar(50),
    matricula_medico varchar(30),
    Especialidad varchar(30),
    sala int,
    estado varchar(20),
    motivoConsulta varchar(255),
    tipoTurno varchar(50),
    foreign key(codigo_paciente) references pacientes(DNI),
    foreign key (matricula_medico) references medicos(Numero_Matricula)

);

create table medicamentos (
    id_medicamento int auto_increment primary key ,
    nombre varchar(100) unique,
    grupo_anatomico varchar(100),
    tipo varchar(50),
    condicion_venta varchar(50),
    forma_farmaceutica varchar(50),
    Categoria_Subtipo varchar(50),
    Via_Administracion varchar(50),
    Dosis_Unidad varchar(50),
    dosis_cantidad int
);

create table enfermedades (
    id_enfermedad int auto_increment primary key ,
    nombre varchar(100) unique,
    descripcion varchar(100),
    categoria varchar(50),
    Lista_Sintomas varchar(100),
    Lista_Tratamientos varchar(100),
    observaciones varchar(100)
);

create table historial_medico (
    id_historial int primary key auto_increment,
    DNI_Paciente int not null,
    id_medico varchar(30),
	nombreDeLaEnfermedad varchar(100),
    nombreMedicamento varchar(100),
    fecha_cita varchar(100),
    peso int,
    altura int,
    razon_cita varchar(100),
    diagnostico varchar(100),
    lista_sintomas varchar(100),
    foreign key (id_medico) references medicos(Numero_Matricula),
    foreign key (nombreDeLaEnfermedad) references enfermedades(nombre),
    foreign key (nombreMedicamento) references medicamentos(nombre)
);

create table Usuarios(
	id int primary key auto_increment,
    Email varchar(100) not null,
    Contraseña varchar(100) not null
);

create table Sintoma(
    Id_sintoma int auto_increment primary key,
    Nombre varchar(100),
    Descripcion varchar(100),
    Durabilidad varchar(100),
    Caracteristicas_Tratamiento varchar(100),
    Cirujia varchar(20),
    Tratable varchar(20),
    Nivel_Severidad varchar(50),
    Escala_Dolor int,
    Requiere_Monitoreo varchar(20),
    Altera_Consciencia varchar(20),
    Riesgo_Secuela varchar(20),
    Tipo_Intervencion varchar(100)
);
create table Tratamiento(
    id_tratamiento int auto_increment primary key,
    nombre varchar(100) unique,
    tipo varchar(50),
    area varchar(50),
    detalles varchar(200),
    dias_duracion int,
    dias_reposo int,
    cantidad_sesiones int,
    costo int,
    requiere_internacion varchar(20),
    estado varchar(20),
    materiales varchar(200),
    medicamento varchar(100),
    enfermedad varchar(100),
    foreign key (medicamento) references medicamentos(nombre),
    foreign key (enfermedad) references enfermedades(nombre),
    foreign key (area) references especialidades(nombre)
);

INSERT INTO especialidades (nombre, descripcion) VALUES 
('Cardiologia', 'Estudio, diagnostico y tratamiento de enfermedades del corazon y del sistema circulatorio.'),
('Pediatria', 'Atencion medica de bebes, ninos y adolescentes.'),
('Clinica medica', 'Atencion integral del adulto, enfocada en el diagnostico y tratamiento no quirurgico.'),
('Traumatologia', 'Tratamiento de lesiones del aparato locomotor, como huesos, musculos y articulaciones.'),
('Dermatologia', 'Diagnostico y tratamiento de enfermedades de la piel, pelo y unas.'),
('Neurologia', 'Tratamiento de los trastornos del sistema nervioso central y periferico.'),
('Ginecologia', 'Cuidado del sistema reproductor femenino y la salud de la mujer.'),
('Oftalmologia', 'Diagnostico y tratamiento de enfermedades y trastornos oculares.'),
('Gastroenterologia', 'Enfermedades del aparato digestivo y organos asociados.'),
('Psiquiatria', 'Evaluacion, diagnostico y tratamiento de trastornos de la salud mental.'),
('Urologia', 'Tratamiento del sistema urinario y del aparato reproductor masculino.'),
('Otorrinolaringologia', 'Enfermedades del oido, nariz, laringe y estructuras del cuello.'),
('Endocrinologia', 'Estudio de las hormonas, el metabolismo y las glandulas endocrinas.'),
('Neumonologia', 'Diagnostico y tratamiento de las enfermedades del sistema respiratorio.'),
('Oncologia', 'Diagnostico y tratamiento medico del cancer.'),
('Reumatologia', 'Tratamiento de enfermedades medicas del tejido conectivo y del aparato locomotor.'),
('Nefrologia', 'Estudio de la estructura y funcion de los rinones y sus enfermedades.'),
('Hematologia', 'Estudio y tratamiento de las enfermedades de la sangre y organos hematopoyeticos.'),
('Infectologia', 'Diagnostico y tratamiento de enfermedades causadas por agentes infecciosos.'),
('Cirugia general', 'Tratamiento quirurgico de problemas abdominales, digestivos y de tejidos blandos.'),
('Cirugia plastica', 'Reparacion quirurgica de deformidades y cirugia estetica.'),
('Anestesiologia', 'Cuidado medico y aplicacion de anestesia antes, durante y despues de cirugias.'),
('Nutricion', 'Estudio de los alimentos y el asesoramiento dietetico para la salud y enfermedad.'),
('Kinesiologia', 'Evaluacion y rehabilitacion fisica a traves del movimiento corporal.'),
('Geriatria', 'Prevencion, diagnostico y tratamiento de las enfermedades de la vejez.');

insert into Sintoma (Nombre, Descripcion, Durabilidad, Caracteristicas_Tratamiento, Cirujia, Tratable, Nivel_Severidad, Escala_Dolor, Requiere_Monitoreo, Altera_Consciencia, Riesgo_Secuela, Tipo_Intervencion) VALUES 
('Fiebre', 'Elevacion de la temperatura corporal', 'Variable', 'Hidratacion, reposo y tratamiento segun la causa', 'No', 'Si', 'Leve', 2, 'No', 'No', 'No', 'Farmacologica'), 
('Migraña', 'Dolor de cabeza intenso que puede acompañarse de nauseas', 'Varias horas', 'Reposo y tratamiento indicado por un profesional', 'No', 'Si', 'Moderada', 7, 'No', 'No', 'No', 'Farmacologica'), 
('Dolor abdominal agudo', 'Dolor localizado en la region abdominal', 'Variable', 'Evaluacion medica para determinar la causa', 'No', 'Si', 'Grave', 8, 'Si', 'No', 'Si', 'Medica'), 
('Perdida de consciencia', 'Alteracion del estado de consciencia', 'Variable', 'Evaluacion urgente y control de signos vitales', 'No', 'Si', 'Grave', 0, 'Si', 'Si', 'Si', 'Urgente'), 
('Fractura expuesta', 'Fractura con comunicacion entre el hueso y el exterior', 'Semanas o meses', 'Evaluacion traumatologica y estabilizacion', 'Si', 'Si', 'Grave', 9, 'Si', 'No', 'Si', 'Quirurgica'), 
('Tos seca', 'Tos sin produccion significativa de mucosidad', 'Variable', 'Evaluacion de la causa y tratamiento segun indicacion medica', 'No', 'Si', 'Leve', 0, 'No', 'No', 'No', 'Medica');


insert into pacientes (Nombre, Apellido, DNI, Email, Fecha_Nacimiento, Direccion, Genero, Seguro_Medico, Numero_Afiliado, Grupo_Sanguineo, Lista_Historial) VALUES 
('Martin', 'Gonzalez', '38452114', 'gonzalezmartin94@gmail.com', '1994-04-18', 'Av Santa Fe 2345 4B', 'Masculino', 'OSDE', '210-44587-2', '0+', 'Hipertension, operado de apendicitis en 2018'), 
('Florencia', 'Rodriguez', '41223658', 'flor.rodriguez@hotmail.com', '1998-11-05', 'Rivadavia 812', 'Femenino', 'Swiss Medical', 'SM-445129', 'A+', 'Asma cronica de nacimiento. Usa paf'), 
('Jose Luis', 'Benitez', '24115887', 'joseluisbenitez@yahoo.com.ar', '1974-08-31', 'San Martin 550', 'Masculino', 'Particular', NULL, 'B-', 'Control anual de glucemia, padre diabetico'), 
('Maria Ines', 'Lopez', '17458963', 'marialopez45@gmail.com', '1964-01-12', 'Corrientes 4500 12A', 'Femenino', 'PAMI', '15502487963', '0-', 'Artrosis en la rodilla izquierda, toma analgesicos'), 
('Matias', 'Gomez', '45889123', 'matute_gomez@hotmail.com', '2004-06-22', 'Alvear 124', 'Masculino', 'Galeno', 'G-77412/5', 'AB+', 'Fractura de radio en 2022 por caida en moto, sin secuelas');


insert into medicos (id_medico, Nombre, Apellido, DNI, Email, Fecha_Nacimiento, Direccion, Genero, Especialidad, Numero_Matricula, Años_Experiencia) VALUES 
(1, 'Martin', 'Gonzalez', '30111222', 'martin.gonzalez@gmail.com', '1980-04-12', 'Av. Rivadavia 1250', 'Masculino', 'Cardiologia', 'MN-10234', 15), 
(2, 'Lucia', 'Fernandez', '32123456', 'lucia.fernandez@gmail.com', '1985-08-23', 'Belgrano 850', 'Femenino', 'Pediatria', 'MN-20456', 10), 
(3, 'Diego', 'Martinez', '28765432', 'diego.martinez@gmail.com', '1978-11-05', 'San Martin 430', 'Masculino', 'Clinica medica', 'MN-30567', 20), 
(4, 'Carolina', 'Lopez', '33456789', 'carolina.lopez@gmail.com', '1990-02-17', 'Mitre 720', 'Femenino', 'Traumatologia', 'MN-40678', 7), 
(5, 'Federico', 'Ramirez', '29876543', 'federico.ramirez@gmail.com', '1982-06-30', 'Sarmiento 1560', 'Masculino', 'Dermatologia', 'MN-50789', 12);

insert into turnos (id_turno, codigo_paciente, nombre_completoMedico, fecha_hora, matricula_medico, Especialidad, sala, estado, motivoConsulta, tipoTurno) VALUES 
(1, 38452114, 'Martin Gonzalez', '2026-10-12 09:00:00', 'MN-10234', 'Cardiologia', 101, 'Confirmado', 'Control general', 'Presencial'), 
(2, 41223658, 'Lucia Fernandez', '2026-10-12 10:30:00', 'MN-20456', 'Pediatria', 102, 'Pendiente', 'Revision', 'Presencial'), 
(3, 24115887, 'Diego Martinez', '2026-10-13 11:00:00', 'MN-30567', 'Clinica medica', 103, 'Confirmado', 'Dolor de estomago', 'Urgencia'), 
(4, 17458963, 'Carolina Lopez', '2026-10-13 14:00:00', 'MN-40678', 'Traumatologia', 104, 'Cancelado', 'Dolor de rodilla', 'Presencial'), 
(5, 45889123, 'Federico Ramirez', '2026-10-14 15:30:00', 'MN-50789', 'Dermatologia', 105, 'Confirmado', 'Mancha en la piel', 'Presencial');


insert into medicamentos (id_medicamento, nombre, grupo_anatomico, tipo, condicion_venta, forma_farmaceutica, Categoria_Subtipo, Via_Administracion, Dosis_Unidad, dosis_cantidad) VALUES 
(1, 'Paracetamol', 'Sistema nervioso', 'Analgesico', 'Venta libre', 'Comprimido', 'Analgesico', 'Oral', 'mg', 500), 
(2, 'Amoxicilina', 'Antiinfecciosos', 'Antibiotico', 'Bajo receta', 'Capsula', 'Penicilina', 'Oral', 'mg', 500), 
(3, 'Ibuprofeno', 'Sistema musculoesqueletico', 'Antiinflamatorio', 'Venta libre', 'Comprimido', 'AINE', 'Oral', 'mg', 400), 
(4, 'Loratadina', 'Sistema respiratorio', 'Antihistaminico', 'Venta libre', 'Comprimido', 'Antialergico', 'Oral', 'mg', 10), 
(5, 'Omeprazol', 'Tracto gastrointestinal', 'Antiulceroso', 'Bajo receta', 'Capsula', 'Inhibidor de bomba de protones', 'Oral', 'mg', 20);


insert into enfermedades (id_enfermedad, nombre, descripcion, categoria, Lista_Sintomas, Lista_Tratamientos, observaciones) VALUES 
(1, 'Hipertension arterial', 'Presion arterial elevada', 'Cardiovascular', 'Dolor de cabeza, mareos', 'Control medico, medicacion', 'Requiere controles periodicos'), 
(2, 'Gripe', 'Infeccion viral respiratoria', 'Infecciosa', 'Fiebre, tos, congestion', 'Reposo, hidratacion', 'Evitar contacto con personas vulnerables'), 
(3, 'Gastritis', 'Inflamacion de la mucosa gastrica', 'Digestiva', 'Dolor abdominal, nauseas', 'Evaluacion medica, dieta', 'Evitar alimentos irritantes'), 
(4, 'Dermatitis', 'Inflamacion de la piel', 'Dermatologica', 'Picazon, enrojecimiento', 'Tratamiento dermatologico', 'Controlar posibles irritantes'), 
(5, 'Lumbalgia', 'Dolor localizado en la zona lumbar', 'Musculoesqueletica', 'Dolor lumbar, rigidez', 'Evaluacion medica, rehabilitacion', 'Controlar la evolucion');

insert into Tratamiento (nombre, tipo, area, detalles, dias_duracion, dias_reposo, cantidad_sesiones, costo, requiere_internacion, estado, materiales, medicamento, enfermedad) VALUES
('Control de presion arterial', 'Farmacologico', 'Cardiologia', 'Control periodico y medicacion antihipertensiva', 30, 0, 1, 15000, 'No', 'Activo', 'Tensiometro', 'Paracetamol', 'Hipertension arterial'),
('Reposo e hidratacion', 'Farmacologico', 'Clinica medica', 'Reposo, hidratacion y control de la fiebre', 7, 5, 1, 8000, 'No', 'Activo', 'Termometro', 'Amoxicilina', 'Gripe'),
('Dieta y proteccion gastrica', 'Farmacologico', 'Clinica medica', 'Dieta blanda y protector gastrico', 21, 0, 2, 12000, 'No', 'Activo', 'Ninguno', 'Omeprazol', 'Gastritis'),
('Tratamiento dermatologico topico', 'Farmacologico', 'Dermatologia', 'Aplicacion de cremas y control de irritantes', 14, 0, 2, 20000, 'No', 'Activo', 'Cremas topicas', 'Loratadina', 'Dermatitis'),
('Rehabilitacion lumbar', 'Rehabilitacion', 'Traumatologia', 'Sesiones de kinesiologia y ejercicios posturales', 45, 3, 15, 90000, 'No', 'Activo', 'Camilla, bandas elasticas', 'Ibuprofeno', 'Lumbalgia');


insert into historial_medico (id_historial, DNI_Paciente, id_medico, nombreDeLaEnfermedad, nombreMedicamento, fecha_cita, peso, altura, razon_cita, diagnostico, lista_sintomas) VALUES 
(1, 38452114, 'MN-10234', 'Hipertension arterial', 'Paracetamol', '2026-10-05 09:00:00', 75, 175, 'Control de rutina', 'Presion arterial elevada', 'Dolor de cabeza intenso, mareos, vision borrosa'), 
(2, 41223658, 'MN-20456', 'Gripe', 'Amoxicilina', '2026-10-06 10:30:00', 60, 165, 'Fiebre and tos', 'Cuadro gripal', 'Fiebre alta, tos'), 
(3, 24115887, 'MN-30567', 'Gastritis', 'Ibuprofeno', '2026-10-07 11:00:00', 82, 178, 'Dolor estomacal', 'Gastritis', 'Dolor estomacal, nauseas'), 
(4, 45889123, 'MN-40678', 'Dermatitis', 'Loratadina', '2026-10-08 14:00:00', 68, 170, 'Picazon en la piel', 'Dermatitis', 'Picor, enrojecimiento'), 
(5, 17458963, 'MN-50789', 'Lumbalgia', 'Omeprazol', '2026-10-09 15:30:00', 80, 180, 'Dolor de espalda', 'Lumbalgia', 'Dolor agudo, inflamacion');

INSERT INTO Usuarios(id, Email, Contraseña) VALUES (1, 'admin@gmail.com', '1234');
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


-- 22. Pacientes_VerificarExistenciaEmail : comprueba si un correo electrónico ya está registrado.

DELIMITER //
create procedure Pacientes_VerificarExistenciaEmail(in P_Email varchar(50), out Respuesta Varchar(100))
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

-- 25. Medicos_MostrarTodos : muestra todos los médicos registrados.
Delimiter //
create procedure Medicos_MostrarTodos()
begin
	select *
    from medicos;
end //


-- 26. Medicos_BuscarPorID : busca un médico mediante su identificador único.
delimiter //
create procedure Medicos_BuscarPorID(in id int)
begin 
	select *
    from medicos
	where id_medico = id;
end //
 	
-- 27. Medicos_BuscarPorDNI : localiza un médico utilizando su número de documento.
delimiter //
create procedure Medicos_BuscarPorDNI(in MedicoDni int)
begin 
	select *
    from medicos
	where DNI = MedicoDni;
end //

-- 28. Medicos_BuscarPorNombre : busca médicos por su nombre.
delimiter //
create procedure Medicos_BuscarPorNombre(in medicoNombre varchar(100))
begin
	select *
    from medicos
    where Nombre = medicoNombre;
end //

-- 29. Medicos_BuscarPorApellido : muestra médicos que coinciden con un apellido determinado.
delimiter //
create procedure Medicos_BuscarPorApellido(in medicoApellido varchar(100))
begin		
	select *
    from medicos
    where Apellido = medicoApellido;
end //

-- 30. Medicos_BuscarPorEspecialidad : lista los médicos de una especialidad específica.
delimiter //
create procedure Medicos_BuscarPorEspecialidad(in medicoEspecialidad varchar(50))
begin
	select *
    from medicos
    where Especialidad = medicoEspecialidad;
end //

-- 31. Medicos_BuscarPorMatricula : busca un médico por su número de matrícula profesional.
Delimiter // 
create procedure Medicos_BuscarPorMatricula(in MedicoMatricula varchar(30))
begin 
	select * 
    from medicos
    where Numero_Matricula = MedicoMatricula;
end //

-- 32. Medicos_Registrar : registra un nuevo médico con sus datos personales y profesionales.
Delimiter //
CREATE PROCEDURE Medicos_Registrar(
    in p_Nombre varchar(50),
    in p_Apellido varchar(50),
    in p_DNI int,
    in p_Email varchar(50),
    in p_Fecha_Nacimiento varchar(30),
    in p_Direccion varchar(100),
    in p_Genero varchar(20),
    in p_Especialidad varchar(50),
    in p_Numero_Matricula varchar(30),
    in p_Anios_Experiencia int
)	
BEGIN
    INSERT INTO medicos (
        Nombre, 
        Apellido, 
        DNI, 
        Email, 
        Fecha_Nacimiento, 
        Direccion, 
        Genero, 
        Especialidad, 
        Numero_Matricula, 
        Años_Experiencia
    ) 
    VALUES (
        p_Nombre, 
        p_Apellido, 
        p_DNI, 
        p_Email, 
        p_Fecha_Nacimiento, 
        p_Direccion, 
        p_Genero, 
        p_Especialidad, 
        p_Numero_Matricula, 
        p_Anios_Experiencia
    );
END //



-- 33. Medicos_ActualizarDatos : modifica los datos personales y profesionales de un médico.
	
DELIMITER //
create procedure Medicos_ActualizarDatos(in p_id_medico int, in p_Nombre VARCHAR(50),
    in p_Apellido varchar(50),
    in p_DNI int,
    in p_Email varchar(50),
    in p_Fecha_Nacimiento varchar(30),
    in p_Direccion varchar(100),
    in p_Genero varchar(20),
    in p_Especialidad varchar(50),
    in p_Numero_Matricula varchar(30),
    in p_Anios_Experiencia int)
begin
	update Medicos
    set	Nombre = p_Nombre,
        Apellido = p_Apellido,
        DNI = p_DNI,
        Email = p_Email,
        Fecha_Nacimiento = p_Fecha_Nacimiento,
        Direccion = p_Direccion,
        Genero = p_Genero,
        Especialidad = p_Especialidad,
        Numero_Matricula = p_Numero_Matricula,
        Años_Experiencia = p_Anios_Experiencia
		where id_medico = p_id_medico;
end //

-- 34. Medicos_Eliminar : elimina un médico cuando no existen restricciones por relaciones con otras tablas.
DELIMITER //
create procedure Medicos_Eliminar(in MedicoId int)
begin
	Delete from Medicos
    where id_medico = MedicoId;
end //

-- 35. Medicos_ContarTotal : devuelve la cantidad total de médicos registrados.
DELIMITER //
create procedure Medicos_ContarTotal()
begin
	select count(*) from medicos;
end //
delimiter ;

-- 36. Medicos_ActualizarEspecialidad : modifica la especialidad de un médico.
delimiter // 
create procedure Medicos_ActualizarEspecialidad (in p_id_medico INT, in p_NuevaEspecialidad VARCHAR(50))
begin
    update medicos
    set Especialidad = p_NuevaEspecialidad
    where id_medico = p_id_medico;
end //

-- 37. Medicos_ActualizarMatricula : actualiza el número de matrícula de un médico.
delimiter //
create procedure Medicos_ActualizarMatricula (in p_id_medico int, in p_nuevaMatricula VARCHAR(50))
begin
    update medicos
    set Numero_Matricula = p_nuevaMatricula
    where id_medico = p_id_medico;
end //


-- 38. Medicos_MostrarOrdenadosPorApellido : muestra los médicos ordenados alfabéticamente por apellido.
delimiter //
create procedure Medicos_MostrarOrdenadosPorApellido()
begin
    select *
    from medicos
    order by Apellido asc;
end //

-- 39. Medicos_BuscarPorEmail : localiza un médico utilizando su correo electrónico.
	delimiter //
create procedure Medicos_BuscarPorEmail(in gmailMedico varchar(100))
begin 
	select *
    from medicos
	where Email  = gmailMedico;
end //

	
-- 40. Turnos_MostrarTodos : muestra todos los turnos registrados.
delimiter //
create procedure Turnos_MostrarTodos ()
begin
	select *
    from turnos;
end //

-- 41. Turnos_BuscarPorID : busca un turno mediante su identificador único.
delimiter //
create procedure Turnos_BuscarPorID(in idTurno int)
begin 
	select *
    from turnos
	where id_turno = idTurno;
end //



-- 42. Turnos_Registrar : registra un turno asociando un paciente con un médico.
delimiter //

create procedure Turnos_Registrar(
    in p_codigo_paciente int,
    in p_nombre_completoMedico varchar(100),
    in p_fecha_hora varchar(50),
    in p_matricula_medico varchar(30),
    in p_Especialidad varchar(30),
    in p_sala int,
    in p_estado varchar(20),
    in p_motivoConsulta varchar(255),
    in p_tipoTurno varchar(50)
)
begin
    insert into turnos (
        codigo_paciente, 
        nombre_completoMedico, 
        fecha_hora, 
        matricula_medico, 
        Especialidad, 
        sala, 
        estado, 
        motivoConsulta, 
        tipoTurno
    ) 
    values (
        p_codigo_paciente, 
        p_nombre_completoMedico, 
        p_fecha_hora, 
        p_matricula_medico, 
        p_Especialidad, 
        p_sala, 
        p_estado, 
        p_motivoConsulta, 
        p_tipoTurno
    );
end //


-- 43. Turnos_Actualizar : modifica la información de un turno existente.
delimiter //
create procedure Turnos_Actualizar(
    in p_id_turno int,
    in p_codigo_paciente int,
    in p_nombre_completoMedico varchar(100),
    in p_fecha_hora varchar(50),
    in p_matricula_medico varchar(30),
    in p_Especialidad varchar(30),
    in p_sala int,
    in p_estado varchar(20),
    in p_motivoConsulta varchar(255),
    in p_tipoTurno varchar(50)
)
begin
    update turnos
    set codigo_paciente = p_codigo_paciente,
        nombre_completoMedico = p_nombre_completoMedico,
        fecha_hora = p_fecha_hora,
        matricula_medico = p_matricula_medico,
        Especialidad = p_Especialidad,
        sala = p_sala,
        estado = p_estado,
        motivoConsulta = p_motivoConsulta,
        tipoTurno = p_tipoTurno
    where id_turno = p_id_turno;
end //
-- 44. Turnos_Eliminar : elimina un turno identificado por su ID.
delimiter // 
    create procedure Turnos_Eliminar(in idTurno int)
    begin
		delete from turnos
        where id_turno = idTurno;
end //    
        
-- 45. Turnos_MostrarPorPaciente : muestra los turnos asociados a un paciente determinado.
delimiter //
create procedure Turnos_MostrarPorPaciente (in dniPaciente int)
begin
	select *
    from turnos 
    where codigo_paciente = dniPaciente;
end//
-- 46. Turnos_MostrarPorMedico : lista los turnos asignados a un médico específico.
delimiter //
	create procedure Turnos_MostrarPorMedico (in matriculadelmedico varchar(50))
begin 
	select *
    from turnos
    where matricula_medico = matriculadelmedico;
end //

-- 47. Turnos_MostrarPorFecha : muestra los turnos correspondientes a una fecha determinada.
delimiter //
create procedure Turnos_MostrarPorFecha (in turno_fecha_buscar varchar(50))
begin
    select *
    from turnos 
    where fecha_hora = turno_fecha_buscar;
end //



-- 48. Turnos_MostrarPorEspecialidad : lista los turnos correspondientes a una especialidad médica.
delimiter //
create procedure Turnos_MostrarPorEspecialidad (in TurnoPorEspecialidad varchar(50))
begin
	select *
    from turnos
where Especialidad = TurnoPorEspecialidad;
end //

-- Turnos_mostrarPorCOdigo_PACIENTE: lista los turnos por el codigo del paciente
delimiter //

create procedure Turnos_mostrarPorCOdigo_PACIENTE(in dnipaciente int)
begin
    select * 
    from turnos 
    where codigo_paciente = dnipaciente;
end //

-- 1. Mostrar Todos

DELIMITER //
CREATE PROCEDURE tratamientos_mostrartodos()
BEGIN
    SELECT * FROM Tratamiento;
END //
DELIMITER ;

-- 2. Buscar Por Nombre

DELIMITER //
CREATE PROCEDURE tratamientos_buscarpornombre(IN p_nombre VARCHAR(100))
BEGIN
    SELECT * FROM Tratamiento WHERE nombre = p_nombre;
END //
DELIMITER ;

-- 3. Registrar

DELIMITER //
CREATE PROCEDURE tratamientos_registrar(
    IN p_nombre VARCHAR(100),
    IN p_tipo VARCHAR(50),
    IN p_area VARCHAR(50),
    IN p_detalles TEXT,
    IN p_dias_duracion INT,
    IN p_dias_reposo INT,
    IN p_cantidad_sesiones INT,
    IN p_costo INT,
    IN p_requiere_internacion VARCHAR(20),
    IN p_estado VARCHAR(50),
    IN p_materiales TEXT,
    IN p_medicamento VARCHAR(100),
    IN p_enfermedad VARCHAR(100)
)
BEGIN
    INSERT INTO Tratamiento (nombre, tipo, area, detalles, dias_duracion, dias_reposo, cantidad_sesiones, costo, requiere_internacion, estado, materiales, medicamento, enfermedad)
    VALUES (p_nombre, p_tipo, p_area, p_detalles, p_dias_duracion, p_dias_reposo, p_cantidad_sesiones, p_costo, p_requiere_internacion, p_estado, p_materiales, p_medicamento, p_enfermedad);
END //
DELIMITER ;

-- 4. Actualizar

DELIMITER //
CREATE PROCEDURE tratamientos_actualizar(
    IN p_id_tratamiento INT,
    IN p_nombre VARCHAR(100),
    IN p_tipo VARCHAR(50),
    IN p_area VARCHAR(50),
    IN p_detalles TEXT,
    IN p_dias_duracion INT,
    IN p_dias_reposo INT,
    IN p_cantidad_sesiones INT,
    IN p_costo INT,
    IN p_requiere_internacion VARCHAR(20),
    IN p_estado VARCHAR(50),
    IN p_materiales TEXT,
    IN p_medicamento VARCHAR(100),
    IN p_enfermedad VARCHAR(100)
)
BEGIN
    UPDATE Tratamiento 
    SET nombre = p_nombre, 
        tipo = p_tipo, 
        area = p_area, 
        detalles = p_detalles, 
        dias_duracion = p_dias_duracion, 
        dias_reposo = p_dias_reposo, 
        cantidad_sesiones = p_cantidad_sesiones, 
        costo = p_costo, 
        requiere_internacion = p_requiere_internacion, 
        estado = p_estado, 
        materiales = p_materiales, 
        medicamento = p_medicamento, 
        enfermedad = p_enfermedad 
    WHERE id_tratamiento = p_id_tratamiento;
END //
DELIMITER ;

-- 5. Eliminar
DELIMITER //
CREATE PROCEDURE tratamientos_eliminar(IN p_id_tratamiento INT)
BEGIN
    DELETE FROM Tratamiento WHERE id_tratamiento = p_id_tratamiento;
END //
DELIMITER ;	

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



ALTER TABLE turnos DROP FOREIGN KEY turnos_ibfk_1;

select * from turnos;


/*Vistas*/
-- Vistas Paciente

-- 1. Vista general de pacientes activos con su edad actual calculada
CREATE VIEW Vista_Pacientes_Edad as
select 
	id_paciente,
    Nombre,
    Apellido,
     FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) AS edad
from pacientes;
select * from Vista_Pacientes_Edad;
-- 2. Directorio de contacto para administración (sin datos médicos)

create view Vista_pacientes_Contacto as
select
	id_paciente,
    Nombre,
    Apellido,
    DNI,
    seguro_medico,
    numero_afiliado
from pacientes;
select * from Vista_pacientes_Contacto;

-- 3. Listado de pacientes ordenados por Obra Social / Prepaga

create view Vista_pacientes_Obra_Social as
select
	id_paciente,
    Nombre,
    Apellido,
    DNI,
    Seguro_Medico,
    Numero_Afiliado
from pacientes
where Seguro_Medico is not null;
select * from Vista_pacientes_Obra_Social;

-- 4. Pacientes de la tercera edad (Para campañas de vacunación o geriatría)

CREATE VIEW Vista_Pacientes_3ra_Edad as
select 
	id_paciente,
    Nombre,
    Apellido,
	FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) AS edad
from pacientes
where FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) > 65;
select * from Vista_Pacientes_3ra_Edad;

-- 5. Pacientes menores de edad (Para el sector de pediatría)

CREATE VIEW Vista_Pacientes_Menor_Edad as
select 
	id_paciente,
    Nombre,
    Apellido,
	FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) AS edad
from pacientes
where FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) < 18;
select * from Vista_Pacientes_Menor_Edad;

-- 6. Pacientes sin Cobertura Médica (Particulares)

create view Vista_pacientes_Particulares as
select
	id_paciente,
    Nombre,
    Apellido,
    DNI,
    Seguro_Medico,
    Numero_Afiliado
from pacientes
where Seguro_Medico is null;
select * from Vista_pacientes_Particulares;

-- 7. Listado rápido para emergencias (Grupo Sanguíneo)

create view Vista_pacientes_Emergencias as
select
	Grupo_sanguineo,
    Nombre,
    Apellido,
    DNI,
    Seguro_Medico
from pacientes;

select * from Vista_pacientes_Emergencias;

-- 8. Pacientes y su lista de Historiales Medicos.

create view Vista_pacientes_Lista_Historial as
select
	id_paciente,
    Nombre,
    Apellido,
    Lista_Historial
from pacientes;
select * from Vista_pacientes_Lista_Historial;

-- 9. Resumen demográfico por Género

create view Vista_pacientes_Genero as
select
	count(genero)
from pacientes
group by genero ;
select * from Vista_pacientes_Genero;

-- 10. Pacientes con Edad Laboral.

CREATE VIEW vista_pacientes_edad_laboral AS
SELECT 
	id_paciente, 
    nombre, 
    apellido, 
	FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) AS edad, 
	email, 
    seguro_medico
FROM pacientes
WHERE FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento) / 365.25) BETWEEN 18 AND 65;

-- Vistas Especialidades.

-- 1 ) Vista total de las Especialidades.

Create view Vista_Total_Especialidades as
select 
	*
from especialidades;
select * from Vista_Total_Especialidades;

-- 2 ) Vista completa de especialidades y cantidad de estas.

Create view Vista_Cantidad_Especialidades as
select 
	Nombre,
    count(*)
from especialidades
group by Nombre;
select * from Vista_Cantidad_Especialidades;

-- 1. une las tablas turnos y pacientes para mostrar en una tabla del jframe la agenda completa con nombres legibles en lugar de solo codigos.
create view vista_agenda_turnos_detallada as
select 
    t.id_turno,
    t.fecha_hora,
    p.dni as dni_paciente,
    concat(p.nombre, ' ', p.apellido) as paciente_nombre,
    t.nombre_completomedico as medico_nombre,
    t.matricula_medico,
    t.especialidad,
    t.sala,
    t.estado,
    t.tipoturno
from turnos t
inner join pacientes p on t.codigo_paciente = p.dni;

-- 2. filtra los turnos buscando las fechas que coincidan con el texto del dia actual.
create view vista_turnos_hoy as
select id_turno, fecha_hora, codigo_paciente, nombre_completomedico, sala, estado, tipoturno
from turnos
where fecha_hora like concat(curdate(), '%');

-- 3. muestra unicamente los turnos que estan pendientes o activos, facilitando la fila de espera de los medicos.
create view vista_turnos_pendientes as
select id_turno, fecha_hora, codigo_paciente, nombre_completomedico, especialidad, sala, motivoconsulta
from turnos
where estado = 'pendiente' or estado = 'activo';

-- 4. ordena a todos los profesionales medicos segun sus años de experiencia de mayor a menor para analisis interno.
create view vista_medicos_por_experiencia as
select id_medico, nombre, apellido, especialidad, numero_matricula, años_experiencia
from medicos
order by años_experiencia desc;

-- 5. lista los medicos agrupados por su especialidad medica y ordenados alfabeticamente para filtros de busqueda en la interfaz.
create view vista_medicos_por_especialidad as
select especialidad, id_medico, nombre, apellido, numero_matricula, email
from medicos
order by especialidad, apellido;

-- 6. calcula cuantos turnos vigentes estan asignados a cada sala para controlar la saturacion de los espacios de la clinica.
create view vista_ocupacion_salas as
select sala, count(*) as turnos_asignados
from turnos
where estado = 'pendiente' or estado = 'activo'
group by sala;

-- 7. aisla los turnos que no se concretaron por cancelacion o inasistencia para evaluar estadisticas de ausentismo.
create view vista_turnos_cancelados_o_ausentes as
select id_turno, fecha_hora, codigo_paciente, nombre_completomedico, estado, motivoconsulta
from turnos
where estado in ('cancelado', 'ausente');

-- 8. cuenta la cantidad total de turnos que ha solicitado cada paciente para identificar a los usuarios mas recurrentes.
create view vista_frecuencia_turnos_pacientes as
select codigo_paciente, count(*) as total_turnos
from turnos
group by codigo_paciente;

-- 9. provee una libreta de direcciones basica con el correo y ubicacion de los medicos que tienen un email valido registrado.
create view vista_medicos_contacto as
select id_medico, concat(apellido, ', ', nombre) as medico, email, direccion
from medicos
where email is not null and email like '%@%';

-- 10. totaliza los turnos segun su modalidad (presencial, virtual) y su estado actual para reportes de gestion clinica.
create view vista_resumen_tipo_turno as
select tipoturno, count(*) as cantidad, estado
from turnos
group by tipoturno, estado;

-- SINTOMA

-- 1. Mostrar todos los sintomas
CREATE VIEW vista_todos_sintomas AS
SELECT * FROM Sintoma;

-- 2. Mostrar nombre y descripcion de los sintomas
CREATE VIEW vista_nombre_descripcion_sintomas AS
SELECT Nombre, Descripcion
FROM Sintoma;

-- 3. Mostrar sintomas que requieren cirugia
CREATE VIEW vista_sintomas_con_cirugia AS
SELECT *
FROM Sintoma
WHERE Cirujia = 'Si';

-- 4. Mostrar sintomas tratables
CREATE VIEW vista_sintomas_tratables AS
SELECT *
FROM Sintoma
WHERE Tratable = 'Si';

-- 5. Mostrar sintomas graves
CREATE VIEW vista_sintomas_graves AS
SELECT Nombre, Descripcion, Nivel_Severidad
FROM Sintoma
WHERE Nivel_Severidad = 'Grave';

-- 6. Mostrar sintomas con escala de dolor alta
CREATE VIEW vista_sintomas_dolor_alto AS
SELECT Nombre, Escala_Dolor, Nivel_Severidad
FROM Sintoma
WHERE Escala_Dolor >= 7;

-- 7. Mostrar sintomas que requieren monitoreo
CREATE VIEW vista_sintomas_monitoreo AS
SELECT Nombre, Descripcion, Requiere_Monitoreo
FROM Sintoma
WHERE Requiere_Monitoreo = 'Si';

-- 8. Mostrar sintomas que alteran la consciencia
CREATE VIEW vista_sintomas_alteran_consciencia AS
SELECT Nombre, Descripcion, Altera_Consciencia
FROM Sintoma
WHERE Altera_Consciencia = 'Si';

-- 9. Mostrar sintomas con riesgo de secuelas
CREATE VIEW vista_sintomas_con_secuelas AS
SELECT Nombre, Descripcion, Riesgo_Secuela
FROM Sintoma
WHERE Riesgo_Secuela = 'Si';

-- 10. Mostrar sintomas segun su tipo de intervencion
CREATE VIEW vista_sintomas_por_intervencion AS
SELECT Nombre, Nivel_Severidad, Tipo_Intervencion
FROM Sintoma;


-- TRATAMIENTO

-- 1. Mostrar todos los tratamientos
CREATE VIEW vista_todos_tratamientos AS
SELECT * FROM Tratamiento;

-- 2. Mostrar nombre, tipo y area de los tratamientos
CREATE VIEW vista_nombre_tipo_area_tratamientos AS
SELECT nombre, tipo, area
FROM Tratamiento;

-- 3. Mostrar tratamientos activos
CREATE VIEW vista_tratamientos_activos AS
SELECT *
FROM Tratamiento
WHERE estado = 'Activo';

-- 4. Mostrar tratamientos que requieren internacion
CREATE VIEW vista_tratamientos_con_internacion AS
SELECT nombre, detalles, requiere_internacion
FROM Tratamiento
WHERE requiere_internacion = 'Si';

-- 5. Mostrar tratamientos con un costo mayor a 20000
CREATE VIEW vista_tratamientos_costosos AS
SELECT nombre, tipo, costo
FROM Tratamiento
WHERE costo > 20000;

-- 6. Mostrar tratamientos con una duracion mayor a 30 dias
CREATE VIEW vista_tratamientos_largos AS
SELECT nombre, dias_duracion, dias_reposo
FROM Tratamiento
WHERE dias_duracion > 30;

-- 7. Mostrar tratamientos con mas de 5 sesiones
CREATE VIEW vista_tratamientos_muchas_sesiones AS
SELECT nombre, cantidad_sesiones, area
FROM Tratamiento
WHERE cantidad_sesiones > 5;

-- 8. Mostrar tratamientos farmacologicos
CREATE VIEW vista_tratamientos_farmacologicos AS
SELECT nombre, tipo, medicamento, enfermedad
FROM Tratamiento
WHERE tipo = 'Farmacologico';

-- 9. Mostrar tratamientos asociados a una enfermedad
CREATE VIEW vista_tratamientos_por_enfermedad AS
SELECT nombre, enfermedad, detalles
FROM Tratamiento
WHERE enfermedad IS NOT NULL;

-- 10. Mostrar tratamientos con su medicamento y costo
CREATE VIEW vista_tratamientos_medicamentos_costos AS
SELECT nombre, medicamento, costo
FROM Tratamiento;

-- Tabla historial_medico

-- 1. Mostrar todos los historiales médicos
CREATE VIEW VW_Historial_Todos AS
SELECT *
FROM historial_medico;


-- 2. Mostrar los datos básicos de cada historial
CREATE VIEW VW_Historial_DatosBasicos AS
SELECT id_historial, DNI_Paciente, id_medico, fecha_cita
FROM historial_medico;


-- 3. Mostrar los diagnósticos de los pacientes
CREATE VIEW VW_Historial_Diagnosticos AS
SELECT id_historial, DNI_Paciente, nombreDeLaEnfermedad, diagnostico
FROM historial_medico;


-- 4. Mostrar los medicamentos recetados
CREATE VIEW VW_Historial_Medicamentos AS
SELECT id_historial, DNI_Paciente, nombreMedicamento
FROM historial_medico;


-- 5. Mostrar los síntomas de cada paciente
CREATE VIEW VW_Historial_Sintomas AS
SELECT id_historial, DNI_Paciente, lista_sintomas
FROM historial_medico;


-- 6. Mostrar los historiales de pacientes atendidos por cada médico
CREATE VIEW VW_Historial_PorMedico AS
SELECT h.id_historial, h.DNI_Paciente,
       h.id_medico, m.Nombre, m.Apellido,
       h.diagnostico
FROM historial_medico h
INNER JOIN medicos m
ON h.id_medico = m.Numero_Matricula;


-- 7. Mostrar el historial junto con el nombre del paciente
CREATE VIEW VW_Historial_NombrePaciente AS
SELECT h.id_historial, h.DNI_Paciente,
       p.Nombre, p.Apellido,
       h.nombreDeLaEnfermedad, h.diagnostico
FROM historial_medico h
INNER JOIN pacientes p
ON h.DNI_Paciente = p.DNI;


-- 8. Mostrar historiales con enfermedades y medicamentos
CREATE VIEW VW_Historial_EnfermedadesMedicamentos AS
SELECT id_historial, DNI_Paciente,
       nombreDeLaEnfermedad, nombreMedicamento
FROM historial_medico;


-- 9. Mostrar el peso y la altura de cada paciente
CREATE VIEW VW_Historial_MedidasPaciente AS
SELECT id_historial, DNI_Paciente, peso, altura
FROM historial_medico;


-- 10. Mostrar los motivos de consulta y fechas de atención
CREATE VIEW VW_Historial_Consultas AS
SELECT id_historial, DNI_Paciente,
       fecha_cita, razon_cita, diagnostico
FROM historial_medico;



-- Tabla Usuarios

-- 1. Mostrar todos los usuarios registrados
CREATE VIEW VW_Usuarios_Todos AS
SELECT *
FROM Usuarios;


-- 2. Mostrar los identificadores de los usuarios
CREATE VIEW VW_Usuarios_ID AS
SELECT id
FROM Usuarios;


-- 3. Mostrar los correos electrónicos registrados
CREATE VIEW VW_Usuarios_Correos AS
SELECT id, Email
FROM Usuarios;


-- 4. Mostrar los usuarios administradores
CREATE VIEW VW_Usuarios_Administrador AS
SELECT id, Email
FROM Usuarios
WHERE Email = 'admin@gmail.com';


-- 5. Mostrar los usuarios que no son administradores
CREATE VIEW VW_Usuarios_NoAdministradores AS
SELECT id, Email
FROM Usuarios
WHERE Email <> 'admin@gmail.com';


-- 6. Mostrar los usuarios cuyo correo pertenece a Gmail
CREATE VIEW VW_Usuarios_Gmail AS
SELECT id, Email
FROM Usuarios
WHERE Email LIKE '%@gmail.com';


-- 7. Mostrar los usuarios cuyo correo pertenece a Hotmail
CREATE VIEW VW_Usuarios_Hotmail AS
SELECT id, Email
FROM Usuarios
WHERE Email LIKE '%@hotmail.com';


-- 8. Mostrar la cantidad total de usuarios
CREATE VIEW VW_Usuarios_Cantidad AS
SELECT COUNT(*) AS Cantidad_Usuarios
FROM Usuarios;


-- 9. Mostrar los usuarios ordenados por ID
CREATE VIEW VW_Usuarios_Ordenados AS
SELECT id, Email
FROM Usuarios
ORDER BY id ASC;


-- 10. Mostrar los usuarios con correo electrónico que contiene una letra específica
CREATE VIEW VW_Usuarios_BusquedaCorreo AS
SELECT id, Email
FROM Usuarios
WHERE Email LIKE '%a%';





-- Triggers

-- Triggers Paciente : 

-- 1 ) Nombre con Numeros : 
delimiter //
create trigger Pacientes_Con_Nombre_Numeros
Before insert on pacientes
for each row
begin
	if new.Nombre regexp '[0-9]' then 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El nombre del paciente no puede contener números.';
	end if;
end //
delimiter ;

-- 2 ) Apellido con Numeros : 
delimiter //
create trigger Pacientes_Con_Apellido_Numeros
Before insert on pacientes
for each row
begin
	if new.Apellido regexp '[0-9]' then 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El apellido del paciente no puede contener números.';
	end if;
end //
delimiter ;

-- 3 ) DNI Correcto

delimiter //
create trigger DNI_Correcto
Before insert on pacientes
for each row
begin
	if new.DNI < 1000000 or new.DNI >99999999 then 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El DNI ingresado no es valido, trate de nuevo.';
	end if;
end //
delimiter ;

-- 4 ) Email Correcto 

delimiter //
create trigger Email_Correcto
Before insert on pacientes
for each row
begin
	if NEW.Email NOT REGEXP '[@]+[a-z]' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El Gmail ingresado no tiene sentido';
	end if;
end //
delimiter ;

-- 5 ) Grupo sanguineo Correcto

delimiter //
create trigger Grupo_Sanguineo_Correcto
Before insert on pacientes
for each row
begin
	 IF NEW.Grupo_Sanguineo NOT IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Grupo sanguíneo no válido. Use valores como A+, O-, AB+, etc.';
    END IF;
end //
delimiter ;

-- 6 ) Genero Fijo

delimiter //
create trigger Genero_Fijo
Before insert on pacientes
for each row
begin
	 IF NEW.Genero NOT IN ('masculino','femenino','otro','Masculino','Femenino','Otro') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Genero no valido, pruebe ingresando : Masculino,Femenino,Otro';
    END IF;
end //
delimiter ;

-- 7 ) Numero afiliado Correcto.

delimiter //
create trigger Numero_Afiliado_Correcto
Before insert on pacientes
for each row
begin
	 IF NEW.Numero_Afiliado REGEXP '[a-z]' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El numero afiliado no lleva letras.';
    END IF;
end //
delimiter ;

-- 8 ) ACtualizar DNI Paciente no 
DELIMITER //
CREATE TRIGGER Pacientes_Actualizar_DNI
BEFORE UPDATE ON pacientes
FOR EACH ROW
BEGIN
    IF NEW.DNI <> OLD.DNI THEN -- tengo entendido que el <> indica si se cambia
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de seguridad: El DNI de un paciente no puede ser modificado.';
    END IF;
END //
DELIMITER ;

-- 9) ACtualizar Grupo Sanguineo Paciente 
DELIMITER //
CREATE TRIGGER Pacientes_Actualizar_Grupo_Sanguineo
BEFORE UPDATE ON pacientes
FOR EACH ROW
BEGIN
    IF NEW.Grupo_Sanguineo <> OLD.Grupo_Sanguineo THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de seguridad: El grupo sanguíneo no puede alterarse por riesgo médico.';
    END IF;
END //
DELIMITER ;

-- 10 ) Actualizar Fecha_Nacimiento
DELIMITER //
CREATE TRIGGER tg_pacientes_bloquear_datos_criticos
BEFORE UPDATE ON pacientes
FOR EACH ROW
BEGIN
    IF NEW.Fecha_Nacimiento <> OLD.Fecha_Nacimiento THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de seguridad: No se puede actualizar la fecha de nacimiento de un paciente.';
    END IF;
END //
DELIMITER ;

-- 1 ) Trigger de especialidad no valida
delimiter //
create trigger Nombre_No_Valido_Especialidad
before insert on especialidades
for each row
begin
	if new.nombre REGEXP '[0-9]' then 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El nombre de uan especialidad no puede contener numeros.';
	end if;
end //
delimiter ; 

-- 1. Forzar primera letra en mayúscula y el resto en minúscula (Formato Nombre Propio)
delimiter //
CREATE TRIGGER Trg_Enf_Formato_Nombre BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    SET NEW.nombre = CONCAT(UPPER(SUBSTRING(NEW.nombre,1,1)), LOWER(SUBSTRING(NEW.nombre,2)));
END //
delimiter ;

-- 2. Impedir registrar nombres vacíos en las patologías
delimiter //
CREATE TRIGGER Trg_Enf_Prevenir_Vacio BEFORE INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    IF NEW.nombre = '' OR NEW.nombre IS NULL THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La enfermedad debe tener un nombre válido.';
    END IF;
END //
delimiter ;

-- 3. Auditoría automática al agregar una nueva patología al sistema
delimiter //
CREATE TRIGGER Trg_Enf_Log_Insercion AFTER INSERT ON Enfermedades
FOR EACH ROW 
BEGIN
    INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Nueva patología añadida: ', NEW.nombre));
END //
delimiter ;



-- 6. Logear cambios de nombre en enfermedades (Evitar confusiones de diagnóstico)
delimiter //
CREATE TRIGGER Trg_Enf_Log_Modificacion AFTER UPDATE ON Enfermedades
FOR EACH ROW 
BEGIN
    IF OLD.nombre <> NEW.nombre THEN
        INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Corrección de diagnóstico: ', OLD.nombre, ' ahora se llama ', NEW.nombre));
    END IF;
END //
delimiter ;



-- 9. Registrar en auditoría cuando una enfermedad es dada de baja del catálogo
delimiter //
CREATE TRIGGER Trg_Enf_Log_Eliminar AFTER DELETE ON Enfermedades
FOR EACH ROW 
BEGIN
    INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Enfermedad eliminada del catálogo: ', OLD.nombre));
END //
delimiter ;


-- 1. Estandarizar nombre a MAYÚSCULAS antes de guardar
delimiter //
CREATE TRIGGER Trg_Med_Nombre_Mayuscula BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN
    SET NEW.nombre = UPPER(NEW.nombre);
END //
delimiter ;







-- 7. Guardar un log histórico cuando un medicamento se elimina por completo
delimiter //
CREATE TRIGGER Trg_Med_Log_Eliminacion AFTER DELETE ON Medicamentos
FOR EACH ROW 
BEGIN
    INSERT INTO Log_Auditoria (accion) VALUES (CONCAT('Eliminado físicamente el medicamento: ', OLD.nombre));
END //
delimiter ;

-- 8. Validar longitud mínima del nombre del medicamento (Evitar errores como "X")
delimiter //
CREATE TRIGGER Trg_Med_Validar_Longitud BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN
    IF LENGTH(NEW.nombre) < 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del medicamento es demasiado corto.';
    END IF;
END //
delimiter ;


-- 10. Colocar un tipo por defecto si el campo viene vacío
delimiter //
CREATE TRIGGER Trg_Med_Tipo_Defecto BEFORE INSERT ON Medicamentos
FOR EACH ROW 
BEGIN
    IF NEW.tipo IS NULL OR NEW.tipo = '' THEN 
        SET NEW.tipo = 'General'; 
    END IF;
END //

DELIMITER ;

-- 1. evita que se ingresen años de experiencia negativos en la tabla medicos, forzando el valor a cero si es necesario.
DELIMITER //
create trigger tr_medicos_antes_insertar_experiencia
before insert on medicos
for each row
begin
    if new.años_experiencia < 0 then
        set new.años_experiencia = 0;
    end if;
end //
DELIMITER ;

-- 2. estandariza los nombres y apellidos de los medicos para que siempre comiencen con mayuscula al registrarse.
DELIMITER //
create trigger tr_medicos_formato_nombre
before insert on medicos
for each row
begin
    set new.nombre = concat(upper(left(new.nombre, 1)), lower(substring(new.nombre, 2)));
    set new.apellido = concat(upper(left(new.apellido, 1)), lower(substring(new.apellido, 2)));
end //
DELIMITER ;

-- 3. busca el nombre y apellido del medico usando su matricula si el campo se deja vacio al agendar un turno.
DELIMITER //
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
DELIMITER ;

-- 4. asigna automaticamente el estado 'pendiente' a un nuevo turno si no se especifica ninguno en la insercion.
DELIMITER //
create trigger tr_turnos_estado_defecto
before insert on turnos
for each row
begin
    if new.estado is null or new.estado = '' then
        set new.estado = 'pendiente';
    end if;
end //
DELIMITER ;

-- 5. asocia de forma automatica la especialidad correcta al turno basandose en la especialidad real del medico asignado.
DELIMITER //
create trigger tr_turnos_sincronizar_especialidad
before insert on turnos
for each row
begin
    select especialidad into @especialidad_medico 
    from medicos 
    where numero_matricula = new.matricula_medico;
    
    set new.especialidad = @especialidad_medico;
end //
DELIMITER ;

-- 6. cancela la insercion de un turno si el numero de la sala medica es menor o igual a cero, lanzando un mensaje de error.
DELIMITER //
create trigger tr_turnos_validar_sala
before insert on turnos
for each row
begin
    if new.sala <= 0 then
        signal sqlstate '45000' 
        set message_text = 'error: el numero de sala asignado al turno no es valido.';
    end if;
end //
DELIMITER ;

-- 7. impide la modificacion de la matricula de un medico si este ya cuenta con un historial de turnos programados en el sistema.
DELIMITER //
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
DELIMITER ;

-- 8. verifica rudimentariamente que el correo del medico tenga una estructura valida con arroba y punto antes de guardarlo.
DELIMITER //
create trigger tr_medicos_validar_email
before insert on medicos
for each row
begin
    if new.email not like '%@%.%' then
        signal sqlstate '45000' 
        set message_text = 'error: el formato del correo electronico ingresado no es valido.';
    end if;
end //
DELIMITER ;

-- 9. establece la cadena 'consulta medica general' de forma automatica si se crea un turno sin detallar el motivo.
DELIMITER //
create trigger tr_turnos_motivo_defecto
before insert on turnos
for each row
begin
    if new.motivoconsulta is null or new.motivoconsulta = '' then
        set new.motivoconsulta = 'consulta medica general';
    end if;
end //
DELIMITER ;

-- 10. fuerza la propiedad del tipo de turno a 'presencial' si el campo llega vacio desde el formulario del jframe.
DELIMITER //
create trigger tr_turnos_validar_tipo
before insert on turnos
for each row
begin
    if new.tipoturno is null or new.tipoturno = '' then
        set new.tipoturno = 'presencial';
    end if;
end //

delimiter ;

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
DELIMITER ;CREATE VIEW Vista_Med_Por_Tipo AS SELECT tipo, COUNT(*) AS Total_Productos, AVG(precio) AS Precio_Promedio FROM Medicamentos GROUP BY tipo
