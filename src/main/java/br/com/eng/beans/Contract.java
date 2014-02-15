package br.com.eng.beans;

import java.util.Date;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;

public class Contract implements IGenericBean {

	@Database(columnName = "contract_id")
	private Long id;

	@Database(columnName = "student_id")
	private Long studentID;

	@Database(columnName = "student_name")
	private String studentName;

	@Database(columnName = "contract_total_value")
	private String totalValue;

	@Database(columnName = "contract_entry_value")
	private String entryValue;

	@Database(columnName = "contract_begin_date")
	private String beginDate;

	@Database(columnName = "contract_end_date")
	private String endDate;

	@Database(columnName = "contract_monthly_payment_value")
	private String monthlyPaymentValue;

	@Database(columnName = "contract_alternative_payment_value")
	private String alternativePaymentValue;

	@Database(columnName = "contract_dateCreated")
	private Date dateCreated;

	public Contract() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getStudentID() {
		return studentID;
	}

	public void setStudentID(Long studentID) {
		this.studentID = studentID;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getTotalValue() {
		return totalValue;
	}

	public void setTotalValue(String totalValue) {
		this.totalValue = totalValue;
	}

	public String getEntryValue() {
		return entryValue;
	}

	public void setEntryValue(String entryValue) {
		this.entryValue = entryValue;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getMonthlyPaymentValue() {
		return monthlyPaymentValue;
	}

	public void setMonthlyPaymentValue(String monthlyPaymentValue) {
		this.monthlyPaymentValue = monthlyPaymentValue;
	}

	public String getAlternativePaymentValue() {
		return alternativePaymentValue;
	}

	public void setAlternativePaymentValue(String alternativePaymentValue) {
		this.alternativePaymentValue = alternativePaymentValue;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	@Override
	public int compareTo(IGenericBean o) {
		// TODO Auto-generated method stub
		return 0;
	}

}