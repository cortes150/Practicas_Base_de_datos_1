-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 13-04-2026 a las 16:22:11
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
  `Id_autor` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `Apellido_paterno` varchar(50) DEFAULT NULL,
  `Apellido_materno` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor_libro`
--

CREATE TABLE `autor_libro` (
  `Id_autor_libro` int(11) NOT NULL,
  `Id_autor` int(11) DEFAULT NULL,
  `Id_libro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliotecario`
--

CREATE TABLE `bibliotecario` (
  `Id_bibliotecario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `Apellido_paterno` varchar(50) DEFAULT NULL,
  `Apellido_materno` varchar(50) DEFAULT NULL,
  `anios_experiencia` int(11) DEFAULT NULL,
  `telefono_contacto` varchar(50) DEFAULT NULL,
  `turno` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_libro`
--

CREATE TABLE `categoria_libro` (
  `Id_categoria` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `Id_libro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `Id_estudiante` int(11) NOT NULL,
  `Codigo_matricula` varchar(30) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `Apellido_paterno` varchar(50) DEFAULT NULL,
  `Apellido_materno` varchar(50) DEFAULT NULL,
  `carrera` varchar(100) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `calle` varchar(50) DEFAULT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `Id_libro` int(11) NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `editorial` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `Id_prestamo` int(11) NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `fecha_prestamo` date DEFAULT NULL,
  `fecha_devolucion_prevista` date DEFAULT NULL,
  `Id_libro` int(11) DEFAULT NULL,
  `Id_bibliotecario` int(11) DEFAULT NULL,
  `Id_estudiante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono_bibliotecario`
--

CREATE TABLE `telefono_bibliotecario` (
  `Id_telefono_bibliotecario` int(11) NOT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `Id_bibliotecario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono_estudiante`
--

CREATE TABLE `telefono_estudiante` (
  `Id_telefono_estudiante` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `Id_estudiante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno_bibliotecario`
--

CREATE TABLE `turno_bibliotecario` (
  `Id_turno_bibliotecario` int(11) NOT NULL,
  `nombre_turno` varchar(50) DEFAULT NULL,
  `Id_bibliotecario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`Id_autor`);

--
-- Indices de la tabla `autor_libro`
--
ALTER TABLE `autor_libro`
  ADD PRIMARY KEY (`Id_autor_libro`),
  ADD KEY `Id_libro` (`Id_libro`),
  ADD KEY `Id_autor` (`Id_autor`);

--
-- Indices de la tabla `bibliotecario`
--
ALTER TABLE `bibliotecario`
  ADD PRIMARY KEY (`Id_bibliotecario`);

--
-- Indices de la tabla `categoria_libro`
--
ALTER TABLE `categoria_libro`
  ADD PRIMARY KEY (`Id_categoria`),
  ADD KEY `Id_libro` (`Id_libro`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`Id_estudiante`),
  ADD UNIQUE KEY `Codigo_matricula` (`Codigo_matricula`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`Id_libro`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`Id_prestamo`),
  ADD KEY `Id_libro` (`Id_libro`),
  ADD KEY `Id_bibliotecario` (`Id_bibliotecario`),
  ADD KEY `Id_estudiante` (`Id_estudiante`);

--
-- Indices de la tabla `telefono_bibliotecario`
--
ALTER TABLE `telefono_bibliotecario`
  ADD PRIMARY KEY (`Id_telefono_bibliotecario`),
  ADD KEY `Id_bibliotecario` (`Id_bibliotecario`);

--
-- Indices de la tabla `telefono_estudiante`
--
ALTER TABLE `telefono_estudiante`
  ADD PRIMARY KEY (`Id_telefono_estudiante`),
  ADD KEY `Id_estudiante` (`Id_estudiante`);

--
-- Indices de la tabla `turno_bibliotecario`
--
ALTER TABLE `turno_bibliotecario`
  ADD PRIMARY KEY (`Id_turno_bibliotecario`),
  ADD KEY `Id_bibliotecario` (`Id_bibliotecario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autor`
--
ALTER TABLE `autor`
  MODIFY `Id_autor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `autor_libro`
--
ALTER TABLE `autor_libro`
  MODIFY `Id_autor_libro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bibliotecario`
--
ALTER TABLE `bibliotecario`
  MODIFY `Id_bibliotecario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoria_libro`
--
ALTER TABLE `categoria_libro`
  MODIFY `Id_categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `Id_estudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `Id_libro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `Id_prestamo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `telefono_bibliotecario`
--
ALTER TABLE `telefono_bibliotecario`
  MODIFY `Id_telefono_bibliotecario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `telefono_estudiante`
--
ALTER TABLE `telefono_estudiante`
  MODIFY `Id_telefono_estudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turno_bibliotecario`
--
ALTER TABLE `turno_bibliotecario`
  MODIFY `Id_turno_bibliotecario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `autor_libro`
--
ALTER TABLE `autor_libro`
  ADD CONSTRAINT `autor_libro_ibfk_1` FOREIGN KEY (`Id_libro`) REFERENCES `libro` (`Id_libro`),
  ADD CONSTRAINT `autor_libro_ibfk_2` FOREIGN KEY (`Id_autor`) REFERENCES `autor` (`Id_autor`);

--
-- Filtros para la tabla `categoria_libro`
--
ALTER TABLE `categoria_libro`
  ADD CONSTRAINT `categoria_libro_ibfk_1` FOREIGN KEY (`Id_libro`) REFERENCES `libro` (`Id_libro`);

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`Id_libro`) REFERENCES `libro` (`Id_libro`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`Id_bibliotecario`) REFERENCES `bibliotecario` (`Id_bibliotecario`),
  ADD CONSTRAINT `prestamo_ibfk_3` FOREIGN KEY (`Id_estudiante`) REFERENCES `estudiante` (`Id_estudiante`);

--
-- Filtros para la tabla `telefono_bibliotecario`
--
ALTER TABLE `telefono_bibliotecario`
  ADD CONSTRAINT `telefono_bibliotecario_ibfk_1` FOREIGN KEY (`Id_bibliotecario`) REFERENCES `bibliotecario` (`Id_bibliotecario`);

--
-- Filtros para la tabla `telefono_estudiante`
--
ALTER TABLE `telefono_estudiante`
  ADD CONSTRAINT `telefono_estudiante_ibfk_1` FOREIGN KEY (`Id_estudiante`) REFERENCES `estudiante` (`Id_estudiante`);

--
-- Filtros para la tabla `turno_bibliotecario`
--
ALTER TABLE `turno_bibliotecario`
  ADD CONSTRAINT `turno_bibliotecario_ibfk_1` FOREIGN KEY (`Id_bibliotecario`) REFERENCES `bibliotecario` (`Id_bibliotecario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
