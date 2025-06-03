create database moira;
use moira;
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  contrasena VARCHAR(255) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from usuarios;
DELETE FROM usuarios;
-- Tabla principal: temas
CREATE TABLE temas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
DELETE FROM usuarios WHERE id = 9;
select * from temas;
DELETE FROM temas WHERE id = 1;

-- Tabla relacionada: subtemas
CREATE TABLE subtemas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tema_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (tema_id) REFERENCES temas(id) ON DELETE CASCADE
);
-- Oficios y Reparaciones
INSERT INTO temas (nombre) VALUES ('Oficios y Reparaciones');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Fontanería'),
(@tema_id, 'Carpintería'),
(@tema_id, 'Electricidad'),
(@tema_id, 'Albañilería'),
(@tema_id, 'Pintura'),
(@tema_id, 'Cerrajería'),
(@tema_id, 'Reformas'),
(@tema_id, 'Cristalería'),
(@tema_id, 'Climatización / Aire acondicionado'),
(@tema_id, 'Instalación de gas');

-- Tareas del Hogar y Jardinería
INSERT INTO temas (nombre) VALUES ('Tareas del Hogar y Jardinería');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Limpieza doméstica'),
(@tema_id, 'Jardinería'),
(@tema_id, 'Cuidado de mascotas'),
(@tema_id, 'Cuidado de personas mayores'),
(@tema_id, 'Reparaciones menores (manitas)'),
(@tema_id, 'Mudanzas'),
(@tema_id, 'Decoración de interiores'),
(@tema_id, 'Montaje de muebles'),
(@tema_id, 'Cocina a domicilio');

-- Trabajo Rural y del Campo
INSERT INTO temas (nombre) VALUES ('Trabajo Rural y del Campo');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Agricultura'),
(@tema_id, 'Ganadería'),
(@tema_id, 'Recolección de frutas'),
(@tema_id, 'Mantenimiento de fincas'),
(@tema_id, 'Conducción de maquinaria agrícola'),
(@tema_id, 'Apicultura');

-- Tecnología e Informática
INSERT INTO temas (nombre) VALUES ('Tecnología e Informática');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Soporte técnico'),
(@tema_id, 'Reparación de PCs / móviles'),
(@tema_id, 'Diseño web'),
(@tema_id, 'Programación'),
(@tema_id, 'Edición de vídeo'),
(@tema_id, 'Marketing digital'),
(@tema_id, 'Community manager'),
(@tema_id, 'Desarrollo de apps'),
(@tema_id, 'Ciberseguridad'),
(@tema_id, 'Asistencia remota');

-- Educación y Formación
INSERT INTO temas (nombre) VALUES ('Educación y Formación');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Clases particulares (mates, idiomas, etc.)'),
(@tema_id, 'Clases de música'),
(@tema_id, 'Preparación para exámenes'),
(@tema_id, 'Tutorías escolares'),
(@tema_id, 'Enseñanza online'),
(@tema_id, 'Cursos técnicos'),
(@tema_id, 'Logopedia'),
(@tema_id, 'Psicopedagogía');

-- Transporte y Vehículos
INSERT INTO temas (nombre) VALUES ('Transporte y Vehículos');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Conductor privado'),
(@tema_id, 'Transporte de mercancías'),
(@tema_id, 'Reparación de coches / motos'),
(@tema_id, 'Lavado de vehículos'),
(@tema_id, 'Mantenimiento y revisión');

-- Arte y Creatividad
INSERT INTO temas (nombre) VALUES ('Arte y Creatividad');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Diseño gráfico'),
(@tema_id, 'Fotografía'),
(@tema_id, 'Producción musical'),
(@tema_id, 'Pintura artística'),
(@tema_id, 'Ilustración'),
(@tema_id, 'Artesanía'),
(@tema_id, 'Modelado 3D');

-- Eventos y Servicios Especiales
INSERT INTO temas (nombre) VALUES ('Eventos y Servicios Especiales');
SET @tema_id = LAST_INSERT_ID();
INSERT INTO subtemas (tema_id, nombre) VALUES
(@tema_id, 'Organización de eventos'),
(@tema_id, 'DJ / música en vivo'),
(@tema_id, 'Catering'),
(@tema_id, 'Animadores infantiles'),
(@tema_id, 'Alquiler de material'),
(@tema_id, 'Seguridad para eventos');
select * from temas;
select * from subtemas;
CREATE TABLE ofertas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  tema_id INT NOT NULL,
  subtema_id INT NOT NULL,
  titulo VARCHAR(255) NOT NULL,
  descripcion TEXT NOT NULL,
  
  comunidad VARCHAR(100) NOT NULL,
  provincia VARCHAR(100) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  direccion VARCHAR(255),

  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  dias_horarios VARCHAR(255) NOT NULL,

  tipo_remuneracion VARCHAR(50) NOT NULL,
  cantidad DECIMAL(10,2) NOT NULL,
  tipo_pago VARCHAR(50) NOT NULL,

  nombre_ofertante VARCHAR(100) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  email VARCHAR(100),
  vacantes INT NOT NULL DEFAULT 1,

  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  FOREIGN KEY (tema_id) REFERENCES temas(id),
  FOREIGN KEY (subtema_id) REFERENCES subtemas(id)
);
ALTER TABLE ofertas ADD imagen VARCHAR(255) AFTER descripcion;
DROP TABLE IF EXISTS ofertas;

CREATE TABLE ofertas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  tema_id INT NOT NULL,
  subtema_id INT NOT NULL,
  titulo VARCHAR(255) NOT NULL,
  descripcion TEXT NOT NULL,
  imagen VARCHAR(255), -- Ruta de imagen (opcional)

  comunidad VARCHAR(100) NOT NULL,
  provincia VARCHAR(100) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  direccion VARCHAR(255), -- opcional

  fecha_inicio DATE NOT NULL,
  fecha_fin DATE, -- opcional

  tipo_remuneracion VARCHAR(50) NOT NULL,
  cantidad DECIMAL(10,2) NOT NULL,
  tipo_pago VARCHAR(50) NOT NULL,

  telefono VARCHAR(20) NOT NULL,
  vacantes INT NOT NULL DEFAULT 1,

  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  FOREIGN KEY (tema_id) REFERENCES temas(id),
  FOREIGN KEY (subtema_id) REFERENCES subtemas(id)
);

INSERT INTO ofertas (
  usuario_id, tema_id, subtema_id, titulo, descripcion, imagen,
  comunidad, provincia, ciudad, direccion,
  fecha_inicio, fecha_fin, dias_horarios,
  tipo_remuneracion, cantidad, tipo_pago,
  nombre_ofertante, telefono, email, vacantes
) VALUES (
  9, -- ID de usuario existente
  2, -- ID de tema existente
  22, -- ID de subtema existente
  'Cuidado de jardín de verano',
  'Buscamos a alguien que ayude con el mantenimiento del jardín durante los meses de verano.',
  'source/img/limpiando.jpg',
  'Galicia',
  'Pontevedra',
  'A Guarda',
  'Calle Rosalía de Castro, 12',
  '2025-06-15',
  '2025-08-31',
  'Lunes a viernes de 9:00 a 13:00',
  'Por hora',
  10.00,
  'Efectivo',
  'Ana López',
  '612345678',
  'ana@example.com',
  1
);
select * from subtemas;
select * from ofertas;
select * from usuarios;
CREATE TABLE favoritos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  oferta_id INT NOT NULL,
  fecha_marcado DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  FOREIGN KEY (oferta_id) REFERENCES ofertas(id) ON DELETE CASCADE,
  UNIQUE KEY (usuario_id, oferta_id)
);
