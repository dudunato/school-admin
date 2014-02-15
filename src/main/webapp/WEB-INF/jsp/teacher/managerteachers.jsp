<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<tiles:insertTemplate template="/default.jsp">

<tiles:putAttribute name="head">
<style type="text/css">

#panel{
    margin: 2% auto auto;
    padding-bottom: 15px;
    position: relative;
    width: 930px;
}

.fieldsetclass {
	border: 1px solid #CCCCCC;
    border-radius: 4px 4px 4px 4px;
    height: 100%;
    margin: auto;
    padding: 10px;
    width: 800px;
    margin-top: 10px;
}

#grid {
	margin: 20px auto auto;
    width: 822px;
    height: 276px;
    border-radius: 4px 4px 4px 4px;
    border: 1px solid #CCCCCC;
}

#tbteachers{
	border-collapse: collapse;
    text-align: center;
    width: 100%;
    font-size: 11px;
}

#tbteachers_wrapper{
	margin: auto;
    width: 822px;
}

#tbteachers_length{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbteachers_filter{
	float: right;
    margin: 4px;
    font-size: 12px;
}

#tbteachers_info{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbteachers_paginate{
	float: right;
    margin: 4px;
}

#tbview td {
	padding: 2px;
	font-size: 11px;
}

table thead th div.DataTables_sort_wrapper {
	position: relative;
	padding-right: 20px;
	padding-right: 20px;
	cursor: pointer;
}

table thead th div.DataTables_sort_wrapper span {
	position: absolute;
	top: 50%;
	margin-top: -8px;
	right: 0;
}

table#tbteachers tbody tr:nth-child(odd) {
	background-color: #FFFFFF;
}

table#tbteachers tbody tr:nth-child(even) {
	background-color: #E8E8E8;
}

table#tbteachers tbody tr:nth-child(odd):hover,table#tbteachers tbody tr:nth-child(even):hover{
	background-color: orange;
	color: #ffffff;
}

legend {
	color: #544E41;
    font-size: 15px;
    margin: 2px;
}

</style>
</tiles:putAttribute>

<tiles:putAttribute name="js">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.maskedinput-1.2.2.min.js"></script>
<script type="text/javascript">

function TeacherController(){ DJR.call(this); }
TeacherController.prototype.routes = {
	"save":{
		url: "${pageContext.request.contextPath}/teacher/save", method: "POST"
	},
	"edit":{
		url: "${pageContext.request.contextPath}/teacher/edit", method: "POST"
	},
	"del":{
		url: "${pageContext.request.contextPath}/teacher/delete", method: "POST"
	}
}

var controller = new TeacherController();

$(function() {
	
	$('.mandatory').focus(function(e) {
		$(this).removeClass("ui-state-error");
	});
	
	$("#birth, #birthEdit").datepicker({
		dateFormat:"dd/mm/yy",
		changeMonth: true,
		changeYear: true,
		yearRange: '-100y:c+nn',
        maxDate: '-1d',
		showOn : "button",
		buttonImage : "${pageContext.request.contextPath}/images/calendar.png",
		buttonImageOnly : true,
		dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
	    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
	    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
	    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
	    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
	    nextText: 'Próximo',
	    prevText: 'Anterior'
	});
	
	$('.ui-datepicker-trigger').attr('style','display: block;margin-left: 138px;margin-top: -19px;');
	
	$("#cpf, #cpfEdit").mask("999.999.999-99");
	$("#tel, #telEdit, #cel, #celEdit").mask("(99)9999-9999");
	$("#cep, #cepEdit").mask("99999-999");
	$("#number, #numberEdit").mask("9?999");
	
	loadGrid();
});

