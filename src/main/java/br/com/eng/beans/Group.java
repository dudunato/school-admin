package br.com.eng.beans;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;

public class Group implements IGenericBean {

	@Database(columnName = "group_id")
	private Long id;

	@Database(columnName = "group_name")
	private String name;

	@Database(columnName = "teacher_id")
	private Long teacherId;

	@Database(columnName = "teacher_name")
	private String teacherName;

	@Database(columnName = "group_day1")
	private String day1;

	@Database(columnName = "group_startTime1")
	private String startTime1;

	@Database(columnName = "group_endTime1")
	private String endTime1;

	@Database(columnName = "group_day2")
	private String day2;

	@Database(columnName = "group_startTime2")
	private String startTime2;

	@Database(columnName = "group_endTime2")
	private String endTime2;

	public Group() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getDay1() {
		return day1;
	}

	public void setDay1(String day1) {
		this.day1 = day1;
	}

	public String getStartTime1() {
		return startTime1;
	}

	public void setStartTime1(String startTime1) {
		this.startTime1 = startTime1;
	}

	public String getEndTime1() {
		return endTime1;
	}

	public void setEndTime1(String endTime1) {
		this.endTime1 = endTime1;
	}

	public String getDay2() {
		return day2;
	}

	public void setDay2(String day2) {
		this.day2 = day2;
	}

	public String getStartTime2() {
		return startTime2;
	}

	public void setStartTime2(String startTime2) {
		this.startTime2 = startTime2;
	}

	public String getEndTime2() {
		return endTime2;
	}

	public void setEndTime2(String endTime2) {
		this.endTime2 = endTime2;
	}

	@Override
	public int compareTo(IGenericBean o) {
		// TODO Auto-generated method stub
		return 0;
	}

}
