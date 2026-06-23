-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 02:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `workconnect_sl`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `Application_ID` int(11) NOT NULL,
  `Job_ID` int(11) DEFAULT NULL,
  `Seeker_ID` int(11) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Submitted' CHECK (`Status` in ('Submitted','Under_Review','Accepted','Rejected')),
  `Reference_Number` varchar(30) NOT NULL,
  `Submitted_Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employers`
--

CREATE TABLE `employers` (
  `Employer_ID` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Company_name` varchar(150) DEFAULT NULL,
  `Registration_no` varchar(50) DEFAULT NULL,
  `Verified_status` tinyint(1) DEFAULT 0,
  `Safety_rating` decimal(2,1) DEFAULT 0.0,
  `Flag_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employment_reports`
--

CREATE TABLE `employment_reports` (
  `Report_ID` int(11) NOT NULL,
  `Officer_ID` int(11) DEFAULT NULL,
  `Month` varchar(20) NOT NULL,
  `Jobs_Created` int(11) DEFAULT 0,
  `Applications_Count` int(11) DEFAULT 0,
  `Safety_Incidents` int(11) DEFAULT 0,
  `District` varchar(100) DEFAULT NULL,
  `Generated_Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_listings`
--

CREATE TABLE `job_listings` (
  `Job_ID` int(11) NOT NULL,
  `Employer_ID` int(11) DEFAULT NULL,
  `Title` varchar(150) DEFAULT NULL,
  `Sector` varchar(100) DEFAULT NULL,
  `Salary_Min` decimal(10,2) DEFAULT NULL,
  `Salary_Max` decimal(10,2) DEFAULT NULL,
  `Location` varchar(150) DEFAULT NULL,
  `Latitude` decimal(10,7) DEFAULT NULL,
  `Longitude` decimal(10,7) DEFAULT NULL,
  `Skills_Required` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active' CHECK (`Status` in ('Active','Closed','Pending')),
  `Verified_by_officer` tinyint(1) DEFAULT 0,
  `Posted_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_seekers`
--

CREATE TABLE `job_seekers` (
  `Seeker_ID` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Skills` text DEFAULT NULL,
  `Education` varchar(100) DEFAULT NULL,
  `Work_History` text DEFAULT NULL,
  `Profile_status` varchar(20) DEFAULT 'active',
  `Alerts_enabled` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `safety_reports`
--

CREATE TABLE `safety_reports` (
  `Report_ID` int(11) NOT NULL,
  `Issue_Type` varchar(50) DEFAULT NULL CHECK (`Issue_Type` in ('Safety_Hazard','Wage_Theft','Harassment','Other')),
  `Description` text NOT NULL,
  `Latitude` decimal(10,7) DEFAULT NULL,
  `Longitude` decimal(10,7) DEFAULT NULL,
  `Employer_ID` int(11) DEFAULT NULL,
  `Reporter_Encrypted` text NOT NULL,
  `Case_ID` varchar(30) NOT NULL,
  `Status` varchar(20) DEFAULT 'Open' CHECK (`Status` in ('Open','Investigating','Resolved')),
  `Submitted_Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Pin_Hash` varchar(255) DEFAULT NULL,
  `Role` varchar(20) DEFAULT NULL CHECK (`Role` in ('job_seeker','employer','labour_officer','admin')),
  `Location` varchar(100) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `Name`, `Phone`, `Pin_Hash`, `Role`, `Location`, `Created_at`) VALUES
(1, 'Test Job Seeker', '+23276000001', 'hashed_pin_here', 'job_seeker', 'Freetown', '2026-06-15 08:26:41'),
(2, 'BuildRight SL Ltd', '+23276000002', 'hashed_pin_here', 'employer', 'Lumley, Freetown', '2026-06-15 08:27:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`Application_ID`),
  ADD UNIQUE KEY `Reference_Number` (`Reference_Number`);

--
-- Indexes for table `employers`
--
ALTER TABLE `employers`
  ADD PRIMARY KEY (`Employer_ID`);

--
-- Indexes for table `employment_reports`
--
ALTER TABLE `employment_reports`
  ADD PRIMARY KEY (`Report_ID`);

--
-- Indexes for table `job_listings`
--
ALTER TABLE `job_listings`
  ADD PRIMARY KEY (`Job_ID`);

--
-- Indexes for table `job_seekers`
--
ALTER TABLE `job_seekers`
  ADD PRIMARY KEY (`Seeker_ID`);

--
-- Indexes for table `safety_reports`
--
ALTER TABLE `safety_reports`
  ADD PRIMARY KEY (`Report_ID`),
  ADD UNIQUE KEY `Case_ID` (`Case_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `Application_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employers`
--
ALTER TABLE `employers`
  MODIFY `Employer_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employment_reports`
--
ALTER TABLE `employment_reports`
  MODIFY `Report_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_seekers`
--
ALTER TABLE `job_seekers`
  MODIFY `Seeker_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `safety_reports`
--
ALTER TABLE `safety_reports`
  MODIFY `Report_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
