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
use moira;
select * from temas;
select * from subtemas;
CREATE TABLE solicitudes_servicio (
  id INT AUTO_INCREMENT PRIMARY KEY,
  oferta_id INT NOT NULL,                 -- Oferta a la que aplica
  usuario_id INT NOT NULL,                -- Usuario que envía la solicitud
  nombre VARCHAR(100) NOT NULL,
  apellidos VARCHAR(150) NOT NULL,
  telefono VARCHAR(20),
  email VARCHAR(100) NOT NULL,
  presentacion TEXT,                      -- Texto libre
  archivo VARCHAR(255),                   -- Ruta del archivo adjunto (PDF, CV, etc.)
  fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (oferta_id) REFERENCES ofertas(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);
CREATE TABLE resenas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reseñado_id INT NOT NULL,         -- a quién va dirigida la reseña
    autor_id INT NOT NULL,            -- quién la dejó
    valoracion TINYINT NOT NULL,      -- 1 a 5
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reseñado_id) REFERENCES usuarios(id),
    FOREIGN KEY (autor_id) REFERENCES usuarios(id)
);
select * from resenas;
use moira;
select * from ofertas;
SELECT * FROM ofertas 
WHERE tema = 'Arte y Creatividad' 
AND comunidad = 'Ceuta' 
AND provincia = 'Ceuta' 
AND ciudad = 'Ceuta';
ALTER TABLE solicitudes_servicio ADD estado ENUM('pendiente', 'aceptado', 'rechazado') DEFAULT 'pendiente';
use moira;
select * from usuarios;
select * from solicitudes_servicio;
select * from temas;
select * from favoritos;
INSERT INTO ofertas (
  usuario_id, tema_id, subtema_id, titulo, descripcion, imagen,
  comunidad, provincia, ciudad, direccion, fecha_inicio, fecha_fin,
  tipo_remuneracion, cantidad, tipo_pago, telefono, vacantes, fecha_creacion
)
VALUES
-- Usuario 9 - otaku
(9, 2, 22, 'Necesito carpintero para mueble a medida',
 'Busco un carpintero profesional que pueda diseñar e instalar un mueble empotrado en el salón.',
 'source/img/carpintero.jpg', 'Andalucía', 'Sevilla', 'Dos Hermanas', 'Calle Real 123',
 '2025-06-15', '2025-06-20', 'fijo', 300.00, 'efectivo', '600123456', 1, NOW()),

(9, 5, 49, 'Pequeño proyecto en Python',
 'Se requiere programador freelance para script automatizado en Python (web scraping).',
 'source/img/programador.jpg', 'Madrid', 'Madrid', 'Madrid', 'Av. de América 42',
 '2025-06-18', '2025-06-25', 'por hora', 25.00, 'bizum', '600987654', 1, NOW()),

(9, 3, 31, 'Servicio de limpieza en piso turístico',
 'Busco persona para limpieza puntual de apartamento entre reservas de Airbnb.',
 'source/img/limpiando.jpg', 'Cataluña', 'Barcelona', 'Barcelona', 'Calle Marina 67',
 '2025-06-12', '2025-06-30', 'fijo', 50.00, 'transferencia', '600222333', 1, NOW()),

-- Usuario 10 - prueba
(10, 3, 39, 'Cocinero a domicilio para evento familiar',
 'Necesito un cocinero para preparar menú casero para 10 personas. Cocina equipada.',
 'source/img/cocinero.jpg', 'Valencia', 'Valencia', 'Gandía', 'Calle Playa 5',
 '2025-07-01', '2025-07-01', 'fijo', 150.00, 'efectivo', '699000111', 1, NOW()),

(10, 4, 41, 'Ayuda en granja de cabras',
 'Se busca ayuda para alimentar y cuidar cabras. Trabajo sencillo pero físico.',
 'source/img/ganadero.jpg', 'Castilla y León', 'León', 'Ponferrada', 'Finca El Roble',
 '2025-06-20', '2025-07-05', 'por hora', 10.00, 'efectivo', '611222333', 2, NOW()),

(10, 2, 24, 'Albañil para arreglos en patio',
 'Necesito alicatado de una pared y colocación de bordillos en patio interior.',
 'source/img/obrero.jpg', 'Extremadura', 'Badajoz', 'Badajoz', 'Calle Jardín 12',
 '2025-06-15', '2025-06-17', 'fijo', 200.00, 'transferencia', '688123456', 1, NOW()),

-- Usuario 11 - angel
(11, 5, 48, 'Diseñador web para portfolio',
 'Busco diseñador para crear una web moderna en HTML/CSS para mostrar mi trabajo.',
 'source/img/programador.jpg', 'Andalucía', 'Málaga', 'Málaga', 'Paseo del Parque 45',
 '2025-06-20', '2025-07-01', 'fijo', 400.00, 'paypal', '677999000', 1, NOW()),

(11, 9, 77, 'DJ para cumpleaños en local privado',
 'Quiero contratar DJ con su propio equipo de sonido para fiesta en local de alquiler.',
 'source/img/barman.jpg', 'Andalucía', 'Cádiz', 'San Fernando', 'Calle Sol 9',
 '2025-06-22', '2025-06-22', 'fijo', 250.00, 'efectivo', '666555444', 1, NOW()),

(11, 3, 32, 'Jardinero para mantenimiento mensual',
 'Se busca jardinero para cuidar césped, podar arbustos y mantener jardín pequeño.',
 'source/img/jardinero.jpg', 'Madrid', 'Madrid', 'Madrid', 'Av. del Olivo 33',
 '2025-06-15', '2025-09-15', 'mensual', 120.00, 'transferencia', '611000222', 1, NOW());
select * from ofertas;
DELETE FROM ofertas
WHERE id BETWEEN 7 AND 15;
select * from favoritos;
ALTER TABLE usuarios ADD COLUMN verificado BOOLEAN DEFAULT FALSE;
ALTER TABLE usuarios ADD COLUMN token_verificacion VARCHAR(64) DEFAULT NULL;
select * from usuarios;
select * from resenas;
DELETE FROM usuarios WHERE id = 23;
DELETE FROM  resenas WHERE id = 11;
UPDATE usuarios
SET verificado = 1
WHERE verificado = 0;
ALTER TABLE usuarios
ADD COLUMN foto VARCHAR(255) AFTER email;
UPDATE usuarios
SET foto = 'source/img/moira-logo.png'
WHERE foto IS NULL;
select * from temas;
select * from subtemas;
INSERT INTO ofertas (
  usuario_id, tema_id, subtema_id, titulo, descripcion, imagen,
  comunidad, provincia, ciudad, direccion, fecha_inicio, fecha_fin,
  tipo_remuneracion, cantidad, tipo_pago, telefono, vacantes, fecha_creacion
) VALUES (
  10, 2, 23,
  'Electricista para instalación en local comercial', 
  'Buscamos profesional en electricidad para renovar el sistema eléctrico de un local en funcionamiento. Trabajo de un día.', 
  'source/img/electricista.jpg',
  'Madrid', 'Madrid', 'Madrid', 'Calle Voltios 77',
  '2025-06-20', '2025-06-20',
  'fijo', 180.00, 'efectivo',
  '611223344', 1, NOW()
);



