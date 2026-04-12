-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-04-2026 a las 23:32:06
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
-- Base de datos: `biblioteca_universitaria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `id_autor` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido_paterno` varchar(50) DEFAULT NULL,
  `apellido_materno` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor_libro`
--

CREATE TABLE `autor_libro` (
  `id_autor_libro` int(11) NOT NULL,
  `id_autor` int(11) DEFAULT NULL,
  `id_libro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliotecario`
--

CREATE TABLE `bibliotecario` (
  `id_bibliotecario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido_paterno` varchar(50) DEFAULT NULL,
  `apellido_materno` varchar(50) DEFAULT NULL,
  `años_experiencia` int(11) DEFAULT NULL,
  `turno` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `id_estudiante` int(11) NOT NULL,
  `codigo_matricula` varchar(30) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido_paterno` varchar(50) DEFAULT NULL,
  `apellido_materno` varchar(50) DEFAULT NULL,
  `carrera` varchar(100) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `calle` varchar(100) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `correo_electronico` varchar(50) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `id_libro` int(11) NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `editorial` varchar(20) DEFAULT NULL,
  `categoria` varchar(20) DEFAULT NULL,
  `año_publicacion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `id_prestamo` int(11) NOT NULL,
  `id_estudiante` int(11) DEFAULT NULL,
  `id_libro` int(11) DEFAULT NULL,
  `id_bibliotecario` int(11) DEFAULT NULL,
  `fecha_prestamo` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `fecha_devolucion_prevista` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono_estudiante`
--

CREATE TABLE `telefono_estudiante` (
  `id_telefono` int(11) NOT NULL,
  `id_estudiante` int(11) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`id_autor`);

--
-- Indices de la tabla `autor_libro`
--
ALTER TABLE `autor_libro`
  ADD PRIMARY KEY (`id_autor_libro`),
  ADD KEY `id_autor` (`id_autor`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `bibliotecario`
--
ALTER TABLE `bibliotecario`
  ADD PRIMARY KEY (`id_bibliotecario`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD UNIQUE KEY `codigo_matricula` (`codigo_matricula`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`id_libro`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `id_estudiante` (`id_estudiante`),
  ADD KEY `id_libro` (`id_libro`),
  ADD KEY `id_bibliotecario` (`id_bibliotecario`);

--
-- Indices de la tabla `telefono_estudiante`
--
ALTER TABLE `telefono_estudiante`
  ADD PRIMARY KEY (`id_telefono`),
  ADD KEY `id_estudiante` (`id_estudiante`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autor`
--
ALTER TABLE `autor`
  MODIFY `id_autor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `autor_libro`
--
ALTER TABLE `autor_libro`
  MODIFY `id_autor_libro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bibliotecario`
--
ALTER TABLE `bibliotecario`
  MODIFY `id_bibliotecario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `id_libro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `telefono_estudiante`
--
ALTER TABLE `telefono_estudiante`
  MODIFY `id_telefono` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `autor_libro`
--
ALTER TABLE `autor_libro`
  ADD CONSTRAINT `autor_libro_ibfk_1` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`),
  ADD CONSTRAINT `autor_libro_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`);

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`),
  ADD CONSTRAINT `prestamo_ibfk_3` FOREIGN KEY (`id_bibliotecario`) REFERENCES `bibliotecario` (`id_bibliotecario`);

--
-- Filtros para la tabla `telefono_estudiante`
--
ALTER TABLE `telefono_estudiante`
  ADD CONSTRAINT `telefono_estudiante_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
