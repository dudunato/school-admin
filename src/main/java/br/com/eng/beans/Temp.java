package br.com.eng.beans;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.daos.SchoolDAO;
import br.com.eng.daos.StudentDAO;
import br.com.eng.daos.TeacherDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
@ApplicationScoped
public class Temp {

	private SchoolDAO schoolDAO;
	private TeacherDAO teacherDAO;
	private Map<Long, Set<Teacher>> teachers;
	private StudentDAO studentDAO;
	private Map<Long, Set<Student>> students;
	private Map<Long, Set<Student>> possibleStudents;

	public Temp(SchoolDAO schoolDAO, TeacherDAO teacherDAO, StudentDAO studentDAO) {
		this.schoolDAO = schoolDAO;
		this.teacherDAO = teacherDAO;
		this.studentDAO = studentDAO;
		this.teachers = new ConcurrentHashMap<Long, Set<Teacher>>();
		this.students = new ConcurrentHashMap<Long, Set<Student>>();
		this.possibleStudents = new ConcurrentHashMap<Long, Set<Student>>();
	}

	public void updateSchools() {
		Set<Object> list = schoolDAO.getListShcool();

		for (Object object : list) {
			Long schoolId = (Long) object;
			teachers.put(schoolId, new HashSet<Teacher>());
			students.put(schoolId, new HashSet<Student>());
			possibleStudents.put(schoolId, new HashSet<Student>());
		}
	}

	public void updateTeachers() {
		clearTeachers();
		for (IGenericBean teacher : teacherDAO.getListTeacher()) {
			Teacher t = (Teacher) teacher;
			teachers.get(t.getSchoolId()).add(t);
		}
	}

	public void updateStudents() {
		clearStudents();
		for (IGenericBean student : studentDAO.getListStudent()) {
			Student s = (Student) student;
			
			if (Student.ACTIVE.equals(s.getStatus())) {
				students.get(s.getSchoolId()).add(s);
			} else {
				possibleStudents.get(s.getSchoolId()).add(s);
			}
		}
	}

	public Set<Teacher> getTeachers(Long schoolId) {
		return teachers.get(schoolId);
	}

	public Set<Student> getStudents(Long schoolId) {
		return students.get(schoolId);
	}
	
	public Set<Student> getPossibleStudents(Long schoolId) {
		return possibleStudents.get(schoolId);
	}

	private void clearTeachers() {
		for (Long schoolId : teachers.keySet()) {
			teachers.get(schoolId).clear();
		}
	}

	private void clearStudents() {
		for (Long schoolId : students.keySet()) {
			students.get(schoolId).clear();
			possibleStudents.get(schoolId).clear();
		}
	}

}
