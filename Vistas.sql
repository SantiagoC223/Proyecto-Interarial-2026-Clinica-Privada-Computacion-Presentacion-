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

-- 1. Catálogo de medicamentos genéricos y comerciales por tipo
CREATE VIEW Vista_Med_Por_Tipo AS
SELECT tipo, COUNT(*) AS Total_Productos, AVG(precio) AS Precio_Promedio
FROM Medicamentos GROUP BY tipo;

-- 2. Alerta de stock crítico (menos de 5 unidades disponibles)
CREATE VIEW Vista_Med_Stock_Critico AS
SELECT id, nombre, stock, precio FROM Medicamentos WHERE stock < 5;

-- 3. Medicamentos de alta gama o VIP (Precios por encima del promedio)
CREATE VIEW Vista_Med_Precio_Premium AS
SELECT id, nombre, precio, tipo FROM Medicamentos 
WHERE precio > (SELECT AVG(precio) FROM Medicamentos);

-- 4. Ranking de los 10 medicamentos más caros del inventario
CREATE VIEW Vista_Med_Top10_Caros AS
SELECT id, nombre, precio, stock FROM Medicamentos ORDER BY precio DESC LIMIT 10;

-- 5. Medicamentos con stock abundante (Listos para distribución masiva)
CREATE VIEW Vista_Med_Stock_Seguro AS
SELECT id, nombre, stock FROM Medicamentos WHERE stock >= 100;

-- 6. Reporte de valorización total del inventario por producto
CREATE VIEW Vista_Med_Valor_Inventario AS
SELECT id, nombre, stock, precio, (stock * precio) AS Valor_Total_Monetario FROM Medicamentos;

-- 7. Medicamentos agrupados por rango de precio (Económicos vs Caros)
CREATE VIEW Vista_Med_Rangos_Precio AS
SELECT id, nombre, precio,
       CASE WHEN precio < 1500 THEN 'Económico'
            WHEN precio BETWEEN 1500 AND 5000 THEN 'Moderado'
            ELSE 'Alto Costo' END AS Categoria_Precio
FROM Medicamentos;

-- 8. Medicamentos cuyo nombre empieza con una letra específica (Buscador rápido)
CREATE VIEW Vista_Med_Abecedario AS
SELECT id, nombre, tipo FROM Medicamentos ORDER BY nombre ASC;

-- 9. Resumen de stock total acumulado en la farmacia
CREATE VIEW Vista_Med_Auditoria_Stock AS
SELECT SUM(stock) AS Total_Pastillas_Disponibles, MIN(stock) AS Stock_Minimo_Actual FROM Medicamentos;

-- 10. Medicamentos con precios con centavos (Para control de caja)
CREATE VIEW Vista_Med_Precios_Fraccionados AS
SELECT id, nombre, precio FROM Medicamentos WHERE precio <> FLOOR(precio);
DELIMITER //

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
