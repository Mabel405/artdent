CREATE DATABASE  IF NOT EXISTS `db_artdent_up` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_artdent_up`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_artdent_up
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `cita`
--

DROP TABLE IF EXISTS `cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita` (
  `idCita` int NOT NULL AUTO_INCREMENT,
  `FechaHoraEntrada` datetime NOT NULL,
  `FechaHoraSalida` datetime DEFAULT NULL,
  `Diagnostico` text NOT NULL,
  `Recomendaciones` text,
  `Observaciones` text,
  `seguimiento_requerido` tinyint NOT NULL,
  `fechaSeguimiento` date DEFAULT NULL,
  `duracionMinutos` int DEFAULT NULL,
  `Servicio_idServicio` int NOT NULL,
  `reserva_idReserva` int NOT NULL,
  PRIMARY KEY (`idCita`),
  KEY `fk_Cita_Servicio1_idx` (`Servicio_idServicio`),
  KEY `fk_cita_reserva1_idx` (`reserva_idReserva`),
  CONSTRAINT `fk_cita_reserva1` FOREIGN KEY (`reserva_idReserva`) REFERENCES `reserva` (`idReserva`),
  CONSTRAINT `fk_Cita_Servicio1` FOREIGN KEY (`Servicio_idServicio`) REFERENCES `servicio` (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
INSERT INTO `cita` VALUES (1,'2025-06-25 10:30:00','2025-06-25 11:15:00','Placa bacteriana moderada, gingivitis leve en sector anterior','Mejorar técnica de cepillado, usar hilo dental diariamente, enjuague bucal con flúor','Paciente colaborador, buena higiene general',0,NULL,45,1,3),(2,'2025-06-25 14:15:00','2025-06-25 15:30:00','Maloclusión clase II, apiñamiento dental moderado','Tratamiento de ortodoncia con brackets metálicos, duración estimada 18-24 meses','Primera consulta, se tomaron impresiones y radiografías',1,'2025-07-25',75,2,2),(3,'2025-06-26 09:45:00','2025-06-26 10:30:00','Tercer molar inferior derecho impactado, pericoronaritis recurrente','Reposo relativo 24h, analgésicos según prescripción, dieta blanda','Extracción sin complicaciones, sutura con 3 puntos',1,'2025-07-03',45,3,1),(4,'2025-06-26 16:20:00','2025-06-26 17:00:00','Dientes con manchas por café y tabaco, color A3','Evitar alimentos pigmentados 48h, usar pasta dental para dientes sensibles','Blanqueamiento exitoso, mejoría de 4 tonos',0,NULL,40,4,4);
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprobante`
--

