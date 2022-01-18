-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2021 at 09:32 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `eircode` varchar(8) NOT NULL,
  `address` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_ID` int(11) NOT NULL,
  `patient_ID` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `visit_status` enum('booked','cancelled','late cancellation','closed') NOT NULL DEFAULT 'booked',
  `reminder_status` enum('sent','not sent','na') NOT NULL DEFAULT 'not sent' COMMENT '''sent'' for past or shortly upcoming appointments\r\n''not sent'' for future appointments\r\n''na''  not applicable.  appointments that may have been cancelled before reminders sent out.',
  `visit_type` enum('first booking','follow up','standard') NOT NULL DEFAULT 'standard' COMMENT '''first booking'' will trigger a new patient chart\record to be created.\r\n''follow up'' -  indicate that the patient has reserved treatments\r\n''standard'' - patient already has a chart and there are not reserved treatments.',
  `notes` varchar(300) DEFAULT NULL,
  `dentist_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_ID` int(11) NOT NULL,
  `bill_total_amt` float NOT NULL,
  `balance_owed` float DEFAULT NULL,
  `late_fee` float DEFAULT NULL,
  `balance_paid` float DEFAULT NULL,
  `bill_status` enum('open','closed') NOT NULL,
  `patient_ID` int(11) NOT NULL,
  `misc_fee` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

CREATE TABLE `bill_items` (
  `bill_ID` int(11) NOT NULL,
  `chart_item_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Itemized unpaid treatments are listed for each bill';

-- --------------------------------------------------------

--
-- Table structure for table `dentists`
--

