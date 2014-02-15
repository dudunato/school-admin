UPDATE contract 
SET student_id = ?,
    contract_total_value = ?,
    contract_entry_value = ?,
    contract_begin_date = ?,
    contract_end_date = ?,
    contract_monthly_payment_value = ?,
    contract_alternative_payment_value = ?
WHERE contract_id = ?;