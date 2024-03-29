<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<script type="text/javascript">
$("td a").button();

$('#tbstudents').dataTable({
	"bJQueryUI": true,
	"oLanguage": {
		"sSearch": "Busca:",
		"sInfo": "_START_ � _END_ de _TOTAL_ Alunos",
		"sLengthMenu": "Mostrar _MENU_ ",
		"sEmptyTable": "N�o existe Alunos cadastrados.",
		"sZeroRecords": "Nenhum aluno encontrado.",
		"sInfoFiltered": ""
	},
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 5 ]
	} ],
	"sDom": '<"H"lTfr>t<"F"ip>',
	"oTableTools": {
		"sSwfPath": "${pageContext.request.contextPath}/js/swf/copy_csv_xls_pdf.swf",
		"aButtons": [ "xls" ]
	}
});

$("#tbstudents_filter").children("label").children("input").css("width", "350px");
</script>

<table id="tbstudents">
	<thead>
		<tr> 
			<th>Nome</th>
			<th>Email</th>
			<th>Tel</th>
			<th>Cel.</th>
			<th>Status</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="student" items="${listPossible}" varStatus="idx">
			<tr>
				<td id='tdname${idx.index}'>${student.name}</td>
				<td id="tdemail${idx.index}">${student.email}
					<input id="tdid${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${student.id}'></fmt:formatNumber>" />
				</td>
				<td id="tdtel${idx.index}">${student.tel}</td>
				<td id="tdcel${idx.index}">${student.cel}</td>
				<td id="tdstatus${idx.index}">${student.status}</td>
				<td>
					<a onclick="switchEdit(${idx.index})" style="height:17px;width:26px;"  href="#" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-pencil" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="activating(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Ativar" class="ui-icon ui-icon-check" style="margin-left: -7px;margin-top: -5px;"></span></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>