DROP TABLE IF EXISTS `comprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprobante` (
  `idVenta` int NOT NULL AUTO_INCREMENT,
  `Importe` decimal(10,2) NOT NULL,
  `TipodeDoc` varchar(45) NOT NULL,
  `RUC_Empresa` varchar(11) DEFAULT NULL,
  `paciente_idPaciente` int NOT NULL,
  `serie` varchar(4) NOT NULL,
  `numeroCorrelativo` varchar(4) NOT NULL,
  `fecha_horaEmision` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipopago` int NOT NULL,
  `igv` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`idVenta`),
  KEY `fk_comprobante_paciente1_idx` (`paciente_idPaciente`),
  CONSTRAINT `fk_comprobante_paciente1` FOREIGN KEY (`paciente_idPaciente`) REFERENCES `paciente` (`idPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprobante`
--

LOCK TABLES `comprobante` WRITE;
/*!40000 ALTER TABLE `comprobante` DISABLE KEYS */;
INSERT INTO `comprobante` VALUES (1,40.00,'Boleta','20123456789',1,'B001','1','2025-06-25 10:30:00',1,7.20,32.80,'Limpieza dental rutinaria'),(2,850.00,'Factura','20123456789',2,'F001','1','2025-06-25 14:15:00',2,153.00,697.00,'Tratamiento de ortodoncia - Primera fase'),(3,250.00,'Boleta','20123456789',3,'B001','2','2025-06-26 09:45:00',1,45.00,205.00,'Extracción de muela del juicio'),(4,180.00,'Boleta','20123456789',4,'B001','3','2025-06-26 16:20:00',3,32.40,147.60,'Blanqueamiento dental profesional');
/*!40000 ALTER TABLE `comprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `idFaq` int NOT NULL AUTO_INCREMENT,
  `Pregunta` text NOT NULL,
  `Respuesta` text NOT NULL,
  `Prioridad` int NOT NULL DEFAULT '1',
  `Activo` tinyint(1) NOT NULL DEFAULT '1',
  `FechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaActualizacion` datetime DEFAULT NULL,
  `Servicio_idServicio` int DEFAULT NULL,
  `Usuario_idUsuario` int NOT NULL,
  PRIMARY KEY (`idFaq`),
  KEY `fk_FAQ_Servicio_idx` (`Servicio_idServicio`),
  KEY `fk_FAQ_Usuario_idx` (`Usuario_idUsuario`),
  CONSTRAINT `fk_FAQ_Servicio` FOREIGN KEY (`Servicio_idServicio`) REFERENCES `servicio` (`idServicio`) ON DELETE SET NULL,
  CONSTRAINT `fk_FAQ_Usuario` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` VALUES (1,'¿Qué hago si no puedo presentarme a mi cita?','Si no puedes presentarte a tu cita, te recomendamos que contactes a la clínica o al consultorio lo antes posible. Generalmente, se puede reprogramar la cita sin problema si se avisa con antelación. Algunos lugares pueden cobrar una tarifa por cancelaciones tardías o ausencias sin previo aviso, por lo que es importante comunicarte con ellos para evitar cargos adicionales.',1,1,'2025-06-26 14:07:48','2025-06-26 15:02:45',1,1),(2,'¿Cuál es el costo de una consulta?','El costo de una consulta dental puede variar dependiendo del tipo de servicio y del profesional. En general, una consulta inicial puede costar alrededor de S/ 50.00. Este costo generalmente incluye una evaluación general y recomendaciones iniciales de tratamiento. Para tratamientos específicos, como limpiezas profundas, empastes o procedimientos quirúrgicos, es posible que se apliquen tarifas adicionales.',5,1,'2025-06-26 15:00:16','2025-06-29 23:24:15',2,1),(3,'¿Con qué frecuencia debo ir al dentista?','Se recomienda visitar al dentista al menos cada seis meses para una revisión y limpieza dental. Sin embargo, la frecuencia puede variar según las necesidades individuales y la salud bucal. Si tienes problemas dentales específicos, como caries recurrentes o enfermedades de las encías, tu dentista puede recomendarte visitas más frecuentes.',2,1,'2025-06-26 15:00:33','2025-06-26 15:06:44',3,1),(4,'¿Duele el tratamiento de ortodoncia?','El tratamiento de ortodoncia puede causar algunas molestias, especialmente durante los primeros días después de la colocación o ajuste de los brackets. Esta incomodidad es normal y temporal. Se puede manejar con analgésicos de venta libre y alimentos blandos. La mayoría de pacientes se adaptan rápidamente.',3,0,'2025-06-26 15:10:00','2025-06-29 23:24:35',2,3),(5,'¿Qué cuidados debo tener después de una cirugía oral?','Después de una cirugía oral es importante seguir las indicaciones del cirujano: aplicar hielo para reducir la inflamación, tomar los medicamentos prescritos, evitar enjuagues vigorosos las primeras 24 horas, no fumar, y mantener una dieta blanda. Es normal un poco de sangrado y molestias los primeros días.',4,0,'2025-06-26 15:15:00','2025-06-29 22:20:56',3,3),(6,'¿Cuánto dura un blanqueamiento dental?','Los resultados del blanqueamiento dental pueden durar entre 1 a 3 años, dependiendo de los hábitos del paciente. El consumo de café, té, vino tinto, tabaco y otros alimentos pigmentados puede acelerar la pérdida del efecto blanqueador. Mantener una buena higiene oral y evitar estos hábitos ayuda a prolongar los resultados.',2,0,'2025-06-26 15:20:00','2025-06-30 10:51:55',4,1);
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario` (
  `idHorario` int NOT NULL AUTO_INCREMENT,
  `HoraInicio` time NOT NULL,
  `HoraFinal` time NOT NULL,
  `DiaSemana` varchar(15) NOT NULL,
  PRIMARY KEY (`idHorario`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES (1,'08:00:00','12:00:00','Lunes'),(2,'14:00:00','18:00:00','Lunes'),(3,'08:00:00','12:00:00','Martes'),(4,'14:00:00','18:00:00','Martes'),(5,'08:00:00','12:00:00','Miércoles'),(6,'14:00:00','18:00:00','Miércoles'),(7,'08:00:00','12:00:00','Jueves'),(8,'14:00:00','18:00:00','Jueves'),(9,'08:00:00','12:00:00','Viernes'),(10,'14:00:00','18:00:00','Viernes'),(11,'08:00:00','13:00:00','Sábado');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente` (
  `idPaciente` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `DNI` varchar(8) NOT NULL,
  `Telefono` varchar(9) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (1,'Manturano','Montalvo','76543211','987654321','m@gmail.com'),(2,'Luis Alberto','Pérez González','12345678','956789123','luis.perez@email.com'),(3,'Carmen Rosa','Flores Díaz','87654321','945678912','carmen.flores@email.com'),(4,'José Miguel','Torres Ramírez','23456789','934567891','jose.torres@email.com'),(5,'Patricia Elena','Vargas Morales','34567891','923456789','patricia.vargas@email.com'),(6,'Roberto Carlos','Jiménez Castro','45678912','912345678','roberto.jimenez@email.com'),(7,'Sandra Milena','Herrera Ruiz','56789123','901234567','sandra.herrera@email.com'),(8,'Fernando José','Castillo Mendez','67891234','987123456','fernando.castillo@email.com'),(9,'Mónica Andrea','Sánchez Paredes','78912345','976543210','monica.sanchez@email.com'),(10,'Diego Alejandro','Ramos Guerrero','89123456','965432109','diego.ramos@email.com'),(13,'Prueba','Miranda','76543231','948124812','alex.04.antay@gmail.com'),(14,'Juan','Miranda','72407570','906442235','alex.04.antay@gmail.com');
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `idReserva` int NOT NULL AUTO_INCREMENT,
  `DiaReserva` date NOT NULL,
  `HoraReserva` time NOT NULL,
  `Descripcion` text NOT NULL,
  `dia_semana` varchar(10) NOT NULL,
  `tipoestado` int NOT NULL,
  `token_cliente` text NOT NULL,
  `Usuario_idUsuario` int NOT NULL,
  `Paciente_idPaciente` int NOT NULL,
  `Servicio_idServicio` int NOT NULL,
  `Odontologo_idUsuario` int NOT NULL,
  `comprobante_idVenta` int NOT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idReserva`),
  KEY `fk_Reserva_Usuario1_idx` (`Usuario_idUsuario`),
  KEY `fk_Reserva_Paciente1_idx` (`Paciente_idPaciente`),
  KEY `fk_Reserva_Servicio1_idx` (`Servicio_idServicio`),
  KEY `fk_Reserva_Usuario2_idx` (`Odontologo_idUsuario`),
  KEY `fk_reserva_comprobante1_idx` (`comprobante_idVenta`),
  CONSTRAINT `fk_reserva_comprobante1` FOREIGN KEY (`comprobante_idVenta`) REFERENCES `comprobante` (`idVenta`),
  CONSTRAINT `fk_Reserva_Paciente1` FOREIGN KEY (`Paciente_idPaciente`) REFERENCES `paciente` (`idPaciente`),
  CONSTRAINT `fk_Reserva_Servicio1` FOREIGN KEY (`Servicio_idServicio`) REFERENCES `servicio` (`idServicio`),
  CONSTRAINT `fk_Reserva_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `fk_Reserva_Usuario2` FOREIGN KEY (`Odontologo_idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,'2025-06-28','09:00:00','Limpieza dental de rutina','Sábado',1,'token123abc',1,1,1,3,1,'2025-06-01 00:59:34','2025-06-03 00:59:34'),(2,'2025-06-28','10:30:00','Consulta inicial para ortodoncia','Sábado',1,'token456def',2,2,2,4,2,'2025-06-01 00:59:34','2025-06-03 00:59:34'),(3,'2025-06-28','14:00:00','Extracción de muela del juicio','Sábado',3,'token789ghi',1,3,3,3,3,'2025-06-01 00:59:34','2025-06-03 00:59:34'),(4,'2025-06-29','08:30:00','Blanqueamiento dental','Domingo',2,'token012jkl',1,4,4,4,4,'2025-06-01 00:59:34','2025-06-03 00:59:34'),(5,'2025-06-30','09:15:00','Control post-operatorio','Lunes',1,'token345mno',1,5,1,3,1,'2025-06-01 00:59:34','2025-06-03 00:59:34'),(6,'2025-06-30','11:00:00','Endodoncia molar superior','Lunes',2,'token678pqr',1,6,5,4,2,'2025-06-30 00:59:34','2025-06-30 11:02:40'),(7,'2025-07-01','15:30:00','Consulta para implante dental','Martes',1,'token901stu',1,7,6,3,3,'2025-06-30 00:59:34','2025-06-30 00:59:34'),(8,'2025-07-01','16:45:00','Limpieza y fluorización','Martes',2,'token234vwx',1,8,1,4,1,'2025-06-30 00:59:34','2025-06-30 11:03:28'),(14,'2025-07-18','11:00:00','Tengo un dolor fuerte de muelas y me recomendaron una limpieza','Viernes',2,'tokena18ba2',1,13,1,3,1,'2025-06-30 00:59:34','2025-06-30 07:03:13'),(15,'2025-06-30','16:00:00','El doctor me lo recomendó, para solucionar mi problema','Lunes',1,'956B506E',1,14,5,3,1,'2025-06-30 09:00:44','2025-06-30 09:00:44');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calcular_dia_semana` BEFORE INSERT ON `reserva` FOR EACH ROW BEGIN
    SET NEW.dia_semana = CASE DAYOFWEEK(NEW.DiaReserva)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sábado'
    END;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `TipoRol` varchar(20) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Administrador'),(2,'Secretaria'),(3,'Odontólogo');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio` (
  `idServicio` int NOT NULL AUTO_INCREMENT,
  `TipoServicio` text NOT NULL,
  `Lema` text NOT NULL,
  `Descripcion` text NOT NULL,
  `Respuesta` text NOT NULL,
  `Costo` decimal(10,2) NOT NULL,
  `img` text NOT NULL,
  PRIMARY KEY (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES (1,'Limpieza Dental','La limpieza dental profesional es crucial para eliminar las bacterias dañinas que pueden causar enfermedades bucodentales como la caries, la gingivitis y la periodontitis.','La limpieza dental, también conocida como profilaxis dental, es uno de los tratamientos dentales más solicitados. Este procedimiento se realiza con el objetivo de prevenir enfermedades bucales. Su finalidad es eliminar el sarro y las manchas acumuladas en los dientes. No debe confundirse con el blanqueamiento dental, ya que la limpieza dental no altera el color natural de los dientes.\r\nEl principal objetivo de la limpieza dental es prevenir enfermedades, además de eliminar placa y sarro. La limpieza bucal debe ser realizada por un profesional y es eficaz para cuidar los dientes y las encías. Sin embargo, no se debe olvidar la higiene diaria, es decir, el cepillado, especialmente antes de dormir.','El sarro en nuestros dientes es peligroso para la salud bucodental, ya que puede dar lugar a enfermedades periodontales. Algunas de sus consecuencias son:\r\n- Problemas de salud bucodental\r\n- Aparición de caries\r\n- Pérdida de piezas dentales\r\n- Afectación de la estética de la sonrisa\r\nTanto las limpiezas dentales rutinarias como las profundas son importantes para prevenir infecciones y la pérdida de dientes causada por enfermedades de las encías.',40.00,'https://www.dentaldelaware.com/wp-content/uploads/2021/12/teeth-cleaning.jpg'),(2,'Ortodoncia','La ortodoncia es la rama de la odontología que se encarga de los problemas de los dientes y la mandíbula.','La ortodoncia sirve para corregir defectos de posición de los dientes y los huesos relacionados, con el fin de lograr una mordida u oclusión adecuada, y así permitir que la boca funcione correctamente al masticar o incluso al hablar.\r\nPor tanto, los beneficios de un tratamiento de ortodoncia son muchos. Aunque uno de ellos es la estética, y por eso se ha convertido en un tratamiento muy solicitado, esta es solo una consecuencia, no el objetivo principal del tratamiento.\r\nAdemás, cuando los dientes no están bien posicionados o se apiñan, se vuelven más difíciles de limpiar, lo que puede llevar a una peor salud dental. Esto puede causar problemas como:\r\n- Aparición de caries\r\n- Enfermedades como la periodontitis\r\n- Dolores de cabeza, cuello, hombros o espalda, por el esfuerzo excesivo de la musculatura al masticar','La respuesta a esa pregunta solo la puede dar el dentista tras realizar un diagnóstico craneofacial, pero en los siguientes casos hay probabilidades de que así sea:\r\n- Tener una maloclusión dental, como por ejemplo una sobremordida, una mordida cruzada o una mordida abierta.\r\n- Si la llamada \"línea media\" (que divide a los dientes anteriores superiores) está desplazada, porque no se alinea con la de los dientes inferiores.\r\n- Cuando existen espacios entre los dientes o diastemas.\r\n- Si los dientes están apiñados o son asimétricos.\r\n- Si hay dolor en la articulación temporomandibular.\r\n- Si existe una discrepancia entre los maxilares.',850.00,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQd3mIOWBBl7dkSQLGH417t6dFMFgKv3xYTQ&s'),(3,'Cirugía Oral','La cirugía oral es una especialidad de la odontología que se encarga de tratar las enfermedades y lesiones.','La cirugía oral se ocupa del diagnóstico, tratamiento y prevención de las enfermedades quirúrgicas de la cavidad oral. Esto incluye procedimientos quirúrgicos en los dientes, mandíbulas, y tejidos blandos de la boca. Los procedimientos más comunes en cirugía oral incluyen la extracción de dientes impactados, la corrección de malformaciones mandibulares y el tratamiento de lesiones orales.','Es recomendable considerar la cirugía oral en los siguientes casos:\r\n- Dientes Impactados: Dientes que no han erupcionado correctamente y pueden causar dolor o infecciones.\r\n- Malformaciones Mandibulares: Problemas con la alineación de la mandíbula que pueden afectar la masticación y el habla.\r\n- Lesiones Orales: Tratamiento de lesiones o infecciones en la cavidad oral que requieren intervención quirúrgica.',250.00,'https://clinicaruizestrada.com/wp-content/uploads/2023/02/limpieza-dental-prevencion-problemas-boca.jpg'),(4,'Blanqueamiento Dental','Tratamiento estético para aclarar el color de los dientes y eliminar manchas.','El blanqueamiento dental es un procedimiento cosmético que utiliza agentes blanqueadores para eliminar manchas y decoloraciones de los dientes. Es uno de los tratamientos estéticos más populares en odontología. El procedimiento puede realizarse en consultorio o en casa con supervisión profesional.\r\nExisten diferentes tipos de blanqueamiento: con luz LED, láser, o mediante férulas personalizadas. Los resultados pueden durar entre 1 a 3 años dependiendo de los hábitos del paciente.','El blanqueamiento dental está indicado para:\r\n- Manchas por café, té, vino tinto o tabaco\r\n- Decoloración por edad\r\n- Manchas por medicamentos\r\n- Fluorosis dental leve\r\nNo está recomendado durante el embarazo, en menores de 16 años, o en personas con sensibilidad dental severa.',180.00,'https://www.clinicaveronicagil.com/wp-content/uploads/2023/06/blanqueamiento-dental.jpg'),(5,'Endodoncia','Tratamiento del conducto radicular para salvar dientes con pulpa dañada o infectada.','La endodoncia es el tratamiento de los conductos radiculares del diente. Se realiza cuando la pulpa dental (nervio) está infectada, inflamada o necrótica. El procedimiento consiste en limpiar, desinfectar y sellar los conductos radiculares.\r\nEste tratamiento permite conservar el diente natural evitando su extracción. Después de una endodoncia, generalmente se requiere una corona para proteger el diente.','La endodoncia está indicada cuando:\r\n- Hay dolor intenso al morder o masticar\r\n- Sensibilidad prolongada al calor o frío\r\n- Decoloración del diente\r\n- Hinchazón y sensibilidad en las encías cercanas\r\n- Absceso dental\r\n- Fractura dental que expone la pulpa',320.00,'https://staticnew-prod.topdoctors.mx/files/Image/large/62af5abd3cb1b9a8e6904af7349494b0.png'),(6,'Implantes Dentales','Reemplazo de dientes perdidos mediante implantes de titanio.','Los implantes dentales son raíces artificiales de titanio que se colocan en el hueso maxilar para reemplazar dientes perdidos. Sobre el implante se coloca una corona que simula el diente natural.\r\nLos implantes ofrecen una solución permanente y estética para la pérdida dental. Tienen una alta tasa de éxito y pueden durar toda la vida con el cuidado adecuado.','Los implantes están indicados para:\r\n- Reemplazar uno o varios dientes perdidos\r\n- Evitar el desgaste de dientes adyacentes\r\n- Mantener la estructura ósea facial\r\n- Mejorar la función masticatoria\r\n- Proporcionar mayor comodidad que las prótesis removibles',1200.00,'https://clinicafldental.com/wp-content/uploads/2022/09/implante-dental-madrid-dentologies-1200x800-1-1024x683.jpg'),(13,'Extracción Dental','Procedimiento para remover dientes dañados, infectados o retenidos.','La extracción dental es necesaria cuando un diente está severamente dañado por caries, trauma, infección o por motivos ortodónticos. También se realiza cuando hay dientes retenidos (como las muelas del juicio). Es un procedimiento común que puede requerir anestesia local o general, según la complejidad del caso.','Se recomienda la extracción dental en los siguientes casos:\r\n- Dientes con caries irreparables\r\n- Infecciones dentales avanzadas\r\n- Dientes retenidos o impactados\r\n- Preparación para tratamientos de ortodoncia\r\n- Dientes fracturados sin posibilidad de restauración',235.00,'https://staticnew-prod.topdoctors.mx/files/Image/large/e7e5689fdaa0d329f72e99daa2c06328.jpg');
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `DNI` char(8) NOT NULL,
  `Telefono` char(9) NOT NULL,
  `CorreoElectronico` varchar(100) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  `Clave` varchar(50) NOT NULL,
  `Rol_idRol` int NOT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `fk_Usuario_Rol_idx` (`Rol_idRol`),
  CONSTRAINT `fk_Usuario_Rol` FOREIGN KEY (`Rol_idRol`) REFERENCES `rol` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Juan Alexander','Miranda Quispe','72401234','906442235','U22234838@utp.edu.pe','Av. Las Malvinas 123','2005-08-22','123456',1),(2,'María Elena','García López','45678912','987654321','maria.garcia@artdent.com','Jr. Los Olivos 456','1985-03-15','admin123',2),(3,'Ruben Fernando','Cuadros Mieses','43218764','990280708','U23228449@utp.edu.pe','Av. Ancestrales 321','2000-06-29','1233',3),(4,'Ana Sofía','Rodríguez Vega','87654321','912345678','ana.rodriguez@artdent.com','Av. Universitaria 789','1990-11-20','odon456',3),(5,'Carlos Alberto','Mendoza Silva','12345678','923456789','carlos.mendoza@artdent.com','Calle Las Flores 234','1988-07-10','secre789',2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_horario`
--

DROP TABLE IF EXISTS `usuario_horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_horario` (
  `idUsuario_Horario` int NOT NULL AUTO_INCREMENT,
  `Usuario_idUsuario` int NOT NULL,
  `Horario_idHorario` int NOT NULL,
  PRIMARY KEY (`idUsuario_Horario`),
  KEY `fk_Usuario_Horario_Usuario1_idx` (`Usuario_idUsuario`),
  KEY `fk_Usuario_Horario_Horario1_idx` (`Horario_idHorario`),
  CONSTRAINT `fk_Usuario_Horario_Horario1` FOREIGN KEY (`Horario_idHorario`) REFERENCES `horario` (`idHorario`),
  CONSTRAINT `fk_Usuario_Horario_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_horario`
--

LOCK TABLES `usuario_horario` WRITE;
/*!40000 ALTER TABLE `usuario_horario` DISABLE KEYS */;
INSERT INTO `usuario_horario` VALUES (1,3,1),(2,3,2),(3,3,3),(4,3,4),(5,3,5),(6,3,6),(7,4,7),(8,4,8),(9,4,9),(10,4,10),(11,4,11),(12,2,1),(13,2,3),(14,2,5),(15,2,7),(16,2,9),(17,5,2),(18,5,4),(19,5,6),(20,5,8),(21,5,10);
/*!40000 ALTER TABLE `usuario_horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_servicio`
--

DROP TABLE IF EXISTS `usuario_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_servicio` (
  `idUsuario` int NOT NULL,
  `idServicio` int NOT NULL,
  `Disponibilidad` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idUsuario`,`idServicio`),
  KEY `idServicio` (`idServicio`),
  CONSTRAINT `usuario_servicio_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `usuario_servicio_ibfk_2` FOREIGN KEY (`idServicio`) REFERENCES `servicio` (`idServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_servicio`
--

LOCK TABLES `usuario_servicio` WRITE;
/*!40000 ALTER TABLE `usuario_servicio` DISABLE KEYS */;
INSERT INTO `usuario_servicio` VALUES (3,1,0),(3,2,1),(3,5,0),(3,6,0),(4,1,1),(4,3,1),(4,4,1),(4,6,1);
/*!40000 ALTER TABLE `usuario_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db_artdent_up'
--

--
-- Dumping routines for database 'db_artdent_up'
--
/*!50003 DROP PROCEDURE IF EXISTS `ListarCitasPorDiaSemana` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCitasPorDiaSemana`(IN diasemana VARCHAR(10), IN semanaActual INT)
BEGIN
    DECLARE fechaInicio DATE;
    DECLARE fechaFin DATE;

    SET fechaInicio = DATE_ADD(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(CURDATE()) DAY), INTERVAL (semanaActual - WEEK(CURDATE(), 1)) WEEK);
    SET fechaFin = DATE_ADD(fechaInicio, INTERVAL 6 DAY);

    CREATE TEMPORARY TABLE IF NOT EXISTS TempCitas (
        idCita INT,
        DiaReserva DATE,
        HoraReserva TIME,
        NombrePaciente VARCHAR(100),
        ApellidoPaciente VARCHAR(100),
        EstadoReserva VARCHAR(50),
        TipoServicio VARCHAR(50),
        Costo decimal(10,2),
        NombreOdontologo VARCHAR(100),
        ApellidoOdontologo VARCHAR(100),
        orden_row INT,
        color CHAR(7)
    );

    INSERT INTO TempCitas (idCita, DiaReserva, HoraReserva, NombrePaciente, ApellidoPaciente, 
                            EstadoReserva, TipoServicio, Costo, NombreOdontologo, ApellidoOdontologo, orden_row, color)
    SELECT  c.idCita, 
            c.DiaReserva, 
            c.HoraReserva, 
            u.Nombre AS NombrePaciente, 
            u.Apellido AS ApellidoPaciente, 
            e.TipoEstado AS EstadoReserva, 
            s.TipoServicio, s.Costo,
            od.Nombre AS NombreOdontologo, 
            od.Apellido AS ApellidoOdontologo,
            CASE 
                WHEN TIME(c.HoraReserva) < TIME('08:00:00') THEN 0
                WHEN TIME(c.HoraReserva) = TIME('08:00:00') THEN 2
                ELSE 2 + FLOOR(TIMESTAMPDIFF(MINUTE, TIME('08:00:00'), TIME(c.HoraReserva)) / 15)
            END AS orden_row,
            CONCAT('#', LPAD(FLOOR(RAND() * 16777215), 6, '0')) AS color
    FROM cita c
    INNER JOIN paciente u ON c.Paciente_idPaciente = u.idPaciente
    INNER JOIN estado e ON c.Estado_idEstado = e.idEstado
    INNER JOIN servicio s ON c.Servicio_idServicio = s.idServicio
    INNER JOIN usuario od ON c.Odontologo_idUsuario = od.idUsuario
    WHERE c.Estado_idEstado IN (3) 
      AND c.DiaReserva BETWEEN fechaInicio AND fechaFin
      AND DAYOFWEEK(c.DiaReserva) = CASE diasemana
            WHEN 'Domingo' THEN 1
            WHEN 'Lunes' THEN 2
            WHEN 'Martes' THEN 3
            WHEN 'Miércoles' THEN 4
            WHEN 'Jueves' THEN 5
            WHEN 'Viernes' THEN 6
            WHEN 'Sábado' THEN 7
        END;

    SELECT * FROM TempCitas;
    DROP TEMPORARY TABLE IF EXISTS TempCitas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizarServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarServicio`(
    IN p_idServicio INT,
    IN p_TipoServicio TEXT,
    IN p_Lema TEXT,
    IN p_Descripcion TEXT,
    IN p_Respuesta TEXT,
    IN p_Costo DECIMAL(10,2),
    IN p_img TEXT
)
BEGIN
    UPDATE servicio
    SET TipoServicio = p_TipoServicio,
        Lema = p_Lema,
        Descripcion = p_Descripcion,
        Respuesta = p_Respuesta,
        Costo = p_Costo,
        img = p_img
    WHERE idServicio = p_idServicio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_eliminarServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminarServicio`(IN p_idServicio INT)
BEGIN
    DELETE FROM servicio WHERE idServicio = p_idServicio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_faq_listar_activas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_faq_listar_activas`()
BEGIN
    SELECT 
        idFaq,
        Pregunta as pregunta,
        Respuesta as respuesta,
        Prioridad as prioridad,
        Servicio_idServicio as servicioId
    FROM faq 
    WHERE Activo = 1
    ORDER BY Prioridad ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_iniciosesion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_iniciosesion`(IN i_DNI VARCHAR(100), IN i_clave VARCHAR(100))
BEGIN
    SELECT 
        u.idUsuario, u.Nombre, u.Apellido, u.DNI, r.TipoRol 
    FROM usuario u INNER JOIN rol r 
    ON u.Rol_idRol = r.idRol 
    WHERE u.DNI = i_DNI AND u.Clave = i_clave;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertarServicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarServicio`(
    IN p_TipoServicio TEXT,
    IN p_Lema TEXT,
    IN p_Descripcion TEXT,
    IN p_Respuesta TEXT,
    IN p_Costo DECIMAL(10,2),
    IN p_img TEXT
)
BEGIN
    INSERT INTO servicio (TipoServicio, Lema, Descripcion, Respuesta, Costo, img)
    VALUES (p_TipoServicio, p_Lema, p_Descripcion, p_Respuesta, p_Costo, p_img);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_faq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_faq`(
    IN p_Pregunta VARCHAR(255),
    IN p_Respuesta TEXT,
    IN p_Prioridad INT,
    IN p_Activo BOOLEAN,
    IN p_Servicio_idServicio INT,
    IN p_Usuario_idUsuario INT
)
BEGIN
    INSERT INTO Faq (
        Pregunta, Respuesta, Prioridad, Activo,
        FechaCreacion, FechaActualizacion,
        Servicio_idServicio, Usuario_idUsuario
    ) VALUES (
        p_Pregunta, p_Respuesta, p_Prioridad, p_Activo,
        NOW(), NOW(),
        p_Servicio_idServicio, p_Usuario_idUsuario
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_listarservicios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarservicios`()
BEGIN
    SELECT * FROM servicio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrarusuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrarusuario`(
    IN p_Nombre VARCHAR(50),
    IN p_Apellido VARCHAR(50),
    IN p_DNI VARCHAR(8),
    IN p_Telefono VARCHAR(9),
    IN p_Correo VARCHAR(100))
BEGIN
    INSERT INTO paciente (Nombre, Apellido, DNI, Telefono, Correo)
    VALUES (p_Nombre, p_Apellido, p_DNI, p_Telefono, p_Correo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_faq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_faq`(
    IN p_idFaq INT,
    IN p_Pregunta VARCHAR(255),
    IN p_Respuesta TEXT,
    IN p_Prioridad INT,
    IN p_Activo tinyint(1),
    IN p_Servicio_idServicio INT,
    IN p_Usuario_idUsuario INT
)
BEGIN
    UPDATE Faq
    SET Pregunta = p_Pregunta,
        Respuesta = p_Respuesta,
        Prioridad = p_Prioridad,
        Activo = p_Activo,
        FechaActualizacion = NOW(),
        Servicio_idServicio = p_Servicio_idServicio,
        Usuario_idUsuario = p_Usuario_idUsuario
    WHERE idFaq = p_idFaq;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-14 19:49:03