function save(){
	
	if (validations('fieldsetCad')) {
		$("#msgDesc").text("Deseja cadastrar este Professor?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.save(
							{"teacher":{
						            "name": $('#name').val(),
						            "rg": $('#rg').val(),
						            "cpf": $('#cpf').val(),
						            "birthDate" : $('#birth').val(),
						            "specialty" : ($('#spec').val() == '-1') ? "" : $('#spec').val(),
						            "mei" : $('#mei').val(),
						            "email" : $('#email').val().trim(),
						            "tel" : $('#tel').val(),
						            "cel" : $('#cel').val(),
						            "cep" : $('#cep').val(),
						            "address" : $('#end').val(),
						            "numberHouse" : $('#number').val(),
						            "neighborhood" : $('#neighborhood').val(),
						            "obs" : $('#obs').val(),
						            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Professor cadastrado com sucesso.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					clearFields();
						    					$(this).dialog( "close" );
						    					loadGrid();
						    				}
						    			}
						    		});
						    	}else{
						    		$("#msgDesc").text("Houve um erro ao cadastrar o Professor.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					$(this).dialog( "close" );
						    				}
						    			}
						    		});
						    	}
						    }
					);
				},
				Cancel: function () {
					$(this).dialog( "close" );
				}
			}
		});	
	}
}

function edit(){
	
	if (validations('fieldsetEdit')) {
		$("#msgDesc").text("Deseja editar este Professor?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.edit(
							{"teacher":{
								"id" : $('#idEdit').val(),
					            "name": $('#nameEdit').val(),
					            "rg": $('#rgEdit').val(),
					            "cpf": $('#cpfEdit').val(),
					            "birthDate" : $('#birthEdit').val(),
					            "specialty" : ($('#specEdit').val() == '-1') ? "" : $('#specEdit').val(),
					            "mei" : $('#meiEdit').val(),
					            "email" : $('#emailEdit').val().trim(),
					            "tel" : $('#telEdit').val(),
					            "cel" : $('#celEdit').val(),
					            "cep" : $('#cepEdit').val(),
					            "address" : $('#endEdit').val(),
					            "numberHouse" : $('#numberEdit').val(),
					            "neighborhood" : $('#neighborhoodEdit').val(),
					            "obs" : $('#obsEdit').val(),
					            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$('#fieldsetEdit').hide();
			    					$('#fieldsetCad').show('slide', 120);
						    		$("#msgDesc").text("Professor editado com sucesso.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					clearFields();
						    					$(this).dialog( "close" );
						    					loadGrid();
						    				}
						    			}
						    		});
						    	}else{
						    		$("#msgDesc").text("Houve um erro ao editar o Professor.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					$(this).dialog( "close" );
						    				}
						    			}
						    		});
						    	}
						    }
					);
				},
				Cancel: function () {
					$(this).dialog( "close" );
				}
			}
		});	
	}
}

function del(n){
	
	$("#msgDesc").text("Deseja deletar este Professor?");
	$("#boxMsg").dialog({
		resizable: false,
		height:180,
		modal: true,
		buttons: {
			Ok: function() {
				lockSetButton();
				$('#loader').css('display', 'block');
				controller.del(
						{
							"id" : $('#tdid' + n).val(),
					    },
					    function(data){
					    	if(data.string == "success"){
					    		$('#loader').hide();
					    		$("#msgDesc").text("Professor deletado com sucesso.");
					    		$("#boxMsg").dialog({
					    			resizable: false,
					    			height:180,
					    			modal: true,
					    			buttons: {
					    				Ok: function() {
					    					clearFields();
					    					$(this).dialog( "close" );
					    					loadGrid();
					    				}
					    			}
					    		});
					    	}else{
					    		$('#loader').hide();
					    		$("#msgDesc").text("Houve um erro ao deletar o Professor.");
					    		$("#boxMsg").dialog({
					    			resizable: false,
					    			height:180,
					    			modal: true,
					    			buttons: {
					    				Ok: function() {
					    					$(this).dialog( "close" );
					    				}
					    			}
					    		});
					    	}
					    }
				);
			},
			Cancel: function () {
				$(this).dialog( "close" );
			}
		}
	});
}

function switchEdit(n){
	clearFields();
	
	$('#idEdit').val($('#tdid' + n).val());
	$('#nameEdit').val($('#tdname' + n).text());
	$('#rgEdit').val($('#tdrg' + n).val());
	$('#cpfEdit').val($('#tdcpf' + n).text());
	$('#birthEdit').val($('#tdbirth' + n).val());
	$('#specEdit').val($('#tdspec' + n).text());
	$('#meiEdit').val($('#tdmei' + n).val());
	$('#emailEdit').val($('#tdemail' + n).text());
	$('#telEdit').val($('#tdtel' + n).val());
	$('#celEdit').val($('#tdcel' + n).val());
	$('#cepEdit').val($('#tdcep' + n).val());
	$('#endEdit').val($('#tdend' + n).val());
	$('#numberEdit').val($('#tdnumber' + n).val());
	$('#neighborhoodEdit').val($('#tdneighborhood' + n).val());
	$('#obsEdit').val($('#tdobs' + n).val());
	
	$('#fieldsetCad').hide();
	$('#fieldsetEdit').show('slide', 150);
}

