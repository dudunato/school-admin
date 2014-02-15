<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<script type="text/javascript">
$("td a").button();

$('#tbcontracts').dataTable({
	"bJQueryUI": true,
	"oLanguage": {
		"sSearch": "Busca:",
		"sInfo": "_START_ à _END_ de _TOTAL_ Contratos",
		"sLengthMenu": "Mostrar _MENU_ ",
		"sEmptyTable": "Não existe Contratos cadastrados.",
		"sZeroRecords": "Nenhum Contrato encontrado.",
		"sInfoFiltered": ""
	},
	"aoColumnDefs" : [ {
		"bSortable" : false,
		"aTargets" : [ 5 ]
	} ]
});

$("#tbcontracts_filter").children("label").children("input").css("width", "350px");
</script>

<table id="tbcontracts">
	<thead>
		<tr> 
			<th>Aluno</th>
			<th>Ínicio Contrato</th>
			<th>Fim Contrato</th>
			<th>Mensalidade</th>
			<th>Valor Total</th>
			<th>A&ccedil;&otilde;es</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="contract" items="${listContract}" varStatus="idx">
			<tr>
				<td id="tdstudent${idx.index}">${contract.studentName} <input id="tdstudentId${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${contract.studentID}'></fmt:formatNumber>"></td>
				<td id="tdstart${idx.index}">${contract.beginDate}</td>
				<td id="tdend${idx.index}">${contract.endDate}</td>
				<td id="tdmonthly${idx.index}">${contract.monthlyPaymentValue}</td>
				<td id="tdtotalvalue${idx.index}">${contract.totalValue}
					<input id="tdidContract${idx.index}" type="hidden" value="<fmt:formatNumber type='number' value='${contract.id}'></fmt:formatNumber>">
					<input id="tdinputvalue${idx.index}" type="hidden" value="${contract.entryValue}">
					<input id="tdmonthlyalternative${idx.index}" type="hidden" value="${contract.alternativePaymentValue}">
				</td>
				<td> 
					<a onclick="switchEdit(${idx.index})" style="height:17px;width:26px;"  href="#" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Editar" class="ui-icon ui-icon-pencil" style="margin-left: -7px;margin-top: -5px;"></span></a>
					<%--<a onclick="" style="height:17px;width:26px;" target="_blank"  href="${pageContext.request.contextPath}/contracts/printcontract/<fmt:formatNumber type='number' value='${contract.studentID}'></fmt:formatNumber>" class="fg-button fg-button-icon-left ui-state-default ui-corner-all"><span title="Imprimir" class="ui-icon ui-icon-print" style="margin-left: -7px;margin-top: -5px;"></span></a>--%>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>