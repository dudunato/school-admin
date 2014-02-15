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
		"sInfo": "_START_ à _END_ de _TOTAL_ Alunos",
		"sLengthMenu": "Mostrar _MENU_ ",
		"sEmptyTable": "Não existe Alunos cadastrados.",
		"sZeroRecords": "Nenhum aluno encontrado.",
		"sInfoFiltered": ""
	},
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 4 ]
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
			<th>CPF</th>
			<th>Email</th>
			<th>Tipo</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="student" items="${listStudent}" varStatus="idx">
			<tr>
				<td id='tdname${idx.index}'>${student.name}</td>
				<td id="tdcpf${idx.index}">${student.cpf}</td>
				<td id="tdemail${idx.index}">${student.email}
					<input id="tdid${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${student.id}'></fmt:formatNumber>" />
					<input id="tdrg${idx.index}" type="hidden" value="${student.rg}" />
					<input id="tdbirth${idx.index}" type="hidden" value="${student.birthDate}" />
					<input id="tdschooling${idx.index}" type="hidden" value="${student.schooling}" />
					<input id="tdprofId${idx.index}" type="hidden" value="${student.profId}" />
					<input id="tdprofName${idx.index}" type="hidden" value="${student.profName}" />
					<input id="tdtel${idx.index}" type="hidden" value="${student.tel}" />
					<input id="tdcel${idx.index}" type="hidden" value="${student.cel}" />
					<input id="tdcep${idx.index}" type="hidden" value="${student.cep}" />
					<input id="tdend${idx.index}" type="hidden" value="${student.address}" />
					<input id="tdnumber${idx.index}" type="hidden" value="${student.numberHouse}" />
					<input id="tdneighborhood${idx.index}" type="hidden" value="${student.neighborhood}" />
					<input id="tdmedia${idx.index}" type="hidden" value="${student.media}" />
					<input id="tdobs${idx.index}" type="hidden" value="${student.obs}" />
					<input id="tdcityId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${student.cityId}'></fmt:formatNumber>" />
					<input id="tdcityName${idx.index}" type="hidden" value="${student.cityName}" />
					<input id="tdstateId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${student.stateId}'></fmt:formatNumber>" />
					<input id="tdstateUF${idx.index}" type="hidden" value="${student.stateUF}" />
					<input id="tdcomplement${idx.index}" type="hidden" value="${student.complement}" />
					<input id="tdfiliation${idx.index}" type="hidden" value="${student.filiation}" />
				</td>
				<td id="tdtype${idx.index}">${student.type}</td>
				<td>
					<a onclick="view(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-search" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="switchEdit(${idx.index})" style="height:17px;width:26px;"  href="#" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-pencil" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="del(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Desativar" class="ui-icon ui-icon-cancel" style="margin-left: -7px;margin-top: -5px;"></span></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>