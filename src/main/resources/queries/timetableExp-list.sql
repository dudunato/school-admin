SELECT tt.timetable_exp_id, tt.student_id, s.student_name, tt.teacher_id, t.teacher_name,
       tt.timetable_exp_day, tt.timetable_exp_startTime, tt.timetable_exp_endTime
FROM timetable_exp tt, student s, teacher t
WHERE tt.student_id = s.student_id
AND tt.teacher_id = t.teacher_id
AND s.school_id = ?;