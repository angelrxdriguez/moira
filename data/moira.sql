-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-06-2025 a las 22:31:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


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
(69, 11, 3, '2025-06-07 18:38:43');

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
(2, 9, 2, 22, 'Arreglar Urinario Averiado', 'dasdadsa', 'source/img/limpiando.jpg', 'Ceuta', 'Ceuta', 'Ceuta', 'aqui', '2025-06-26', '2025-06-24', 'Por día', 54.00, 'Efectivo', '666666666', 5, '2025-06-03 19:11:14'),
(3, 9, 3, 33, 'dasdasd', 'dsadads', 'source/img/ayuda.jpg', 'Melilla', 'Melilla', 'Melilla', '2', '2025-06-03', NULL, 'Por hora', 22.00, 'Efectivo', '2', 2, '2025-06-03 19:27:44'),
(4, 11, 3, 32, 'carpintero', 'ds', 'source/img/carpintero.jpg', 'Aragón', 'Teruel', 'Alcañiz', 'alcala de locuras', '2025-06-10', NULL, 'Por hora', 44.00, 'Efectivo', '2', 2, '2025-06-03 19:28:33'),
(5, 11, 2, 22, 'Arreglar Urinario Averiado', '231312', 'source/img/ayuda.jpg', 'Ceuta', 'Ceuta', 'Ceuta', '32131', '2025-06-20', NULL, 'Por día', 44.00, 'A convenir', '666666666', 3, '2025-06-03 19:50:23'),
(6, 11, 2, 22, 'carpintero', 'dasdadsdas', 'source/img/programador.jpg', 'Melilla', 'Melilla', 'Melilla', 'alcala de locuras', '2025-06-10', NULL, 'Por día', 44.00, 'Efectivo', '2', 2, '2025-06-03 20:10:35');

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
(2, 3, 11, 'Angel', 'Panadero Rodríguez', '666666666', 'angelrobaliz@gmail.com', 'una conversación con este personaje es como:\r\n- El cielo es azul?\r\n- depende el día y la hora. \r\n- un martes a las 10 de la mañana, el cielo es azul?', '', '2025-06-07 18:39:31', 'aceptado'),
(3, 3, 11, 'Angel', 'Panadero Rodríguez', '666666666', 'angelrobaliz@gmail.com', 'AYUDA NECESITO CHOLLO', 'curriculum.pdf', '2025-06-07 18:43:56', 'aceptado'),
(4, 4, 9, 'pepe', 'padasda', '666666666', 'prueba@prueba.prueba', 'dasdasdas', 'curriculum.pdf', '2025-06-08 11:21:17', 'pendiente'),
(5, 2, 11, 'Angel', 'Panadero Rodríguez', '666666666', 'angelrobaliz@gmail.com', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'curriculum.pdf', '2025-06-08 20:08:39', 'aceptado');

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
  `contrasena` varchar(255) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `email`, `contrasena`, `fecha_nacimiento`, `fecha_registro`) VALUES
(7, 'prueba', 'prueba@prueba.prueba', 'prueba', '2222-02-12', '2025-05-31 16:41:13'),
(8, 'angel', 'angel@angel.angel', 'angel', '2025-05-31', '2025-05-31 20:25:57'),
(9, 'otaku', 'robalizaotaku@gmail.com', 'abc123.', '2025-06-02', '2025-06-02 20:36:55'),
(10, 'prueba', 'panaderorodriguezangel.sangrina@gmail.com', 'prueba', '2025-06-02', '2025-06-02 20:44:14'),
(11, 'angel', 'angelrobaliz@gmail.com', 'abc123.', '2025-06-03', '2025-06-03 19:23:22');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `ofertas`
--
ALTER TABLE `ofertas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
