-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2025 a las 21:04:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
CREATE DATABASE moira;
use moira;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `moira`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `oferta_id` int(11) NOT NULL,
  `fecha_marcado` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`id`, `usuario_id`, `oferta_id`, `fecha_marcado`) VALUES
(98, 9, 5, '2025-06-11 18:31:39'),
(99, 9, 6, '2025-06-11 18:31:44'),
(100, 13, 6, '2025-06-12 17:58:17'),
(109, 9, 21, '2025-06-12 21:50:58'),
(111, 9, 20, '2025-06-12 21:51:02'),
(113, 11, 16, '2025-06-12 22:17:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ofertas`
--

CREATE TABLE `ofertas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tema_id` int(11) NOT NULL,
  `subtema_id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `comunidad` varchar(100) NOT NULL,
  `provincia` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `tipo_remuneracion` varchar(50) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `tipo_pago` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `vacantes` int(11) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ofertas`
--

INSERT INTO `ofertas` (`id`, `usuario_id`, `tema_id`, `subtema_id`, `titulo`, `descripcion`, `imagen`, `comunidad`, `provincia`, `ciudad`, `direccion`, `fecha_inicio`, `fecha_fin`, `tipo_remuneracion`, `cantidad`, `tipo_pago`, `telefono`, `vacantes`, `fecha_creacion`) VALUES
(4, 11, 3, 32, 'carpintero', 'ds', 'source/img/carpintero.jpg', 'Aragón', 'Teruel', 'Alcañiz', 'alcala de locuras', '2025-06-10', NULL, 'Por hora', 44.00, 'Efectivo', '2', 2, '2025-06-03 19:28:33'),
(5, 11, 2, 22, 'Arreglar Urinario Averiado', '231312', 'source/img/ayuda.jpg', 'Ceuta', 'Ceuta', 'Ceuta', '32131', '2025-06-20', NULL, 'Por día', 44.00, 'A convenir', '666666666', 3, '2025-06-03 19:50:23'),
(6, 11, 2, 22, 'carpintero', 'dasdadsdas', 'source/img/programador.jpg', 'Melilla', 'Melilla', 'Melilla', 'alcala de locuras', '2025-06-10', NULL, 'Por día', 44.00, 'Efectivo', '2', 2, '2025-06-03 20:10:35'),
(16, 9, 2, 22, 'Necesito carpintero para mueble a medida', 'Busco un carpintero profesional que pueda diseñar e instalar un mueble empotrado en el salón.', 'source/img/carpintero.jpg', 'Andalucía', 'Sevilla', 'Dos Hermanas', 'Calle Real 123', '2025-06-15', '2025-06-20', 'fijo', 300.00, 'efectivo', '600123456', 1, '2025-06-10 19:59:42'),
(17, 9, 5, 49, 'Pequeño proyecto en Python', 'Se requiere programador freelance para script automatizado en Python (web scraping).', 'source/img/programador.jpg', 'Madrid', 'Madrid', 'Madrid', 'Av. de América 42', '2025-06-18', '2025-06-25', 'por hora', 25.00, 'bizum', '600987654', 1, '2025-06-10 19:59:42'),
(18, 9, 3, 31, 'Servicio de limpieza en piso turístico', 'Busco persona para limpieza puntual de apartamento entre reservas de Airbnb.', 'source/img/limpiando.jpg', 'Cataluña', 'Barcelona', 'Barcelona', 'Calle Marina 67', '2025-06-12', '2025-06-30', 'fijo', 50.00, 'transferencia', '600222333', 1, '2025-06-10 19:59:42'),
(19, 10, 3, 39, 'Cocinero a domicilio para evento familiar', 'Necesito un cocinero para preparar menú casero para 10 personas. Cocina equipada.', 'source/img/cocinero.jpg', 'Valencia', 'Valencia', 'Gandía', 'Calle Playa 5', '2025-07-01', '2025-07-01', 'fijo', 150.00, 'efectivo', '699000111', 1, '2025-06-10 19:59:42'),
(20, 10, 4, 41, 'Ayuda en granja de cabras', 'Se busca ayuda para alimentar y cuidar cabras. Trabajo sencillo pero físico.', 'source/img/ganadero.jpg', 'Castilla y León', 'León', 'Ponferrada', 'Finca El Roble', '2025-06-20', '2025-07-05', 'por hora', 10.00, 'efectivo', '611222333', 2, '2025-06-10 19:59:42'),
(21, 10, 2, 24, 'Albañil para arreglos en patio', 'Necesito alicatado de una pared y colocación de bordillos en patio interior.', 'source/img/obrero.jpg', 'Extremadura', 'Badajoz', 'Badajoz', 'Calle Jardín 12', '2025-06-15', '2025-06-17', 'fijo', 200.00, 'transferencia', '688123456', 1, '2025-06-10 19:59:42'),
(22, 11, 5, 48, 'Diseñador web para portfolio', 'Busco diseñador para crear una web moderna en HTML/CSS para mostrar mi trabajo.', 'source/img/programador.jpg', 'Andalucía', 'Málaga', 'Málaga', 'Paseo del Parque 45', '2025-06-20', '2025-07-01', 'fijo', 400.00, 'paypal', '677999000', 1, '2025-06-10 19:59:42'),
(23, 11, 9, 77, 'DJ para cumpleaños en local privado', 'Quiero contratar DJ con su propio equipo de sonido para fiesta en local de alquiler.', 'source/img/barman.jpg', 'Andalucía', 'Cádiz', 'San Fernando', 'Calle Sol 9', '2025-06-22', '2025-06-22', 'fijo', 250.00, 'efectivo', '666555444', 1, '2025-06-10 19:59:42'),
(24, 11, 3, 32, 'Jardinero para mantenimiento mensual', 'Se busca jardinero para cuidar césped, podar arbustos y mantener jardín pequeño.', 'source/img/jardinero.jpg', 'Madrid', 'Madrid', 'Madrid', 'Av. del Olivo 33', '2025-06-15', '2025-09-15', 'mensual', 120.00, 'transferencia', '611000222', 1, '2025-06-10 19:59:42'),
(26, 11, 3, 32, 'Busco Jardinero', 'Busco Jardinero para una finca que esta mal y quiero hacer quemas', 'source/img/jardinero.jpg', 'Galicia', 'Pontevedra', 'Vigo', 'aqui', '2025-06-12', '2025-06-13', 'Por día', 50.00, 'Efectivo', '666666666', 1, '2025-06-12 19:15:20'),
(27, 11, 8, 69, 'Diseño grafico', 'Busco diseñador para tatatatta', 'source/img/limpiando.jpg', 'Ceuta', 'Ceuta', 'Ceuta', '242343', '2025-06-12', '2025-06-13', 'Por día', 33.00, 'Transferencia', '666666666', 2, '2025-06-12 19:21:26'),
(29, 9, 9, 77, 'DJ para cumpleaños en local privado', 'Solicitud de servicio: dj para cumpleaños en local privado.', 'source/img/barman.jpg', 'Andalucía', 'Cádiz', 'San Fernando', 'Calle Ejemplo 1', '2025-06-22', '2025-06-22', 'fijo', 100.00, 'efectivo', '600000100', 1, '2025-06-13 12:34:56'),
(30, 9, 9, 77, 'DJ para cumpleaños en local privado', 'Solicitud de servicio: dj para cumpleaños en local privado.', 'source/img/barman.jpg', 'Andalucía', 'Cádiz', 'San Fernando', 'Calle Ejemplo 1', '2025-06-22', '2025-06-22', 'fijo', 100.00, 'efectivo', '600000100', 1, '2025-06-13 12:34:56'),
(31, 11, 7, 64, 'Chofer privado para traslados al aeropuerto', 'Se necesita chofer profesional con coche propio para traslados puntuales al aeropuerto. Puntualidad y buena presencia son imprescindibles.', 'source/img/chofer.jpg', 'Andalucía', 'Cádiz', 'San Fernando', 'Av. Aeropuerto 123', '2025-06-20', '2025-06-20', 'fijo', 70.00, 'efectivo', '600000102', 1, '2025-06-13 14:38:55'),
(32, 10, 2, 22, 'Servicio de arreglos y costura a domicilio', 'Busco persona con experiencia en costura para hacer arreglos de ropa (bajos, cremalleras, ajustes) en mi domicilio. Trabajo puntual pero con posibilidad de continuidad.', 'source/img/costurera.jpg', 'Madrid', 'Madrid', 'Madrid', 'Calle Aguja 45', '2025-06-18', '2025-06-18', 'fijo', 35.00, 'efectivo', '611222333', 1, '2025-06-13 14:40:06'),
(33, 11, 9, 77, 'DJ para evento corporativo en terraza', 'Se necesita DJ con experiencia y repertorio variado para animar evento empresarial nocturno en terraza. Se valorará equipo propio.', 'source/img/dj.jpg', 'Cataluña', 'Barcelona', 'Barcelona', 'Avenida del Sonido 101', '2025-07-05', '2025-07-05', 'fijo', 300.00, 'transferencia', '688999123', 1, '2025-06-13 14:41:22'),
(34, 10, 2, 23, 'Electricista para instalación en local comercial', 'Buscamos profesional en electricidad para renovar el sistema eléctrico de un local en funcionamiento. Trabajo de un día.', 'source/img/electricista.jpg', 'Madrid', 'Madrid', 'Madrid', 'Calle Voltios 77', '2025-06-20', '2025-06-20', 'fijo', 180.00, 'efectivo', '611223344', 1, '2025-06-13 14:42:23'),
(35, 9, 8, 70, 'Fotógrafo para evento familiar en exterior', 'Buscamos fotógrafo para una sesión de fotos al aire libre en parque natural. Se requiere equipo propio.', 'source/img/fotografo.jpg', 'Cataluña', 'Barcelona', 'Terrassa', 'Parque Vallparadís s/n', '2025-06-28', '2025-06-28', 'fijo', 120.00, 'transferencia', '612343434', 1, '2025-06-13 14:44:36'),
(36, 11, 3, 31, 'Servicio de limpieza profunda para piso de 90m2', 'Solicito profesional para limpieza completa de piso antes de alquiler. Se valorará experiencia previa.', 'source/img/limpiador.jpg', 'Comunidad Valenciana', 'Valencia', 'Gandía', 'Avenida de los Naranjos 12', '2025-06-25', '2025-06-25', 'fijo', 90.00, 'efectivo', '688999123', 1, '2025-06-13 14:44:44'),
(37, 10, 2, 24, 'Obrero para reformas en local comercial', 'Necesitamos un albañil con experiencia para reforma integral de un local. Posibilidad de trabajo continuo.', 'source/img/obrero2.jpg', 'Madrid', 'Madrid', 'Madrid', 'Calle Alcalá 95', '2025-07-01', '2025-07-10', 'fijo', 600.00, 'transferencia', '645222111', 1, '2025-06-13 14:52:33'),
(38, 9, 2, 25, 'Pintor para renovación de fachada', 'Requiero pintor profesional para pintar fachada de casa unifamiliar. Materiales incluidos.', 'source/img/pintor.jpg', 'Galicia', 'A Coruña', 'Santiago de Compostela', 'Rúa do Home Santo 8', '2025-07-05', '2025-07-06', 'fijo', 180.00, 'efectivo', '611888444', 1, '2025-06-13 14:52:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenas`
--

CREATE TABLE `resenas` (
  `id` int(11) NOT NULL,
  `reseñado_id` int(11) NOT NULL,
  `autor_id` int(11) NOT NULL,
  `valoracion` tinyint(4) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resenas`
--

INSERT INTO `resenas` (`id`, `reseñado_id`, `autor_id`, `valoracion`, `fecha`) VALUES
(9, 11, 9, 4, '2025-06-10 19:56:17'),
(10, 11, 9, 1, '2025-06-10 20:27:41'),
(12, 11, 9, 2, '2025-06-12 20:58:08'),
(13, 9, 11, 3, '2025-06-13 16:10:13'),
(14, 9, 11, 5, '2025-06-13 16:10:21'),
(16, 28, 9, 3, '2025-06-13 17:25:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_servicio`
--

CREATE TABLE `solicitudes_servicio` (
  `id` int(11) NOT NULL,
  `oferta_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(150) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `presentacion` text DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp(),
  `estado` enum('pendiente','aceptado','rechazado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitudes_servicio`
--

INSERT INTO `solicitudes_servicio` (`id`, `oferta_id`, `usuario_id`, `nombre`, `apellidos`, `telefono`, `email`, `presentacion`, `archivo`, `fecha_envio`, `estado`) VALUES
(1, 5, 9, 'dasda', 'Panadero Rodríguez', '666666666', 'prueba@prueba.prueba', 'edasdad', 'curriculum.pdf', '2025-06-07 17:04:17', 'pendiente'),
(4, 4, 9, 'pepe', 'padasda', '666666666', 'prueba@prueba.prueba', 'dasdasdas', 'curriculum.pdf', '2025-06-08 11:21:17', 'aceptado'),
(7, 26, 9, 'pepe', 'Panadero Rodríguez', '666666666', 'prueba@prueba.prueba', 'dsadsadasdasdasd', 'curriculum.pdf', '2025-06-12 21:16:50', 'aceptado'),
(8, 27, 9, 'prueba', 'dsad', '555555555', 'panaderorodriguezangel.sangrina@gmail.com', 'dasdasdasddadsdasdas', 'curriculum.pdf', '2025-06-12 21:23:34', 'aceptado'),
(12, 16, 28, 'Angel', 'Panadero Rodriguez', '6666666666', 'panapriv@gmail.com', 'Soy muy manitas, se me dará bien', 'curriculum.pdf', '2025-06-13 17:24:27', 'aceptado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subtemas`
--

CREATE TABLE `subtemas` (
  `id` int(11) NOT NULL,
  `tema_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `subtemas`
--

INSERT INTO `subtemas` (`id`, `tema_id`, `nombre`) VALUES
(21, 2, 'Fontanería'),
(22, 2, 'Carpintería'),
(23, 2, 'Electricidad'),
(24, 2, 'Albañilería'),
(25, 2, 'Pintura'),
(26, 2, 'Cerrajería'),
(27, 2, 'Reformas'),
(28, 2, 'Cristalería'),
(29, 2, 'Climatización / Aire acondicionado'),
(30, 2, 'Instalación de gas'),
(31, 3, 'Limpieza doméstica'),
(32, 3, 'Jardinería'),
(33, 3, 'Cuidado de mascotas'),
(34, 3, 'Cuidado de personas mayores'),
(35, 3, 'Reparaciones menores (manitas)'),
(36, 3, 'Mudanzas'),
(37, 3, 'Decoración de interiores'),
(38, 3, 'Montaje de muebles'),
(39, 3, 'Cocina a domicilio'),
(40, 4, 'Agricultura'),
(41, 4, 'Ganadería'),
(42, 4, 'Recolección de frutas'),
(43, 4, 'Mantenimiento de fincas'),
(44, 4, 'Conducción de maquinaria agrícola'),
(45, 4, 'Apicultura'),
(46, 5, 'Soporte técnico'),
(47, 5, 'Reparación de PCs / móviles'),
(48, 5, 'Diseño web'),
(49, 5, 'Programación'),
(50, 5, 'Edición de vídeo'),
(51, 5, 'Marketing digital'),
(52, 5, 'Community manager'),
(53, 5, 'Desarrollo de apps'),
(54, 5, 'Ciberseguridad'),
(55, 5, 'Asistencia remota'),
(56, 6, 'Clases particulares (mates, idiomas, etc.)'),
(57, 6, 'Clases de música'),
(58, 6, 'Preparación para exámenes'),
(59, 6, 'Tutorías escolares'),
(60, 6, 'Enseñanza online'),
(61, 6, 'Cursos técnicos'),
(62, 6, 'Logopedia'),
(63, 6, 'Psicopedagogía'),
(64, 7, 'Conductor privado'),
(65, 7, 'Transporte de mercancías'),
(66, 7, 'Reparación de coches / motos'),
(67, 7, 'Lavado de vehículos'),
(68, 7, 'Mantenimiento y revisión'),
(69, 8, 'Diseño gráfico'),
(70, 8, 'Fotografía'),
(71, 8, 'Producción musical'),
(72, 8, 'Pintura artística'),
(73, 8, 'Ilustración'),
(74, 8, 'Artesanía'),
(75, 8, 'Modelado 3D'),
(76, 9, 'Organización de eventos'),
(77, 9, 'DJ / música en vivo'),
(78, 9, 'Catering'),
(79, 9, 'Animadores infantiles'),
(80, 9, 'Alquiler de material'),
(81, 9, 'Seguridad para eventos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temas`
--

CREATE TABLE `temas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `temas`
--

INSERT INTO `temas` (`id`, `nombre`) VALUES
(2, 'Oficios y Reparaciones'),
(3, 'Tareas del Hogar y Jardinería'),
(4, 'Trabajo Rural y del Campo'),
(5, 'Tecnología e Informática'),
(6, 'Educación y Formación'),
(7, 'Transporte y Vehículos'),
(8, 'Arte y Creatividad'),
(9, 'Eventos y Servicios Especiales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `verificado` tinyint(1) DEFAULT 0,
  `token_verificacion` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `email`, `foto`, `contrasena`, `fecha_nacimiento`, `fecha_registro`, `verificado`, `token_verificacion`) VALUES
(7, 'prueba', 'prueba@prueba.prueba', 'source/img/moira-logo.png', 'prueba', '2222-02-12', '2025-05-31 16:41:13', 1, NULL),
(9, 'otaku', 'robalizaotaku@gmail.com', 'source/img/moira-logo.png', 'abc123.', '2025-06-02', '2025-06-02 20:36:55', 1, NULL),
(10, 'prueba', 'panaderorodriguezangel.sangrina@gmail.com', 'source/img/moira-logo.png', 'prueba', '2025-06-02', '2025-06-02 20:44:14', 1, NULL),
(11, 'angel', 'angelrobaliz@gmail.com', 'source/img/mecanico.jpg', 'abc123.', '2025-06-03', '2025-06-03 19:23:22', 1, NULL),
(13, 'admin', 'admin@admin.admin', 'source/img/moira-logo.png', 'admin', '2005-01-11', '2025-06-11 20:07:42', 1, NULL),
(28, 'Pana', 'panapriv@gmail.com', 'source/img/mecanico.jpg', 'abc123.', '2000-02-02', '2025-06-13 15:22:40', 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`,`oferta_id`),
  ADD KEY `oferta_id` (`oferta_id`);

--
-- Indices de la tabla `ofertas`
--
ALTER TABLE `ofertas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `tema_id` (`tema_id`),
  ADD KEY `subtema_id` (`subtema_id`);

--
-- Indices de la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reseñado_id` (`reseñado_id`),
  ADD KEY `autor_id` (`autor_id`);

--
-- Indices de la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oferta_id` (`oferta_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `subtemas`
--
ALTER TABLE `subtemas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tema_id` (`tema_id`);

--
-- Indices de la tabla `temas`
--
ALTER TABLE `temas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT de la tabla `ofertas`
--
ALTER TABLE `ofertas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `subtemas`
--
ALTER TABLE `subtemas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `temas`
--
ALTER TABLE `temas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ofertas`
--
ALTER TABLE `ofertas`
  ADD CONSTRAINT `ofertas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ofertas_ibfk_2` FOREIGN KEY (`tema_id`) REFERENCES `temas` (`id`),
  ADD CONSTRAINT `ofertas_ibfk_3` FOREIGN KEY (`subtema_id`) REFERENCES `subtemas` (`id`);

--
-- Filtros para la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`reseñado_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  ADD CONSTRAINT `solicitudes_servicio_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `solicitudes_servicio_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `subtemas`
--
ALTER TABLE `subtemas`
  ADD CONSTRAINT `subtemas_ibfk_1` FOREIGN KEY (`tema_id`) REFERENCES `temas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
