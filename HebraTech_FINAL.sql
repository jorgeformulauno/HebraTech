-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: arreglos
-- ------------------------------------------------------
-- Server version	8.0.44

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

--
-- Table structure for table `asignacion_tareas`
--

DROP TABLE IF EXISTS `asignacion_tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion_tareas` (
  `idAsignacion` int NOT NULL AUTO_INCREMENT,
  `idTarea` int NOT NULL,
  `idOperario` int NOT NULL COMMENT 'FK a operarios',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fechaAsignacion` date NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFinalizacion` date DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completada','Cancelada') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  `prioridad` enum('Baja','Media','Alta','Urgente') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Media',
  `horasEstimadas` decimal(5,2) NOT NULL,
  `horasReales` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`idAsignacion`),
  KEY `fk_asig_tarea` (`idTarea`),
  KEY `fk_asig_operario` (`idOperario`),
  CONSTRAINT `fk_asig_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_asig_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion_tareas`
--

LOCK TABLES `asignacion_tareas` WRITE;
/*!40000 ALTER TABLE `asignacion_tareas` DISABLE KEYS */;
INSERT INTO `asignacion_tareas` VALUES (11,1,1,'Reparar la máquina A','2024-01-10','2024-01-11','2024-01-15','Completada','Alta',20.00,18.00),(22,2,2,'Mantenimiento preventivo de la línea B','2024-01-12','2024-01-13',NULL,'En Progreso','Media',15.00,NULL),(33,3,3,'Reparar','2024-01-14','2024-01-15','2024-01-16','Pendiente','Baja',10.00,5.00),(44,4,4,'Inspección de la materia prima','2024-01-15','2024-01-16','2024-01-17','Completada','Alta',8.00,7.00);
/*!40000 ALTER TABLE `asignacion_tareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL COMMENT 'FK a usuarios',
  `tipoCliente` enum('Natural','Empresa') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Natural',
  `empresa` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Nombre empresa (si aplica)',
  `nit` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'NIT o cédula tributaria',
  `limiteCredito` decimal(12,2) NOT NULL DEFAULT '0.00',
  `fechaRegistro` date NOT NULL DEFAULT (curdate()),
  `estado` enum('activo','inactivo','bloqueado') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `uq_cliente_usuario` (`idUsuario`),
  KEY `fk_cli_usuario` (`idUsuario`),
  CONSTRAINT `fk_cli_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (20,20,'Natural',NULL,NULL,500000.00,'2026-03-01','activo'),(21,21,'Natural',NULL,NULL,300000.00,'2026-03-01','activo'),(22,22,'Empresa','Sanchez & Cia','900123456-1',1000000.00,'2026-03-01','activo'),(23,23,'Natural',NULL,NULL,200000.00,'2026-03-01','activo'),(24,24,'Natural',NULL,NULL,150000.00,'2026-03-01','activo');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_ordenes`
--

DROP TABLE IF EXISTS `detalle_ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_ordenes`
--

LOCK TABLES `detalle_ordenes` WRITE;
/*!40000 ALTER TABLE `detalle_ordenes` DISABLE KEYS */;
INSERT INTO `detalle_ordenes` VALUES (1,1001,1,2,24.99,49.98),(2,1001,2,1,19.99,19.99),(3,1002,3,3,29.99,89.97),(4,1003,4,2,14.99,29.98);
/*!40000 ALTER TABLE `detalle_ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_tarea`
--

DROP TABLE IF EXISTS `detalles_tarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_tarea` (
  `idDetalleTarea` int NOT NULL AUTO_INCREMENT,
  `idAsignacion` int NOT NULL COMMENT 'FK a asignacion_tareas — reemplaza la conexión directa a usuarios',
  `estadoAnterior` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estadoNuevo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tipoAccion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `motivoCambio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notificado` tinyint(1) NOT NULL DEFAULT '0',
  `historiaTarea` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `fechaCambio` datetime NOT NULL,
  `fechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleTarea`),
  KEY `fk_det_asignacion` (`idAsignacion`),
  CONSTRAINT `fk_det_asignacion` FOREIGN KEY (`idAsignacion`) REFERENCES `asignacion_tareas` (`idAsignacion`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_tarea`
--

LOCK TABLES `detalles_tarea` WRITE;
/*!40000 ALTER TABLE `detalles_tarea` DISABLE KEYS */;
INSERT INTO `detalles_tarea` VALUES (1,11,'Pendiente','En Progreso','Cambio de estado','Inicio de tarea',1,NULL,'Ninguna','2024-06-01 00:00:00','2026-03-01 14:57:08'),(2,22,'En Progreso','Completado','Cambio de estado','Tarea finalizada',1,NULL,'Ninguna','2024-06-02 00:00:00','2026-03-01 14:57:08'),(3,33,'Pendiente','Cancelado','Cambio de estado','Cliente canceló',0,NULL,'Cliente solicitó cancelación','2024-06-03 00:00:00','2026-03-01 14:57:08'),(4,44,'En Progreso','En Espera','Cambio de estado','Esperando materiales',0,NULL,'Materiales retrasados','2024-06-04 00:00:00','2026-03-01 14:57:08');
/*!40000 ALTER TABLE `detalles_tarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devoluciones` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `idInventario` int NOT NULL COMMENT 'FK a inventario — reemplaza la conexión directa a productos',
  `fechaDevolucion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidadDevuelta` int NOT NULL,
  `motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estadoDevolucion` enum('Recibida','Inspeccionada','Rechazada','Completada') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Recibida',
  `montoReembolso` decimal(20,2) DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`idDevolucion`),
  KEY `fk_dev_inventario` (`idInventario`),
  CONSTRAINT `fk_dev_inventario` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoluciones`
--

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES (42,4,'2024-06-04 00:00:00',1,'Entrega tardía','Recibida',29.99,'El artículo llegó demasiado tarde para el evento'),(123,1,'2024-06-01 00:00:00',2,'Producto defectuoso','Recibida',49.98,'Prendas devueltas por defectos'),(244,2,'2024-06-02 00:00:00',1,'No enviaron el artículo correcto','Inspeccionada',19.99,'Cliente recibió producto incorrecto'),(355,3,'2024-06-03 00:00:00',3,'Cambio de opinión','Recibida',89.97,'Cliente decidió no quedarse con los artículos');
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `idFactura` int NOT NULL AUTO_INCREMENT,
  `idOrden` int NOT NULL,
  `tipoDocumento` enum('Factura','Garantia') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Factura',
  `fechaEmision` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `montoTotal` decimal(20,2) NOT NULL,
  `impuesto` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Porcentaje, ej: 0.15 = 15%',
  `estado` enum('Pagada','Pendiente','Cancelada') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  `numeroSerie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Número de serie del producto en garantía',
  `fechaVencimientoGarantia` date DEFAULT NULL COMMENT 'Fecha hasta la que cubre la garantía',
  PRIMARY KEY (`idFactura`),
  KEY `fk_fac_orden` (`idOrden`),
  CONSTRAINT `fk_fac_orden` FOREIGN KEY (`idOrden`) REFERENCES `ordenes` (`idOrden`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (5001,1001,'Factura','2024-05-20 00:00:00',199.99,0.15,'Pagada',NULL,NULL),(5002,1002,'Factura','2024-05-21 00:00:00',49.99,0.15,'Pendiente',NULL,NULL),(5003,1003,'Factura','2024-05-22 00:00:00',299.99,0.15,'Pagada',NULL,NULL),(5004,1004,'Factura','2024-05-23 00:00:00',89.99,0.15,'Cancelada',NULL,NULL),(5005,1001,'Garantia','2024-05-20 00:00:00',0.00,0.00,'Pagada','SN-JEANS-2024-001','2025-05-20');
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencias` (
  `idIncidencia` int NOT NULL AUTO_INCREMENT,
  `idOperario` int NOT NULL COMMENT 'Operario que genera la incidencia',
  `tipoIncidencia` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Ej: desempeño, ventas, inventario',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `periodoEvaluado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Generado',
  `fechaGeneracion` date NOT NULL,
  `fechaRevision` date DEFAULT NULL,
  PRIMARY KEY (`idIncidencia`),
  KEY `fk_inc_operario` (`idOperario`),
  CONSTRAINT `fk_inc_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias`
--

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
INSERT INTO `incidencias` VALUES (10,1,'Inventario','Reporte de Inventario Mensual',NULL,'Generado','2024-05-31','2024-06-01'),(20,2,'Ventas','Reporte de Ventas Semanal',NULL,'Generado','2024-06-07','2024-06-08'),(30,3,'Desempeño','Reporte de Rendimiento de Empleados',NULL,'Generado','2024-06-15','2024-06-16'),(40,4,'Clientes','Reporte de Análisis de Clientes',NULL,'Generado','2024-06-20','2024-06-21');
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `idInventario` int NOT NULL AUTO_INCREMENT,
  `idProducto` int NOT NULL,
  `cantidadDisponible` int NOT NULL DEFAULT '0',
  `minimoDefinido` int NOT NULL DEFAULT '0',
  `nivelStock` int DEFAULT NULL,
  `unidades` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'unidades',
  `ubicacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fechaActualizacion` date DEFAULT NULL,
  PRIMARY KEY (`idInventario`),
  KEY `fk_inv_producto` (`idProducto`),
  CONSTRAINT `fk_inv_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,50,10,50,'unidades','Bodega A','2024-05-01'),(2,2,30,5,30,'unidades','Bodega A','2024-05-01'),(3,3,80,15,80,'unidades','Bodega B','2024-05-01'),(4,4,20,5,20,'unidades','Bodega B','2024-05-01');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiales`
--

DROP TABLE IF EXISTS `materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiales` (
  `idMaterial` int NOT NULL AUTO_INCREMENT,
  `nombreMaterial` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `stockActual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stockMinimo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unidadBase` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unidad',
  `costoUnitario` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fechaActualizacion` date DEFAULT NULL,
  PRIMARY KEY (`idMaterial`),
  UNIQUE KEY `uq_nombre_material` (`nombreMaterial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiales`
--

LOCK TABLES `materiales` WRITE;
/*!40000 ALTER TABLE `materiales` DISABLE KEYS */;
/*!40000 ALTER TABLE `materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operarios`
--

DROP TABLE IF EXISTS `operarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operarios` (
  `idOperario` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL COMMENT 'FK a usuarios',
  `especialidad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fechaIngreso` date NOT NULL,
  `estado` enum('activo','inactivo') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`idOperario`),
  KEY `fk_op_usuario` (`idUsuario`),
  CONSTRAINT `fk_op_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operarios`
--

LOCK TABLES `operarios` WRITE;
/*!40000 ALTER TABLE `operarios` DISABLE KEYS */;
INSERT INTO `operarios` VALUES (1,10,'Planchado','2025-11-21','activo'),(2,11,'Corte','2025-11-22','activo'),(3,12,'Confeccion','2025-11-23','activo'),(4,13,'Bordado','2025-11-24','activo');
/*!40000 ALTER TABLE `operarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes`
--

DROP TABLE IF EXISTS `ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes` (
  `idOrden` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL COMMENT 'FK a clientes',
  `idUsuarioRegistro` int NOT NULL COMMENT 'FK a usuarios con rol=administrador/operario',
  `fechaCreacion` date NOT NULL,
  `fechaEntregaEstimada` date DEFAULT NULL,
  `instrucciones` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prioridad` enum('Normal','Urgente') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Normal',
  `estado` enum('Pendiente','Procesando','Enviado','Entregado','Cancelado') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`idOrden`),
  KEY `fk_ord_cliente` (`idCliente`),
  CONSTRAINT `fk_ord_cliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes`
--

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
INSERT INTO `ordenes` VALUES (1001,20,1,'2024-05-15','2024-05-20','Jeans para dama con tela licrada','Normal','Enviado'),(1002,21,2,'2024-05-16','2024-05-21','Chaquetas oversize','Normal','Pendiente'),(1003,22,3,'2024-05-17','2024-05-22','Jean para hombre','Urgente','Procesando'),(1004,23,4,'2024-05-18','2024-05-23','Bermudas para hombre','Urgente','Cancelado');
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produccion` (
  `idProduccion` int NOT NULL AUTO_INCREMENT,
  `idProducto` int NOT NULL COMMENT 'Qué producto se produce',
  `idUsuarioResponsable` int NOT NULL COMMENT 'Administrador responsable',
  `nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cantidadProducir` int NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `nuevaFechaInicio` date DEFAULT NULL COMMENT 'Si fue reprogramada',
  `nuevaFechaFin` date DEFAULT NULL COMMENT 'Si fue reprogramada',
  `fechaReprogramacion` date DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completado','Detenido') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`idProduccion`),
  KEY `fk_prod_producto` (`idProducto`),
  CONSTRAINT `fk_prod_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `categoria` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Jeans','Pantalon de jeans cosido a mano',120.00,'Tela',0),(2,'Chaquetas','Chaquetas de jeans cosidas a mano',220.00,'Jeans',0),(3,'Bermudas','Bermudas de tela de alta calidad',100.00,'Tela',0),(4,'Hoodies','Abrigo de tela para invierno',220.00,'Tela',0);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarea_materiales`
--

DROP TABLE IF EXISTS `tarea_materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarea_materiales` (
  `idTareaMaterial` int NOT NULL AUTO_INCREMENT,
  `idTarea` int NOT NULL,
  `idMaterial` int NOT NULL,
  `cantidadUsada` decimal(10,2) NOT NULL COMMENT 'Cantidad consumida del material',
  `unidad` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unidad',
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `fechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTareaMaterial`),
  UNIQUE KEY `uq_tarea_material` (`idTarea`,`idMaterial`) COMMENT 'Un material no se repite en la misma tarea',
  KEY `fk_tm_tarea` (`idTarea`),
  KEY `fk_tm_material` (`idMaterial`),
  CONSTRAINT `fk_tm_material` FOREIGN KEY (`idMaterial`) REFERENCES `materiales` (`idMaterial`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tm_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarea_materiales`
--

LOCK TABLES `tarea_materiales` WRITE;
/*!40000 ALTER TABLE `tarea_materiales` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarea_materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tareas`
--

DROP TABLE IF EXISTS `tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tareas` (
  `idTarea` int NOT NULL AUTO_INCREMENT,
  `idProduccion` int DEFAULT NULL COMMENT 'Tarea vinculada a un proceso de producción',
  `nombreTarea` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `descripcionTarea` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fechaCreacion` date NOT NULL,
  `proceso` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `complejidad` enum('baja','media','alta') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idTarea`),
  KEY `fk_tarea_produccion` (`idProduccion`),
  CONSTRAINT `fk_tarea_produccion` FOREIGN KEY (`idProduccion`) REFERENCES `produccion` (`idProduccion`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tareas`
--

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
INSERT INTO `tareas` VALUES (1,NULL,'Realizar Planchado','Revisar y ejecutar el proceso de planchado','2024-01-10','Planchado','media'),(2,NULL,'Diseñar','Crear el diseño de los nuevos productos','2024-01-12','Diseño','alta'),(3,NULL,'Desarrollar remate','Ejecutar el remate de la materia prima','2024-01-15','Desarrollo','alta'),(4,NULL,'Realizar Pruebas Unitarias','Ejecutar pruebas unitarias en el marco de control de calidad','2024-01-20','Control de Calidad','media'),(5,NULL,'Desplegar en Producción','Llevar a cabo el despliegue del sistema en el entorno de producción','2024-01-25','Despliegue','baja');
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `correoElectronico` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Almacenar siempre hasheada (bcrypt/argon2)',
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rol` enum('administrador','operario','cliente') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cliente',
  `especialidad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Solo aplica a operarios',
  `fechaIngreso` date DEFAULT NULL COMMENT 'Solo aplica a operarios',
  `estado` enum('activo','inactivo','reportado') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  `fechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimaConexion` datetime DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `uq_correo` (`correoElectronico`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Andres','Pastrana','andrespastrana@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-11-26 16:00:00','2025-11-26 16:00:00'),(2,'Jose','Quintero','josequintero@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-10-22 11:00:00','2025-10-22 14:00:00'),(3,'Sara','Martinez','saraMartinez@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-09-12 09:00:00','2025-09-12 14:00:00'),(4,'Camila','Londono','camilaLondono@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'activo','2025-08-22 07:00:00','2025-08-22 15:00:00'),(5,'Juan','Pedraza','juanPedraza@gmail.com','$2b$10$HASH_PENDIENTE',NULL,NULL,'administrador',NULL,NULL,'inactivo','2025-07-01 12:00:00','2025-07-01 06:00:00'),(10,'Juan','Alba','juanalba@gmail.com','$2b$10$HASH_PENDIENTE','1234567891',NULL,'operario','Planchado','2025-11-21','activo','2026-03-01 14:57:08',NULL),(11,'Jorge','Almanza','jorgealmanza@gmail.com','$2b$10$HASH_PENDIENTE','1234567892',NULL,'operario','Corte','2025-11-22','activo','2026-03-01 14:57:08',NULL),(12,'David','Sierra','davidsierra@gmail.com','$2b$10$HASH_PENDIENTE','1234567893',NULL,'operario','Confeccion','2025-11-23','activo','2026-03-01 14:57:08',NULL),(13,'David','Cano','davidcano@gmail.com','$2b$10$HASH_PENDIENTE','1234567894',NULL,'operario','Bordado','2025-11-24','activo','2026-03-01 14:57:08',NULL),(20,'Juan','Perez','juan@example.com','$2b$10$HASH_PENDIENTE','5551234','123 Main St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),(21,'Maria','Gomez','maria@example.com','$2b$10$HASH_PENDIENTE','5555678','456 Elm St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),(22,'Carlos','Sanchez','carlos@example.com','$2b$10$HASH_PENDIENTE','5559012','789 Oak St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),(23,'Ana','Martinez','ana@example.com','$2b$10$HASH_PENDIENTE','5553456','101 Pine St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL),(24,'Luis','Rodriguez','luis@example.com','$2b$10$HASH_PENDIENTE','5557890','202 Maple St','cliente',NULL,NULL,'activo','2026-03-01 14:57:08',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-12 18:16:07
