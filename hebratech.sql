-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-03-2026 a las 14:33:11
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
-- Base de datos: `hebratech`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_una_empresa` ()   BEGIN
UPDATE clientes c 
set c.estado = 'inactivo'
where c.idCliente = 4; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Datos_en_operarios` ()   BEGIN
DELETE FROM `operarios` WHERE operarios.idOperario = 8;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_Datos_en_operarios` ()   BEGIN
INSERT INTO `operarios`(`idOperario`, `idUsuario`, `especialidad`, `fechaIngreso`, `estado`) VALUES ('8','10','inventario','2025-04-01','activo ');
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_materiales_por_tarea` ()   BEGIN
    SELECT 
        t.nombreTarea,
        m.nombreMaterial,
        tm.cantidadUsada,
        tm.unidad
    FROM tarea_materiales tm
    INNER JOIN tareas t 
        ON tm.idTarea = t.idTarea
    INNER JOIN materiales m 
        ON tm.idMaterial = m.idMaterial;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ver_ordenes_completas` ()   BEGIN
    SELECT 
        o.idOrden,
        c.idCliente,
        p.nombre AS producto,
        o.cantidad,
        o.precioUnitario,
        o.subtotal,
        o.estado
    FROM ordenes o
    INNER JOIN clientes c 
        ON o.idCliente = c.idCliente
    INNER JOIN productos p 
        ON o.idProducto = p.idProducto;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_tareas`
--