function view(n){
	
	$('#nameView').text($('#tdname' + n).text());
	$('#rgView').text($('#tdrg' + n).val());
	$('#cpfView').text($('#tdcpf' + n).text());
	$('#birthView').text($('#tdbirth' + n).val());
	$('#specView').text($('#tdspec' + n).text());
	$('#meiView').text($('#tdmei' + n).val());
	$('#emailView').text($('#tdemail' + n).text());
	$('#telView').text($('#tdtel' + n).val());
	$('#celView').text($('#tdcel' + n).val());
	$('#cepView').text($('#tdcep' + n).val());
	$('#endView').text($('#tdend' + n).val());
	$('#numberView').text($('#tdnumber' + n).val());
	$('#neighborhoodView').text($('#tdneighborhood' + n).val());
	$('#obsView').text($('#tdobs' + n).val());
	
	$("#view").dialog({
		resizable: false,
		height:200,
		width: 800,
		modal: false,
		buttons: {
			Ok: function() {
				$(this).dialog( "close" );
			}
		}
	});
}

function loadGrid(){
	$('#tbteachers_wrapper').remove();
	$('#gridload').show();
	$('#gdiv').load('${pageContext.request.contextPath}/teacher/gridteachers', function() {
		$('#gdiv').hide();
		$('#gridload').hide();
		$('#gdiv').fadeIn('slow');
		$('#grid').css('height','auto');
	});
	
}

function validations(fieldset){
	
	var val = 0;
	
	$("#" +fieldset+ " input[type='text'],#"+fieldset+ " select").each(function(){
	    if($(this).val() == "" || $(this).val() == "-1"){
	        if($(this).hasClass('mandatory')){
		        $(this).addClass("ui-state-error");
		        val++;
	        }
	    }
	});
	
	
	if(val != 0){
		$("#msgDesc").text("Preencha os campos obrigatórios (*).");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					$(this).dialog( "close" );
				}
			}
		});
		
		return false;
	}
	
	if(fieldset == 'fieldsetCad'){
		if(!$.validateEmail($('#email').val())){
			$('#email').addClass("ui-state-error");
			
			$("#msgDesc").text("Email inválido.");
			$("#boxMsg").dialog({
				resizable: false,
				height:180,
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog( "close" );
						$('#email').focus();
					}
				}
			});
			
			return false;
		}
	}else{
		if(!$.validateEmail($('#emailEdit').val())){
			$('#emailEdit').addClass("ui-state-error");
			
			$("#msgDesc").text("Email inválido.");
			$("#boxMsg").dialog({
				resizable: false,
				height:180,
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog( "close" );
						$('#emailEdit').focus();
					}
				}
			});
			
			return false;
		}
	}
	
	return true;
}

$.validateEmail = function (email){

    er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;

    if(er.exec(email))
        return true;
    else
        return false;

};


function clearFields(){
	$('input:text, input:password, textarea').val('');
	$('select').val('-1');
	$('select').removeClass('ui-state-error');
	$('input:text, input:password').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
}
</script>
</tiles:putAttribute>

