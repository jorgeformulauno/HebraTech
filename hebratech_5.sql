-- MySQL dump - hebratech_5
-- Cambios aplicados respecto a hebratech_4:
--   - Tabla detalle_entrada_materiales  (ELIMINADA)
--   - entrada_materiales: eliminada FK a usuarios (idUsuarioRegistro)
--   - entrada_materiales: agregada FK a materiales (idMaterial)
--   Cadena: proveedores -> entrada_materiales -> materiales
-- -------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- ----------------------------
-- Tabla: usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `correoElectronico` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `contrasena` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Almacenar siempre hasheada (bcrypt/argon2)',
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rol` enum('administrador','operario','cliente') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cliente',
  `especialidad` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Solo aplica a operarios',
  `fechaIngreso` date DEFAULT NULL COMMENT 'Solo aplica a operarios',
  `estado` enum('activo','inactivo','reportado') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  `fechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimaConexion` datetime DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `uq_correo` (`correoElectronico`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(1,'Andres','Pastrana','andrespastrana@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-11-26 16:00:00','2025-11-26 16:00:00'),
(2,'Jose','Quintero','josequintero@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-10-22 11:00:00','2025-10-22 14:00:00'),
(3,'Sara','Martinez','saraMartinez@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-09-12 09:00:00','2025-09-12 14:00:00'),
(4,'Camila','Londono','camilaLondono@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-08-22 07:00:00','2025-08-22 15:00:00'),
(5,'Juan','Pedraza','juanPedraza@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'inactivo','2025-07-01 12:00:00','2025-07-01 06:00:00'),
(6,'Juan','Alba','juanalba@gmail.com','$2b$10$HASH_PENDIENTE','1234567891',NULL,'operario','Planchado','2025-11-21','activo','2026-03-01 14:57:08',NULL),
(7,'Jorge','Almanza','jorgealmanza@gmail.com','$2b$10$HASH_PENDIENTE','1234567892',NULL,'operario','Corte','2025-11-22','activo','2026-03-01 14:57:08',NULL),
(8,'David','Sierra','davidsierra@gmail.com','$2b$10$HASH_PENDIENTE','1234567893',NULL,'operario','Confeccion','2025-11-23','activo','2026-03-01 14:57:08',NULL),
(9,'David','Cano','davidcano@gmail.com','$2b$10$HASH_PENDIENTE','1234567894',NULL,'operario','Bordado','2025-11-24','activo','2026-03-01 14:57:08',NULL),
(10,'Juan','Perez','juan@example.com','$2b$10$HASH_PENDIENTE','5551234','123 Main St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),
(11,'Maria','Gomez','maria@example.com','$2b$10$HASH_PENDIENTE','5555678','456 Elm St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),
(12,'Carlos','Sanchez','carlos@example.com','$2b$10$HASH_PENDIENTE','5559012','789 Oak St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),
(13,'Ana','Martinez','ana@example.com','$2b$10$HASH_PENDIENTE','5553456','101 Pine St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),
(14,'Luis','Rodriguez','luis@example.com','$2b$10$HASH_PENDIENTE','5557890','202 Maple St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL COMMENT 'FK a usuarios',
  `tipoCliente` enum('Natural','Empresa') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Natural',
  `empresa` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Nombre empresa (si aplica)',
  `nit` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'NIT o cédula tributaria',
  `limiteCredito` decimal(12,2) NOT NULL DEFAULT '0.00',
  `fechaRegistro` date NOT NULL,
  `estado` enum('activo','inactivo','bloqueado') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `uq_cliente_usuario` (`idUsuario`),
  CONSTRAINT `fk_cli_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES
