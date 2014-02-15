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
		"sEmptyTable": "Não existe Contratos cadastrados.",
		"sZeroRecords": "Nenhum Contrato encontrado.",
		"sInfoFiltered": ""
	},
	"aoColumns" : [
		null,
		null,
		{ "bSearchable": false, "bVisible":    false },
		null,
		null,
		null,
		null
	],	
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 5 ]
	} ]
});

$("#tbtimetable_filter").children("label").children("input").css("width", "350px");
</script>

<table id="tbtimetable">
	<thead>
		<tr> 
			<th>Turma</th>
			<th>Aluno</th>
			<th>IdAluno</th>
			<th>Professor</th>
			<th>Horário</th>
			<th>Horário</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="timetable" items="${listTimetable}" varStatus="idx">
			<tr>
				<td id="tdgroup${idx.index}">${timetable.groupName} <input id="tdgroupId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${timetable.groupId}'></fmt:formatNumber>"></td>
				<td id="tdstudent${idx.index}">${timetable.studentName} <input id="tdstudentId${idx.index}" class="students-validation" type="hidden" value="<fmt:formatNumber type='number' value='${timetable.studentId}'></fmt:formatNumber>"></td>
				<td><fmt:formatNumber type='number' value='${timetable.studentId}'></fmt:formatNumber></td>
				<td id="tdteacher${idx.index}">${timetable.teacherName} </td>
				<td>${timetable.day1} - ${timetable.startTime1} às ${timetable.endTime1} </td>
				<td>
					<c:if test="${!empty timetable.day2}">
						${timetable.day2} - ${timetable.startTime2} às ${timetable.endTime2}  
					</c:if>
				</td>
				<td> 
					<a onclick="del(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Deletar" class="ui-icon ui-icon-trash" style="margin-left: -7px;margin-top: -5px;"></span></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>