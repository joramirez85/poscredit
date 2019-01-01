-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-01-2019 a las 01:05:36
-- Versión del servidor: 10.1.33-MariaDB
-- Versión de PHP: 7.1.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `categoria`, `fecha`) VALUES
(1, 'Equipos Electromecánicos', '2017-12-21 20:53:29'),
(2, 'Taladros', '2017-12-21 20:53:29'),
(3, 'Andamios', '2017-12-21 20:53:29'),
(4, 'Generadores de energía', '2017-12-21 20:53:29'),
(5, 'Equipos para construcción', '2017-12-21 20:53:29'),
(6, 'Martillos mecánicos', '2017-12-21 23:06:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `documento` int(11) NOT NULL,
  `email` text COLLATE utf8_spanish_ci NOT NULL,
  `telefono` text COLLATE utf8_spanish_ci NOT NULL,
  `direccion` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `compras` int(11) NOT NULL,
  `ultima_compra` datetime NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `documento`, `email`, `telefono`, `direccion`, `fecha_nacimiento`, `compras`, `ultima_compra`, `fecha`) VALUES
(3, 'Juan Villegas', 2147483647, 'juan@hotmail.com', '(300) 341-2345', 'Calle 23 # 45 - 56', '1980-11-02', 30, '2018-12-25 00:07:51', '2018-12-25 05:07:51'),
(4, 'Pedro Pérez', 2147483647, 'pedro@gmail.com', '(399) 876-5432', 'Calle 34 N33 -56', '1970-08-07', 14, '2018-12-25 00:34:05', '2018-12-25 05:34:05'),
(5, 'Miguel Murillo', 325235235, 'miguel@hotmail.com', '(254) 545-3446', 'calle 34 # 34 - 23', '1976-03-04', 38, '2018-12-22 20:48:56', '2018-12-23 01:48:56'),
(6, 'Margarita Londoño', 34565432, 'margarita@hotmail.com', '(344) 345-6678', 'Calle 45 # 34 - 56', '1976-11-30', 41, '2018-12-30 21:13:41', '2018-12-31 02:13:41'),
(7, 'Julian Ramirez', 786786545, 'julian@hotmail.com', '(675) 674-5453', 'Carrera 45 # 54 - 56', '1980-04-05', 18, '2018-12-24 19:47:02', '2018-12-25 00:47:02'),
(8, 'Stella Jaramillo', 65756735, 'stella@gmail.com', '(435) 346-3463', 'Carrera 34 # 45- 56', '1956-06-05', 21, '2018-12-25 00:48:39', '2018-12-25 05:48:39'),
(9, 'Eduardo López', 2147483647, 'eduardo@gmail.com', '(534) 634-6565', 'Carrera 67 # 45sur', '1978-03-04', 22, '2018-12-30 21:11:36', '2018-12-31 02:11:36'),
(10, 'Ximena Restrepo', 436346346, 'ximena@gmail.com', '(543) 463-4634', 'calle 45 # 23 - 45', '1956-03-04', 18, '2017-12-26 17:25:08', '2017-12-26 22:25:08'),
(11, 'David Guzman', 43634643, 'david@hotmail.com', '(354) 574-5634', 'carrera 45 # 45 ', '1967-05-04', 10, '2017-12-26 17:24:50', '2017-12-26 22:24:50'),
(12, 'Gonzalo Pérez', 436346346, 'gonzalo@yahoo.com', '(235) 346-3464', 'Carrera 34 # 56 - 34', '1967-08-09', 30, '2018-12-24 20:42:19', '2018-12-25 01:42:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `codigo` text COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `imagen` text COLLATE utf8_spanish_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `precio_compra` float NOT NULL,
  `precio_venta` float NOT NULL,
  `ventas` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `id_categoria`, `codigo`, `descripcion`, `imagen`, `stock`, `precio_compra`, `precio_venta`, `ventas`, `fecha`) VALUES
