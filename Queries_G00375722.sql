-- select all the patients in the system
SELECT * FROM PATIENT;





-- ***********************************************************************************************
-- find all patients for one postcode

SELECT * FROM patient where eircode = "P24A123";





-- ***********************************************************************************************
-- calculate overdue days for each open bill

SELECT
    DATEDIFF(CURRENT_DATE, a.date) AS 'Result',
    p.name
FROM
    appointments AS a,
    patient AS p,
    bill AS b
WHERE
    b.bill_status = "open" AND b.patient_ID = a.patient_ID AND b.patient_ID = p.patient_ID;





-- **********************************************************************************
-- display number of patients who have outstanding bills
SELECT
    COUNT(`patient_ID`)
FROM
    patient
WHERE
    `outstanding_balance` > 0;
	
	
	

-- *******************************************************************************
-- display bill item information for patient Mary Murphy id = 1

SELECT
    bi.bill_ID,
    tg.description,
    tg.price
FROM
    patient_chart_details AS pcd,
    bill_items AS bi,
    treatment_guide AS tg
WHERE
    pcd.patient_ID = 3 AND pcd.chart_item_ID = bi.chart_item_ID AND pcd.treatment_ID = tg.treatment_ID;
	
	
	
	
	

-- ************************************************************************************************
-- select treatment history for patient with id=3 (Tim Collins) given by MulCahy dentists.
SELECT
    t.description
	
FROM
    patient_chart_details AS pcd,
    treatment_guide AS t
WHERE
    pcd.patient_ID = "3" AND pcd.treatment_ID = t.treatment_ID AND pcd.treatment_status = "work done";
	
	
	
	
	
-- **********************************************************************************************
-- show complete history for a patient with id 5 – local treatments and any specialist treatments

SELECT
    t.description AS "Treatment(s)",
    a.date AS "Date"
FROM
    patient_chart_details AS pcd,
    treatment_guide AS t,
    appointments AS a
WHERE
    pcd.patient_ID = "5" AND pcd.treatment_ID = t.treatment_ID AND pcd.treatment_status = "work done" AND pcd.appointment_ID = a.appointment_ID
UNION ALL
SELECT
    pst.treatment_desc,
    pst.treatment_received
FROM
    patient_specialist_treatments AS pst
WHERE
    pst.patient_ID = "5";
	
	
	
	
-- **************************************************************************************
-- change a phone number
UPDATE
    `patient_phone_number`
SET
    `phone_no` = '087 5666975'
WHERE
    `patient_phone_number`.`eircode` = 'P24D123' AND `patient_phone_number`.`phone_no` = '087 5778975';
	
	
	
	
-- **************************************************************************************************
-- add a new treatment offering to the existing list
INSERT INTO `treatment_guide`(
    `treatment_ID`,
    `description`,
    `price`,
    `treatment_duration`
)
VALUES(
    '3232',
    'Top Up whitening gel syringe',
    '30',
    '30'
);




-- ****************************************************************************************
-- delete a treatment with id 3232

DELETE
FROM
    treatment_guide
WHERE
    treatment_ID = 3232;
	

