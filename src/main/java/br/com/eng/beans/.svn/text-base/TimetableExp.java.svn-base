package br.com.eng.beans;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;

public class TimetableExp implements IGenericBean {
	
	@Database(columnName = "timetable_exp_id")
	private Long id;
	
	@Database(columnName = "student_id")
	private Long studentId;
	
	@Database(columnName = "student_name")
	private String studentName;
	
	@Database(columnName = "teacher_id")
	private Long teacherId;

	@Database(columnName = "teacher_name")
	private String teacherName;
	
	@Database(columnName = "timetable_exp_day")
	private String day;

	@Database(columnName = "timetable_exp_startTime")
	private String startTime;
	
	@Database(columnName = "timetable_exp_endTime")
	private String endTime;

	public TimetableExp() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getStudentId() {
		return studentId;
	}

	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public Long getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Long teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Override
	public String toString() {
		return "TimetableVip [id=" + id + ", studentId=" + studentId + ", nameStudent=" + studentName + ", teacherId=" + teacherId + ", teacherName=" + teacherName + ", day=" + day + ", startTime=" + startTime + ", endTime=" + endTime + "]";
	}

	@Override
	public int compareTo(IGenericBean o) {
		// TODO Auto-generated method stub
		return 0;
	}

}