(1,10,'Natural','Almacenes Exito','1156098657',500000.00,'2026-03-01','activo'),
(2,11,'Natural','Koaj','60987567',300000.00,'2026-03-01','activo'),
(3,12,'Empresa','Sanchez & Cia','900123456-1',1000000.00,'2026-03-01','activo'),
(4,13,'Natural','Colorim','45987276',200000.00,'2026-03-01','activo'),
(5,14,'Natural','Almacenes Paloquemao','2345678953',150000.00,'2026-03-01','activo'),
(6,5,'Natural','N/A','1023456789',1500000.00,'2026-03-16','activo'),
(7,6,'Empresa','Soluciones Digitales LTDA','901234567-2',8000000.00,'2026-03-16','activo');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: operarios
-- ----------------------------
DROP TABLE IF EXISTS `operarios`;
CREATE TABLE `operarios` (
  `idOperario` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL COMMENT 'FK a usuarios',
  `especialidad` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `fechaIngreso` date NOT NULL,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`idOperario`),
  KEY `fk_op_usuario` (`idUsuario`),
  CONSTRAINT `fk_op_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `operarios` WRITE;
/*!40000 ALTER TABLE `operarios` DISABLE KEYS */;
INSERT INTO `operarios` VALUES
(1,6,'Planchado','2025-11-21','activo'),
(2,7,'Corte','2025-11-22','activo'),
(3,8,'Confeccion','2025-11-23','activo'),
(4,9,'Bordado','2025-11-24','activo'),
(5,5,'Electricidad','2026-03-16','activo'),
(6,6,'Mecánica','2026-03-16','activo'),
(7,7,'Carpintería','2026-03-16','activo');
/*!40000 ALTER TABLE `operarios` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `categoria` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES
(1,'Jeans','Pantalon de jeans cosido a mano',120.00,'Tela',0),
(2,'Chaquetas','Chaquetas de jeans cosidas a mano',220.00,'Jeans',0),
(3,'Bermudas','Bermudas de tela de alta calidad',100.00,'Tela',0),
(4,'Hoodies','Abrigo de tela para invierno',220.00,'Tela',0),
(5,'Laptop HP','Laptop HP 15 pulgadas, i5, 8GB RAM',2500000.00,'Electrónica',10),
(6,'Mouse Logitech','Mouse inalámbrico Logitech',50000.00,'Accesorios',50),
(7,'Teclado Mecánico','Teclado mecánico RGB para gaming',150000.00,'Accesorios',30);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: inventario
-- ----------------------------
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
  `idInventario` int NOT NULL AUTO_INCREMENT,
  `idProducto` int NOT NULL,
  `cantidadDisponible` int NOT NULL DEFAULT '0',
  `minimoDefinido` int NOT NULL DEFAULT '0',
  `nivelStock` int DEFAULT NULL,
  `unidades` varchar(30) COLLATE utf8mb4_general_ci DEFAULT 'unidades',
  `ubicacion` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaActualizacion` date DEFAULT NULL,
  PRIMARY KEY (`idInventario`),
  KEY `fk_inv_producto` (`idProducto`),
  CONSTRAINT `fk_inv_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES
(1,1,50,10,50,'unidades','Bodega A','2024-05-01'),
(2,2,30,5,30,'unidades','Bodega A','2024-05-01'),
(3,3,80,15,80,'unidades','Bodega B','2024-05-01'),
(4,4,20,5,20,'unidades','Bodega B','2024-05-01'),
(5,1,10,2,0,'Unidad','Bodega A','2026-03-16'),
(6,2,50,5,0,'Unidad','Bodega B','2026-03-16'),
(7,3,30,3,0,'Unidad','Bodega C','2026-03-16');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: ordenes
-- ----------------------------
DROP TABLE IF EXISTS `ordenes`;
CREATE TABLE `ordenes` (
  `idOrden` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL COMMENT 'FK a clientes',
  `idUsuarioRegistro` int NOT NULL COMMENT 'FK a usuarios con rol=administrador/operario',
  `fechaCreacion` date NOT NULL,
  `fechaEntregaEstimada` date DEFAULT NULL,
  `instrucciones` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `prioridad` enum('Normal','Urgente') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Normal',
  `estado` enum('Pendiente','Procesando','Enviado','Entregado','Cancelado') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`idOrden`),
  KEY `fk_ord_cliente` (`idCliente`),
  CONSTRAINT `fk_ord_cliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
