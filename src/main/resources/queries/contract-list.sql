SELECT c.contract_id, c.student_id, c.contract_total_value, c.contract_entry_value, c.contract_begin_date, c.contract_end_date,
	c.contract_monthly_payment_value, c.contract_alternative_payment_value, s.student_name
FROM contract c, student s
WHERE s.student_id = c.student_id
AND s.school_id = ?;