(1, 1, '101', 'Aspiradora Industrial ', 'vistas/img/productos/101/105.png', 13, 1000, 1200, 2, '2017-12-24 01:11:04'),
(2, 1, '102', 'Plato Flotante para Allanadora', 'vistas/img/productos/102/940.jpg', 6, 4500, 6300, 3, '2017-12-26 15:04:11'),
(3, 1, '103', 'Compresor de Aire para pintura', 'vistas/img/productos/103/763.jpg', 8, 3000, 4200, 12, '2017-12-26 15:03:22'),
(4, 1, '104', 'Cortadora de Adobe sin Disco ', 'vistas/img/productos/104/957.jpg', 16, 4000, 5600, 4, '2017-12-26 15:03:22'),
(5, 1, '105', 'Cortadora de Piso sin Disco ', 'vistas/img/productos/105/630.jpg', 13, 1540, 2156, 7, '2017-12-26 15:03:22'),
(6, 1, '106', 'Disco Punta Diamante ', 'vistas/img/productos/106/635.jpg', 15, 1100, 1540, 5, '2017-12-26 15:04:38'),
(7, 1, '107', 'Extractor de Aire ', 'vistas/img/productos/107/848.jpg', 12, 1540, 2156, 8, '2017-12-26 15:04:11'),
(8, 1, '108', 'Guadañadora ', 'vistas/img/productos/108/163.jpg', 13, 1540, 2156, 7, '2017-12-26 15:03:52'),
(9, 1, '109', 'Hidrolavadora Eléctrica ', 'vistas/img/productos/109/769.jpg', 15, 2600, 3640, 5, '2017-12-26 15:05:09'),
(10, 1, '110', 'Hidrolavadora Gasolina', 'vistas/img/productos/110/582.jpg', 18, 2210, 3094, 2, '2017-12-26 15:05:09'),
(11, 1, '111', 'Motobomba a Gasolina', 'vistas/img/productos/default/anonymous.png', 20, 2860, 4004, 0, '2017-12-21 21:56:28'),
(12, 1, '112', 'Motobomba El?ctrica', 'vistas/img/productos/default/anonymous.png', 20, 2400, 3360, 0, '2017-12-21 21:56:28'),
(13, 1, '113', 'Sierra Circular ', 'vistas/img/productos/default/anonymous.png', 20, 1100, 1540, 0, '2017-12-21 21:56:28'),
(14, 1, '114', 'Disco de tugsteno para Sierra circular', 'vistas/img/productos/default/anonymous.png', 20, 4500, 6300, 0, '2017-12-21 21:56:28'),
(15, 1, '115', 'Soldador Electrico ', 'vistas/img/productos/default/anonymous.png', 20, 1980, 2772, 0, '2017-12-21 21:56:28'),
(16, 1, '116', 'Careta para Soldador', 'vistas/img/productos/default/anonymous.png', 20, 4200, 5880, 0, '2017-12-21 21:56:28'),
(17, 1, '117', 'Torre de iluminacion ', 'vistas/img/productos/default/anonymous.png', 20, 1800, 2520, 0, '2017-12-21 21:56:28'),
(18, 2, '201', 'Martillo Demoledor de Piso 110V', 'vistas/img/productos/default/anonymous.png', 20, 5600, 7840, 0, '2017-12-21 21:56:28'),
(19, 2, '202', 'Muela o cincel martillo demoledor piso', 'vistas/img/productos/default/anonymous.png', 20, 9600, 13440, 0, '2017-12-21 21:56:28'),
(20, 2, '203', 'Taladro Demoledor de muro 110V', 'vistas/img/productos/default/anonymous.png', 20, 3850, 5390, 0, '2017-12-21 21:56:28'),
(21, 2, '204', 'Muela o cincel martillo demoledor muro', 'vistas/img/productos/default/anonymous.png', 20, 9600, 13440, 0, '2017-12-21 21:56:28'),
(22, 2, '205', 'Taladro Percutor de 1/2 Madera y Metal', 'vistas/img/productos/default/anonymous.png', 20, 8000, 11200, 0, '2017-12-21 22:28:24'),
(23, 2, '206', 'Taladro Percutor SDS Plus 110V', 'vistas/img/productos/default/anonymous.png', 20, 3900, 5460, 0, '2017-12-21 21:56:28'),
(24, 2, '207', 'Taladro Percutor SDS Max 110V (Mineria)', 'vistas/img/productos/default/anonymous.png', 20, 4600, 6440, 0, '2017-12-21 21:56:28'),
(25, 3, '301', 'Andamio colgante', 'vistas/img/productos/default/anonymous.png', 20, 1440, 2016, 0, '2017-12-21 21:56:28'),
(26, 3, '302', 'Distanciador andamio colgante', 'vistas/img/productos/default/anonymous.png', 20, 1600, 2240, 0, '2017-12-21 21:56:28'),
(27, 3, '303', 'Marco andamio modular ', 'vistas/img/productos/default/anonymous.png', 20, 900, 1260, 0, '2017-12-21 21:56:28'),
(28, 3, '304', 'Marco andamio tijera', 'vistas/img/productos/default/anonymous.png', 20, 100, 140, 0, '2017-12-21 21:56:28'),
(29, 3, '305', 'Tijera para andamio', 'vistas/img/productos/default/anonymous.png', 20, 162, 226, 0, '2017-12-21 21:56:28'),
(30, 3, '306', 'Escalera interna para andamio', 'vistas/img/productos/default/anonymous.png', 20, 270, 378, 0, '2017-12-21 21:56:28'),
(31, 3, '307', 'Pasamanos de seguridad', 'vistas/img/productos/default/anonymous.png', 20, 75, 105, 0, '2017-12-21 21:56:28'),
(32, 3, '308', 'Rueda giratoria para andamio', 'vistas/img/productos/default/anonymous.png', 20, 168, 235, 0, '2017-12-21 21:56:28'),
(33, 3, '309', 'Arnes de seguridad', 'vistas/img/productos/default/anonymous.png', 20, 1750, 2450, 0, '2017-12-21 21:56:28'),
(34, 3, '310', 'Eslinga para arnes', 'vistas/img/productos/default/anonymous.png', 20, 175, 245, 0, '2017-12-21 21:56:28'),
(35, 3, '311', 'Plataforma Met?lica', 'vistas/img/productos/default/anonymous.png', 20, 420, 588, 0, '2017-12-21 21:56:28'),
(36, 4, '401', 'Planta Electrica Diesel 6 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3500, 4900, 0, '2017-12-21 21:56:28'),
(37, 4, '402', 'Planta Electrica Diesel 10 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3550, 4970, 0, '2017-12-21 21:56:28'),
(38, 4, '403', 'Planta Electrica Diesel 20 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3600, 5040, 0, '2017-12-21 21:56:28'),
(39, 4, '404', 'Planta Electrica Diesel 30 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3650, 5110, 0, '2017-12-21 21:56:28'),
(40, 4, '405', 'Planta Electrica Diesel 60 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3700, 5180, 0, '2017-12-21 21:56:28'),
(41, 4, '406', 'Planta Electrica Diesel 75 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3750, 5250, 0, '2017-12-21 21:56:28'),
(42, 4, '407', 'Planta Electrica Diesel 100 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3800, 5320, 0, '2017-12-21 21:56:28'),
(43, 4, '408', 'Planta Electrica Diesel 120 Kva', 'vistas/img/productos/default/anonymous.png', 20, 3850, 5390, 0, '2017-12-21 21:56:28'),
(44, 5, '501', 'Escalera de Tijera Aluminio ', 'vistas/img/productos/default/anonymous.png', 20, 350, 490, 0, '2017-12-21 21:56:28'),
(45, 5, '502', 'Extension Electrica ', 'vistas/img/productos/default/anonymous.png', 20, 370, 518, 0, '2017-12-21 21:56:28'),
(46, 5, '503', 'Gato tensor', 'vistas/img/productos/default/anonymous.png', 20, 380, 532, 0, '2017-12-21 21:56:28'),
(47, 5, '504', 'Lamina Cubre Brecha ', 'vistas/img/productos/default/anonymous.png', 20, 380, 532, 0, '2017-12-21 21:56:28'),
(48, 5, '505', 'Llave de Tubo', 'vistas/img/productos/default/anonymous.png', 20, 480, 672, 0, '2017-12-21 21:56:28'),
(49, 5, '506', 'Manila por Metro', 'vistas/img/productos/default/anonymous.png', 20, 600, 840, 0, '2017-12-21 21:56:28'),
(50, 5, '507', 'Polea 2 canales', 'vistas/img/productos/default/anonymous.png', 20, 900, 1260, 0, '2017-12-21 21:56:28'),
(51, 5, '508', 'Tensor', 'vistas/img/productos/508/500.jpg', 19, 100, 140, 1, '2017-12-26 22:26:51'),
(52, 5, '509', 'Bascula ', 'vistas/img/productos/509/878.jpg', 12, 130, 182, 8, '2017-12-26 22:26:51'),
(53, 5, '510', 'Bomba Hidrostatica', 'vistas/img/productos/510/870.jpg', 8, 770, 1078, 12, '2017-12-26 22:26:51'),
(54, 5, '511', 'Chapeta', 'vistas/img/productos/511/239.jpg', 16, 660, 924, 4, '2017-12-26 22:27:42'),
(55, 5, '512', 'Cilindro muestra de concreto', 'vistas/img/productos/512/266.jpg', 16, 400, 560, 4, '2017-12-26 22:27:41'),
(56, 5, '513', 'Cizalla de Palanca', 'vistas/img/productos/513/445.jpg', 3, 450, 630, 17, '2017-12-27 00:30:12'),
(57, 5, '514', 'Cizalla de Tijera', 'vistas/img/productos/514/249.jpg', 20, 580, 812, 13, '2017-12-27 04:29:22'),
(58, 5, '515', 'Coche llanta neumatica', 'vistas/img/productos/515/174.jpg', 16, 420, 588, 4, '2018-12-20 22:02:28'),
(59, 5, '516', 'Cono slump', 'vistas/img/productos/516/228.jpg', 15, 140, 196, 5, '2018-02-06 22:47:02'),
(60, 5, '517', 'Cortadora de Baldosin', 'vistas/img/productos/517/746.jpg', 11, 930, 1302, 11, '2018-12-25 00:51:56'),
(61, 2, '208', 'taladro carlos 1', 'vistas/img/productos/default/anonymous.png', 99, 1000, 1400, 5, '2018-12-25 05:07:51'),
(68, 2, '209', 'taladro carlos 3', 'vistas/img/productos/default/anonymous.png', 40, 1000, 1400, 14, '2018-12-31 02:13:41'),
(69, 2, '210', 'taladro carlos 4', 'vistas/img/productos/default/anonymous.png', 182, 2000, 2800, 30, '2018-12-31 02:13:41'),
(70, 2, '211', 'taladro carlos 5', 'vistas/img/productos/default/anonymous.png', 71, 500, 700, 41, '2018-12-31 02:13:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_meses`
--

CREATE TABLE `productos_meses` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_meses` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos_meses`
--

INSERT INTO `productos_meses` (`id`, `id_producto`, `cantidad_meses`, `precio`) VALUES
(1, 61, 1, 1680),
(2, 61, 2, 1750),
(3, 61, 3, 1820),
(4, 61, 4, 1890),
(5, 61, 5, 1960),
(6, 68, 1, 1680),
(7, 68, 2, 1750),
(8, 68, 3, 1820),
(9, 68, 4, 1890),
(10, 68, 5, 1960),
(11, 69, 1, 3361),
(12, 69, 2, 3501),
(13, 69, 3, 3641),
(14, 69, 4, 3781),
(15, 69, 5, 3921),
(16, 70, 1, 840),
(17, 70, 2, 875),
(18, 70, 3, 910),
(19, 70, 4, 945),
(20, 70, 5, 980);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `usuario` text COLLATE utf8_spanish_ci NOT NULL,
  `password` text COLLATE utf8_spanish_ci NOT NULL,
  `perfil` text COLLATE utf8_spanish_ci NOT NULL,
  `foto` text COLLATE utf8_spanish_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `ultimo_login` datetime NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `usuario`, `password`, `perfil`, `foto`, `estado`, `ultimo_login`, `fecha`) VALUES
(1, 'Administrador', 'admin', '$2a$07$asxx54ahjppf45sd87a5audjuNLZpiad8K/u8JtTcWtPBNJt2m/DS', 'Administrador', 'vistas/img/usuarios/admin/191.jpg', 1, '2018-12-24 20:39:28', '2018-12-25 01:39:28'),
(57, 'Juan Fernando Urrego', 'juan', '$2a$07$asxx54ahjppf45sd87a5auwRi.z6UsW7kVIpm0CUEuCpmsvT2sG6O', 'Vendedor', 'vistas/img/usuarios/juan/461.jpg', 1, '2018-02-06 16:58:50', '2018-02-06 21:58:50'),
(58, 'Julio Gómez', 'julio', '$2a$07$asxx54ahjppf45sd87a5auQhldmFjGsrgUipGlmQgDAcqevQZSAAC', 'Especial', 'vistas/img/usuarios/julio/100.png', 1, '2018-02-06 17:09:22', '2018-02-06 22:09:22'),
(59, 'Ana Gonzalez', 'ana', '$2a$07$asxx54ahjppf45sd87a5auLd2AxYsA/2BbmGKNk2kMChC3oj7V0Ca', 'Vendedor', 'vistas/img/usuarios/ana/260.png', 1, '2017-12-26 19:21:40', '2017-12-27 00:21:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `productos` text COLLATE utf8_spanish_ci NOT NULL,
  `impuesto` float NOT NULL,
  `neto` float NOT NULL,
  `total` float NOT NULL,
  `metodo_pago` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `codigo`, `id_cliente`, `id_vendedor`, `productos`, `impuesto`, `neto`, `total`, `metodo_pago`, `fecha`) VALUES
(17, 10001, 3, 1, '[{\"id\":\"1\",\"descripcion\":\"Aspiradora Industrial \",\"cantidad\":\"2\",\"stock\":\"13\",\"precio\":\"1200\",\"total\":\"2400\"},{\"id\":\"2\",\"descripcion\":\"Plato Flotante para Allanadora\",\"cantidad\":\"2\",\"stock\":\"7\",\"precio\":\"6300\",\"total\":\"12600\"},{\"id\":\"3\",\"descripcion\":\"Compresor de Aire para pintura\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"4200\",\"total\":\"4200\"}]', 3648, 19200, 22848, 'Efectivo', '2018-02-02 01:11:04'),
(18, 10002, 4, 59, '[{\"id\":\"5\",\"descripcion\":\"Cortadora de Piso sin Disco \",\"cantidad\":\"2\",\"stock\":\"18\",\"precio\":\"2156\",\"total\":\"4312\"},{\"id\":\"4\",\"descripcion\":\"Cortadora de Adobe sin Disco \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"5600\",\"total\":\"5600\"},{\"id\":\"6\",\"descripcion\":\"Disco Punta Diamante \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"1540\",\"total\":\"1540\"},{\"id\":\"7\",\"descripcion\":\"Extractor de Aire \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"2156\",\"total\":\"2156\"}]', 2585.52, 13608, 16193.5, 'TC-34346346346', '2018-02-02 14:57:20'),
(19, 10003, 5, 59, '[{\"id\":\"8\",\"descripcion\":\"Guadañadora \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"2156\",\"total\":\"2156\"},{\"id\":\"9\",\"descripcion\":\"Hidrolavadora Eléctrica \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"3640\",\"total\":\"3640\"},{\"id\":\"7\",\"descripcion\":\"Extractor de Aire \",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"2156\",\"total\":\"2156\"}]', 1510.88, 7952, 9462.88, 'Efectivo', '2018-01-18 14:57:40'),
(20, 10004, 5, 59, '[{\"id\":\"3\",\"descripcion\":\"Compresor de Aire para pintura\",\"cantidad\":\"5\",\"stock\":\"14\",\"precio\":\"4200\",\"total\":\"21000\"},{\"id\":\"4\",\"descripcion\":\"Cortadora de Adobe sin Disco \",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"5600\",\"total\":\"5600\"},{\"id\":\"5\",\"descripcion\":\"Cortadora de Piso sin Disco \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"2156\",\"total\":\"2156\"}]', 5463.64, 28756, 34219.6, 'TD-454475467567', '2018-01-25 14:58:09'),
(21, 10005, 6, 57, '[{\"id\":\"4\",\"descripcion\":\"Cortadora de Adobe sin Disco \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"5600\",\"total\":\"5600\"},{\"id\":\"5\",\"descripcion\":\"Cortadora de Piso sin Disco \",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"2156\",\"total\":\"2156\"},{\"id\":\"3\",\"descripcion\":\"Compresor de Aire para pintura\",\"cantidad\":\"5\",\"stock\":\"9\",\"precio\":\"4200\",\"total\":\"21000\"}]', 5463.64, 28756, 34219.6, 'TC-6756856867', '2018-01-09 14:59:07'),
(22, 10006, 10, 1, '[{\"id\":\"3\",\"descripcion\":\"Compresor de Aire para pintura\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"4200\",\"total\":\"4200\"},{\"id\":\"4\",\"descripcion\":\"Cortadora de Adobe sin Disco \",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"5600\",\"total\":\"5600\"},{\"id\":\"5\",\"descripcion\":\"Cortadora de Piso sin Disco \",\"cantidad\":\"3\",\"stock\":\"13\",\"precio\":\"2156\",\"total\":\"6468\"},{\"id\":\"6\",\"descripcion\":\"Disco Punta Diamante \",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"1540\",\"total\":\"1540\"}]', 3383.52, 17808, 21191.5, 'Efectivo', '2018-01-26 15:03:22'),
(23, 10007, 9, 1, '[{\"id\":\"6\",\"descripcion\":\"Disco Punta Diamante \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"1540\",\"total\":\"1540\"},{\"id\":\"7\",\"descripcion\":\"Extractor de Aire \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"2156\",\"total\":\"2156\"},{\"id\":\"8\",\"descripcion\":\"Guadañadora \",\"cantidad\":\"6\",\"stock\":\"13\",\"precio\":\"2156\",\"total\":\"12936\"},{\"id\":\"9\",\"descripcion\":\"Hidrolavadora Eléctrica \",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"3640\",\"total\":\"3640\"}]', 3851.68, 20272, 24123.7, 'TC-357547467346', '2017-11-30 15:03:53'),
(24, 10008, 12, 1, '[{\"id\":\"2\",\"descripcion\":\"Plato Flotante para Allanadora\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"6300\",\"total\":\"6300\"},{\"id\":\"7\",\"descripcion\":\"Extractor de Aire \",\"cantidad\":\"5\",\"stock\":\"12\",\"precio\":\"2156\",\"total\":\"10780\"},{\"id\":\"6\",\"descripcion\":\"Disco Punta Diamante \",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"1540\",\"total\":\"1540\"},{\"id\":\"9\",\"descripcion\":\"Hidrolavadora Eléctrica \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"3640\",\"total\":\"3640\"}]', 4229.4, 22260, 26489.4, 'TD-35745575', '2017-12-25 15:04:11'),
(25, 10009, 11, 1, '[{\"id\":\"10\",\"descripcion\":\"Hidrolavadora Gasolina\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"3094\",\"total\":\"3094\"},{\"id\":\"9\",\"descripcion\":\"Hidrolavadora Eléctrica \",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"3640\",\"total\":\"3640\"},{\"id\":\"6\",\"descripcion\":\"Disco Punta Diamante \",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"1540\",\"total\":\"1540\"}]', 1572.06, 8274, 9846.06, 'TD-5745745745', '2017-08-15 15:04:38'),
(26, 10010, 8, 1, '[{\"id\":\"9\",\"descripcion\":\"Hidrolavadora Eléctrica \",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"3640\",\"total\":\"3640\"},{\"id\":\"10\",\"descripcion\":\"Hidrolavadora Gasolina\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"3094\",\"total\":\"3094\"}]', 1279.46, 6734, 8013.46, 'Efectivo', '2017-12-07 15:05:09'),
(27, 10011, 7, 1, '[{\"id\":\"60\",\"descripcion\":\"Cortadora de Baldosin\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"1302\",\"total\":\"1302\"},{\"id\":\"59\",\"descripcion\":\"Cono slump\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"196\",\"total\":\"196\"},{\"id\":\"58\",\"descripcion\":\"Coche llanta neumatica\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"588\",\"total\":\"588\"},{\"id\":\"57\",\"descripcion\":\"Cizalla de Tijera\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"812\",\"total\":\"812\"}]', 550.62, 2898, 3448.62, 'Efectivo', '2017-12-25 22:23:38'),
(28, 10012, 12, 57, '[{\"id\":\"59\",\"descripcion\":\"Cono slump\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"196\",\"total\":\"196\"},{\"id\":\"58\",\"descripcion\":\"Coche llanta neumatica\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"588\",\"total\":\"588\"},{\"id\":\"54\",\"descripcion\":\"Chapeta\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"924\",\"total\":\"924\"},{\"id\":\"53\",\"descripcion\":\"Bomba Hidrostatica\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"1078\",\"total\":\"1078\"}]', 529.34, 2786, 3315.34, 'TC-3545235235', '2017-12-25 22:24:24'),
(29, 10013, 11, 57, '[{\"id\":\"54\",\"descripcion\":\"Chapeta\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"924\",\"total\":\"924\"},{\"id\":\"59\",\"descripcion\":\"Cono slump\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"196\",\"total\":\"196\"},{\"id\":\"60\",\"descripcion\":\"Cortadora de Baldosin\",\"cantidad\":\"5\",\"stock\":\"14\",\"precio\":\"1302\",\"total\":\"6510\"}]', 1449.7, 7630, 9079.7, 'TC-425235235235', '2017-12-26 22:24:50'),
(30, 10014, 10, 57, '[{\"id\":\"59\",\"descripcion\":\"Cono slump\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"196\",\"total\":\"196\"},{\"id\":\"54\",\"descripcion\":\"Chapeta\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"924\",\"total\":\"924\"},{\"id\":\"53\",\"descripcion\":\"Bomba Hidrostatica\",\"cantidad\":\"10\",\"stock\":\"9\",\"precio\":\"1078\",\"total\":\"10780\"}]', 2261, 11900, 14161, 'Efectivo', '2017-12-26 22:25:09'),
(31, 10015, 9, 57, '[{\"id\":\"57\",\"descripcion\":\"Cizalla de Tijera\",\"cantidad\":\"3\",\"stock\":\"16\",\"precio\":\"812\",\"total\":\"2436\"}]', 462.84, 2436, 2898.84, 'Efectivo', '2017-12-26 22:25:33'),
(32, 10016, 8, 57, '[{\"id\":\"58\",\"descripcion\":\"Coche llanta neumatica\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"588\",\"total\":\"588\"},{\"id\":\"57\",\"descripcion\":\"Cizalla de Tijera\",\"cantidad\":\"5\",\"stock\":\"11\",\"precio\":\"812\",\"total\":\"4060\"},{\"id\":\"56\",\"descripcion\":\"Cizalla de Palanca\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"630\",\"total\":\"630\"}]', 1002.82, 5278, 6280.82, 'TD-4523523523', '2017-12-26 22:25:55'),
(33, 10017, 7, 57, '[{\"id\":\"57\",\"descripcion\":\"Cizalla de Tijera\",\"cantidad\":\"4\",\"stock\":\"7\",\"precio\":\"812\",\"total\":\"3248\"},{\"id\":\"52\",\"descripcion\":\"Bascula \",\"cantidad\":\"3\",\"stock\":\"17\",\"precio\":\"182\",\"total\":\"546\"},{\"id\":\"55\",\"descripcion\":\"Cilindro muestra de concreto\",\"cantidad\":\"2\",\"stock\":\"18\",\"precio\":\"560\",\"total\":\"1120\"},{\"id\":\"56\",\"descripcion\":\"Cizalla de Palanca\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"630\",\"total\":\"630\"}]', 1053.36, 5544, 6597.36, 'Efectivo', '2017-12-26 22:26:28'),
(34, 10018, 6, 57, '[{\"id\":\"51\",\"descripcion\":\"Tensor\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"140\",\"total\":\"140\"},{\"id\":\"52\",\"descripcion\":\"Bascula \",\"cantidad\":\"5\",\"stock\":\"12\",\"precio\":\"182\",\"total\":\"910\"},{\"id\":\"53\",\"descripcion\":\"Bomba Hidrostatica\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"1078\",\"total\":\"1078\"}]', 404.32, 2128, 2532.32, 'Efectivo', '2017-12-26 22:26:51'),
(35, 10019, 5, 57, '[{\"id\":\"56\",\"descripcion\":\"Cizalla de Palanca\",\"cantidad\":\"15\",\"stock\":\"3\",\"precio\":\"630\",\"total\":\"9450\"},{\"id\":\"55\",\"descripcion\":\"Cilindro muestra de concreto\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"560\",\"total\":\"560\"}]', 1901.9, 10010, 11911.9, 'Efectivo', '2017-12-26 22:27:13'),
(36, 10020, 4, 57, '[{\"id\":\"55\",\"descripcion\":\"Cilindro muestra de concreto\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"560\",\"total\":\"560\"},{\"id\":\"54\",\"descripcion\":\"Chapeta\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"924\",\"total\":\"924\"}]', 281.96, 1484, 1765.96, 'TC-46346346346', '2017-12-26 22:27:42'),
(37, 10021, 3, 1, '[{\"id\":\"60\",\"descripcion\":\"Cortadora de Baldosin\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"1302\",\"total\":\"1302\"},{\"id\":\"59\",\"descripcion\":\"Cono slump\",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"196\",\"total\":\"196\"}]', 149.8, 1498, 1647.8, 'Efectivo', '2018-02-06 22:47:02'),
(38, 10022, 7, 1, '[{\"id\":\"58\",\"descripcion\":\"Coche llanta neumatica\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"588\",\"total\":\"588\"}]', 94.08, 588, 682.08, 'TD-1122334455', '2018-12-20 22:02:28'),
(39, 10023, 4, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"99\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"199\",\"precio\":\"2800\",\"total\":\"2800\"}]', 175, 3500, 3675, '', '2018-12-22 19:12:42'),
(40, 10024, 7, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"98\",\"precio\":\"700\",\"total\":\"700\"}]', 112, 700, 812, 'TC-4343434343', '2018-12-22 20:53:50'),
(41, 10025, 5, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"97\",\"precio\":\"700\",\"total\":\"700\"}]', 112, 700, 812, 'Efectivo', '2018-12-22 21:02:05'),
(42, 10026, 8, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"96\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"198\",\"precio\":\"2800\",\"total\":\"2800\"}]', 560, 3500, 4060, '', '2018-12-23 01:11:32'),
(43, 10027, 5, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"95\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"197\",\"precio\":\"2800\",\"total\":\"2800\"},{\"id\":\"68\",\"descripcion\":\"taladro carlos 3\",\"cantidad\":\"1\",\"stock\":\"49\",\"precio\":\"1400\",\"total\":\"1400\"}]', 784, 4900, 5684, '', '2018-12-23 01:26:13'),
(44, 10027, 6, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"94\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"196\",\"precio\":\"2800\",\"total\":\"2800\"}]', 560, 3500, 4060, '', '2018-12-23 01:28:02'),
(45, 10028, 5, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"93\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"195\",\"precio\":\"2800\",\"total\":\"2800\"}]', 560, 3500, 4060, 'a_credito', '2018-12-23 01:48:56'),
(49, 10029, 9, 1, '[{\"id\":\"60\",\"descripcion\":\"Cortadora de Baldosin\",\"cantidad\":\"2\",\"stock\":\"11\",\"precio\":\"1302\",\"total\":\"2604\"}]', 416.64, 2604, 3020.64, 'Efectivo', '2018-12-25 00:51:56'),
(50, 10030, 12, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"91\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"192\",\"precio\":\"2800\",\"total\":\"2800\"}]', 700, 3500, 4200, 'a_credito', '2018-12-25 00:56:26'),
(65, 10031, 8, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"10\",\"stock\":\"76\",\"precio\":\"700\",\"total\":\"7000\"}]', 1120, 7000, 8120, 'a_credito', '2018-12-25 05:48:39'),
(66, 10032, 6, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"75\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"186\",\"precio\":\"2800\",\"total\":\"2800\"},{\"id\":\"68\",\"descripcion\":\"taladro carlos 3\",\"cantidad\":\"1\",\"stock\":\"44\",\"precio\":\"1400\",\"total\":\"1400\"}]', 784, 4900, 5684, 'a_credito', '2018-12-31 01:53:49'),
(67, 10033, 9, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"74\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"185\",\"precio\":\"2800\",\"total\":\"2800\"},{\"id\":\"68\",\"descripcion\":\"taladro carlos 3\",\"cantidad\":\"1\",\"stock\":\"43\",\"precio\":\"1400\",\"total\":\"1400\"}]', 784, 4900, 5684, 'a_credito', '2018-12-31 02:07:07'),
(68, 10034, 9, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"73\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"184\",\"precio\":\"2800\",\"total\":\"2800\"},{\"id\":\"68\",\"descripcion\":\"taladro carlos 3\",\"cantidad\":\"1\",\"stock\":\"42\",\"precio\":\"1400\",\"total\":\"1400\"}]', 784, 4900, 5684, 'a_credito', '2018-12-31 02:11:36'),
(69, 10035, 6, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"72\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"183\",\"precio\":\"2800\",\"total\":\"2800\"},{\"id\":\"68\",\"descripcion\":\"taladro carlos 3\",\"cantidad\":\"1\",\"stock\":\"41\",\"precio\":\"1400\",\"total\":\"1400\"}]', 784, 4900, 5684, 'a_credito', '2018-12-31 02:13:07'),
(70, 10036, 6, 1, '[{\"id\":\"70\",\"descripcion\":\"taladro carlos 5\",\"cantidad\":\"1\",\"stock\":\"71\",\"precio\":\"700\",\"total\":\"700\"},{\"id\":\"69\",\"descripcion\":\"taladro carlos 4\",\"cantidad\":\"1\",\"stock\":\"182\",\"precio\":\"2800\",\"total\":\"2800\"},{\"id\":\"68\",\"descripcion\":\"taladro carlos 3\",\"cantidad\":\"1\",\"stock\":\"40\",\"precio\":\"1400\",\"total\":\"1400\"}]', 784, 4900, 5684, 'a_credito', '2018-12-31 02:13:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_credito`
--

CREATE TABLE `ventas_credito` (
  `id` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `metodo_pago_inicial` varchar(100) NOT NULL,
  `codigo_transaccion` varchar(100) DEFAULT NULL,
  `monto_pago_inicial` float NOT NULL,
  `monto_financiado` float NOT NULL,
  `monto_cada_pago` float NOT NULL,
  `frecuencia_pagos` enum('semanal','quincenal','mensual') NOT NULL,
  `cantidad_pagos` int(11) NOT NULL,
  `fecha_primer_pago` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas_credito`
--

INSERT INTO `ventas_credito` (`id`, `id_venta`, `metodo_pago_inicial`, `codigo_transaccion`, `monto_pago_inicial`, `monto_financiado`, `monto_cada_pago`, `frecuencia_pagos`, `cantidad_pagos`, `fecha_primer_pago`) VALUES
(7, 65, 'tarjeta_debito', '5656565656', 100, 9000, 1500, 'quincenal', 6, '2019-01-08'),
(8, 66, 'efectivo', '', 371, 6000, 1000, 'quincenal', 6, '2019-01-14'),
(9, 67, 'tarjeta_credito', '2323232323', 371, 6000, 500, 'semanal', 12, '2019-01-07'),
(10, 68, 'sin_pagin_inicial', '', 0, 6371, 2123.67, 'mensual', 3, '2019-01-28'),
(11, 69, 'sin_pagin_inicial', '', 0, 6371, 2123.67, 'mensual', 3, '2019-01-28'),
(12, 70, 'sin_pago_inicial', '', 0, 6371, 530.92, 'semanal', 12, '2019-01-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_credito_pagos`
--

CREATE TABLE `ventas_credito_pagos` (
  `id` int(11) NOT NULL,
  `id_venta_credito` int(11) NOT NULL,
  `monto` float NOT NULL,
  `fecha_cobro_original` date NOT NULL,
  `fecha_cobro_real` date DEFAULT NULL,
  `pagado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas_credito_pagos`
--

INSERT INTO `ventas_credito_pagos` (`id`, `id_venta_credito`, `monto`, `fecha_cobro_original`, `fecha_cobro_real`, `pagado`) VALUES
(22, 7, 1500, '2019-01-08', NULL, 0),
(23, 7, 1500, '2019-01-22', NULL, 0),
(24, 7, 1500, '2019-02-05', NULL, 0),
(25, 7, 1500, '2019-02-19', NULL, 0),
(26, 7, 1500, '2019-03-05', NULL, 0),
(27, 7, 1500, '2019-03-19', NULL, 0),
(28, 8, 1000, '2019-01-14', NULL, 0),
(29, 8, 1000, '2019-01-28', NULL, 0),
(30, 8, 1000, '2019-02-11', NULL, 0),
(31, 8, 1000, '2019-02-25', NULL, 0),
(32, 8, 1000, '2019-03-11', NULL, 0),
(33, 8, 1000, '2019-03-25', NULL, 0),
(34, 9, 500, '2019-01-07', NULL, 0),
(35, 9, 500, '2019-01-14', NULL, 0),
(36, 9, 500, '2019-01-21', NULL, 0),
(37, 9, 500, '2019-01-28', NULL, 0),
(38, 9, 500, '2019-02-04', NULL, 0),
(39, 9, 500, '2019-02-11', NULL, 0),
(40, 9, 500, '2019-02-18', NULL, 0),
(41, 9, 500, '2019-02-25', NULL, 0),
(42, 9, 500, '2019-03-04', NULL, 0),
(43, 9, 500, '2019-03-11', NULL, 0),
(44, 9, 500, '2019-03-18', NULL, 0),
(45, 9, 500, '2019-03-25', NULL, 0),
(46, 10, 2123.67, '2019-01-28', NULL, 0),
(47, 10, 2123.67, '2019-02-25', NULL, 0),
(48, 10, 2123.67, '2019-03-25', NULL, 0),
(49, 11, 2123.67, '2019-01-28', NULL, 0),
(50, 11, 2123.67, '2019-02-25', NULL, 0),
(51, 11, 2123.67, '2019-03-25', NULL, 0),
(52, 12, 530.92, '2019-01-07', NULL, 0),
(53, 12, 530.92, '2019-01-14', NULL, 0),
(54, 12, 530.92, '2019-01-21', NULL, 0),
(55, 12, 530.92, '2019-01-28', NULL, 0),
(56, 12, 530.92, '2019-02-04', NULL, 0),
(57, 12, 530.92, '2019-02-11', NULL, 0),
(58, 12, 530.92, '2019-02-18', NULL, 0),
(59, 12, 530.92, '2019-02-25', NULL, 0),
(60, 12, 530.92, '2019-03-04', NULL, 0),
(61, 12, 530.92, '2019-03-11', NULL, 0),
(62, 12, 530.92, '2019-03-18', NULL, 0),
(63, 12, 530.92, '2019-03-25', NULL, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_meses`
--
ALTER TABLE `productos_meses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_meses_producto` (`id_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas_credito`
--
ALTER TABLE `ventas_credito`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `ventas_credito_pagos`
--
ALTER TABLE `ventas_credito_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_venta_credito` (`id_venta_credito`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `productos_meses`
--
ALTER TABLE `productos_meses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `ventas_credito`
--
ALTER TABLE `ventas_credito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `ventas_credito_pagos`
--
ALTER TABLE `ventas_credito_pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ventas_credito`
--
ALTER TABLE `ventas_credito`
  ADD CONSTRAINT `ventas_credito_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`);

--
-- Filtros para la tabla `ventas_credito_pagos`
--
ALTER TABLE `ventas_credito_pagos`
  ADD CONSTRAINT `ventas_credito_pagos_ibfk_1` FOREIGN KEY (`id_venta_credito`) REFERENCES `ventas_credito` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