<tiles:putAttribute name="content">

	<div id="panel" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
        <span class="panel-title">Gerenciar Professores</span>

		<fieldset id="fieldsetCad" class="fieldsetclass">
			<legend>Cadastrar Professor</legend>
			
			<label style="float: left;margin-left: 10px;width: 290px;">Nome*: <input id="name" style="width: 280px; display: block;"   type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 36px;width: 140px;">RG*: <input id="rg" style="display: block;text-transform: uppercase;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 177px;">CPF*: <input id="cpf" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 160px;">Data de Nasc.*: <input id="birth" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory "> </label>
			<label style="float: left;margin-left: 166px;margin-top: 3px;width: 166px;">
				Espec.*: <select id="spec"  style="width: 145px;display: block;" class="mandatory">
							<option selected="selected" value="-1">Selecione... </option>
							<c:choose>
								<c:when test="${ user.schoolId == 1 }">
									<option value="Ingl&ecirc;s Instrumental">Ingl&ecirc;s Instrumental</option>
									<option value="Ingl&ecirc;s Conversa&ccedil;&atilde;o">Ingl&ecirc;s Conversa&ccedil;&atilde;o</option>
									<option value="Tradu&ccedil;&atilde;o">Tradu&ccedil;&atilde;o</option>
									<option value="Tradu&ccedil;&atilde;o Simult&acirc;nea">Tradu&ccedil;&atilde;o Simult&acirc;nea</option>
								</c:when>
								<c:otherwise>
									<option value="Matem&aacute;tica">Matem&aacute;tica</option>
									<option value="Qu&iacute;mica">Qu&iacute;mica</option>
									<option value="F&iacute;sica">F&iacute;sica</option>
									<option value="Portugu&ecirc;s">Portugu&ecirc;s</option>
									<option value="Reda&ccedil;&atilde;o">Reda&ccedil;&atilde;o</option>
									<option value="Literatura">Literatura</option>
									<option value="Geografia">Geografia</option>
									<option value="Hist&oacute;ria">Hist&oacute;ria</option>
									<option value="Filosofia">Filosofia</option>
									<option value="Sociologia">Sociologia</option>
									<option value="Franc&ecirc;s">Franc&ecirc;s</option>
									<option value="Italiano">Italiano</option>
									<option value="Espanhol">Espanhol</option>
								</c:otherwise>
							</c:choose>
							<option value="Outros">Outros</option>
						</select>
			</label>
			<label style="float: left;margin-left: 151px;margin-top: 3px;width: 140px;">MEI: <input  id="mei" style="display: block;text-transform: uppercase;" type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 212px;">Email*: <input id="email" style="width: 205px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 114px;margin-top: 3px;width: 120px;">Telefone: <input id="tel" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="float: left;margin-left: 197px;margin-top: 3px;">Cel: <input id="cel" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 115px;">CEP*: <input  id="cep" style="width: 104px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 211px;margin-top: 3px;width: 285px;">End.*: <input id="end" style="width: 280px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 32px;margin-top: 3px;">N&ordm;*: <input id="number" style="width: 40px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 10px;margin-top: 3px;">Bairro*: <input id="neighborhood" style="width: 104px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 219px;margin-top: 3px;">OBS.:
				<textarea id="obs" style="display:block;height: 40px;width: 306px;" rows="" cols="" class="text ui-widget-content ui-corner-all"></textarea>
			</label>  
			
			<div style="clear: left;margin: auto;padding-top: 15px;width: 134px;">
				<input  type="button" value="Salvar" style="font-size: 10px;font-weight: bold;width: 63px;" onclick="save();">
				<input type="button" value="Cancelar" style="font-size: 10px; font-weight: bold;width: 63px;" onclick="javascript:$('#fieldsetEdit').hide();$('#fieldsetCad').show('slide', 120);clearFields();">
			</div>
		</fieldset>
		
		<fieldset id="fieldsetEdit" class="fieldsetclass" style="display: none">
			<legend>Editar Professor</legend>
			
			<input id="idEdit" type="hidden">
			<label style="float: left;margin-left: 10px;width: 290px;">Nome*: <input id="nameEdit" style="width: 280px; display: block;"   type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 36px;width: 140px;">RG*: <input id="rgEdit" style="display: block;text-transform: uppercase;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 177px;">CPF*: <input id="cpfEdit" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 160px;">Data de Nasc.*: <input id="birthEdit" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory "> </label>
			<label style="float: left;margin-left: 166px;margin-top: 3px;width: 166px;">
				Espec.*: <select id="specEdit"  style="width: 145px;display: block;" class="mandatory">
							<option selected="selected" value="-1">Selecione... </option>
							<c:choose>
								<c:when test="${ user.schoolId == 1 }">
									<option value="Ingl&ecirc;s Instrumental">Ingl&ecirc;s Instrumental</option>
									<option value="Ingl&ecirc;s Conversa&ccedil;&atilde;o">Ingl&ecirc;s Conversa&ccedil;&atilde;o</option>
									<option value="Tradu&ccedil;&atilde;o">Tradu&ccedil;&atilde;o</option>
									<option value="Tradu&ccedil;&atilde;o Simult&acirc;nea">Tradu&ccedil;&atilde;o Simult&acirc;nea</option>
								</c:when>
								<c:otherwise>
									<option value="Matem&aacute;tica">Matem&aacute;tica</option>
									<option value="Qu&iacute;mica">Qu&iacute;mica</option>
									<option value="F&iacute;sica">F&iacute;sica</option>
									<option value="Portugu&ecirc;s">Portugu&ecirc;s</option>
									<option value="Reda&ccedil;&atilde;o">Reda&ccedil;&atilde;o</option>
									<option value="Literatura">Literatura</option>
									<option value="Geografia">Geografia</option>
									<option value="Hist&oacute;ria">Hist&oacute;ria</option>
									<option value="Filosofia">Filosofia</option>
									<option value="Sociologia">Sociologia</option>
									<option value="Franc&ecirc;s">Franc&ecirc;s</option>
									<option value="Italiano">Italiano</option>
									<option value="Espanhol">Espanhol</option>
								</c:otherwise>
							</c:choose>
							<option value="Outros">Outros</option>
						</select>
			</label>
			<label style="float: left;margin-left: 151px;margin-top: 3px;width: 140px;">MEI: <input  id="meiEdit" style="display: block;text-transform: uppercase;" type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 212px;">Email*: <input id="emailEdit" style="width: 205px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 114px;margin-top: 3px;width: 120px;">Telefone: <input id="telEdit" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="float: left;margin-left: 197px;margin-top: 3px;">Cel: <input id="celEdit" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 115px;">CEP*: <input  id="cepEdit" style="width: 104px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 211px;margin-top: 3px;width: 285px;">End.*: <input id="endEdit" style="width: 280px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 32px;margin-top: 3px;">N&ordm;*: <input id="numberEdit" style="width: 40px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 10px;margin-top: 3px;">Bairro*: <input id="neighborhoodEdit" style="width: 104px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 219px;margin-top: 3px;">OBS.:
				<textarea id="obsEdit" style="display:block;height: 40px;width: 306px;" rows="" cols="" class="text ui-widget-content ui-corner-all"></textarea>
			</label>
			 
			<div style="clear: left;margin: auto;padding-top: 15px;width: 134px;">
				<input  type="button" value="Editar" style="font-size: 10px;font-weight: bold;width: 63px;" onclick="edit();">
				<input type="button" value="Cancelar" style="font-size: 10px; font-weight: bold;width: 63px;" onclick="javascript:$('#fieldsetEdit').hide();$('#fieldsetCad').show('slide', 120);clearFields();">
			</div>
		</fieldset>
		
		<div id="grid">
			<img id="gridload" style="display: block;height: 16px;margin: 125px auto auto;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<div id="gdiv"></div>
		</div>
		
		<div title="Professor" id="view" style="display: none;">
			<table id="tbview" style="width: 685px; margin: auto;">
				<tr>
					<td style="font-weight: bold;text-align: right;">Nome: </td>
					<td id="nameView"></td>
					<td style="font-weight: bold;text-align: right;"> RG: </td>
					<td id="rgView"></td>
					<td style="font-weight: bold;text-align: right;">CPF: </td>
					<td id="cpfView"></td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">Data de Nasc: </td>
					<td id="birthView"></td>
					<td style="font-weight: bold;text-align: right;">Espec.: </td>
					<td id="specView"> </td>
					<td style="font-weight: bold;text-align: right;">MEI: </td>
					<td id="meiView"> </td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">Email: </td>
					<td id="emailView"> </td>
					<td style="font-weight: bold;text-align: right;">Telefone: </td>
					<td id="telView"> </td>
					<td style="font-weight: bold;text-align: right;">Cel: </td>
					<td id="celView"></td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">CEP: </td>
					<td id="cepView"> </td>
					<td style="font-weight: bold;text-align: right;">End.: </td>
					<td id="endView"> </td>
					<td style="font-weight: bold;text-align: right;">N&ordm;: </td>
					<td id="numberView"></td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">Bairro: </td>
					<td id="neighborhoodView"> </td>
					<td style="font-weight: bold;text-align: right;">OBS.: </td>
					<td id="obsView"> </td>
				</tr>
			</table>
		</div>
		
	</div>

</tiles:putAttribute>

</tiles:insertTemplate>