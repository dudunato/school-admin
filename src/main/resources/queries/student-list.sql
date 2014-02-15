SELECT s.student_id, s.student_name, s.student_rg, s.student_cpf, s.student_birthDate, s.student_schooling,
       s.prof_id, p.nome_prof, s.student_email, s.student_tel, s.student_cel, s.student_cep, s.student_address, s.student_numberHouse,
       s.student_neighborhood, s.student_media, s.student_obs, s.student_dateCreated, s.school_id, s.student_type, s.cidade_id, 
       s.student_complement, s.student_filiation, c.cidade_nome, c.estado_id, c.estado_uf, s.student_status
FROM student s
LEFT JOIN cidade c ON s.cidade_id = c.cidade_id
LEFT JOIN profissoes p ON p.id_prof = s.prof_id;
