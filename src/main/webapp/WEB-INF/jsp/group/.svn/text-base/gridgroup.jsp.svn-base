<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<script type="text/javascript">
$("td a").button();

$('#tbgroup').dataTable({
	"bJQueryUI": true,
	"oLanguage": {
		"sSearch": "Busca:",
		"sInfo": "_START_ à _END_ de _TOTAL_ Grades",
		"sLengthMenu": "Mostrar _MENU_ ",
		"sEmptyTable": "Não existe Turmas cadastradas.",
		"sZeroRecords": "Nenhuma Turma encontrada.",
		"sInfoFiltered": ""
	},
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 4 ]
	} ]
});

$("#tbgroup_filter").children("label").children("input").css("width", "350px");
</script>

<table id="tbgroup">
	<thead>
		<tr> 
			<th>Nome</th>
			<th>Professor</th>
			<th>Horário</th>
			<th>Horário</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="group" items="${listGroup}" varStatus="idx">
			<tr>
				<td id="tdname${idx.index}">${group.name}</td>
				<td id="tdteacher${idx.index}">${group.teacherName} <input id="tdteacherId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${group.teacherId}'></fmt:formatNumber>"></td>
				<td>${group.day1} - ${group.startTime1} às ${group.endTime1} 
					<input id="tdday1${idx.index}" type="hidden" value="${group.day1}">
					<input id="tdtimeStart1${idx.index}" type="hidden" value="${group.startTime1}">
					<input id="tdtimeEnd1${idx.index}" type="hidden" value="${group.endTime1}">
				</td>
				<td>
					<c:if test="${!empty group.day2}">
						${group.day2} - ${group.startTime2} às ${group.endTime2}  
						<input id="tdday2${idx.index}" type="hidden" value="${group.day2}">
						<input id="tdtimeStart2${idx.index}" type="hidden" value="${group.startTime2}">
						<input id="tdtimeEnd2${idx.index}" type="hidden" value="${group.endTime2}">
					</c:if>
					<input id="tdidGroup${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${group.id}'></fmt:formatNumber>">
				</td>
				<td> 
					<a onclick="switchEdit(${idx.index})" style="height:17px;width:26px;"  href="#" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-pencil" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="del(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Deletar" class="ui-icon ui-icon-trash" style="margin-left: -7px;margin-top: -5px;"></span></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>