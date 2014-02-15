<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>


<tiles:insertTemplate template="/default.jsp">

<tiles:putAttribute name="head">
<style type="text/css">

#panel{
    margin: 2% auto auto;
    padding-bottom: 15px;
    position: relative;
    width: 930px !important;
}

.fieldsetclass {
	border: 1px solid #CCCCCC;
    border-radius: 4px 4px 4px 4px;
    height: 100%;
    margin: auto;
    padding: 10px;
    width: 650px;
    margin-top: 10px;
}

#grid {
	margin: 20px auto auto;
    width: 670px;
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
    width: 670px;
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
	color: #ffffff;
}

legend {
	color: #544E41;
    font-size: 15px;
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
    border: 1px solid #539FEC;
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
	},
	"activating":{
		url: "${pageContext.request.contextPath}/students/activatingInactive", method: "POST"
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
	
	$("#tel, #cel").mask("(99)9999-9999");
	loadGrid();
	
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
						            "email" : $('#email').val().trim(),
						            "tel" : $('#tel').val(),
						            "cel" : $('#cel').val(),
						            "status" : 'REGULAR'
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
		$("#msgDesc").text("Deseja editar este Aluno?");
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
						        "email" : $('#email').val().trim(),
						        "tel" : $('#tel').val(),
						        "cel" : $('#cel').val()
					            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$('#fieldsetEdit').hide();
			    					$('#fieldsetCad').show('slide', 120);
						    		$("#msgDesc").text("Aluno editado com sucesso.");
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
						    		$("#msgDesc").text("Houve um erro ao editar o Aluno.");
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

function activating(n){
	
	$("#msgDesc").text("Deseja ativar este Aluno?");
	$("#boxMsg").dialog({
		resizable: false,
		height:180,
		modal: true,
		buttons: {
			Ok: function() {
				
				if ($('#tdstatus' + n).text() == 'INATIVO') {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.activating(
							{
								"id" : $('#tdid' + n).val(),
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Aluno ativado com sucesso.");
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
						    		$("#msgDesc").text("Houve um erro ao ativar o Aluno.");
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
				} else {
					$("#a-id").val($('#tdid' + n).val());
					$("#a-name").val($('#tdname' + n).text());
			        $("#a-email").val($('#tdemail' + n).text());
			        $("#a-tel").val($('#tdtel' + n).text());
			        $("#a-cel").val($('#tdcel' + n).text());
			        $("#a-form").submit();
				}
				
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
	$('#email').val($('#tdemail' + n).text());
	$('#tel').val($('#tdtel' + n).text());
	$('#cel').val($('#tdcel' + n).text());
	
	$('#legendCad').text('Editar Aluno');
	$('#btnSave').attr('value','Editar');
	$('#btnSave').attr('onclick','edit()');
	
	$('#fieldsetCad').show('slide', 150);
}


function loadGrid(){
	$('#tbstudents_wrapper').remove();
	$('#gridload').show();
	$('#gdiv').load('${pageContext.request.contextPath}/students/gridstudentse', function() {
		$('#gdiv').hide();
		$('#gridload').hide();
		$('#gdiv').fadeIn('slow');
		$('#grid').css('height','auto');
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
	
	$("#" +fieldset+ " input[type='text'],#"+fieldset+ " select").each(function(){
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
			<span class="panel-title" style=" width: 345px;">Gerenciar Possíveis Alunos</span>

		<fieldset id="fieldsetCad" class="fieldsetclass">
			<legend id="legendCad">Cadastrar Aluno Experimental</legend>
			
			<input id="idEdit" type="hidden" value="">
			
			<label style="float: left;margin-left: 10px;width: 290px;font-size: 13px;">Nome*: <input id="name" type="text" style="width: 280px;display: block;" class="text ui-widget-content ui-corner-all mandatory"></label>
			<label style="float: left;margin-left: 130px;width: 210px;">Email*: <input id="email" style="width: 205px;display: block;" type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="clear: left;float: left;margin-left: 10px;margin-top: 3px;width: 120px;">Telefone*: <input id="tel" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			<label style="float: left;margin-left: 300px;margin-top: 3px;">Cel*: <input id="cel" style="width: 110px;display: block;"  type="text" class="text ui-widget-content ui-corner-all mandatory"> </label>
			
			<div style=" margin: 15px auto auto;width: 134px;clear: left;padding-top: 15px;">
				<input id="btnSave" type="button" value="Salvar" style="font-size: 10px;font-weight: bold;width: 63px;" onclick="save();">
				<input type="button" value="Cancelar" style="font-size: 10px; font-weight: bold;width: 63px;" onclick="switchCad()">
			</div>
			
		</fieldset>
		
		
		<div id="grid">
			<img id="gridload" style="display: block;height: 16px;margin: 125px auto auto;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<div id="gdiv"></div>
		</div>
		
		<form id="a-form" method="post" action="${pageContext.request.contextPath}/students/activating">
			<input id="a-id" type="hidden" value="" name="student.id">
			<input id="a-name" type="hidden" value="" name="student.name">
			<input id="a-email" type="hidden" value="" name="student.email">
			<input id="a-tel" type="hidden" value="" name="student.tel">
			<input id="a-cel" type="hidden" value="" name="student.cel">
		</form>
		
	</div>
	
</tiles:putAttribute>

</tiles:insertTemplate>