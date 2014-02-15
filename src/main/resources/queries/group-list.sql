SELECT g.group_id, g.group_name, g.teacher_id, t.teacher_name,
       g.group_day1, g.group_startTime1, g.group_endTime1,
       g.group_day2, g.group_startTime2, g.group_endTime2
FROM `group` g,  teacher t
WHERE g.teacher_id = t.teacher_id
AND t.school_id = ?;