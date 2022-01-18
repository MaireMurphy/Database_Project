-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2021 at 09:35 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dentist_db`
--

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`eircode`, `address`) VALUES
('P24A123', '8, Main st., Cobh, Co. Cork'),
('P24C123', 'Rose Cottage, Clonakilty, Co. Cork'),
('P24D123', 'No. 2 Cobble Dr., Cobh, Co. Cork'),
('P24E123', '123 Upper New Castle, Cobh');

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_ID`, `patient_ID`, `date`, `time`, `visit_status`, `reminder_status`, `visit_type`, `notes`, `dentist_ID`) VALUES
(1, 1, '2017-12-03', '09:00:00', 'closed', 'sent', 'first booking', '', 1),
(2, 3, '2018-04-18', '13:00:00', 'closed', 'sent', 'first booking', 'nervous patient.', 1),
(3, 2, '2021-03-02', '15:00:00', 'closed', 'sent', 'first booking', '', 1),
(4, 2, '2021-05-31', '09:30:00', 'booked', 'not sent', 'follow up', '', 1),
(5, 4, '2021-04-06', '11:30:00', 'late cancellation', 'sent', 'first booking', '', 1),
(6, 1, '2021-04-30', '13:00:00', 'booked', 'not sent', 'standard', '', 1),
(8, 5, '2021-02-22', '14:00:00', 'booked', 'sent', 'first booking', NULL, 1);

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_ID`, `bill_total_amt`, `balance_owed`, `late_fee`, `balance_paid`, `bill_status`, `patient_ID`, `misc_fee`) VALUES
(1, 42, NULL, NULL, 42, 'closed', 1, NULL),
(2, 280, 280, NULL, NULL, 'open', 3, NULL),
(3, 31, NULL, NULL, 31, 'closed', 2, NULL),
(4, 10, 10, NULL, NULL, 'open', 4, NULL),
(5, 42, 0, NULL, 42, 'closed', 5, NULL);

--
-- Dumping data for table `bill_items`
--

INSERT INTO `bill_items` (`bill_ID`, `chart_item_ID`) VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(5, 8);

--
-- Dumping data for table `dentists`
--

INSERT INTO `dentists` (`dentist_ID`, `category`, `dentist_name`, `office_ID`) VALUES
(1, 'regular', 'Mary Mulcahy', 1),
(2, 'specialist', 'Maria Kelly', 2),
(3, 'specialist', 'John Morissey', 3);

--
-- Dumping data for table `office`
--

INSERT INTO `office` (`office_ID`, `phone`, `address`, `practice_name`, `secretary`, `bill_amt_threshold`, `overdue_period`, `late_cancellation_fee`, `misc_fee`) VALUES
(1, '(021) 461 4333', 'Main st., Cobh, Co. Cork', 'Mulcahy\'s Dental Practice', 'Helen', 400, 30, 10, NULL),
(2, '(021) 242 7230', 'East Village Medical Centre, Douglas, Cork', 'Dental & Medical Clinic - City Clinic', 'Dave King', NULL, NULL, NULL, NULL),
(3, '(021) 461 4520', 'Unit 2002, City Gate, St Michael\'s, Cork.', 'Cork Specialist Dental Clinic', 'Sally O\'Brien', NULL, NULL, NULL, NULL);

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_ID`, `name`, `outstanding_balance`, `bill_days_overdue`, `dob`, `notes`, `eircode`) VALUES
(1, 'Mary Murphy', NULL, NULL, '1970-10-12', NULL, 'P24A123'),
(2, 'Kate Murphy', NULL, NULL, '2017-03-23', NULL, 'P24A123'),
(3, 'Tim Collins', 280, 1086, '1951-04-27', NULL, 'P24C123'),
(4, 'John Joe McGrath', 10, 2, '1980-04-06', NULL, 'P24D123'),
(5, 'Roy Keane', NULL, NULL, '1965-04-09', 'fear of needles', 'P24E123'),
(6, 'Tom Murphy', NULL, NULL, '1968-05-01', 'nervous patient', 'P24A123'),
(7, 'Tommy Murphy', NULL, NULL, '2018-06-01', NULL, 'P24A123');

--
-- Dumping data for table `patient_chart_details`
--

INSERT INTO `patient_chart_details` (`chart_item_ID`, `notes`, `treatment_status`, `treatment_ID`, `appointment_ID`, `patient_ID`) VALUES
(1, 'Teeth in great condition', 'work done', 11122, 1, 1),
(2, 'Teeth in poor condition.', 'work done', 111, 2, 3),
(3, 'Back left lower molar', 'work done', 114, 2, 3),
(4, 'Back top left molar', 'work done', 114, 2, 3),
(5, 'Lower front tooth', 'work done', 114, 2, 3),
(6, NULL, 'work done', 1211, 3, 2),
(7, 'all molars with fissure cap seals', 'follow up', 1133, 4, 2),
(8, 'Roy is to be referred to a specialist in cosmetic dentistry', 'work done', 11122, 8, 5);

--
-- Dumping data for table `patient_phone_number`
--

INSERT INTO `patient_phone_number` (`eircode`, `phone_no`) VALUES
('P24A123', '(021) 490 8340'),
('P24A123', '(087) 94321567'),
('P24C123', '(021) 490 8800'),
('P24D123', '087 5778975'),
('P24E123', '(087) 66772211');

--
-- Dumping data for table `patient_specialist_treatments`
--

INSERT INTO `patient_specialist_treatments` (`sp_tr_ID`, `patient_ID`, `dentist_ID`, `treatment_desc`, `referral_sent_date`, `treatment_received`) VALUES
(1, 5, 2, 'Cosmetic veneers', '2021-02-02', '2021-03-22');

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_ID`, `amount`, `payment_method`, `date`, `payment_type`, `bill_ID`) VALUES
(1, 42, 'card', '2017-12-03', 'full', 1),
(2, 31, 'cash', '2021-03-02', 'full', 3),
(3, 42, 'cheque', '2021-02-24', 'full', 5);

--
-- Dumping data for table `treatment_guide`
--

INSERT INTO `treatment_guide` (`treatment_ID`, `description`, `price`, `treatment_duration`) VALUES
(110, 'Fixed bridge', 744, 40),
(111, 'Full Examination: (including 2 bitewing x-rays)', 100, 40),
(112, 'Advanced gum treatment', 220, 30),
(113, 'Xray Intra Oral / Panoramic ', 70, 15),
(114, 'Routine Extraction', 60, 20),
(115, 'Acrylic-based Dentures', 800, 60),
(116, 'Crown', 1200, 45),
(117, 'Root Canal Treatment (dependent on tooth type)', 300, 45),
(119, 'Metal-based Dentures', 1900, 60),
(1122, ' Kids Scale and Polish', 31, 20),
(1133, 'Fissure sealants', 36, 20),
(1211, 'Kids routine exam', 31, 20),
(11122, 'Routine Exam, diagnosis and treatment plan', 42, 30);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
