UPDATE student
SET student_name = ?, student_rg = ?, student_cpf = ?, student_birthDate = ?, student_schooling = ?,
    prof_id = ?, student_email = ?, student_tel = ?, student_cel = ?, student_cep = ?, student_address = ?,
    student_numberHouse = ?, student_neighborhood = ?, student_media = ?, student_obs = ?, student_type = ?, cidade_id = ?,
    student_complement = ?, student_filiation = ?, student_status = ?
WHERE student_id = ?;