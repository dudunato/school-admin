<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<script type="text/javascript">
$("td a").button();

$('#tbteachers').dataTable({
	"bJQueryUI": true,
	"oLanguage": {
		"sSearch": "Busca:",
		"sInfo": "_START_ à _END_ de _TOTAL_ Professores",
		"sLengthMenu": "Mostrar _MENU_ ",
		"sEmptyTable": "Não existe professores cadastrados.",
		"sZeroRecords": "Nenhum professor encontrado.",
		"sInfoFiltered": ""
	},
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 4 ]
	} ],
});

$("#tbteachers_filter").children("label").children("input").css("width", "350px");
</script>


<table id="tbteachers">
	<thead>
		<tr> 
			<th>Nome</th>
			<th>CPF</th>
			<th>Especialidade</th>
			<th>Email</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="teacher" items="${listTeacher}" varStatus="idx">
			<tr>
				<td id='tdname${idx.index}'>${teacher.name}</td>
				<td id="tdcpf${idx.index}">${teacher.cpf}</td>
				<td id="tdspec${idx.index}">${teacher.specialty}</td>
				<td id="tdemail${idx.index}">${teacher.email} 
					<input id="tdid${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${teacher.id}'></fmt:formatNumber>" />
					<input id="tdrg${idx.index}" type="hidden" value="${teacher.rg}" />
					<input id="tdbirth${idx.index}" type="hidden" value="${teacher.birthDate}" />
					<input id="tdmei${idx.index}" type="hidden" value="${teacher.mei}" />
					<input id="tdtel${idx.index}" type="hidden" value="${teacher.tel}" />
					<input id="tdcel${idx.index}" type="hidden" value="${teacher.cel}" />
					<input id="tdcep${idx.index}" type="hidden" value="${teacher.cep}" />
					<input id="tdend${idx.index}" type="hidden" value="${teacher.address}" />
					<input id="tdnumber${idx.index}" type="hidden" value="${teacher.numberHouse}" />
					<input id="tdneighborhood${idx.index}" type="hidden" value="${teacher.neighborhood}" />
					<input id="tdobs${idx.index}" type="hidden" value="${teacher.obs}" />
				</td>
				<td>
					<a onclick="view(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-search" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="switchEdit(${idx.index})" style="height:17px;width:26px;"  href="#" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-pencil" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<a onclick="del(${idx.index})" style="height:17px;width:26px;"  href="javascript:void(0)" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Deletar" class="ui-icon ui-icon-trash" style="margin-left: -7px;margin-top: -5px;"></span></a>
				</td>
			</tr>
		</c:forEach>
 	</tbody>
</table>