INSERT INTO `ordenes` VALUES
(1,1,1,'2024-05-15','2024-05-20','Jeans para dama con tela licrada','Normal','Enviado'),
(2,2,2,'2024-05-16','2024-05-21','Chaquetas oversize','Normal','Pendiente'),
(3,3,3,'2024-05-17','2024-05-22','Jean para hombre','Urgente','Procesando'),
(4,4,4,'2024-05-18','2024-05-23','Bermudas para hombre','Urgente','Cancelado'),
(5,3,1,'2026-03-16','2026-03-20','Entregar en recepción','Normal','Pendiente'),
(6,4,2,'2026-03-16','2026-03-21','Revisar antes de enviar','Normal','Pendiente'),
(7,2,1,'2026-03-16','2026-03-22','Empaquetar con cuidado','Normal','Pendiente');
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: detalle_ordenes
-- ----------------------------
DROP TABLE IF EXISTS `detalle_ordenes`;
CREATE TABLE `detalle_ordenes` (
  `idDetalle` int NOT NULL AUTO_INCREMENT,
  `idOrden` int NOT NULL,
  `idProducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precioUnitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idDetalle`),
  KEY `fk_det_orden` (`idOrden`),
  KEY `fk_det_producto` (`idProducto`),
  CONSTRAINT `fk_det_orden` FOREIGN KEY (`idOrden`) REFERENCES `ordenes` (`idOrden`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_det_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `detalle_ordenes` WRITE;
/*!40000 ALTER TABLE `detalle_ordenes` DISABLE KEYS */;
INSERT INTO `detalle_ordenes` VALUES
(1,1,1,2,24.99,49.98),
(2,1,2,1,19.99,19.99),
(3,2,3,3,29.99,89.97),
(4,3,4,2,14.99,29.98),
(5,5,5,3,15000.00,45000.00),
(6,6,6,2,20000.00,40000.00),
(7,7,7,1,50000.00,50000.00);
/*!40000 ALTER TABLE `detalle_ordenes` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: facturas
-- ----------------------------
DROP TABLE IF EXISTS `facturas`;
CREATE TABLE `facturas` (
  `idFactura` int NOT NULL AUTO_INCREMENT,
  `idOrden` int NOT NULL,
  `tipoDocumento` enum('Factura','Garantia') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Factura',
  `fechaEmision` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `montoTotal` decimal(20,2) NOT NULL,
  `impuesto` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Porcentaje, ej: 0.15 = 15%',
  `estado` enum('Pagada','Pendiente','Cancelada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  `numeroSerie` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Número de serie del producto en garantía',
  `fechaVencimientoGarantia` date DEFAULT NULL COMMENT 'Fecha hasta la que cubre la garantía',
  PRIMARY KEY (`idFactura`),
  KEY `fk_fac_orden` (`idOrden`),
  CONSTRAINT `fk_fac_orden` FOREIGN KEY (`idOrden`) REFERENCES `ordenes` (`idOrden`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES
(1,1,'Factura','2024-05-20 00:00:00',199.99,0.15,'Pagada',NULL,NULL),
(2,2,'Factura','2024-05-21 00:00:00',49.99,0.15,'Pendiente',NULL,NULL),
(3,3,'Factura','2024-05-22 00:00:00',299.99,0.15,'Pagada',NULL,NULL),
(4,4,'Factura','2024-05-23 00:00:00',89.99,0.15,'Cancelada',NULL,NULL),
(5,1,'Garantia','2024-05-20 00:00:00',0.00,0.00,'Pagada','SN-JEANS-2024-001','2025-05-20'),
(6,6,'Factura','2026-03-16 00:00:00',45000.00,19.00,'Pagada','F-2026-005','2027-03-16'),
(7,7,'Factura','2026-03-16 00:00:00',40000.00,19.00,'Pendiente','F-2026-006','2027-03-16');
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: devoluciones
-- ----------------------------
DROP TABLE IF EXISTS `devoluciones`;
CREATE TABLE `devoluciones` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `idInventario` int NOT NULL COMMENT 'FK a inventario',
  `fechaDevolucion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidadDevuelta` int NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `estadoDevolucion` enum('Recibida','Inspeccionada','Rechazada','Completada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Recibida',
  `montoReembolso` decimal(20,2) DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`idDevolucion`),
  KEY `fk_dev_inventario` (`idInventario`),
  CONSTRAINT `fk_dev_inventario` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES
(1,4,'2024-06-04 00:00:00',1,'Entrega tardía','Recibida',29.99,'El artículo llegó demasiado tarde para el evento'),
(2,1,'2024-06-01 00:00:00',2,'Producto defectuoso','Recibida',49.98,'Prendas devueltas por defectos'),
(3,2,'2024-06-02 00:00:00',1,'No enviaron el artículo correcto','Inspeccionada',19.99,'Cliente recibió producto incorrecto'),
(4,3,'2024-06-03 00:00:00',3,'Cambio de opinión','Recibida',89.97,'Cliente decidió no quedarse con los artículos'),
(5,1,'2026-03-16 00:00:00',2,'Producto defectuoso','Recibida',30000.00,'Cliente reportó daños en el envío'),
(6,2,'2026-03-16 00:00:00',1,'Entrega incorrecta','Recibida',50000.00,'Se entregó producto equivocado'),
(7,3,'2026-03-16 00:00:00',3,'Producto vencido','Recibida',45000.00,'Revisión de lote vencido');
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: produccion
-- ----------------------------
DROP TABLE IF EXISTS `produccion`;
CREATE TABLE `produccion` (
  `idProduccion` int NOT NULL AUTO_INCREMENT,
  `idProducto` int NOT NULL COMMENT 'Qué producto se produce',
  `idUsuarioResponsable` int NOT NULL COMMENT 'Administrador responsable',
  `nombre` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `cantidadProducir` int NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `nuevaFechaInicio` date DEFAULT NULL COMMENT 'Si fue reprogramada',
  `nuevaFechaFin` date DEFAULT NULL COMMENT 'Si fue reprogramada',
  `fechaReprogramacion` date DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completado','Detenido') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`idProduccion`),
  KEY `fk_prod_producto` (`idProducto`),
  CONSTRAINT `fk_prod_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
INSERT INTO `produccion` VALUES
(1,1,1,'Producción pantalones',10,'2026-03-16','2026-03-20',NULL,NULL,NULL,'Pendiente'),
(2,2,2,'Producción blusas',50,'2026-03-16','2026-03-18',NULL,NULL,NULL,'Pendiente'),
(3,3,3,'Producción chaquetas',30,'2026-03-16','2026-03-19',NULL,NULL,NULL,'Pendiente'),
(4,1,4,'Producción bermudas',5,'2026-03-17','2026-03-21',NULL,NULL,NULL,'Pendiente'),
(5,2,5,'Producción jeans dama',20,'2026-03-17','2026-03-19',NULL,NULL,NULL,'Pendiente'),
(6,3,6,'Producción jeans caballero',15,'2026-03-18','2026-03-20',NULL,NULL,NULL,'Pendiente'),
(7,1,7,'Producción camisas oversize',8,'2026-03-18','2026-03-22',NULL,NULL,NULL,'Pendiente');
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: tareas
-- ----------------------------
DROP TABLE IF EXISTS `tareas`;
CREATE TABLE `tareas` (
  `idTarea` int NOT NULL AUTO_INCREMENT,
  `idProduccion` int DEFAULT NULL COMMENT 'Tarea vinculada a un proceso de producción',
  `nombreTarea` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcionTarea` text COLLATE utf8mb4_general_ci NOT NULL,
  `fechaCreacion` date NOT NULL,
  `proceso` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `complejidad` enum('baja','media','alta') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idTarea`),
  KEY `fk_tarea_produccion` (`idProduccion`),
  CONSTRAINT `fk_tarea_produccion` FOREIGN KEY (`idProduccion`) REFERENCES `produccion` (`idProduccion`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
INSERT INTO `tareas` VALUES
(1,NULL,'Realizar Planchado','Revisar y ejecutar el proceso de planchado','2024-01-10','Planchado','media'),
(2,NULL,'Diseñar','Crear el diseño de los nuevos productos','2024-01-12','Diseño','alta'),
(3,NULL,'Desarrollar remate','Ejecutar el remate de la materia prima','2024-01-15','Desarrollo','alta'),
(4,NULL,'Realizar Pruebas Unitarias','Ejecutar pruebas unitarias en el marco de control de calidad','2024-01-20','Control de Calidad','media'),
(5,NULL,'Desplegar en Producción','Llevar a cabo el despliegue del sistema en el entorno de producción','2024-01-25','Despliegue','baja'),
(6,5,'Plancha y acabado','Planchar y dar acabado final a la camiseta','2026-03-16','Acabado','media'),
(7,6,'Empaque','Empacar pantalones jean en bolsas individuales','2026-03-16','Empaque','baja');
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: asignacion_tareas
-- ----------------------------
DROP TABLE IF EXISTS `asignacion_tareas`;
CREATE TABLE `asignacion_tareas` (
  `idAsignacion` int NOT NULL AUTO_INCREMENT,
  `idTarea` int NOT NULL,
  `idOperario` int NOT NULL COMMENT 'FK a operarios',
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `fechaAsignacion` date NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFinalizacion` date DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completada','Cancelada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  `prioridad` enum('Baja','Media','Alta','Urgente') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Media',
  `horasEstimadas` decimal(5,2) NOT NULL,
  `horasReales` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`idAsignacion`),
  KEY `fk_asig_tarea` (`idTarea`),
  KEY `fk_asig_operario` (`idOperario`),
  CONSTRAINT `fk_asig_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_asig_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `asignacion_tareas` WRITE;
/*!40000 ALTER TABLE `asignacion_tareas` DISABLE KEYS */;
INSERT INTO `asignacion_tareas` VALUES
(1,1,1,'Reparar la máquina A','2024-01-10','2024-01-11','2024-01-15','Completada','Alta',20.00,18.00),
(2,2,2,'Mantenimiento preventivo de la línea B','2024-01-12','2024-01-13',NULL,'En Progreso','Media',15.00,NULL),
(3,3,3,'Reparar','2024-01-14','2024-01-15','2024-01-16','Pendiente','Baja',10.00,5.00),
(4,4,4,'Inspección de la materia prima','2024-01-15','2024-01-16','2024-01-17','Completada','Alta',8.00,7.00),
(5,2,1,'Revisión de equipo','2026-03-16','2026-03-17','2026-03-18','Pendiente','Alta',5.00,0.00),
(6,3,2,'Mantenimiento preventivo','2026-03-16','2026-03-17','2026-03-19','Pendiente','Media',8.00,3.00),
(7,4,3,'Instalación de sistema','2026-03-16','2026-03-18','2026-03-20','Pendiente','Alta',10.00,0.00);
/*!40000 ALTER TABLE `asignacion_tareas` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: incidencias
-- ----------------------------
DROP TABLE IF EXISTS `incidencias`;
CREATE TABLE `incidencias` (
  `idIncidencia` int NOT NULL AUTO_INCREMENT,
  `idOperario` int NOT NULL COMMENT 'Operario que genera la incidencia',
  `tipoIncidencia` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ej: desempeño, ventas, inventario',
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `periodoEvaluado` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` varchar(30) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Generado',
  `fechaGeneracion` date NOT NULL,
  `fechaRevision` date DEFAULT NULL,
  PRIMARY KEY (`idIncidencia`),
  KEY `fk_inc_operario` (`idOperario`),
  CONSTRAINT `fk_inc_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
INSERT INTO `incidencias` VALUES
(1,1,'Inventario','Reporte de Inventario Mensual',NULL,'Generado','2024-05-31','2024-06-01'),
(2,2,'Ventas','Reporte de Ventas Semanal',NULL,'Generado','2024-06-07','2024-06-08'),
(3,3,'Desempeño','Reporte de Rendimiento de Empleados',NULL,'Generado','2024-06-15','2024-06-16'),
(4,4,'Clientes','Reporte de Análisis de Clientes',NULL,'Generado','2024-06-20','2024-06-21'),
(5,1,'Retraso','Llegada tarde al turno','Marzo 2026','Pendiente','2026-03-16',NULL),
(6,2,'Falta','Ausencia sin aviso','Marzo 2026','Pendiente','2026-03-16',NULL),
(7,3,'Error de procedimiento','No siguió el protocolo de seguridad','Marzo 2026','Pendiente','2026-03-16',NULL);
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: materiales
-- ----------------------------
DROP TABLE IF EXISTS `materiales`;
CREATE TABLE `materiales` (
  `idMaterial` int NOT NULL AUTO_INCREMENT,
  `nombreMaterial` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci,
  `stockActual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stockMinimo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unidadBase` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unidad',
  `costoUnitario` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fechaActualizacion` date DEFAULT NULL,
  PRIMARY KEY (`idMaterial`),
  UNIQUE KEY `uq_nombre_material` (`nombreMaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `materiales` WRITE;
/*!40000 ALTER TABLE `materiales` DISABLE KEYS */;
INSERT INTO `materiales` VALUES
(1,'Tornillo M6','Tornillo de acero M6 x 20mm',500.00,100.00,'Unidad',50.00,'2026-03-16'),
(2,'Tuerca M6','Tuerca de acero M6',500.00,100.00,'Unidad',20.00,'2026-03-16'),
(3,'Arandela M6','Arandela plana M6',500.00,100.00,'Unidad',5.00,'2026-03-16'),
(4,'Tablero MDF 18mm','Tablero MDF 18mm x 2.4m x 1.2m',50.00,10.00,'Unidad',120000.00,'2026-03-16'),
(5,'Pintura Acrílica 1L','Pintura acrílica blanca 1 litro',100.00,20.00,'Litro',15000.00,'2026-03-16'),
(6,'Clavo 2"','Clavo de acero 2 pulgadas',1000.00,200.00,'Unidad',2.00,'2026-03-16'),
(7,'Pegamento Industrial','Pegamento de contacto 500ml',200.00,50.00,'Unidad',25000.00,'2026-03-16');
/*!40000 ALTER TABLE `materiales` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: tarea_materiales
-- ----------------------------
DROP TABLE IF EXISTS `tarea_materiales`;
CREATE TABLE `tarea_materiales` (
  `idTareaMaterial` int NOT NULL AUTO_INCREMENT,
  `idTarea` int NOT NULL,
  `idMaterial` int NOT NULL,
  `cantidadUsada` decimal(10,2) NOT NULL COMMENT 'Cantidad consumida del material',
  `unidad` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unidad',
  `observaciones` text COLLATE utf8mb4_general_ci,
  `fechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTareaMaterial`),
  UNIQUE KEY `uq_tarea_material` (`idTarea`,`idMaterial`) COMMENT 'Un material no se repite en la misma tarea',
  KEY `fk_tm_tarea` (`idTarea`),
  KEY `fk_tm_material` (`idMaterial`),
  CONSTRAINT `fk_tm_material` FOREIGN KEY (`idMaterial`) REFERENCES `materiales` (`idMaterial`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tm_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `tarea_materiales` WRITE;
/*!40000 ALTER TABLE `tarea_materiales` DISABLE KEYS */;
INSERT INTO `tarea_materiales` VALUES
(1,5,1,2.00,'Metro','Tela para camiseta talla M','2026-03-16 00:00:00'),
(2,5,2,1.00,'Carrete','Hilo para costura de camiseta','2026-03-16 00:00:00'),
(3,5,3,4.00,'Unidad','Botones para camiseta','2026-03-16 00:00:00'),
(4,6,1,0.00,'Metro','Tela ya cortada usada para plancha','2026-03-16 00:00:00'),
(5,6,2,0.50,'Carrete','Hilo usado para refuerzo de costuras','2026-03-16 00:00:00'),
(6,7,3,0.00,'Unidad','Botones revisados durante empaque','2026-03-16 00:00:00'),
(7,7,2,0.20,'Carrete','Hilo usado para ajustes finales en empaque','2026-03-16 00:00:00');
/*!40000 ALTER TABLE `tarea_materiales` ENABLE KEYS */;
UNLOCK TABLES;

-- ============================================================
-- NUEVAS TABLAS
-- ============================================================

-- ----------------------------
-- Tabla: proveedores
-- Conectada a usuarios (idUsuario = quien registra/gestiona el proveedor)
-- ----------------------------
DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL COMMENT 'FK a usuarios — usuario que gestiona este proveedor',
  `nombreEmpresa` varchar(150) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre de la empresa proveedora',
  `nombreContacto` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Persona de contacto',
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `correo` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nit` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'NIT o identificación tributaria del proveedor',
  `estado` enum('activo','inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  `fechaRegistro` date NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`idProveedor`),
  KEY `fk_prov_usuario` (`idUsuario`),
  CONSTRAINT `fk_prov_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES
(1,1,'Ferretería Industrial S.A.','Carlos Ruiz','3001234567','ferreteria@proveedor.com','Calle 10 # 20-30, Bogotá','900111222-1','activo','2026-03-01'),
(2,2,'Maderas del Norte LTDA','Lucía Herrera','3019876543','maderas@norte.com','Av. 68 # 5-15, Bogotá','800333444-2','activo','2026-03-05'),
(3,1,'Pinturas y Acabados SAS','Roberto Mora','3105556677','pinturas@acabados.com','Carrera 30 # 45-10, Medellín','901555666-3','activo','2026-03-10');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: entrada_materiales
-- Cabecera de cada entrada/compra de materiales.
-- CAMBIOS v5:
--   - Eliminada FK a usuarios (idUsuarioRegistro)
--   - Agregada FK a materiales (idMaterial)
-- Cadena: proveedores -> entrada_materiales -> materiales
-- ----------------------------
DROP TABLE IF EXISTS `entrada_materiales`;
CREATE TABLE `entrada_materiales` (
  `idEntrada` int NOT NULL AUTO_INCREMENT,
  `idProveedor` int NOT NULL COMMENT 'FK a proveedores',
  `idMaterial` int NOT NULL COMMENT 'FK a materiales — material que ingresa en esta entrada',
  `fechaEntrada` date NOT NULL COMMENT 'Fecha en que ingresan los materiales',
  `cantidad` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Cantidad de unidades que ingresan',
  `precioUnitario` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Precio de compra unitario',
  `subtotal` decimal(12,2) GENERATED ALWAYS AS (`cantidad` * `precioUnitario`) STORED COMMENT 'Calculado automáticamente',
  `unidad` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unidad',
  `numeroRemision` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Número de remisión o factura del proveedor',
  `observaciones` text COLLATE utf8mb4_general_ci,
  `estado` enum('Pendiente','Recibida','Cancelada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  `fechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEntrada`),
  KEY `fk_em_proveedor` (`idProveedor`),
  KEY `fk_em_material` (`idMaterial`),
  CONSTRAINT `fk_em_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`) ON UPDATE CASCADE,
  CONSTRAINT `fk_em_material` FOREIGN KEY (`idMaterial`) REFERENCES `materiales` (`idMaterial`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `entrada_materiales` WRITE;
/*!40000 ALTER TABLE `entrada_materiales` DISABLE KEYS */;
INSERT INTO `entrada_materiales` (`idEntrada`,`idProveedor`,`idMaterial`,`fechaEntrada`,`cantidad`,`precioUnitario`,`unidad`,`numeroRemision`,`observaciones`,`estado`,`fechaRegistro`) VALUES
(1,1,1,'2026-03-10',200.00,48.00,'Unidad','REM-2026-001','Tornillos M6 para stock','Recibida','2026-03-10 08:30:00'),
(2,1,2,'2026-03-10',200.00,18.00,'Unidad','REM-2026-001','Tuercas M6 para stock','Recibida','2026-03-10 08:30:00'),
(3,1,3,'2026-03-10',300.00,4.50,'Unidad','REM-2026-001','Arandelas M6 para stock','Recibida','2026-03-10 08:30:00'),
(4,2,4,'2026-03-12',20.00,115000.00,'Unidad','REM-2026-002','Tableros MDF calibre 18mm','Recibida','2026-03-12 09:00:00'),
(5,3,5,'2026-03-15',50.00,14500.00,'Litro','REM-2026-003','Pintura acrílica blanca','Pendiente','2026-03-15 11:00:00'),
(6,3,7,'2026-03-15',30.00,24000.00,'Unidad','REM-2026-003','Pegamento industrial 500ml','Pendiente','2026-03-15 11:00:00');
/*!40000 ALTER TABLE `entrada_materiales` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Índices adicionales de rendimiento
-- ----------------------------
CREATE INDEX `idx_prov_usuario`   ON `proveedores`      (`idUsuario`);
CREATE INDEX `idx_em_proveedor`   ON `entrada_materiales` (`idProveedor`);
CREATE INDEX `idx_em_material`    ON `entrada_materiales` (`idMaterial`);

-- ============================================================
-- NOTAS v5:
--   - detalle_entrada_materiales: ELIMINADA
--   - entrada_materiales: eliminada FK a usuarios, eliminado idUsuarioRegistro
--   - entrada_materiales: agregada FK a materiales (idMaterial)
--   - Los campos cantidad, precioUnitario, subtotal y unidad
--     se movieron desde detalle_entrada_materiales a entrada_materiales
--   - Cadena final: proveedores -> entrada_materiales -> materiales
-- ============================================================

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump actualizado: 2026-03-16