CREATE TABLE `asignacion_tareas` (
  `idAsignacion` int(11) NOT NULL,
  `idTarea` int(11) NOT NULL,
  `idOperario` int(11) NOT NULL COMMENT 'FK a operarios',
  `descripcion` text NOT NULL,
  `fechaAsignacion` date NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFinalizacion` date DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completada','Cancelada') NOT NULL DEFAULT 'Pendiente',
  `prioridad` enum('Baja','Media','Alta','Urgente') NOT NULL DEFAULT 'Media',
  `horasEstimadas` decimal(5,2) NOT NULL,
  `horasReales` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignacion_tareas`
--

INSERT INTO `asignacion_tareas` (`idAsignacion`, `idTarea`, `idOperario`, `descripcion`, `fechaAsignacion`, `fechaInicio`, `fechaFinalizacion`, `estado`, `prioridad`, `horasEstimadas`, `horasReales`) VALUES
(1, 1, 1, 'Cortar tela algodón lote 500 camisetas Éxito', '2026-01-10', '2026-01-11', '2026-01-12', 'Completada', 'Alta', 16.00, 15.50),
(2, 2, 2, 'Confeccionar 300 pantalones clásicos Koaj temporada verano', '2026-01-15', '2026-01-16', NULL, 'En Progreso', 'Alta', 24.00, NULL),
(3, 3, 2, 'Ensamblar 200 chaquetas denim colección Eliot', '2026-01-20', '2026-01-21', NULL, 'En Progreso', 'Urgente', 32.00, NULL),
(4, 4, 3, 'Bordar diseño exclusivo en 150 blusas Arturo Calle', '2026-02-01', '2026-02-02', NULL, 'En Progreso', 'Alta', 20.00, NULL),
(5, 5, 4, 'Aplicar estampado reflectivo en 400 bermudas Tennis', '2026-02-10', '2026-02-11', NULL, 'Pendiente', 'Media', 18.00, NULL),
(6, 6, 5, 'Planchar pliegues en 180 faldas midi Punto Blanco', '2026-02-20', '2026-02-21', NULL, 'Pendiente', 'Media', 12.00, NULL),
(7, 7, 6, 'Inspección final de calidad en 220 vestidos Studio F', '2026-03-01', '2026-03-02', NULL, 'Pendiente', 'Baja', 10.00, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_productos`
--

CREATE TABLE `audi_productos` (
  `idAuditoria` int(11) NOT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `nombreProducto` varchar(150) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_productos`
--

INSERT INTO `audi_productos` (`idAuditoria`, `idProducto`, `nombreProducto`, `precio`, `accion`, `fecha`, `usuario`) VALUES
(1, 8, 'Jeans azules', 20000.00, 'INSERT', '2026-03-19 07:51:39', 'root@localhost');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_usuarios`
--

CREATE TABLE `audi_usuarios` (
  `id` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `accion` varchar(50) DEFAULT NULL,
  `datos_antes` text DEFAULT NULL,
  `datos_despues` text DEFAULT NULL,
  `usuario_bd` varchar(100) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_usuarios`
--

INSERT INTO `audi_usuarios` (`id`, `idUsuario`, `accion`, `datos_antes`, `datos_despues`, `usuario_bd`, `fecha`) VALUES
(1, 3, 'UPDATE', 'Nombre: Lucía, Apellido: Vargas, Correo: lucia.vargas@hebratech.com', 'Nombre: Laura, Apellido: Gomez, Correo: lucia.vargas@hebratech.com', 'root@localhost', '2026-03-19 07:37:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL COMMENT 'FK a usuarios',
  `tipoCliente` enum('Natural','Empresa') NOT NULL DEFAULT 'Natural',
  `empresa` varchar(150) DEFAULT NULL COMMENT 'Nombre empresa (si aplica)',
  `nit` varchar(30) DEFAULT NULL COMMENT 'NIT o cédula tributaria',
  `limiteCredito` decimal(12,2) NOT NULL DEFAULT 0.00,
  `fechaRegistro` date NOT NULL,
  `estado` enum('activo','inactivo','bloqueado') NOT NULL DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `idUsuario`, `tipoCliente`, `empresa`, `nit`, `limiteCredito`, `fechaRegistro`, `estado`) VALUES
(1, 10, 'Empresa', 'Almacenes Éxito S.A.', '860502316-1', 5000000.00, '2025-05-01', 'activo'),
(2, 11, 'Empresa', 'Koaj Colombia', '830115498-2', 3000000.00, '2025-05-01', 'activo'),
(3, 12, 'Empresa', 'Manufacturas Eliot', '900456789-0', 4000000.00, '2025-06-01', 'activo'),
(4, 13, 'Natural', 'Arturo Calle', '800234567-1', 2500000.00, '2025-06-01', 'activo'),
(5, 14, 'Empresa', 'Tennis S.A.', '890123456-3', 2000000.00, '2025-07-01', 'activo'),
(6, 15, 'Natural', 'Punto Blanco', '701234567-2', 1500000.00, '2025-07-01', 'activo'),
(7, 16, 'Empresa', 'Studio F', '901098765-4', 3500000.00, '2025-08-01', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones`
--

CREATE TABLE `devoluciones` (
  `idDevolucion` int(11) NOT NULL,
  `idInventario` int(11) NOT NULL COMMENT 'FK a inventario',
  `fechaDevolucion` datetime NOT NULL DEFAULT current_timestamp(),
  `cantidadDevuelta` int(11) NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `estadoDevolucion` enum('Recibida','Inspeccionada','Rechazada','Completada') NOT NULL DEFAULT 'Recibida'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `devoluciones`
--

INSERT INTO `devoluciones` (`idDevolucion`, `idInventario`, `fechaDevolucion`, `cantidadDevuelta`, `motivo`, `estadoDevolucion`) VALUES
(1, 1, '2026-01-26 09:00:00', 20, 'Costuras defectuosas en hombros de camisetas lote #1', 'Inspeccionada'),
(2, 2, '2026-01-31 10:00:00', 10, 'Talla incorrecta en lote de pantalones talla 34', 'Completada'),
(3, 3, '2026-02-16 11:00:00', 5, 'Estampado corrido en vestidos del lote inicial', 'Recibida'),
(4, 4, '2026-02-11 08:30:00', 8, 'Cremalleras defectuosas en bolsillos de chaquetas denim', 'Inspeccionada'),
(5, 5, '2026-02-26 14:00:00', 15, 'Elástico flojo en cintura de bermudas deportivas', 'Recibida'),
(6, 6, '2026-03-06 09:30:00', 6, 'Bordado incompleto en pecho de blusas formales', 'Recibida'),
(7, 7, '2026-03-19 10:00:00', 12, 'Pliegues mal formados en faldas plisadas por exceso de calor', 'Recibida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada_materiales`
--

CREATE TABLE `entrada_materiales` (
  `idEntrada` int(11) NOT NULL,
  `idProveedor` int(11) NOT NULL COMMENT 'FK a proveedores',
  `idMaterial` int(11) NOT NULL COMMENT 'FK a materiales',
  `fechaEntrada` date NOT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precioUnitario` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS (`cantidad` * `precioUnitario`) STORED COMMENT 'Calculado automáticamente',
  `unidad` varchar(20) NOT NULL DEFAULT 'unidad',
  `numeroRemision` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `estado` enum('Pendiente','Recibida','Cancelada') NOT NULL DEFAULT 'Pendiente',
  `fechaRegistro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entrada_materiales`
--

INSERT INTO `entrada_materiales` (`idEntrada`, `idProveedor`, `idMaterial`, `fechaEntrada`, `cantidad`, `precioUnitario`, `unidad`, `numeroRemision`, `observaciones`, `estado`, `fechaRegistro`) VALUES
(1, 1, 1, '2026-02-01', 1000.00, 4500.00, 'Metro', 'REM-2026-T001', 'Tela algodón peinado para temporada verano', 'Recibida', '2026-02-01 08:00:00'),
(2, 2, 2, '2026-02-03', 50.00, 8500.00, 'Cono', 'REM-2026-H002', 'Hilos poliéster 40/2 para producción confección', 'Recibida', '2026-02-03 09:00:00'),
(3, 3, 3, '2026-02-05', 2000.00, 150.00, 'Unidad', 'REM-2026-B003', 'Botones nácar colores surtidos colección formal', 'Recibida', '2026-02-05 08:30:00'),
(4, 4, 4, '2026-02-10', 500.00, 1200.00, 'Unidad', 'REM-2026-C004', 'Cremalleras YKK para chaquetas y faldas plisadas', 'Recibida', '2026-02-10 10:00:00'),
(5, 5, 5, '2026-02-15', 800.00, 800.00, 'Metro', 'REM-2026-E005', 'Elástico plano 2 cm para bermudas y faldas', 'Recibida', '2026-02-15 08:00:00'),
(6, 6, 6, '2026-02-20', 600.00, 2200.00, 'Metro', 'REM-2026-EN006', 'Entretela fusionable para blusas y chaquetas', 'Pendiente', '2026-02-20 09:30:00'),
(7, 7, 7, '2026-02-25', 3000.00, 350.00, 'Unidad', 'REM-2026-ET007', 'Etiquetas tejidas toda la colección 2026', 'Pendiente', '2026-02-25 11:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidencias`
--

CREATE TABLE `incidencias` (
  `idIncidencia` int(11) NOT NULL,
  `idOperario` int(11) NOT NULL COMMENT 'Operario que genera la incidencia',
  `tipoIncidencia` varchar(50) NOT NULL COMMENT 'Ej: desempeño, ventas, inventario',
  `descripcion` text NOT NULL,
  `periodoEvaluado` varchar(50) DEFAULT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'Generado',
  `fechaGeneracion` date NOT NULL,
  `fechaRevision` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `incidencias`
--

INSERT INTO `incidencias` (`idIncidencia`, `idOperario`, `tipoIncidencia`, `descripcion`, `periodoEvaluado`, `estado`, `fechaGeneracion`, `fechaRevision`) VALUES
(1, 1, 'Error de corte', 'Exceso de desperdicio de tela algodón en lote camisetas #1 (15% sobre lo estimado)', 'Enero 2026', 'Revisado', '2026-01-12', '2026-01-13'),
(2, 2, 'Retraso', 'Entrega del lote de pantalones Koaj con 2 días de retraso por falla de maquinaria', 'Enero 2026', 'Revisado', '2026-01-31', '2026-02-01'),
(3, 3, 'Calidad', 'Bordado fuera de especificación en 15 blusas del lote: hilo corrido en pecho', 'Febrero 2026', 'Pendiente', '2026-02-05', NULL),
(4, 4, 'Máquina', 'Falla en máquina de serigrafía que detuvo producción de bermudas durante 4 horas', 'Febrero 2026', 'Pendiente', '2026-02-12', NULL),
(5, 5, 'Procedimiento', 'Temperatura incorrecta en planchado de faldas: pliegues deformados en 12 unidades', 'Febrero 2026', 'Pendiente', '2026-02-22', NULL),
(6, 6, 'Calidad', 'Aprobó prendas con costuras flojas en la revisión de calidad del lote vestidos', 'Marzo 2026', 'Pendiente', '2026-03-02', NULL),
(7, 7, 'Retraso', 'Retraso en empaque lote Studio F por agotamiento de bolsas antihumedad', 'Marzo 2026', 'Pendiente', '2026-03-03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `idInventario` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidadDisponible` int(11) NOT NULL DEFAULT 0,
  `minimoDefinido` int(11) NOT NULL DEFAULT 0,
  `nivelStock` int(11) DEFAULT NULL,
  `unidades` varchar(30) DEFAULT 'unidades',
  `ubicacion` varchar(100) DEFAULT NULL,
  `fechaActualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idInventario`, `idProducto`, `cantidadDisponible`, `minimoDefinido`, `nivelStock`, `unidades`, `ubicacion`, `fechaActualizacion`) VALUES
(1, 1, 200, 50, 200, 'Unidades', 'Bodega Confección A', '2026-03-01'),
(2, 2, 150, 30, 150, 'Unidades', 'Bodega Confección A', '2026-03-01'),
(3, 3, 80, 20, 80, 'Unidades', 'Bodega Confección B', '2026-03-01'),
(4, 4, 60, 15, 60, 'Unidades', 'Bodega Denim', '2026-03-01'),
(5, 5, 120, 40, 120, 'Unidades', 'Bodega Deportiva', '2026-03-01'),
(6, 6, 90, 25, 90, 'Unidades', 'Bodega Formal', '2026-03-01'),
(7, 7, 70, 20, 70, 'Unidades', 'Bodega Formal', '2026-03-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `idMaterial` int(11) NOT NULL,
  `nombreMaterial` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `stockActual` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stockMinimo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `unidadBase` varchar(20) NOT NULL DEFAULT 'unidad',
  `costoUnitario` decimal(10,2) NOT NULL DEFAULT 0.00,
  `fechaActualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`idMaterial`, `nombreMaterial`, `descripcion`, `stockActual`, `stockMinimo`, `unidadBase`, `costoUnitario`, `fechaActualizacion`) VALUES
(1, 'Tela Algodón Peinado', 'Tela 100% algodón peinado 180 g/m², ancho 1.5 m', 2500.00, 500.00, 'Metro', 4500.00, '2026-03-01'),
(2, 'Hilo Poliéster 40/2', 'Hilo de coser poliéster resistente 40/2, cono 5000 m', 150.00, 30.00, 'Cono', 8500.00, '2026-03-01'),
(3, 'Botón Nácar 4 Huecos', 'Botón nácar sintético 4 huecos 15 mm, colores surtidos', 800.00, 200.00, 'Unidad', 150.00, '2026-03-01'),
(4, 'Cremallera Metálica YKK', 'Cremallera metálica YKK #5 de 25 cm, color negro', 300.00, 100.00, 'Unidad', 1200.00, '2026-03-01'),
(5, 'Elástico Plano 2 cm', 'Elástico tejido plano 2 cm de ancho, alta resistencia al lavado', 500.00, 100.00, 'Metro', 800.00, '2026-03-01'),
(6, 'Entretela Fusionable', 'Entretela no tejida fusionable media rigidez, ancho 90 cm', 400.00, 80.00, 'Metro', 2200.00, '2026-03-01'),
(7, 'Etiqueta Tejida Marca', 'Etiqueta jacquard tejida con marca, talla y país de origen', 1000.00, 200.00, 'Unidad', 350.00, '2026-03-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operarios`
--

CREATE TABLE `operarios` (
  `idOperario` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL COMMENT 'FK a usuarios',
  `especialidad` varchar(100) NOT NULL,
  `fechaIngreso` date NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `operarios`
--

INSERT INTO `operarios` (`idOperario`, `idUsuario`, `especialidad`, `fechaIngreso`, `estado`) VALUES
(1, 23, 'Corte', '2025-02-01', 'activo'),
(2, 4, 'Confección', '2025-02-01', 'activo'),
(3, 5, 'Bordado', '2025-02-15', 'activo'),
(4, 6, 'Estampado', '2025-03-01', 'activo'),
(5, 7, 'Planchado', '2025-03-01', 'activo'),
(6, 8, 'Control de Calidad', '2025-03-15', 'activo'),
(7, 9, 'Empaque', '2025-04-01', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes`
--

CREATE TABLE `ordenes` (
  `idOrden` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL COMMENT 'FK a clientes',
  `idProducto` int(11) DEFAULT NULL COMMENT 'FK a productos — producto de la orden',
  `fechaCreacion` date NOT NULL,
  `fechaEntregaEstimada` date DEFAULT NULL,
  `instrucciones` varchar(1000) NOT NULL,
  `cantidad` int(11) DEFAULT NULL COMMENT 'Unidades pedidas',
  `precioUnitario` decimal(10,2) DEFAULT NULL COMMENT 'Precio unitario al momento de la orden',
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `precioUnitario`) STORED COMMENT 'Calculado automáticamente',
  `prioridad` enum('Normal','Urgente') NOT NULL DEFAULT 'Normal',
  `estado` enum('Pendiente','Procesando','Enviado','Entregado','Cancelado') NOT NULL DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ordenes`
--

INSERT INTO `ordenes` (`idOrden`, `idCliente`, `idProducto`, `fechaCreacion`, `fechaEntregaEstimada`, `instrucciones`, `cantidad`, `precioUnitario`, `prioridad`, `estado`) VALUES
(1, 1, 1, '2026-01-10', '2026-01-25', 'Camisetas con logo bordado en pecho izquierdo, bolsa individual', 500, 35000.00, 'Normal', 'Entregado'),
(2, 2, 2, '2026-01-15', '2026-01-30', 'Pantalones slim tallas 30-38, etiqueta interna y swing tag', 300, 85000.00, 'Normal', 'Enviado'),
(3, 3, 4, '2026-01-20', '2026-02-10', 'Chaquetas denim acabado vintage, instrucciones de lavado incluidas', 200, 130000.00, 'Urgente', 'Procesando'),
(4, 4, 6, '2026-02-01', '2026-02-15', 'Blusas con bordado exclusivo logo AC, empacar en caja individual', 150, 75000.00, 'Normal', 'Procesando'),
(5, 5, 5, '2026-02-10', '2026-02-25', 'Bermudas deportivas colección verano, etiqueta reflectiva lateral', 400, 55000.00, 'Normal', 'Pendiente'),
(6, 6, 7, '2026-02-20', '2026-03-05', 'Faldas plisadas midi temporada, control de calidad exhaustivo', 180, 70000.00, 'Urgente', 'Pendiente'),
(7, 7, 3, '2026-03-01', '2026-03-18', 'Vestidos casuales fondo negro, estampado floral, empacar con papel', 220, 95000.00, 'Normal', 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `produccion`
--

CREATE TABLE `produccion` (
  `idProduccion` int(11) NOT NULL,
  `idOrden` int(11) DEFAULT NULL COMMENT 'FK a ordenes (puede ser NULL)',
  `idProducto` int(11) NOT NULL COMMENT 'FK a productos',
  `descripcion` varchar(255) NOT NULL,
  `cantidadRequerida` int(11) NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaEstimadaFin` date NOT NULL,
  `fechaRealFin` date DEFAULT NULL,
  `costoEstimado` decimal(12,2) DEFAULT NULL,
  `costoReal` decimal(12,2) DEFAULT NULL,
  `estado` enum('Pendiente','En Progreso','Completado','Detenido') NOT NULL DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `produccion`
--

INSERT INTO `produccion` (`idProduccion`, `idOrden`, `idProducto`, `descripcion`, `cantidadRequerida`, `fechaInicio`, `fechaEstimadaFin`, `fechaRealFin`, `costoEstimado`, `costoReal`, `estado`) VALUES
(1, 1, 1, 'Lote camisetas básicas — orden Éxito', 500, '2026-01-10', '2026-01-24', '2026-01-24', 12000000.00, 11500000.00, 'Completado'),
(2, 2, 2, 'Lote pantalones clásicos — orden Koaj', 300, '2026-01-15', '2026-01-29', NULL, 18000000.00, NULL, 'En Progreso'),
(3, 3, 4, 'Lote chaquetas denim — orden Eliot', 200, '2026-01-20', '2026-02-09', NULL, 20000000.00, NULL, 'En Progreso'),
(4, 4, 6, 'Lote blusas formales — orden Arturo Calle', 150, '2026-02-01', '2026-02-14', NULL, 9000000.00, NULL, 'En Progreso'),
(5, 5, 5, 'Lote bermudas deportivas — orden Tennis', 400, '2026-02-10', '2026-02-24', NULL, 16000000.00, NULL, 'Pendiente'),
(6, 6, 7, 'Lote faldas plisadas — orden Punto Blanco', 180, '2026-02-20', '2026-03-04', NULL, 10800000.00, NULL, 'Pendiente'),
(7, 7, 3, 'Lote vestidos casuales — orden Studio F', 220, '2026-03-01', '2026-03-17', NULL, 17600000.00, NULL, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `nombre`, `descripcion`, `precio`, `categoria`, `cantidad`) VALUES
(1, 'Camiseta Básica', 'Camiseta 100% algodón peinado 180 g/m², corte recto unisex', 35000.00, 'Camisetas', 0),
(2, 'Pantalón Clásico', 'Pantalón gabardina stretch corte slim, tallas 28-38', 85000.00, 'Pantalones', 0),
(3, 'Vestido Casual', 'Vestido viscosa estampada manga corta, talla única ajustable', 95000.00, 'Vestidos', 0),
(4, 'Chaqueta Denim', 'Chaqueta denim 12 oz acabado desgastado, botones metálicos', 130000.00, 'Chaquetas', 0),
(5, 'Bermuda Deportiva', 'Bermuda tela sintética transpirable con bolsillos laterales', 55000.00, 'Bermudas', 0),
(6, 'Blusa Formal', 'Blusa popelina con bordado exclusivo en pecho, manga larga', 75000.00, 'Blusas', 0),
(7, 'Falda Plisada', 'Falda plisada poliéster largo midi, pretina elástica reforzada', 70000.00, 'Faldas', 0),
(8, 'Jeans azules', 'pantalones unisex baggy', 20000.00, '[value-5]', 0);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `trg_productos_insert` AFTER INSERT ON `productos` FOR EACH ROW BEGIN
    INSERT INTO audi_productos (
        idProducto,
        nombreProducto,
        precio,
        accion,
        fecha,
        usuario
    )
    VALUES (
        NEW.idProducto,
        NEW.nombre,
        NEW.precio,
        'INSERT',
        NOW(),
        CURRENT_USER()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idProveedor` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL COMMENT 'FK a usuarios — administrador que gestiona el proveedor',
  `nombreEmpresa` varchar(150) NOT NULL,
  `nombreContacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(200) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `nit` varchar(30) DEFAULT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `fechaRegistro` date NOT NULL DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedor`, `idUsuario`, `nombreEmpresa`, `nombreContacto`, `telefono`, `correo`, `direccion`, `nit`, `estado`, `fechaRegistro`) VALUES
(1, 1, 'Textiles Colombia S.A.', 'Jorge Bedoya', '3002000001', 'ventas@textilescol.com', 'Calle 13 #34-20, Bogotá', '830456789-1', 'activo', '2025-12-01'),
(2, 2, 'Hilos y Fibras Andinas', 'Carmen Ríos', '3152000002', 'pedidos@hilosandinos.com', 'Carrera 50 #12-30, Medellín', '900234567-2', 'activo', '2025-12-05'),
(3, 1, 'Botones y Avíos del Norte', 'Ricardo Peña', '3203000003', 'avios@btnorte.com', 'Av. 80 #65-10, Barranquilla', '901345678-3', 'activo', '2025-12-10'),
(4, 2, 'Cremalleras YKK Colombia', 'Sandra López', '3104000004', 'ventas@ykkco.com', 'Calle 100 #19-60, Bogotá', '830567890-4', 'activo', '2026-01-05'),
(5, 1, 'Elásticos y Cintas S.A.S.', 'Mauricio Silva', '3005000005', 'pedidos@elasticos.com', 'Carrera 7 #45-80, Bogotá', '900678901-5', 'activo', '2026-01-10'),
(6, 2, 'Entretelas del Pacífico', 'Gloria Muñoz', '3156000006', 'entretelas@pacifico.com', 'Calle 5 #10-20, Cali', '901789012-6', 'activo', '2026-01-15'),
(7, 1, 'Etiquetas y Marcas Print', 'Héctor Duarte', '3107000007', 'ventas@etiquetasprint.com', 'Carrera 15 #88-20, Bogotá', '830890123-7', 'activo', '2026-01-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `idTarea` int(11) NOT NULL,
  `idProduccion` int(11) DEFAULT NULL COMMENT 'Tarea vinculada a un proceso de producción',
  `nombreTarea` varchar(150) NOT NULL,
  `descripcionTarea` text NOT NULL,
  `fechaCreacion` date NOT NULL,
  `proceso` varchar(100) NOT NULL,
  `complejidad` enum('baja','media','alta') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`idTarea`, `idProduccion`, `nombreTarea`, `descripcionTarea`, `fechaCreacion`, `proceso`, `complejidad`) VALUES
(1, 1, 'Corte de tela — camisetas', 'Cortar tela algodón según moldes de camiseta básica tallas S-XL', '2026-01-10', 'Corte', 'media'),
(2, 2, 'Confección de pantalones', 'Unir piezas, coser costuras principales y colocar cremallera', '2026-01-15', 'Confección', 'alta'),
(3, 3, 'Ensamble chaquetas denim', 'Unir delantero, espalda y mangas; remache de botones metálicos', '2026-01-20', 'Confección', 'alta'),
(4, 4, 'Bordado blusas formales', 'Aplicar bordado exclusivo logo AC en pecho izquierdo de la blusa', '2026-02-01', 'Bordado', 'alta'),
(5, 5, 'Estampado bermudas', 'Aplicar estampado reflectivo lateral con serigrafía en 2 colores', '2026-02-10', 'Estampado', 'media'),
(6, 6, 'Planchado faldas plisadas', 'Planchar pliegues con vapor industrial 160°C; controlar temperatura', '2026-02-20', 'Planchado', 'media'),
(7, 7, 'Control de calidad vestidos', 'Inspeccionar costuras, estampado y acabados del lote Studio F', '2026-03-01', 'Control de Calidad', 'baja');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea_materiales`
--

CREATE TABLE `tarea_materiales` (
  `idTareaMaterial` int(11) NOT NULL,
  `idTarea` int(11) NOT NULL,
  `idMaterial` int(11) NOT NULL,
  `cantidadUsada` decimal(10,2) NOT NULL COMMENT 'Cantidad consumida del material',
  `unidad` varchar(20) NOT NULL DEFAULT 'unidad',
  `observaciones` text DEFAULT NULL,
  `fechaRegistro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarea_materiales`
--

INSERT INTO `tarea_materiales` (`idTareaMaterial`, `idTarea`, `idMaterial`, `cantidadUsada`, `unidad`, `observaciones`, `fechaRegistro`) VALUES
(1, 1, 1, 3.50, 'Metro', 'Tela algodón cortada según moldes camiseta tallas S-XL', '2026-01-11 08:00:00'),
(2, 2, 2, 2.00, 'Cono', 'Hilo para costuras principales y dobladillo del pantalón', '2026-01-16 08:00:00'),
(3, 3, 4, 1.00, 'Unidad', 'Cremallera YKK en bolsillo lateral de la chaqueta denim', '2026-01-21 08:00:00'),
(4, 4, 3, 6.00, 'Unidad', 'Botones nácar para decoración en cuello de blusa formal', '2026-02-02 08:00:00'),
(5, 5, 5, 0.30, 'Metro', 'Elástico para cintura interior de bermuda deportiva', '2026-02-11 08:00:00'),
(6, 6, 6, 0.50, 'Metro', 'Entretela fusionable en pretina de falda plisada', '2026-02-21 08:00:00'),
(7, 7, 7, 1.00, 'Unidad', 'Etiqueta de marca y talla aplicada en costado del vestido', '2026-03-02 08:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correoElectronico` varchar(200) NOT NULL,
  `contrasena` varchar(255) NOT NULL COMMENT 'Almacenar siempre hasheada (bcrypt/argon2)',
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `rol` enum('administrador','operario','cliente') NOT NULL DEFAULT 'cliente',
  `especialidad` varchar(100) DEFAULT NULL COMMENT 'Solo aplica a operarios',
  `fechaIngreso` date DEFAULT NULL COMMENT 'Solo aplica a operarios',
  `estado` enum('activo','inactivo','reportado') NOT NULL DEFAULT 'activo',
  `fechaCreacion` datetime NOT NULL DEFAULT current_timestamp(),
  `ultimaConexion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `apellido`, `correoElectronico`, `contrasena`, `telefono`, `direccion`, `rol`, `especialidad`, `fechaIngreso`, `estado`, `fechaCreacion`, `ultimaConexion`) VALUES
(1, 'Andrea', 'Rios', 'andrea.rios@hebratech.com', '$2b$10$HASH_PENDIENTE', '3001000001', 'Bogotá', 'administrador', NULL, NULL, 'activo', '2025-01-01 08:00:00', '2026-03-17 09:00:00'),
(2, 'Miguel', 'Torres', 'miguel.torres@hebratech.com', '$2b$10$HASH_PENDIENTE', '3001000002', 'Bogotá', 'administrador', NULL, NULL, 'activo', '2025-01-01 08:00:00', '2026-03-17 08:30:00'),
(4, 'Carlos', 'Méndez', 'carlos.mendez@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000002', NULL, 'operario', 'Confección', '2025-02-01', 'activo', '2025-02-01 08:00:00', NULL),
(5, 'Diana', 'Puentes', 'diana.puentes@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000003', NULL, 'operario', 'Bordado', '2025-02-15', 'activo', '2025-02-15 08:00:00', NULL),
(6, 'Felipe', 'Mora', 'felipe.mora@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000004', NULL, 'operario', 'Estampado', '2025-03-01', 'activo', '2025-03-01 08:00:00', NULL),
(7, 'Valentina', 'Cruz', 'valentina.cruz@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000005', NULL, 'operario', 'Planchado', '2025-03-01', 'activo', '2025-03-01 08:00:00', NULL),
(8, 'Sergio', 'Leal', 'sergio.leal@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000006', NULL, 'operario', 'Control de Calidad', '2025-03-15', 'activo', '2025-03-15 08:00:00', NULL),
(9, 'Natalia', 'Ossa', 'natalia.ossa@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000007', NULL, 'operario', 'Empaque', '2025-04-01', 'activo', '2025-04-01 08:00:00', NULL),
(10, 'Compras', 'Exito', 'compras@exito.com', '$2b$10$HASH_PENDIENTE', '6017001000', 'Cra 43A #1 Sur, Medellín', 'cliente', NULL, NULL, 'activo', '2025-05-01 08:00:00', NULL),
(11, 'Pedidos', 'Koaj', 'pedidos@koaj.com', '$2b$10$HASH_PENDIENTE', '6017002000', 'Calle 80 #50-30, Bogotá', 'cliente', NULL, NULL, 'activo', '2025-05-01 08:00:00', NULL),
(12, 'Compras', 'Eliot', 'compras@eliot.com', '$2b$10$HASH_PENDIENTE', '6017003000', 'Carrera 7 #12-40, Bogotá', 'cliente', NULL, NULL, 'activo', '2025-06-01 08:00:00', NULL),
(13, 'Pedidos', 'ArturoCalle', 'pedidos@arturocalle.com', '$2b$10$HASH_PENDIENTE', '6017004000', 'El Poblado, Medellín', 'cliente', NULL, NULL, 'activo', '2025-06-01 08:00:00', NULL),
(14, 'Compras', 'Tennis', 'compras@tennis.com', '$2b$10$HASH_PENDIENTE', '6017005000', 'Calle 97 #60-30, Bogotá', 'cliente', NULL, NULL, 'activo', '2025-07-01 08:00:00', NULL),
(15, 'Pedidos', 'PuntoBlanco', 'pedidos@puntoblanco.com', '$2b$10$HASH_PENDIENTE', '6017006000', 'Av. 6N #24-01, Cali', 'cliente', NULL, NULL, 'activo', '2025-07-01 08:00:00', NULL),
(16, 'Compras', 'StudioF', 'compras@studiof.com', '$2b$10$HASH_PENDIENTE', '6017007000', 'Calle 122 #15-80, Bogotá', 'cliente', NULL, NULL, 'activo', '2025-08-01 08:00:00', NULL),
(23, 'Laura', 'Gomez', 'lucia.vargas@hebratech.com', '$2b$10$HASH_PENDIENTE', '3101000001', NULL, 'operario', 'Corte', '2025-02-01', 'activo', '2025-02-01 08:00:00', NULL);

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `trg_insert_usuarios` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO audi_usuarios (
        idUsuario,
    	accion,
    	datos_antes,
    	datos_despues,
    	usuario_bd,
    	fecha
    )
    VALUES (
        NEW.idUsuario,
        'INSERT',
        CONCAT(
            'Nombre: ', NEW.nombre,
            ', Apellido: ', NEW.apellido,
            ', Correo: ', NEW.correoElectronico,
            ', Teléfono: ', NEW.telefono,
            ', Dirección: ', NEW.direccion,
            ', Rol: ', NEW.rol
        ),
        CURRENT_USER(),
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_usuarios_update` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO audi_usuarios (
        idUsuario,
        accion,
        datos_antes,
        datos_despues,
        usuario_bd,
        fecha
    )
    VALUES (
        OLD.idUsuario,
        'UPDATE',
        CONCAT('Nombre: ', OLD.nombre, 
               ', Apellido: ', OLD.apellido,
               ', Correo: ', OLD.correoElectronico),
        CONCAT('Nombre: ', NEW.nombre, 
               ', Apellido: ', NEW.apellido,
               ', Correo: ', NEW.correoElectronico),
        CURRENT_USER(),
        NOW()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ver_incidentes_de_operario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `ver_incidentes_de_operario` (
`el_operario_en_cuestion` int(11)
,`que_sucedio` text
,`pendiente_o_revisado` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ver_un_producto_y_su_estado_en_la_produccion`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `ver_un_producto_y_su_estado_en_la_produccion` (
`nombre` varchar(150)
,`descripcion` text
,`categoria` varchar(100)
,`estado` enum('Pendiente','En Progreso','Completado','Detenido')
);

-- --------------------------------------------------------

--
-- Estructura para la vista `ver_incidentes_de_operario`
--
DROP TABLE IF EXISTS `ver_incidentes_de_operario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ver_incidentes_de_operario`  AS SELECT `i`.`idOperario` AS `el_operario_en_cuestion`, `i`.`descripcion` AS `que_sucedio`, `i`.`estado` AS `pendiente_o_revisado` FROM `incidencias` AS `i` WHERE `i`.`idIncidencia` = 4 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `ver_un_producto_y_su_estado_en_la_produccion`
--
DROP TABLE IF EXISTS `ver_un_producto_y_su_estado_en_la_produccion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ver_un_producto_y_su_estado_en_la_produccion`  AS SELECT `p`.`nombre` AS `nombre`, `p`.`descripcion` AS `descripcion`, `p`.`categoria` AS `categoria`, `pr`.`estado` AS `estado` FROM (`productos` `p` join `produccion` `pr` on(`p`.`idProducto` = `pr`.`idProducto`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion_tareas`
--
ALTER TABLE `asignacion_tareas`
  ADD PRIMARY KEY (`idAsignacion`),
  ADD KEY `fk_asig_tarea` (`idTarea`),
  ADD KEY `fk_asig_operario` (`idOperario`);

--
-- Indices de la tabla `audi_productos`
--
ALTER TABLE `audi_productos`
  ADD PRIMARY KEY (`idAuditoria`);

--
-- Indices de la tabla `audi_usuarios`
--
ALTER TABLE `audi_usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `uq_cliente_usuario` (`idUsuario`),
  ADD KEY `idx_cliente_nit` (`nit`);

--
-- Indices de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`idDevolucion`),
  ADD KEY `fk_dev_inventario` (`idInventario`);

--
-- Indices de la tabla `entrada_materiales`
--
ALTER TABLE `entrada_materiales`
  ADD PRIMARY KEY (`idEntrada`),
  ADD KEY `fk_em_proveedor` (`idProveedor`),
  ADD KEY `fk_em_material` (`idMaterial`),
  ADD KEY `idx_em_proveedor` (`idProveedor`),
  ADD KEY `idx_em_material` (`idMaterial`);

--
-- Indices de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD PRIMARY KEY (`idIncidencia`),
  ADD KEY `fk_inc_operario` (`idOperario`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`idInventario`),
  ADD KEY `fk_inv_producto` (`idProducto`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`idMaterial`),
  ADD UNIQUE KEY `uq_nombre_material` (`nombreMaterial`);

--
-- Indices de la tabla `operarios`
--
ALTER TABLE `operarios`
  ADD PRIMARY KEY (`idOperario`),
  ADD KEY `fk_op_usuario` (`idUsuario`);

--
-- Indices de la tabla `ordenes`
--
ALTER TABLE `ordenes`
  ADD PRIMARY KEY (`idOrden`),
  ADD KEY `fk_ord_cliente` (`idCliente`),
  ADD KEY `fk_ord_producto` (`idProducto`),
  ADD KEY `idx_ord_producto` (`idProducto`),
  ADD KEY `idx_orden_estado` (`estado`);

--
-- Indices de la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD PRIMARY KEY (`idProduccion`),
  ADD KEY `fk_prod_orden` (`idOrden`),
  ADD KEY `fk_prod_producto` (`idProducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idProveedor`),
  ADD KEY `fk_prov_usuario` (`idUsuario`),
  ADD KEY `idx_prov_usuario` (`idUsuario`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`idTarea`),
  ADD KEY `fk_tarea_produccion` (`idProduccion`);

--
-- Indices de la tabla `tarea_materiales`
--
ALTER TABLE `tarea_materiales`
  ADD PRIMARY KEY (`idTareaMaterial`),
  ADD UNIQUE KEY `uq_tarea_material` (`idTarea`,`idMaterial`) COMMENT 'Un material no se repite en la misma tarea',
  ADD KEY `fk_tm_tarea` (`idTarea`),
  ADD KEY `fk_tm_material` (`idMaterial`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `uq_correo` (`correoElectronico`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignacion_tareas`
--
ALTER TABLE `asignacion_tareas`
  MODIFY `idAsignacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `audi_productos`
--
ALTER TABLE `audi_productos`
  MODIFY `idAuditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `audi_usuarios`
--
ALTER TABLE `audi_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `idDevolucion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `entrada_materiales`
--
ALTER TABLE `entrada_materiales`
  MODIFY `idEntrada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  MODIFY `idIncidencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `idInventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `idMaterial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `operarios`
--
ALTER TABLE `operarios`
  MODIFY `idOperario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ordenes`
--
ALTER TABLE `ordenes`
  MODIFY `idOrden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `produccion`
--
ALTER TABLE `produccion`
  MODIFY `idProduccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `idTarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tarea_materiales`
--
ALTER TABLE `tarea_materiales`
  MODIFY `idTareaMaterial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion_tareas`
--
ALTER TABLE `asignacion_tareas`
  ADD CONSTRAINT `fk_asig_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asig_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_cli_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD CONSTRAINT `fk_dev_inventario` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrada_materiales`
--
ALTER TABLE `entrada_materiales`
  ADD CONSTRAINT `fk_em_material` FOREIGN KEY (`idMaterial`) REFERENCES `materiales` (`idMaterial`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_em_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD CONSTRAINT `fk_inc_operario` FOREIGN KEY (`idOperario`) REFERENCES `operarios` (`idOperario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inv_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `operarios`
--
ALTER TABLE `operarios`
  ADD CONSTRAINT `fk_op_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ordenes`
--
ALTER TABLE `ordenes`
  ADD CONSTRAINT `fk_ord_cliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ord_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD CONSTRAINT `fk_prod_orden` FOREIGN KEY (`idOrden`) REFERENCES `ordenes` (`idOrden`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prod_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `fk_prov_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `fk_tarea_produccion` FOREIGN KEY (`idProduccion`) REFERENCES `produccion` (`idProduccion`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `tarea_materiales`
--
ALTER TABLE `tarea_materiales`
  ADD CONSTRAINT `fk_tm_material` FOREIGN KEY (`idMaterial`) REFERENCES `materiales` (`idMaterial`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tm_tarea` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