CREATE TABLE `dentists` (
  `dentist_ID` int(11) NOT NULL,
  `category` enum('specialist','regular') NOT NULL,
  `dentist_name` varchar(100) NOT NULL,
  `office_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `office`
--

CREATE TABLE `office` (
  `office_ID` int(11) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `address` varchar(200) NOT NULL,
  `practice_name` varchar(200) NOT NULL,
  `secretary` varchar(100) DEFAULT NULL,
  `bill_amt_threshold` float DEFAULT NULL,
  `overdue_period` int(11) DEFAULT NULL,
  `late_cancellation_fee` float DEFAULT NULL,
  `misc_fee` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `outstanding_balance` float DEFAULT NULL,
  `bill_days_overdue` int(11) DEFAULT NULL,
  `dob` date NOT NULL,
  `notes` varchar(300) DEFAULT NULL,
  `eircode` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient_address`
--

CREATE TABLE `patient_address` (
  `patient_ID` int(11) NOT NULL,
  `eircode` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient_chart_details`
--

CREATE TABLE `patient_chart_details` (
  `chart_item_ID` int(11) NOT NULL,
  `notes` varchar(300) DEFAULT NULL,
  `treatment_status` enum('work done','follow up','na') NOT NULL COMMENT '''work done'' - patient received treatment\r\n''follow up'' - patient has not received treatment\r\n''na'' - not applicable. patient declines treatment or it is not necessary anymore.',
  `treatment_ID` int(11) NOT NULL,
  `appointment_ID` int(11) NOT NULL,
  `patient_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains a treatment history for the patient. Any follow up treatments are also stored for the next appointment.';

-- --------------------------------------------------------

--
-- Table structure for table `patient_phone_number`
--

CREATE TABLE `patient_phone_number` (
  `eircode` varchar(8) NOT NULL,
  `phone_no` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient_specialist_treatments`
--

CREATE TABLE `patient_specialist_treatments` (
  `sp_tr_ID` int(11) NOT NULL,
  `patient_ID` int(11) NOT NULL,
  `dentist_ID` int(11) NOT NULL,
  `treatment_desc` varchar(300) NOT NULL,
  `referral_sent_date` date NOT NULL,
  `treatment_received` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Specialist treatments which have been referred by Mulcahy dentists are recorded in the patient''s history.';

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_ID` int(11) NOT NULL,
  `amount` float NOT NULL,
  `payment_method` enum('card','cheque','cash') NOT NULL,
  `date` date NOT NULL,
  `payment_type` enum('installment','full') NOT NULL,
  `bill_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `treatment_guide`
--

CREATE TABLE `treatment_guide` (
  `treatment_ID` int(11) NOT NULL,
  `description` varchar(300) NOT NULL,
  `price` float NOT NULL,
  `treatment_duration` int(11) NOT NULL COMMENT 'Approximate length of time in minutes to carry out the procedure.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains a list of treatment offerings by the Mulcahy dental practice';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`eircode`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_ID`),
  ADD KEY `fkIdx_202` (`dentist_ID`),
  ADD KEY `fkIdx_21` (`patient_ID`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_ID`),
  ADD KEY `fkIdx_183` (`patient_ID`);

--
-- Indexes for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD PRIMARY KEY (`bill_ID`,`chart_item_ID`),
  ADD KEY `fkIdx_150` (`bill_ID`),
  ADD KEY `fkIdx_180` (`chart_item_ID`);

--
-- Indexes for table `dentists`
--
ALTER TABLE `dentists`
  ADD PRIMARY KEY (`dentist_ID`),
  ADD KEY `fkIdx_220` (`office_ID`);

--
-- Indexes for table `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`office_ID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_ID`);

--
-- Indexes for table `patient_address`
--
ALTER TABLE `patient_address`
  ADD PRIMARY KEY (`patient_ID`,`eircode`) USING BTREE,
  ADD KEY `fkIdx_251` (`patient_ID`),
  ADD KEY `fkIdx_255` (`eircode`);

--
-- Indexes for table `patient_chart_details`
--
ALTER TABLE `patient_chart_details`
  ADD PRIMARY KEY (`chart_item_ID`),
  ADD KEY `fkIdx_174` (`treatment_ID`),
  ADD KEY `fkIdx_177` (`appointment_ID`),
  ADD KEY `fkIdx_198` (`patient_ID`);

--
-- Indexes for table `patient_phone_number`
--
ALTER TABLE `patient_phone_number`
  ADD PRIMARY KEY (`eircode`,`phone_no`),
  ADD KEY `fkIdx_281` (`eircode`);

--
-- Indexes for table `patient_specialist_treatments`
--
ALTER TABLE `patient_specialist_treatments`
  ADD PRIMARY KEY (`sp_tr_ID`),
  ADD KEY `fkIdx_96` (`patient_ID`),
  ADD KEY `fkIdx_99` (`dentist_ID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_ID`),
  ADD KEY `fkIdx_126` (`bill_ID`);

--
-- Indexes for table `treatment_guide`
--
ALTER TABLE `treatment_guide`
  ADD PRIMARY KEY (`treatment_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `bill_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_chart_details`
--
ALTER TABLE `patient_chart_details`
  MODIFY `chart_item_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_specialist_treatments`
--
ALTER TABLE `patient_specialist_treatments`
  MODIFY `sp_tr_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `FK_20` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`),
  ADD CONSTRAINT `FK_201` FOREIGN KEY (`dentist_ID`) REFERENCES `dentists` (`dentist_ID`);

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `FK_182` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`);

--
-- Constraints for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD CONSTRAINT `FK_149` FOREIGN KEY (`bill_ID`) REFERENCES `bill` (`bill_ID`),
  ADD CONSTRAINT `FK_179` FOREIGN KEY (`chart_item_ID`) REFERENCES `patient_chart_details` (`chart_item_ID`);

--
-- Constraints for table `dentists`
--
ALTER TABLE `dentists`
  ADD CONSTRAINT `FK_219` FOREIGN KEY (`office_ID`) REFERENCES `office` (`office_ID`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `FK_257` FOREIGN KEY (`eircode`) REFERENCES `address` (`eircode`);

--
-- Constraints for table `patient_address`
--
ALTER TABLE `patient_address`
  ADD CONSTRAINT `FK_250` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`),
  ADD CONSTRAINT `FK_254` FOREIGN KEY (`eircode`) REFERENCES `address` (`eircode`);

--
-- Constraints for table `patient_chart_details`
--
ALTER TABLE `patient_chart_details`
  ADD CONSTRAINT `FK_173` FOREIGN KEY (`treatment_ID`) REFERENCES `treatment_guide` (`treatment_ID`),
  ADD CONSTRAINT `FK_176` FOREIGN KEY (`appointment_ID`) REFERENCES `appointments` (`appointment_ID`),
  ADD CONSTRAINT `FK_197` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`);

--
-- Constraints for table `patient_phone_number`
--
ALTER TABLE `patient_phone_number`
  ADD CONSTRAINT `FK_280` FOREIGN KEY (`eircode`) REFERENCES `address` (`eircode`);

--
-- Constraints for table `patient_specialist_treatments`
--
ALTER TABLE `patient_specialist_treatments`
  ADD CONSTRAINT `FK_95` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`),
  ADD CONSTRAINT `FK_98` FOREIGN KEY (`dentist_ID`) REFERENCES `dentists` (`dentist_ID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `FK_125` FOREIGN KEY (`bill_ID`) REFERENCES `bill` (`bill_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
