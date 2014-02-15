UPDATE timetable_exp
SET
student_id = ?,
teacher_id = ?,
timetable_exp_day = ?,
timetable_exp_startTime = ?,
timetable_exp_endTime = ?
WHERE timetable_exp_id = ?;
