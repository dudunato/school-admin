<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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

#tbstudents{
	border-collapse: collapse;
    text-align: center;
    width: 100%;
    font-size: 11px;
}

#tbstudents_wrapper{
	margin: auto;
    width: 822px;
}

#tbstudents_length{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbstudents_filter{
	float: right;
    margin: 4px;
    font-size: 12px;
}

#tbstudents_info{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbstudents_paginate{
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

table#tbstudents tbody tr:nth-child(odd) {
	background-color: #FFFFFF;
}

table#tbstudents tbody tr:nth-child(even) {
	background-color: #E8E8E8;
}

table#tbstudents tbody tr:nth-child(odd):hover,table#tbstudents tbody tr:nth-child(even):hover{
	background-color: orange;
    margin: 2px;
}

.fg-toolbar {
	height: 30px !important;
}

.DTTT_container {
	float: left;
	margin-left: 5px;
    margin-top: 5px;
}

#ToolTables_tbstudents_0 {
	height: 17px;
    width: 42px;
}

.ui-button { margin-left: -1px; }
.ui-button-icon-only .ui-button-text { padding: 0.35em; } 
.ui-autocomplete-input {
	font-family: Trebuchet MS !important;
    height: 17px;
    margin: 0;
    width: 230px;
    border: 1px solid #D19405;
    float: left;
    display: block;
}
button.ui-button-icon-only {
    height: 21px;
    width: 26px;
    float: left;
    display: block;
}
</style>
</tiles:putAttribute>

<tiles:putAttribute name="js">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/TableTools.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.maskedinput-1.2.2.min.js"></script>
<script type="text/javascript">

function StudentsController(){ DJR.call(this); }
StudentsController.prototype.routes = {
	"save":{
		url: "${pageContext.request.contextPath}/students/save", method: "POST"
	},
	"edit":{
		url: "${pageContext.request.contextPath}/students/edit", method: "POST"
	},
	"del":{
		url: "${pageContext.request.contextPath}/students/delete", method: "POST"
	}
}

var controller = new StudentsController();

