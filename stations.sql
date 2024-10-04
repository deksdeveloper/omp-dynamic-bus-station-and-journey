SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `stations` (
  `ID` int(11) NOT NULL,
  `stationName` varchar(30) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `stationPrice` int(11) NOT NULL,
  `stationTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_turkish_ci ROW_FORMAT=DYNAMIC;

ALTER TABLE `stations`
  ADD UNIQUE KEY `ID` (`ID`) USING BTREE;
COMMIT;
