-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.45 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.17.0.7270
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla game_food.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `ID_Cliente` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Apellido_Paterno` varchar(50) NOT NULL,
  `Apellido_Materno` varchar(50) NOT NULL,
  `Telefono` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla game_food.cliente: ~0 rows (aproximadamente)

-- Volcando estructura para tabla game_food.detalle_pedido
CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `ID_Detalle_Pedido` int NOT NULL AUTO_INCREMENT,
  `Cantidad_PLatos` int NOT NULL,
  `ID_Pedido` int DEFAULT NULL,
  `ID_Plato` int DEFAULT NULL,
  PRIMARY KEY (`ID_Detalle_Pedido`),
  KEY `fk_detalle_pedido_pedido` (`ID_Pedido`),
  KEY `fk_detalle_pedido_plato` (`ID_Plato`),
  CONSTRAINT `fk_detalle_pedido_pedido` FOREIGN KEY (`ID_Pedido`) REFERENCES `pedido` (`ID_Pedido`),
  CONSTRAINT `fk_detalle_pedido_plato` FOREIGN KEY (`ID_Plato`) REFERENCES `plato` (`ID_Plato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla game_food.detalle_pedido: ~0 rows (aproximadamente)

-- Volcando estructura para tabla game_food.pago
CREATE TABLE IF NOT EXISTS `pago` (
  `ID_Pago` int NOT NULL AUTO_INCREMENT,
  `Monto` double NOT NULL,
  `Metodo_Pago` varchar(50) NOT NULL,
  `ID_Pedido` int DEFAULT NULL,
  PRIMARY KEY (`ID_Pago`),
  UNIQUE KEY `ID_Pedido` (`ID_Pedido`),
  CONSTRAINT `fk_pago_pedido` FOREIGN KEY (`ID_Pedido`) REFERENCES `pedido` (`ID_Pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla game_food.pago: ~0 rows (aproximadamente)

-- Volcando estructura para tabla game_food.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `ID_Pedido` int NOT NULL AUTO_INCREMENT,
  `Estado` varchar(50) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `ID_Cliente` int DEFAULT NULL,
  PRIMARY KEY (`ID_Pedido`),
  KEY `fk_pedido_cliente` (`ID_Cliente`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla game_food.pedido: ~0 rows (aproximadamente)

-- Volcando estructura para tabla game_food.plato
CREATE TABLE IF NOT EXISTS `plato` (
  `ID_Plato` int NOT NULL AUTO_INCREMENT,
  `Categoria` varchar(50) NOT NULL,
  `Precio` double NOT NULL,
  `Nombre_Plato` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Plato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla game_food.plato: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