$(function() {
	
	$('.mandatory').focus(function(e) {
		$(this).removeClass("ui-state-error");
	});
	
	$("#birth").datepicker({
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
	
	$.widget( "ui.combobox", {
		_create: function() {
			var self = this,
				select = this.element.hide(),
				selected = select.children( ":selected" ),
				value = selected.val() ? selected.text() : "";
			var input = this.input = $( "<input>" )
				.insertAfter( select )
				.val( value )
				.autocomplete({
					delay: 0,
					minLength: 0,
					source: function( request, response ) {
						var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
						response( select.children( "option" ).map(function() {
							var text = $( this ).text();
							if ( this.value && ( !request.term || matcher.test(text) ) )
								return {
									label: text.replace(
										new RegExp(
											"(?![^&;]+;)(?!<[^<>]*)(" +
											$.ui.autocomplete.escapeRegex(request.term) +
											")(?![^<>]*>)(?![^&;]+;)", "gi"
										), "<strong>$1</strong>" ),
									value: text,
									option: this
								};
						}) );
					},
					select: function( event, ui ) {
						ui.item.option.selected = true;
						self._trigger( "selected", event, {
							item: ui.item.option
						});
					},
					change: function( event, ui ) {
						if ( !ui.item ) {
							var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
								valid = false;
							select.children( "option" ).each(function() {
								if ( $( this ).text().match( matcher ) ) {
									this.selected = valid = true;
									return false;
								}
							});
							if ( !valid ) {
								// remove invalid value, as it didn't match anything
								$( this ).val( "" );
								select.val( "" );
								input.data( "autocomplete" ).term = "";
								return false;
							}
						}
					}
				})
				.addClass( "ui-widget ui-widget-content ui-corner-left" );

			input.data( "autocomplete" )._renderItem = function( ul, item ) {
				return $( "<li></li>" )
					.data( "item.autocomplete", item )
					.append( "<a>" + item.label + "</a>" )
					.appendTo( ul );
			};

			this.button = $( "<button type='button'>&nbsp;</button>" )
				.attr( "tabIndex", -1 )
				.attr( "title", "Show All Items" )
				.insertAfter( input )
				.button({
					icons: {
						primary: "ui-icon-triangle-1-s"
					},
					text: false
				})
				.removeClass( "ui-corner-all" )
				.addClass( "ui-corner-right ui-button-icon" )
				.click(function() {
					// close if already visible
					if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
						input.autocomplete( "close" );
						return;
					}

					// work around a bug (likely same cause as #5265)
					$( this ).blur();

					// pass empty string as value to search for, displaying all results
					input.autocomplete( "search", "" );
					input.focus();
				});
		},

		destroy: function() {
			this.input.remove();
			this.button.remove();
			this.element.show();
			$.Widget.prototype.destroy.call( this );
		}
	});
	
	$('.ui-datepicker-trigger').attr('style','display: block;margin-left: 138px;margin-top: -19px;');
	
	$('#city, #prof').combobox();
	$('#state').combobox({
		 selected: function(event, ui) {
			 loadCity($('#state').val());
         }
	});
	$('#statelabel').children('span').children('input').css('width','30px');
	$('#citylabel').children('span').children('input').css('width','131px');
	$('#proflabel').children('span').children('input').css('width','131px');
    $('#statelabel').children('span').children('input').addClass('mandatory');
    $('#citylabel').children('span').children('input').addClass('mandatory');
    $('#proflabel').children('span').children('input').addClass('mandatory');
	
	$("#cpf").mask("999.999.999-99");
	$("#tel, #cel").mask("(99)9999-9999");
	$("#cep").mask("99999-999");
	$("#number").mask("9?999");
	
	$("#type-student-div").buttonset();
	
	loadGrid();
	loadProf();
	loadState();
	disableCombo('#citylabel');
	
	<c:if test="${!empty activate }">
		$('#legendCad').text('Ativar Aluno');
		$('#btnSave').attr('value','Ativar');
		$('#btnSave').attr('onclick','edit()');
	</c:if>
	
});

function save(){
	
	if (validations('fieldsetCad')) {
		$("#msgDesc").text("Deseja cadastrar este Aluno?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.save(
							{"student":{
						            "name": $('#name').val(),
						            "rg": $('#rg').val(),
						            "cpf": $('#cpf').val(),
						            "birthDate" : $('#birth').val(),
						            "schooling" : ($('#schooling').val() == '-1') ? "" : $('#schooling').val(),
						            "profId" : $('#prof').val().trim(),
						            "email" : $('#email').val().trim(),
						            "tel" : $('#tel').val(),
						            "cel" : $('#cel').val(),
						            "cityId" : $('#city').val(),
						            "cep" : $('#cep').val(),
						            "address" : $('#end').val(),
						            "numberHouse" : $('#number').val(),
						            "complement" : $('#comp').val(),
						            "neighborhood" : $('#neighborhood').val(),
						            "media" : ($('#media').val() == '-1') ? "" : $('#media').val(),
						            "obs" : $('#obs').val(),
						            "filiation" : $('#filiation').val(),
						            "type" : $("input[name=type-student]:checked").val(),
                                    "status" : "ATIVO"
						            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Aluno cadastrado com sucesso.");
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
						    		$("#msgDesc").text("Houve um erro ao cadastrar o Aluno.");
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
	
	if (validations('fieldsetCad')) {
		if ($('#btnSave').attr('value') == 'Ativar') {
			$("#msgDesc").text("Deseja ativar este Aluno?");
		} else {
			$("#msgDesc").text("Deseja editar este Aluno?");
		}
		
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.edit(
							{"student":{
								"id" : $('#idEdit').val(),
								"name": $('#name').val(),
						        "rg": $('#rg').val(),
						        "cpf": $('#cpf').val(),
						        "birthDate" : $('#birth').val(),
						        "schooling" : ($('#schooling').val() == '-1') ? "" : $('#schooling').val(),
						        "profId" : $('#prof').val().trim(),
						        "email" : $('#email').val().trim(),
						        "tel" : $('#tel').val(),
						        "cel" : $('#cel').val(),
						        "cityId" : $('#city').val(),
						        "cep" : $('#cep').val(),
						        "address" : $('#end').val(),
						        "numberHouse" : $('#number').val(),
						        "complement" : $('#comp').val(),
						        "neighborhood" : $('#neighborhood').val(),
						        "media" : ($('#media').val() == '-1') ? "" : $('#media').val(),
						        "obs" : $('#obs').val(),
						        "filiation" : $('#filiation').val(),
						        "type" : $("input[name=type-student]:checked").val(),
						        "status" : "ATIVO"
					            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$('#fieldsetEdit').hide();
			    					$('#fieldsetCad').show('slide', 120);
			    					if ($('#btnSave').attr('value') == 'Ativar') {
			    						$("#msgDesc").text("Aluno ativado com sucesso.");
			    					} else {
							    		$("#msgDesc").text("Aluno editado com sucesso.");
			    					}
			    					
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
						    		if ($('#btnSave').attr('value') == 'Ativar') {
						    			$("#msgDesc").text("Houve um erro ao ativar o Aluno.");
						    		} else {
							    		$("#msgDesc").text("Houve um erro ao editar o Aluno.");
						    		}
						    		
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
	
	$("#msgDesc").text("Deseja desativar este Aluno?");
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
							"id" : $('#tdid' + n).val()
					    },
					    function(data){
					    	if(data.string == "success"){
					    		$('#loader').hide();
					    		$("#msgDesc").text("Aluno desativado com sucesso.");
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
					    		$("#msgDesc").text("Houve um erro ao desativar o Aluno.");
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
	$('#name').val($('#tdname' + n).text());
	$('#rg').val($('#tdrg' + n).val());
	$('#cpf').val($('#tdcpf' + n).text());
	$('#birth').val($('#tdbirth' + n).val());
	$('#schooling').val($('#tdschooling' + n).val());
	$('#company').val($('#tdcompany' + n).val());
	$('#email').val($('#tdemail' + n).text());
	$('#tel').val($('#tdtel' + n).val());
	$('#cel').val($('#tdcel' + n).val());
	$('#cep').val($('#tdcep' + n).val());
	$('#end').val($('#tdend' + n).val());
	$('#number').val($('#tdnumber' + n).val());
	$('#neighborhood').val($('#tdneighborhood' + n).val());
	$('#media').val($('#tdmedia' + n).val());
	$('#obs').val($('#tdobs' + n).val());
	$('#tdtype' + n).text() == "VIP" ? $("#type2").click() : $("#type1").click();
	$('#state').val($('#tdstateId' + n).val());
	$('#statelabel').children('span').children('input').val($('#tdstateUF' + n).val());
	
	if ($('#tdstateId' + n).val().trim() != '') {
		$('#cityLoader').css('display', 'block');
		$('#city').load('${pageContext.request.contextPath}/cityState/cities', {stateId: $('#tdstateId' + n).val()}, function() {
			$('#cityLoader').css('display', 'none');
			enableCombo('#citylabel');
			$('#city').val($('#tdcityId' + n).val());
			$('#citylabel').children('span').children('input').val($('#tdcityName' + n).val());
		});
	}
	
	$('#comp').val($('#tdcomplement' + n).val());
	$('#filiation').val($('#tdfiliation' + n).val());
	$('#prof').val($('#tdprofId' + n).val());
	$('#proflabel').children('span').children('input').val($('#tdprofName' + n).val());
	
	$('#legendCad').text('Editar Aluno');
	$('#btnSave').attr('value','Editar');
	$('#btnSave').attr('onclick','edit()');
	
	$('#fieldsetCad').show('slide', 150);
}

function view(n){
	
	$('#nameView').text($('#tdname' + n).text());
	$('#rgView').text($('#tdrg' + n).val());
	$('#cpfView').text($('#tdcpf' + n).text());
	$('#birthView').text($('#tdbirth' + n).val());
	$('#schoolingView').text($('#tdschooling' + n).val());
	$('#companyView').text($('#tdcompany' + n).val());
	$('#emailView').text($('#tdemail' + n).text());
	$('#telView').text($('#tdtel' + n).val());
	$('#celView').text($('#tdcel' + n).val());
	$('#cepView').text($('#tdcep' + n).val());
	$('#stateView').text($('#tdstateUF' + n).val());
	$('#cityView').text($('#tdcityName' + n).val());
	$('#endView').text($('#tdend' + n).val());
	$('#numberView').text($('#tdnumber' + n).val());
	$('#neighborhoodView').text($('#tdcomplement' + n).val());
	$('#compView').text($('#tdneighborhood' + n).val());
	$('#mediaView').text($('#tdmedia' + n).val());
	$('#obsView').text($('#tdobs' + n).val());
	$('#filiationView').text($('#tdfiliation' + n).val());
	
	$("#view").dialog({
		width:  'auto',
		height:  'auto',
		resizable: true,
		modal: false,
		buttons: {
			Ok: function() {
				$(this).dialog( "close" );
			}
		}
	});
}

function loadGrid(){
	$('#tbstudents_wrapper').remove();
	$('#gridload').show();
	$('#gdiv').load('${pageContext.request.contextPath}/students/gridstudents', function() {
		$('#gdiv').hide();
		$('#gridload').hide();
		$('#gdiv').fadeIn('slow');
		$('#grid').css('height','auto');
	});
	
}

function loadProf(){
	$('#profLoader').css('display', 'block');
	$('#prof').load('${pageContext.request.contextPath}/students/listprof', function() {
		$('#profLoader').css('display', 'none');
	});
}

function loadState(){
	$('#stateLoader').css('display', 'block');
	$('#state').load('${pageContext.request.contextPath}/cityState/states', function() {
		$('#stateLoader').css('display', 'none');
	});
}

function loadCity(id){
	disableCombo('#citylabel');
	$('#cityLoader').css('display', 'block');
	$('#city').load('${pageContext.request.contextPath}/cityState/cities', {stateId: id}, function() {
		$('#cityLoader').css('display', 'none');
		enableCombo('#citylabel');
	});
}

function switchCad(){
	clearFields();
	$('#fieldsetCad').hide();
	$('#legendCad').text('Cadastrar Aluno');
	$('#btnSave').attr('value','Salvar');
	$('#btnSave').attr('onclick','save()');
	$('#fieldsetCad').show('slide', 150);
}

function validations(fieldset){
	
	var val = 0;
	
	$("#" +fieldset+ " input[type='text'],#"+fieldset+ " select, #" +fieldset+" input[role=textbox]").each(function(){
	    if($(this).val() == "" || $(this).val() == "-1"){
	        if($(this).hasClass('mandatory')){
		        $(this).addClass("ui-state-error");
		        console.log(this);
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
	$('#legendCad').text('Cadastrar Aluno');
	$('#btnSave').attr('value','Salvar');
	$('#btnSave').attr('onclick','save()');
	disableCombo('#citylabel');
}
</script>
</tiles:putAttribute>

<tiles:putAttribute name="content">
	
	<div id="panel" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
        <span class="panel-title">Gerenciar Alunos</span>

		<fieldset id="fieldsetCad" class="fieldsetclass">
			<legend id="legendCad">Cadastrar Aluno</legend>
			
			<input id="idEdit" type="hidden" value="${activate.id}">
			
			<div id="type-student-div" style="width: 131px;margin-left: 11px;">
				<input type="radio" id="type1" name="type-student" checked="checked" value="NORMAL"> <label style="font-size: 10px;" for="type1">Normal</label>
				<input type="radio" id="type2" name="type-student" value="VIP"> <label style="font-size: 10px;" for="type2">VIP</label>
			</div>
			 
			<label style="float: left;margin-left: 10px;width: 290px;font-size: 13px;">Nome*: <input id="name" type="text" style="width: 280px;display: block;" class="text ui-widget-content ui-corner-all mandatory" value="${activate.name}"></label>
			<label style="float: left;margin-left: 36px;width: 142px;">RG*: <input id="rg" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 152px;">CPF*: <input id="cpf" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 145px;">Data&nbsp;de&nbsp;Nasc*: <input id="birth" style="display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 181px;margin-top: 3px;width: 150px;">Escolaridade: 
				 <select id="schooling"  style="width: 145px;display: block;">
						<option selected="selected" value="-1">Selecione... </option>
						<option value="Ensino Fundamental">Ensino Fundamental</option>
						<option value="Ensino M&eacute;dio">Ensino M&eacute;dio</option>
						<option value="Ensino Superior">Ensino Superior</option>
				</select>
			</label>
			<label id="proflabel" style=" display: block;float: left;margin-left: 144px;margin-top: 3px;width: 162px;">Profissão*:
				<span style="display: block;">
					<select id="prof" style="width: 135px;">
					</select>
				</span>
			</label>
			<img id="profLoader" style="display: block;height: 16px;margin-left: 790px;margin-top: 57px;position: absolute;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 210px;">Email*: <input id="email" style="width: 205px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory" value="${activate.email}"> </label>
			<label style="float: left;margin-left: 116px;margin-top: 3px;width: 120px;">Telefone: <input id="tel" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all" value="${activate.tel}"> </label>
			<label style="float: left;margin-left: 174px;margin-top: 3px;">Cel: <input id="cel" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all" value="${activate.cel}"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 110px;">CEP*: <input  id="cep" style="width: 104px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label id="statelabel" style="display: block;float: left;margin-left: 216px;margin-top: 3px;width: 90px;">Estado*:
				<span style="display: block;">
					<select id="state" style="width: 135px;">
					</select>
				</span>
			</label>
			<img id="stateLoader" style="display: block;height: 16px; margin-left: 394px;margin-top: 135px;position: absolute;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<label id="citylabel" style=" display: block;float: left;margin-left: 204px;margin-top: 3px;width: 162px;">Cidade*:
				<span style="display: block;">
					<select id="city" style="width: 135px;">
					</select>
				</span>
			</label>
			<img id="cityLoader" style="display: none;height: 16px;margin-left: 790px;margin-top: 135px;position: absolute;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<label style="float: left;clear:left;margin-left: 10px;margin-top: 3px;width: 287px;">End.*: <input id="end" style="width: 280px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 39px;margin-top: 3px;width: 50px;">N&ordm;*: <input id="number" style="width: 40px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 244px;margin-top: 3px;width: 110px;">Bairro*: <input id="neighborhood" style="width: 131px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left; margin-left: 10px;margin-top: 3px;">Complemento: <input id="comp" style="display: block;" type="text" class="text ui-widget-content ui-corner-all"> </label>
			<label style="float: left;margin-left: 189px;margin-top: 3px;width: 235px;">OBS.:
				<textarea id="obs" style="display:block;height: 40px;width: 220px;;" rows="" cols="" class="text ui-widget-content ui-corner-all"></textarea>
			</label> 
			<label style="float: left;margin-left: 59px;margin-top: 3px;width: 147px;">Tipo de M&iacute;dia: 
				 <select id="media"  style="width: 145px;display: block;">
						<option selected="selected" value="-1">Selecione... </option>
						<option value="TV">TV</option>
						<option value="Site">Site</option>
						<option value="Facebook">Facebook</option>
						<option value="Radio">Radio</option>
						<option value="Ex Alunos">Ex Alunos</option>
						<option value="Coordena&ccedil;&atilde;o da Escola">Coordena&ccedil;&atilde;o da Escola</option>
						<option value="Faculdade">Faculdade</option>
						<option value="Outdoors">Outdoors</option>
						<option value="Folder">Folder</option>
						<option value="Outros">Outros</option>
				</select>
			</label>
			<label style="float: left; margin-left: 10px;margin-top: -16px;">Filiação: <input id="filiation" style="display: block;width: 280px;" type="text" class="text ui-widget-content ui-corner-all"> </label>
			
			<div style=" margin: 15px auto auto;width: 134px;clear: left;padding-top: 15px;">
				<input id="btnSave" type="button" value="Salvar" style="font-size: 10px;font-weight: bold;width: 63px;" onclick="save();">
				<input type="button" value="Cancelar" style="font-size: 10px; font-weight: bold;width: 63px;" onclick="switchCad()">
			</div>
			
		</fieldset>
		
		
		<div id="grid">
			<img id="gridload" style="display: block;height: 16px;margin: 125px auto auto;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<div id="gdiv"></div>
		</div>
		
		<div title="Aluno" id="view" style="display: none;">
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
					<td style="font-weight: bold;text-align: right;"> Escolaridade: </td>
					<td id="schoolingView"> </td>
					<td style="font-weight: bold;text-align: right;">Profissão: </td>
					<td id="companyView"> </td>
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
					<td style="font-weight: bold;text-align: right;">Estado: </td>
					<td id="stateView"> </td>
					<td style="font-weight: bold;text-align: right;">Cidade: </td>
					<td id="cityView"></td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">End.: </td>
					<td id="endView"> </td>
					<td style="font-weight: bold;text-align: right;">N&ordm;: </td>
					<td id="numberView"></td>
					<td style="font-weight: bold;text-align: right;">Bairro: </td>
					<td id="neighborhoodView"> </td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">Complemento: </td>
					<td id="compView"> </td>
					<td style="font-weight: bold;text-align: right;">OBS.: </td>
					<td id="obsView"> </td>
					<td style="font-weight: bold;text-align: right;">Tipo de M&iacute;dia: </td>
					<td id="mediaView"></td>
				</tr>
				<tr>
					<td style="font-weight: bold;text-align: right;">Filiação: </td>
					<td id="filiationView"> </td>
					<td></td>
					<td> </td>
					<td></td>
					<td> </td>
				</tr>
			</table>
		</div>
		
	</div>
	
</tiles:putAttribute>

</tiles:insertTemplate>