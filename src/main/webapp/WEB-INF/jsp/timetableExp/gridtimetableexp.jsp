<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<script type="text/javascript">
$("td a").button();

$('#tbtimetable').dataTable({
	"bJQueryUI": true,
	"oLanguage": {
		"sSearch": "Busca:",
		"sInfo": "_START_ à _END_ de _TOTAL_ Grades",
		"sLengthMenu": "Mostrar _MENU_ ",
		"sEmptyTable": "Não existe Grades cadastradas.",
		"sZeroRecords": "Nenhuma Grade encontrada.",
		"sInfoFiltered": ""
	},
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 3 ]
	} ]
});

$("#tbtimetable_filter").children("label").children("input").css("width", "300px");
</script>

<table id="tbtimetable">
	<thead>
		<tr> 
			<th>Aluno</th>
			<th>Professor</th>
			<th>Horário</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="timetable" items="${listTimetable}" varStatus="idx">
			<tr>
				<td id="tdstudent${idx.index}">${timetable.studentName} <input id="tdstudentId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${timetable.studentId}'></fmt:formatNumber>"></td>
				<td id="tdteacher${idx.index}">${timetable.teacherName}a<input id="tdteacherId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${timetable.teacherId}'></fmt:formatNumber>"></td>
				<td>${timetable.day} ${timetable.startTime} às ${timetable.endTime} 
					<input id="tdday${idx.index}" type="hidden" value="${timetable.day}">
					<input id="tdtimeStart${idx.index}" type="hidden" value="${timetable.startTime}">
					<input id="tdtimeEnd${idx.index}" type="hidden" value="${timetable.endTime}">
					<input id="tdidTimetable${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${timetable.id}'></fmt:formatNumber>">
				</td>
				<td> 
					<a onclick="switchEdit(${idx.index})" style="height:17px;width:26px;"  href="#" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-pencil" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="del(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Deletar" class="ui-icon ui-icon-trash" style="margin-left: -7px;margin-top: -5px;"></span></a>
				</td>
			</tr>
        </c:forEach>
	</tbody>
</table>