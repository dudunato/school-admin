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
    width: 930px;
}

#grid {
	margin: 20px auto auto;
    width: 822px;
    height: 276px;
    border-radius: 4px 4px 4px 4px;
    border: 1px solid #CCCCCC;
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

#tbcontracts{
	border-collapse: collapse;
    text-align: center;
    width: 100%;
    font-size: 11px;
}

#tbcontracts_wrapper{
	margin: auto;
    width: 822px;
}

#tbcontracts_length{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbcontracts_filter{
	float: right;
    margin: 4px;
    font-size: 12px;
}

#tbcontracts_info{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbcontracts_paginate{
	float: right;
    margin: 4px;
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

table#tbcontracts tbody tr:nth-child(odd) {
	background-color: #FFFFFF;
}

table#tbcontracts tbody tr:nth-child(even) {
	background-color: #E8E8E8;
}

table#tbcontracts tbody tr:nth-child(odd):hover,table#tbcontracts tbody tr:nth-child(even):hover{
	background-color: orange;
	color: #ffffff;
}

legend {
	color: #544E41;
    font-size: 15px;
    margin: 2px;
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.maskMoney.js"></script>
<script type="text/javascript"> 

function ContractsController(){ DJR.call(this); }
ContractsController.prototype.routes = {
	"save":{
		url: "${pageContext.request.contextPath}/contracts/save", method: "POST"
	},
	"edit":{
		url: "${pageContext.request.contextPath}/contracts/edit", method: "POST"
	}
}

var controller = new ContractsController();


$(function() {
	
	$("#start, #end").datepicker({
		dateFormat:"dd/mm/yy",
		changeMonth: true,
		onSelect: function( selectedDate ) {
			var option = this.id == "from" ? "minDate" : "maxDate",
				instance = $( this ).data( "datepicker" ),
				date = $.datepicker.parseDate(
					instance.settings.dateFormat ||
					$.datepicker._defaults.dateFormat,
					selectedDate, instance.settings );
		},
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
	
	$('#students').combobox();
	
	$("#totalValue, #monthlyValue, #inputValue, #monthlyAlternative").maskMoney({symbol:"R$",decimal:",",thousands:"."});
	
	loadGrid();
	loadStudents();
	$('#slabel').children('span').children('input').addClass('mandatory');
	
	$('.mandatory').focus(function(e) {
		$(this).removeClass("ui-state-error");
	});
});

function save(){
	
	if (validations('fieldsetCad')) {
		$("#msgDesc").text("Deseja cadastrar este Contrato?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.save(
							{"contract":{
						            "studentID": $('#students').val(),
						            "beginDate": $('#start').val(),
						            "endDate": $('#end').val(),
						            "totalValue" : $('#totalValue').val(),
						            "monthlyPaymentValue" : $('#monthlyValue').val(),
						            "entryValue" : $('#inputValue').val(),
						            "alternativePaymentValue" : $('#monthlyAlternative').val()
						            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Contrato cadastrado com sucesso.");
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
						    		$("#msgDesc").text("Houve um erro ao cadastrar o Contrato.");
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
		$("#msgDesc").text("Deseja editar este Contrato?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.edit(
							{"contract":{
									"id" : $('#idContract').val(),
									"studentID": $('#students').val(),
						            "beginDate": $('#start').val(),
						            "endDate": $('#end').val(),
						            "totalValue" : $('#totalValue').val(),
						            "monthlyPaymentValue" : $('#monthlyValue').val(),
						            "entryValue" : $('#inputValue').val(),
						            "alternativePaymentValue" : $('#monthlyAlternative').val()
						            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Contrato editado com sucesso.");
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
						    		$("#msgDesc").text("Houve um erro ao editar o Contrato.");
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

function loadGrid(){
	$('#tbcontracts_wrapper').remove();
	$('#gridload').show();
	$('#gdiv').load('${pageContext.request.contextPath}/contracts/gridcontracts', function() {
		$('#gdiv').hide();
		$('#gridload').hide();
		$('#gdiv').fadeIn('slow');
		$('#grid').css('height','auto');
	});
	
}

function loadStudents(){
	$('#studentLoader').css('display', 'block');
	$('#students').load('${pageContext.request.contextPath}/students/listStudents', function() {
		$('#studentLoader').css('display', 'none');
	});
}

function switchEdit(n){
	clearFields();
	$('#fieldsetCad').hide();
	$('#idContract').val($('#tdidContract' + n).val());
	$('#students').val($('#tdstudentId' + n).val());
	$('.ui-autocomplete-input').val($('#tdstudent' + n).text())
	$('#start').val($('#tdstart' + n).text());
	$('#end').val($('#tdend' + n).text());
	$('#totalValue').val($('#tdtotalvalue' + n).text());
	$('#monthlyValue').val($('#tdmonthly' + n).text());
	$('#inputValue').val($('#tdinputvalue' + n).val());
	$('#monthlyAlternative').val($('#tdmonthlyalternative' + n).val());
	
	$('#legendCad').text('Editar Contrato');
	$('#btnSave').attr('value','Editar');
	$('#btnSave').attr('onclick','edit()');
	
	$('#fieldsetCad').show('slide', 150);
}

function switchCad(){
	clearFields();
	$('#fieldsetCad').hide();
	$('#legendCad').text('Cadastrar Contrato');
	$('#btnSave').attr('value','Salvar');
	$('#btnSave').attr('onclick','save()');
	$('#fieldsetCad').show('slide', 150);
}

function validations(fieldset){
	
	var val = 0;
	
	$("#fieldsetCad input, #fieldsetCad select").each(function(){
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
	
	return true;
}

function clearFields(){
    $('input:text, input:password, textarea').val('');
    $('select').val('-1');
    $('select').removeClass('ui-state-error');
    $('input:text, input:password').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
    $('#legendCad').text('Cadastrar Contrato');
    $('#btnSave').attr('value','Salvar');
    $('#btnSave').attr('onclick','save()');
}
</script>
</tiles:putAttribute>

<tiles:putAttribute name="content">
	<div id="panel" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
        <span class="panel-title" style="width: 253px">Gerenciar Contratos</span>

		<fieldset id="fieldsetCad" class="fieldsetclass">
			<legend id="legendCad">Cadastrar Contrato</legend>
			
			<div style="margin: auto;width: 605px;">
				<input id="idContract" type="hidden">
				
				<label id="slabel" style=" display: block;width: 265px;">Aluno*:
					<span style="display: block;">
						<select id="students" style="width: 150px;">
						</select>
					</span>
				</label>
				<img id="studentLoader" style="display: block;height: 16px;margin-left: 257px;margin-top: 3px;position: absolute;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
				
				<label style="float: left; margin-left: 48px;margin-top: -15px;">Per&iacute;odo*:
					<input style="display: block;" id="start" type="text" class="text ui-widget-content ui-corner-all mandatory">
				</label>
				
				<label style="float: left;margin-left: 1px;">a
					<input  id="end" type="text" class="text ui-widget-content ui-corner-all mandatory">
				</label>
			
				<label style="float: left;clear: left;margin-top: 3px;width: 143px;">Valor Total*:
					<input  style="display: block;" id="totalValue" type="text" class="text ui-widget-content ui-corner-all mandatory">
				</label>
				
				<label style="float: left;margin-top: 3px;margin-left: 163px;">Valor Mensalidade*:	
					<input  style="display: block;" id="monthlyValue" type="text" class="text ui-widget-content ui-corner-all mandatory">
				</label>
				
				<label style="float: left;clear: left;margin-top: 3px;width: 143px;">Entrada:
					<input  style="display: block;" id="inputValue" type="text" class="text ui-widget-content ui-corner-all">
				</label>
				
				<label style="float: left;margin-top: 3px;margin-left: 163px;">Valor Alternativo:	
					<input  style="display: block;" id="monthlyAlternative" type="text" class="text ui-widget-content ui-corner-all">
				</label>
				
				<div style=" margin: 15px auto auto;width: 134px;clear: left;padding-top: 15px;">
					<input id="btnSave"  type="button" value="Salvar" style="font-size: 10px;font-weight: bold;width: 63px;" onclick="save();">
					<input type="button" value="Cancelar" style="font-size: 10px; font-weight: bold;width: 63px;" onclick="switchCad()">
				</div>
			</div>
			
			
		</fieldset>
		
		<div id="grid">
			<img id="gridload" style="display: block;height: 16px;margin: 125px auto auto;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			<div id="gdiv"></div>
		</div>
		
	</div>
</tiles:putAttribute>

</tiles:insertTemplate>