SELECT tt.group_id, tt.student_id, g.group_name, s.student_name,
        g.group_endTime2, g.teacher_id, t.teacher_name, g.group_day1, 
        g.group_startTime1, g.group_endTime1, g.group_day2, g.group_startTime2, g.group_endTime2
FROM student s, teacher t, timetable tt, `group` g
WHERE s.student_id = tt.student_id
AND t.teacher_id = g.teacher_id
AND g.group_id = tt.group_id
AND s.school_id = ?;