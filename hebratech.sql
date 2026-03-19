-- MySQL dump - hebratech_7
-- Cambios aplicados respecto a hebratech_6:
--   - Tabla facturas              (ELIMINADA)
--   - Todos los datos reemplazados por 7 registros temáticos de satélite textil
--   - Datos coherentes y conectados entre todas las tablas
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
-- 2 administradores + 7 operarios + 7 clientes = 16 filas
-- (necesario para soportar las FKs de clientes, operarios y proveedores)
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
-- Administradores (gestionan proveedores y el sistema)
(1, 'Andrea',    'Rios',      'andrea.rios@hebratech.com',      '$2b$10$HASH_PENDIENTE', '3001000001', 'Bogotá',    'administrador', NULL,                  NULL,         'activo',   '2025-01-01 08:00:00', '2026-03-17 09:00:00'),
(2, 'Miguel',    'Torres',    'miguel.torres@hebratech.com',    '$2b$10$HASH_PENDIENTE', '3001000002', 'Bogotá',    'administrador', NULL,                  NULL,         'activo',   '2025-01-01 08:00:00', '2026-03-17 08:30:00'),
-- Operarios (especialidades textiles)
(3, 'Lucía',     'Vargas',    'lucia.vargas@hebratech.com',     '$2b$10$HASH_PENDIENTE', '3101000001', NULL,        'operario',      'Corte',               '2025-02-01', 'activo',   '2025-02-01 08:00:00', NULL),
(4, 'Carlos',    'Méndez',    'carlos.mendez@hebratech.com',    '$2b$10$HASH_PENDIENTE', '3101000002', NULL,        'operario',      'Confección',          '2025-02-01', 'activo',   '2025-02-01 08:00:00', NULL),
(5, 'Diana',     'Puentes',   'diana.puentes@hebratech.com',    '$2b$10$HASH_PENDIENTE', '3101000003', NULL,        'operario',      'Bordado',             '2025-02-15', 'activo',   '2025-02-15 08:00:00', NULL),
(6, 'Felipe',    'Mora',      'felipe.mora@hebratech.com',      '$2b$10$HASH_PENDIENTE', '3101000004', NULL,        'operario',      'Estampado',           '2025-03-01', 'activo',   '2025-03-01 08:00:00', NULL),
(7, 'Valentina', 'Cruz',      'valentina.cruz@hebratech.com',   '$2b$10$HASH_PENDIENTE', '3101000005', NULL,        'operario',      'Planchado',           '2025-03-01', 'activo',   '2025-03-01 08:00:00', NULL),
(8, 'Sergio',    'Leal',      'sergio.leal@hebratech.com',      '$2b$10$HASH_PENDIENTE', '3101000006', NULL,        'operario',      'Control de Calidad',  '2025-03-15', 'activo',   '2025-03-15 08:00:00', NULL),
(9, 'Natalia',   'Ossa',      'natalia.ossa@hebratech.com',     '$2b$10$HASH_PENDIENTE', '3101000007', NULL,        'operario',      'Empaque',             '2025-04-01', 'activo',   '2025-04-01 08:00:00', NULL),
-- Clientes (empresas del sector textil/retail colombiano)
(10, 'Compras',  'Exito',     'compras@exito.com',              '$2b$10$HASH_PENDIENTE', '6017001000', 'Cra 43A #1 Sur, Medellín',  'cliente', NULL, NULL, 'activo', '2025-05-01 08:00:00', NULL),
(11, 'Pedidos',  'Koaj',      'pedidos@koaj.com',               '$2b$10$HASH_PENDIENTE', '6017002000', 'Calle 80 #50-30, Bogotá',   'cliente', NULL, NULL, 'activo', '2025-05-01 08:00:00', NULL),
(12, 'Compras',  'Eliot',     'compras@eliot.com',              '$2b$10$HASH_PENDIENTE', '6017003000', 'Carrera 7 #12-40, Bogotá',  'cliente', NULL, NULL, 'activo', '2025-06-01 08:00:00', NULL),
(13, 'Pedidos',  'ArturoCalle','pedidos@arturocalle.com',       '$2b$10$HASH_PENDIENTE', '6017004000', 'El Poblado, Medellín',      'cliente', NULL, NULL, 'activo', '2025-06-01 08:00:00', NULL),
(14, 'Compras',  'Tennis',    'compras@tennis.com',             '$2b$10$HASH_PENDIENTE', '6017005000', 'Calle 97 #60-30, Bogotá',   'cliente', NULL, NULL, 'activo', '2025-07-01 08:00:00', NULL),
(15, 'Pedidos',  'PuntoBlanco','pedidos@puntoblanco.com',       '$2b$10$HASH_PENDIENTE', '6017006000', 'Av. 6N #24-01, Cali',       'cliente', NULL, NULL, 'activo', '2025-07-01 08:00:00', NULL),
(16, 'Compras',  'StudioF',   'compras@studiof.com',            '$2b$10$HASH_PENDIENTE', '6017007000', 'Calle 122 #15-80, Bogotá',  'cliente', NULL, NULL, 'activo', '2025-08-01 08:00:00', NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: clientes  [7 filas]
-- Empresas del sector textil y retail colombiano
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES
(1, 10, 'Empresa', 'Almacenes Éxito S.A.',        '860502316-1', 5000000.00, '2025-05-01', 'activo'),
(2, 11, 'Empresa', 'Koaj Colombia',               '830115498-2', 3000000.00, '2025-05-01', 'activo'),
(3, 12, 'Empresa', 'Manufacturas Eliot',          '900456789-0', 4000000.00, '2025-06-01', 'activo'),
(4, 13, 'Natural', 'Arturo Calle',                '800234567-1', 2500000.00, '2025-06-01', 'activo'),
(5, 14, 'Empresa', 'Tennis S.A.',                 '890123456-3', 2000000.00, '2025-07-01', 'activo'),
(6, 15, 'Natural', 'Punto Blanco',                '701234567-2', 1500000.00, '2025-07-01', 'activo'),
(7, 16, 'Empresa', 'Studio F',                    '901098765-4', 3500000.00, '2025-08-01', 'activo');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: operarios  [7 filas]
-- Especialidades del proceso productivo textil
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
(1, 3, 'Corte',               '2025-02-01', 'activo'),
(2, 4, 'Confección',          '2025-02-01', 'activo'),
(3, 5, 'Bordado',             '2025-02-15', 'activo'),
(4, 6, 'Estampado',           '2025-03-01', 'activo'),
(5, 7, 'Planchado',           '2025-03-01', 'activo'),
(6, 8, 'Control de Calidad',  '2025-03-15', 'activo'),
(7, 9, 'Empaque',             '2025-04-01', 'activo');
/*!40000 ALTER TABLE `operarios` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: productos  [7 filas]
-- Prendas de la línea de producción textil
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
(1, 'Camiseta Básica',    'Camiseta 100% algodón peinado 180 g/m², corte recto unisex',            35000.00, 'Camisetas',  0),
(2, 'Pantalón Clásico',   'Pantalón gabardina stretch corte slim, tallas 28-38',                   85000.00, 'Pantalones', 0),
(3, 'Vestido Casual',     'Vestido viscosa estampada manga corta, talla única ajustable',          95000.00, 'Vestidos',   0),
(4, 'Chaqueta Denim',     'Chaqueta denim 12 oz acabado desgastado, botones metálicos',           130000.00, 'Chaquetas',  0),
(5, 'Bermuda Deportiva',  'Bermuda tela sintética transpirable con bolsillos laterales',            55000.00, 'Bermudas',   0),
(6, 'Blusa Formal',       'Blusa popelina con bordado exclusivo en pecho, manga larga',            75000.00, 'Blusas',     0),
(7, 'Falda Plisada',      'Falda plisada poliéster largo midi, pretina elástica reforzada',        70000.00, 'Faldas',     0);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: inventario  [7 filas — uno por producto]
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
(1, 1, 200, 50, 200, 'Unidades', 'Bodega Confección A', '2026-03-01'),
(2, 2, 150, 30, 150, 'Unidades', 'Bodega Confección A', '2026-03-01'),
(3, 3, 80,  20,  80, 'Unidades', 'Bodega Confección B', '2026-03-01'),
(4, 4, 60,  15,  60, 'Unidades', 'Bodega Denim',        '2026-03-01'),
(5, 5, 120, 40, 120, 'Unidades', 'Bodega Deportiva',    '2026-03-01'),
(6, 6, 90,  25,  90, 'Unidades', 'Bodega Formal',       '2026-03-01'),
(7, 7, 70,  20,  70, 'Unidades', 'Bodega Formal',       '2026-03-01');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: ordenes  [7 filas]
-- CAMBIOS v6: sin idUsuarioRegistro; idProducto, cantidad, precioUnitario y subtotal
-- absorbidos desde la antigua detalle_ordenes. subtotal = GENERATED.
-- Cadena: clientes → ordenes → productos
-- ----------------------------
DROP TABLE IF EXISTS `ordenes`;
CREATE TABLE `ordenes` (
  `idOrden` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL COMMENT 'FK a clientes',
  `idProducto` int DEFAULT NULL COMMENT 'FK a productos — producto de la orden',
  `fechaCreacion` date NOT NULL,
  `fechaEntregaEstimada` date DEFAULT NULL,
  `instrucciones` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `cantidad` int DEFAULT NULL COMMENT 'Unidades pedidas',
  `precioUnitario` decimal(10,2) DEFAULT NULL COMMENT 'Precio unitario al momento de la orden',
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `precioUnitario`) STORED COMMENT 'Calculado automáticamente',
  `prioridad` enum('Normal','Urgente') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Normal',
  `estado` enum('Pendiente','Procesando','Enviado','Entregado','Cancelado') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`idOrden`),
  KEY `fk_ord_cliente`  (`idCliente`),
  KEY `fk_ord_producto` (`idProducto`),
  CONSTRAINT `fk_ord_cliente`  FOREIGN KEY (`idCliente`)  REFERENCES `clientes`  (`idCliente`)  ON UPDATE CASCADE,
  CONSTRAINT `fk_ord_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
INSERT INTO `ordenes` (`idOrden`,`idCliente`,`idProducto`,`fechaCreacion`,`fechaEntregaEstimada`,`instrucciones`,`cantidad`,`precioUnitario`,`prioridad`,`estado`) VALUES
(1, 1, 1, '2026-01-10','2026-01-25', 'Camisetas con logo bordado en pecho izquierdo, bolsa individual',   500, 35000.00, 'Normal',  'Entregado'),
(2, 2, 2, '2026-01-15','2026-01-30', 'Pantalones slim tallas 30-38, etiqueta interna y swing tag',        300, 85000.00, 'Normal',  'Enviado'),
(3, 3, 4, '2026-01-20','2026-02-10', 'Chaquetas denim acabado vintage, instrucciones de lavado incluidas',200,130000.00, 'Urgente', 'Procesando'),
(4, 4, 6, '2026-02-01','2026-02-15', 'Blusas con bordado exclusivo logo AC, empacar en caja individual',  150, 75000.00, 'Normal',  'Procesando'),
(5, 5, 5, '2026-02-10','2026-02-25', 'Bermudas deportivas colección verano, etiqueta reflectiva lateral', 400, 55000.00, 'Normal',  'Pendiente'),
(6, 6, 7, '2026-02-20','2026-03-05', 'Faldas plisadas midi temporada, control de calidad exhaustivo',     180, 70000.00, 'Urgente', 'Pendiente'),
(7, 7, 3, '2026-03-01','2026-03-18', 'Vestidos casuales fondo negro, estampado floral, empacar con papel', 220, 95000.00, 'Normal', 'Pendiente');
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: devoluciones  [7 filas]
-- Productos devueltos con defectos de producción textil
-- ----------------------------
DROP TABLE IF EXISTS `devoluciones`;
CREATE TABLE `devoluciones` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `idInventario` int NOT NULL COMMENT 'FK a inventario',
  `fechaDevolucion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidadDevuelta` int NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `estadoDevolucion` enum('Recibida','Inspeccionada','Rechazada','Completada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Recibida',
  PRIMARY KEY (`idDevolucion`),
  KEY `fk_dev_inventario` (`idInventario`),
  CONSTRAINT `fk_dev_inventario` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES
(1, 1, '2026-01-26 09:00:00', 20, 'Costuras defectuosas en hombros de camisetas lote #1',          'Inspeccionada'),
(2, 2, '2026-01-31 10:00:00', 10, 'Talla incorrecta en lote de pantalones talla 34',               'Completada'),
(3, 3, '2026-02-16 11:00:00',  5, 'Estampado corrido en vestidos del lote inicial',                 'Recibida'),
(4, 4, '2026-02-11 08:30:00',  8, 'Cremalleras defectuosas en bolsillos de chaquetas denim',       'Inspeccionada'),
(5, 5, '2026-02-26 14:00:00', 15, 'Elástico flojo en cintura de bermudas deportivas',              'Recibida'),
(6, 6, '2026-03-06 09:30:00',  6, 'Bordado incompleto en pecho de blusas formales',                'Recibida'),
(7, 7, '2026-03-19 10:00:00', 12, 'Pliegues mal formados en faldas plisadas por exceso de calor',  'Recibida');
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: produccion  [7 filas]
-- Proceso de fabricación de cada prenda, vinculado a su orden
-- ----------------------------
DROP TABLE IF EXISTS `produccion`;
CREATE TABLE `produccion` (
  `idProduccion` int NOT NULL AUTO_INCREMENT,
  `idOrden` int DEFAULT NULL COMMENT 'FK a ordenes (puede ser NULL)',
  `idProducto` int NOT NULL COMMENT 'FK a productos',
  `descripcion` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `cantidadRequerida` int NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaEstimadaFin` date NOT NULL,
  `fechaRealFin` date DEFAULT NULL,
  `costoEstimado` decimal(12,2) DEFAULT NULL,
  `costoReal` decimal(12,2) DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completado','Detenido') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`idProduccion`),
  KEY `fk_prod_orden`    (`idOrden`),
  KEY `fk_prod_producto` (`idProducto`),
  CONSTRAINT `fk_prod_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE,
  CONSTRAINT `fk_prod_orden`    FOREIGN KEY (`idOrden`)    REFERENCES `ordenes`   (`idOrden`)    ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
INSERT INTO `produccion` VALUES
(1, 1, 1, 'Lote camisetas básicas — orden Éxito',          500, '2026-01-10','2026-01-24','2026-01-24', 12000000.00, 11500000.00, 'Completado'),
(2, 2, 2, 'Lote pantalones clásicos — orden Koaj',         300, '2026-01-15','2026-01-29', NULL,        18000000.00,        NULL, 'En Progreso'),
(3, 3, 4, 'Lote chaquetas denim — orden Eliot',            200, '2026-01-20','2026-02-09', NULL,        20000000.00,        NULL, 'En Progreso'),
(4, 4, 6, 'Lote blusas formales — orden Arturo Calle',     150, '2026-02-01','2026-02-14', NULL,         9000000.00,        NULL, 'En Progreso'),
(5, 5, 5, 'Lote bermudas deportivas — orden Tennis',       400, '2026-02-10','2026-02-24', NULL,        16000000.00,        NULL, 'Pendiente'),
(6, 6, 7, 'Lote faldas plisadas — orden Punto Blanco',     180, '2026-02-20','2026-03-04', NULL,        10800000.00,        NULL, 'Pendiente'),
(7, 7, 3, 'Lote vestidos casuales — orden Studio F',       220, '2026-03-01','2026-03-17', NULL,        17600000.00,        NULL, 'Pendiente');
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: tareas  [7 filas]
-- Cada tarea corresponde a una etapa del proceso productivo textil
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
(1, 1, 'Corte de tela — camisetas',    'Cortar tela algodón según moldes de camiseta básica tallas S-XL',     '2026-01-10', 'Corte',               'media'),
(2, 2, 'Confección de pantalones',     'Unir piezas, coser costuras principales y colocar cremallera',        '2026-01-15', 'Confección',          'alta'),
(3, 3, 'Ensamble chaquetas denim',     'Unir delantero, espalda y mangas; remache de botones metálicos',      '2026-01-20', 'Confección',          'alta'),
(4, 4, 'Bordado blusas formales',      'Aplicar bordado exclusivo logo AC en pecho izquierdo de la blusa',   '2026-02-01', 'Bordado',             'alta'),
(5, 5, 'Estampado bermudas',           'Aplicar estampado reflectivo lateral con serigrafía en 2 colores',   '2026-02-10', 'Estampado',           'media'),
(6, 6, 'Planchado faldas plisadas',    'Planchar pliegues con vapor industrial 160°C; controlar temperatura', '2026-02-20', 'Planchado',           'media'),
(7, 7, 'Control de calidad vestidos',  'Inspeccionar costuras, estampado y acabados del lote Studio F',       '2026-03-01', 'Control de Calidad',  'baja');
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: asignacion_tareas  [7 filas]
-- Cada tarea asignada al operario con la especialidad correspondiente
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
  KEY `fk_asig_tarea`    (`idTarea`),
  KEY `fk_asig_operario` (`idOperario`),
  CONSTRAINT `fk_asig_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_asig_tarea`    FOREIGN KEY (`idTarea`)    REFERENCES `tareas`    (`idTarea`)    ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `asignacion_tareas` WRITE;
/*!40000 ALTER TABLE `asignacion_tareas` DISABLE KEYS */;
INSERT INTO `asignacion_tareas` VALUES
(1, 1, 1, 'Cortar tela algodón lote 500 camisetas Éxito',               '2026-01-10','2026-01-11','2026-01-12', 'Completada',  'Alta',    16.00, 15.50),
(2, 2, 2, 'Confeccionar 300 pantalones clásicos Koaj temporada verano',  '2026-01-15','2026-01-16', NULL,        'En Progreso', 'Alta',    24.00,  NULL),
(3, 3, 2, 'Ensamblar 200 chaquetas denim colección Eliot',               '2026-01-20','2026-01-21', NULL,        'En Progreso', 'Urgente', 32.00,  NULL),
(4, 4, 3, 'Bordar diseño exclusivo en 150 blusas Arturo Calle',          '2026-02-01','2026-02-02', NULL,        'En Progreso', 'Alta',    20.00,  NULL),
(5, 5, 4, 'Aplicar estampado reflectivo en 400 bermudas Tennis',         '2026-02-10','2026-02-11', NULL,        'Pendiente',   'Media',   18.00,  NULL),
(6, 6, 5, 'Planchar pliegues en 180 faldas midi Punto Blanco',           '2026-02-20','2026-02-21', NULL,        'Pendiente',   'Media',   12.00,  NULL),
(7, 7, 6, 'Inspección final de calidad en 220 vestidos Studio F',        '2026-03-01','2026-03-02', NULL,        'Pendiente',   'Baja',    10.00,  NULL);
/*!40000 ALTER TABLE `asignacion_tareas` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: incidencias  [7 filas]
-- Incidencias reales del proceso productivo textil
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
INSERT INTO `incidencias` VALUES
(1, 1, 'Error de corte',       'Exceso de desperdicio de tela algodón en lote camisetas #1 (15% sobre lo estimado)',     'Enero 2026',    'Revisado',  '2026-01-12', '2026-01-13'),
(2, 2, 'Retraso',              'Entrega del lote de pantalones Koaj con 2 días de retraso por falla de maquinaria',      'Enero 2026',    'Revisado',  '2026-01-31', '2026-02-01'),
(3, 3, 'Calidad',              'Bordado fuera de especificación en 15 blusas del lote: hilo corrido en pecho',           'Febrero 2026',  'Pendiente', '2026-02-05', NULL),
(4, 4, 'Máquina',              'Falla en máquina de serigrafía que detuvo producción de bermudas durante 4 horas',       'Febrero 2026',  'Pendiente', '2026-02-12', NULL),
(5, 5, 'Procedimiento',        'Temperatura incorrecta en planchado de faldas: pliegues deformados en 12 unidades',      'Febrero 2026',  'Pendiente', '2026-02-22', NULL),
(6, 6, 'Calidad',              'Aprobó prendas con costuras flojas en la revisión de calidad del lote vestidos',         'Marzo 2026',    'Pendiente', '2026-03-02', NULL),
(7, 7, 'Retraso',              'Retraso en empaque lote Studio F por agotamiento de bolsas antihumedad',                 'Marzo 2026',    'Pendiente', '2026-03-03', NULL);
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: materiales  [7 filas]
-- Insumos textiles de producción
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
(1, 'Tela Algodón Peinado',     'Tela 100% algodón peinado 180 g/m², ancho 1.5 m',                2500.00, 500.00, 'Metro',   4500.00, '2026-03-01'),
(2, 'Hilo Poliéster 40/2',      'Hilo de coser poliéster resistente 40/2, cono 5000 m',            150.00,  30.00, 'Cono',    8500.00, '2026-03-01'),
(3, 'Botón Nácar 4 Huecos',     'Botón nácar sintético 4 huecos 15 mm, colores surtidos',          800.00, 200.00, 'Unidad',   150.00, '2026-03-01'),
(4, 'Cremallera Metálica YKK',  'Cremallera metálica YKK #5 de 25 cm, color negro',                300.00, 100.00, 'Unidad',  1200.00, '2026-03-01'),
(5, 'Elástico Plano 2 cm',      'Elástico tejido plano 2 cm de ancho, alta resistencia al lavado', 500.00, 100.00, 'Metro',    800.00, '2026-03-01'),
(6, 'Entretela Fusionable',     'Entretela no tejida fusionable media rigidez, ancho 90 cm',       400.00,  80.00, 'Metro',   2200.00, '2026-03-01'),
(7, 'Etiqueta Tejida Marca',    'Etiqueta jacquard tejida con marca, talla y país de origen',     1000.00, 200.00, 'Unidad',   350.00, '2026-03-01');
/*!40000 ALTER TABLE `materiales` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: tarea_materiales  [7 filas]
-- Qué insumo textil consume cada tarea de producción
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
  KEY `fk_tm_tarea`    (`idTarea`),
  KEY `fk_tm_material` (`idMaterial`),
  CONSTRAINT `fk_tm_material` FOREIGN KEY (`idMaterial`) REFERENCES `materiales` (`idMaterial`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tm_tarea`    FOREIGN KEY (`idTarea`)    REFERENCES `tareas`    (`idTarea`)    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `tarea_materiales` WRITE;
/*!40000 ALTER TABLE `tarea_materiales` DISABLE KEYS */;
INSERT INTO `tarea_materiales` VALUES
(1, 1, 1,  3.50, 'Metro',  'Tela algodón cortada según moldes camiseta tallas S-XL',      '2026-01-11 08:00:00'),
(2, 2, 2,  2.00, 'Cono',   'Hilo para costuras principales y dobladillo del pantalón',    '2026-01-16 08:00:00'),
(3, 3, 4,  1.00, 'Unidad', 'Cremallera YKK en bolsillo lateral de la chaqueta denim',    '2026-01-21 08:00:00'),
(4, 4, 3,  6.00, 'Unidad', 'Botones nácar para decoración en cuello de blusa formal',    '2026-02-02 08:00:00'),
(5, 5, 5,  0.30, 'Metro',  'Elástico para cintura interior de bermuda deportiva',        '2026-02-11 08:00:00'),
(6, 6, 6,  0.50, 'Metro',  'Entretela fusionable en pretina de falda plisada',           '2026-02-21 08:00:00'),
(7, 7, 7,  1.00, 'Unidad', 'Etiqueta de marca y talla aplicada en costado del vestido',  '2026-03-02 08:00:00');
/*!40000 ALTER TABLE `tarea_materiales` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: proveedores  [7 filas]
-- Proveedores especializados en insumos del sector textil
-- ----------------------------
DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL COMMENT 'FK a usuarios — administrador que gestiona el proveedor',
  `nombreEmpresa` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `nombreContacto` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `correo` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nit` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'activo',
  `fechaRegistro` date NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`idProveedor`),
  KEY `fk_prov_usuario` (`idUsuario`),
  CONSTRAINT `fk_prov_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES
(1, 1, 'Textiles Colombia S.A.',        'Jorge Bedoya',  '3002000001', 'ventas@textilescol.com',     'Calle 13 #34-20, Bogotá',           '830456789-1', 'activo', '2025-12-01'),
(2, 2, 'Hilos y Fibras Andinas',        'Carmen Ríos',   '3152000002', 'pedidos@hilosandinos.com',   'Carrera 50 #12-30, Medellín',       '900234567-2', 'activo', '2025-12-05'),
(3, 1, 'Botones y Avíos del Norte',     'Ricardo Peña',  '3203000003', 'avios@btnorte.com',          'Av. 80 #65-10, Barranquilla',       '901345678-3', 'activo', '2025-12-10'),
(4, 2, 'Cremalleras YKK Colombia',      'Sandra López',  '3104000004', 'ventas@ykkco.com',           'Calle 100 #19-60, Bogotá',          '830567890-4', 'activo', '2026-01-05'),
(5, 1, 'Elásticos y Cintas S.A.S.',     'Mauricio Silva','3005000005', 'pedidos@elasticos.com',      'Carrera 7 #45-80, Bogotá',          '900678901-5', 'activo', '2026-01-10'),
(6, 2, 'Entretelas del Pacífico',       'Gloria Muñoz',  '3156000006', 'entretelas@pacifico.com',    'Calle 5 #10-20, Cali',              '901789012-6', 'activo', '2026-01-15'),
(7, 1, 'Etiquetas y Marcas Print',      'Héctor Duarte', '3107000007', 'ventas@etiquetasprint.com',  'Carrera 15 #88-20, Bogotá',         '830890123-7', 'activo', '2026-01-20');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Tabla: entrada_materiales  [7 filas]
-- Cada proveedor suministra su insumo específico
-- Cadena: proveedores → entrada_materiales → materiales
-- ----------------------------
DROP TABLE IF EXISTS `entrada_materiales`;
CREATE TABLE `entrada_materiales` (
  `idEntrada` int NOT NULL AUTO_INCREMENT,
  `idProveedor` int NOT NULL COMMENT 'FK a proveedores',
  `idMaterial` int NOT NULL COMMENT 'FK a materiales',
  `fechaEntrada` date NOT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT '0.00',
  `precioUnitario` decimal(10,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) GENERATED ALWAYS AS (`cantidad` * `precioUnitario`) STORED COMMENT 'Calculado automáticamente',
  `unidad` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unidad',
  `numeroRemision` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_general_ci,
  `estado` enum('Pendiente','Recibida','Cancelada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pendiente',
  `fechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEntrada`),
  KEY `fk_em_proveedor` (`idProveedor`),
  KEY `fk_em_material`  (`idMaterial`),
  CONSTRAINT `fk_em_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores`    (`idProveedor`) ON UPDATE CASCADE,
  CONSTRAINT `fk_em_material`  FOREIGN KEY (`idMaterial`)  REFERENCES `materiales`     (`idMaterial`)  ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `entrada_materiales` WRITE;
/*!40000 ALTER TABLE `entrada_materiales` DISABLE KEYS */;
INSERT INTO `entrada_materiales` (`idEntrada`,`idProveedor`,`idMaterial`,`fechaEntrada`,`cantidad`,`precioUnitario`,`unidad`,`numeroRemision`,`observaciones`,`estado`,`fechaRegistro`) VALUES
(1, 1, 1, '2026-02-01', 1000.00,  4500.00, 'Metro',  'REM-2026-T001', 'Tela algodón peinado para temporada verano',         'Recibida',  '2026-02-01 08:00:00'),
(2, 2, 2, '2026-02-03',   50.00,  8500.00, 'Cono',   'REM-2026-H002', 'Hilos poliéster 40/2 para producción confección',   'Recibida',  '2026-02-03 09:00:00'),
(3, 3, 3, '2026-02-05', 2000.00,   150.00, 'Unidad', 'REM-2026-B003', 'Botones nácar colores surtidos colección formal',   'Recibida',  '2026-02-05 08:30:00'),
(4, 4, 4, '2026-02-10',  500.00,  1200.00, 'Unidad', 'REM-2026-C004', 'Cremalleras YKK para chaquetas y faldas plisadas',  'Recibida',  '2026-02-10 10:00:00'),
(5, 5, 5, '2026-02-15',  800.00,   800.00, 'Metro',  'REM-2026-E005', 'Elástico plano 2 cm para bermudas y faldas',        'Recibida',  '2026-02-15 08:00:00'),
(6, 6, 6, '2026-02-20',  600.00,  2200.00, 'Metro',  'REM-2026-EN006','Entretela fusionable para blusas y chaquetas',      'Pendiente', '2026-02-20 09:30:00'),
(7, 7, 7, '2026-02-25', 3000.00,   350.00, 'Unidad', 'REM-2026-ET007','Etiquetas tejidas toda la colección 2026',          'Pendiente', '2026-02-25 11:00:00');
/*!40000 ALTER TABLE `entrada_materiales` ENABLE KEYS */;
UNLOCK TABLES;

-- ----------------------------
-- Índices adicionales de rendimiento
-- ----------------------------
CREATE INDEX `idx_prov_usuario`  ON `proveedores`       (`idUsuario`);
CREATE INDEX `idx_em_proveedor`  ON `entrada_materiales` (`idProveedor`);
CREATE INDEX `idx_em_material`   ON `entrada_materiales` (`idMaterial`);
CREATE INDEX `idx_ord_producto`  ON `ordenes`            (`idProducto`);

-- ============================================================
-- NOTAS v7:
--   - facturas: ELIMINADA completamente
--   - Todos los datos actualizados a temática de satélite textil
--   - 7 filas por tabla en todas las tablas con relaciones
--   - Coherencia de FKs garantizada:
--       usuarios (16) → clientes (7) + operarios (7) + proveedores (7, vía admins)
--       productos (7) → inventario (7) + ordenes (7) + produccion (7)
--       ordenes (7)   → devoluciones (vía inventario) + produccion (7)
--       produccion (7)→ tareas (7) → asignacion_tareas (7) + tarea_materiales (7)
--       operarios (7) → asignacion_tareas (7) + incidencias (7)
--       materiales (7)→ tarea_materiales (7) + entrada_materiales (7)
--       proveedores (7)→ entrada_materiales (7)
-- ============================================================

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump actualizado: 2026-03-18
