-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-04-2026 a las 16:20:44
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
-- Base de datos: `herox`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrenadores`
--

CREATE TABLE `entrenadores` (
  `id_entrenador` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Especialidad` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `heroes`
--

CREATE TABLE `heroes` (
  `id_heroe` int(11) NOT NULL,
  `Nombre_Heroico` varchar(100) NOT NULL,
  `Identidad_Sec` varchar(100) DEFAULT NULL,
  `id_entrenador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `heroe_mision`
--

CREATE TABLE `heroe_mision` (
  `ID_H_M` int(11) NOT NULL,
  `id_heroe` int(11) DEFAULT NULL,
  `id_mision` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `heroe_poder`
--

CREATE TABLE `heroe_poder` (
  `ID_H_P` int(11) NOT NULL,
  `id_heroe` int(11) DEFAULT NULL,
  `id_poder` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `misiones`
--

CREATE TABLE `misiones` (
  `id_mision` int(11) NOT NULL,
  `Nombre_Mision` varchar(100) NOT NULL,
  `Rango_Peligro` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poderes`
--

CREATE TABLE `poderes` (
  `id_poder` int(11) NOT NULL,
  `Nombre_Poder` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  ADD PRIMARY KEY (`id_entrenador`);

--
-- Indices de la tabla `heroes`
--
ALTER TABLE `heroes`
  ADD PRIMARY KEY (`id_heroe`),
  ADD KEY `id_entrenador` (`id_entrenador`);

--
-- Indices de la tabla `heroe_mision`
--
ALTER TABLE `heroe_mision`
  ADD PRIMARY KEY (`ID_H_M`),
  ADD KEY `id_heroe` (`id_heroe`),
  ADD KEY `id_mision` (`id_mision`);

--
-- Indices de la tabla `heroe_poder`
--
ALTER TABLE `heroe_poder`
  ADD PRIMARY KEY (`ID_H_P`),
  ADD KEY `id_heroe` (`id_heroe`),
  ADD KEY `id_poder` (`id_poder`);

--
-- Indices de la tabla `misiones`
--
ALTER TABLE `misiones`
  ADD PRIMARY KEY (`id_mision`);

--
-- Indices de la tabla `poderes`
--
ALTER TABLE `poderes`
  ADD PRIMARY KEY (`id_poder`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  MODIFY `id_entrenador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `heroes`
--
ALTER TABLE `heroes`
  MODIFY `id_heroe` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `heroe_mision`
--
ALTER TABLE `heroe_mision`
  MODIFY `ID_H_M` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `heroe_poder`
--
ALTER TABLE `heroe_poder`
  MODIFY `ID_H_P` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `misiones`
--
ALTER TABLE `misiones`
  MODIFY `id_mision` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `poderes`
--
ALTER TABLE `poderes`
  MODIFY `id_poder` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `heroes`
--
ALTER TABLE `heroes`
  ADD CONSTRAINT `heroes_ibfk_1` FOREIGN KEY (`id_entrenador`) REFERENCES `entrenadores` (`id_entrenador`);

--
-- Filtros para la tabla `heroe_mision`
--
ALTER TABLE `heroe_mision`
  ADD CONSTRAINT `heroe_mision_ibfk_1` FOREIGN KEY (`id_heroe`) REFERENCES `heroes` (`id_heroe`),
  ADD CONSTRAINT `heroe_mision_ibfk_2` FOREIGN KEY (`id_mision`) REFERENCES `misiones` (`id_mision`);

--
-- Filtros para la tabla `heroe_poder`
--
ALTER TABLE `heroe_poder`
  ADD CONSTRAINT `heroe_poder_ibfk_1` FOREIGN KEY (`id_heroe`) REFERENCES `heroes` (`id_heroe`),
  ADD CONSTRAINT `heroe_poder_ibfk_2` FOREIGN KEY (`id_poder`) REFERENCES `poderes` (`id_poder`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
