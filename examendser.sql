-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-02-2018 a las 13:08:18
-- Versión del servidor: 10.1.26-MariaDB
-- Versión de PHP: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `examendser`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarCliente` (IN `p_nombre` VARCHAR(30), IN `p_apellidos` VARCHAR(50), IN `p_telefono` VARCHAR(20))  NO SQL
BEGIN
DELETE FROM `clientes` WHERE Nombre=p_nombre AND Apellidos=p_apellidos AND Telefono=p_telefono;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarArticulo` (IN `pArticulo` VARCHAR(30), IN `pPrecio` INT(11), IN `pCategoria` INT(11))  NO SQL
INSERT INTO articulos (articulo, precio, idCategoria)
	VALUES (pArticulo, pPrecio, pCategoria)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarCategoria` (IN `pCategoria` VARCHAR(30))  NO SQL
INSERT INTO categorias (categoria) VALUES (pCategoria)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarCliente` (IN `pnombre` VARCHAR(30), IN `pApellido` VARCHAR(50), IN `pTelefono` VARCHAR(20))  NO SQL
BEGIN

INSERT INTO clientes (nombre, apellidos, telefono)
	VALUES (pnombre, pApellido, pTelefono);
    
    SELECT LAST_INSERT_ID() ultimoId;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarClienteArticulo` (IN `PidCliente` INT, IN `PidArticulo` INT)  NO SQL
BEGIN
INSERT INTO clientes_articulos (`idCliente`, `idArticulo`) VALUES (PidCliente, PidArticulo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarArticulos` ()  NO SQL
SELECT idArticulo, articulo AS Articulo, precio AS Precio,
	   categoria AS Categoria,
       CONCAT(articulo, ' - ',precio, '€ - ', categoria) AS ArticuloDetalle
	FROM articulos
    	INNER JOIN categorias ON categorias.idCategoria
        = articulos.idCategoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarCategorias` ()  NO SQL
Select idCategoria, categoria AS Categoria
	FROM categorias$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarClientes` ()  NO SQL
SELECT * FROM Clientes$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMostrarClientesArticulos` ()  NO SQL
BEGIN
SELECT c.*, IFNULL(a.articulo, "no tiene") AS Articulos FROM Clientes C LEFT JOIN clientes_articulos ca ON c.IdCliente= ca.idCliente LEFT JOIN articulos a ON a.idArticulo=cA.idArticulo;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `comprobarCliente` (`p_nombre` VARCHAR(30), `p_apellidos` VARCHAR(50), `p_telefono` VARCHAR(20)) RETURNS INT(11) NO SQL
BEGIN

DECLARE existeCliente INT;

SET existeCliente = 0;

SET existeCliente = (SELECT COUNT(*) FROM clientes where p_nombre = Nombre AND p_apellidos = Apellidos AND p_telefono=Telefono);

RETURN existeCliente;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fComprobarUsuario` (`pUsuario` VARCHAR(20), `pPassword` VARCHAR(50)) RETURNS TINYINT(1) NO SQL
BEGIN

DECLARE existeUsuario INT;

SET existeUsuario = 0;

SET existeUsuario = (SELECT COUNT(*) FROM usuarios where pUsuario = usuario AND pPassword = password);

RETURN existeUsuario;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `idArticulo` int(11) NOT NULL,
  `articulo` varchar(30) DEFAULT NULL,
  `precio` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`idArticulo`, `articulo`, `precio`, `idCategoria`) VALUES
(1, 'Portátil', 600, 4),
(2, 'Tablet', 200, 4),
(8, 'USB', 20, 4),
(9, 'Impresora', 60, 4),
(10, 'Pantalla', 150, 4),
(11, 'Adaptador', 4, 4),
(12, 'Ratón', 14, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `idCategoria` int(11) NOT NULL,
  `categoria` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`idCategoria`, `categoria`) VALUES
(1, 'Bebé'),
(2, 'Belleza'),
(3, 'Electrónica'),
(4, 'Informática'),
(5, 'Motor'),
(13, 'Hogar'),
(14, 'Ocio'),
(15, 'Outdoor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `IdCliente` int(11) NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`IdCliente`, `Nombre`, `Apellidos`, `Telefono`) VALUES
(1, 'Xabier', 'Atutxa', '666 44 33 22'),
(2, 'Michael', 'Lasa', NULL),
(3, 'Unai', 'Etxebarria', '666 11 33 55'),
(4, 'Jon Ander', 'Pereda', '667 77 66 55'),
(5, 'aa', 'bb', 'cc'),
(6, 'Iñigo', 'Carrasco', '555 44 33 22'),
(8, 'Anabel', 'Sante', '444 333 222'),
(9, 'Borja', 'Manzano', '888777888'),
(10, 'Mikel', 'Marquez', '777 666 555'),
(11, 'Julen', 'Estibez', '633956882'),
(22, '?', '?', '?'),
(23, '?', '?', '?'),
(24, '?', '?', '?'),
(25, '?', '?', '?');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_articulos`
--

CREATE TABLE `clientes_articulos` (
  `idCliente` int(11) NOT NULL DEFAULT '0',
  `idArticulo` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes_articulos`
--

INSERT INTO `clientes_articulos` (`idCliente`, `idArticulo`) VALUES
(10, 10),
(10, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario`, `password`) VALUES
('xugarte', 'xugarte');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`idArticulo`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `clientes_articulos`
--
ALTER TABLE `clientes_articulos`
  ADD PRIMARY KEY (`idCliente`,`idArticulo`),
  ADD KEY `idArticulo` (`idArticulo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario`,`password`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `idArticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`idCategoria`);

--
-- Filtros para la tabla `clientes_articulos`
--
ALTER TABLE `clientes_articulos`
  ADD CONSTRAINT `clientes_articulos_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`IdCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `clientes_articulos_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`idArticulo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
