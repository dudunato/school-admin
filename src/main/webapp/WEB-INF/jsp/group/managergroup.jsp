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

#tbgroup{
	border-collapse: collapse;
    text-align: center;
    width: 100%;
    font-size: 11px;
}

#tbgroup_wrapper{
	margin: auto;
    width: 822px;
}

#tbgroup_length{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbgroup_filter{
	float: right;
    margin: 4px;
    font-size: 12px;
}

#tbgroup_info{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbgroup_paginate{
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

table#tbgroup tbody tr:nth-child(odd) {
	background-color: #FFFFFF;
}

table#tbgroup tbody tr:nth-child(even) {
	background-color: #E8E8E8;
}

table#tbgroup tbody tr:nth-child(odd):hover,table#tbgroup tbody tr:nth-child(even):hover{
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

.time {
    width: 56px;
}
</style>
</tiles:putAttribute>

<tiles:putAttribute name="js">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.maskedinput-1.2.2.min.js"></script>
<script type="text/javascript"> 

function GroupController(){ DJR.call(this); }
GroupController.prototype.routes = {
	"save":{
		url: "${pageContext.request.contextPath}/group/save", method: "POST"
	},
	"edit":{
		url: "${pageContext.request.contextPath}/group/edit", method: "POST"
	},
	"del":{
		url: "${pageContext.request.contextPath}/group/del", method: "POST"
	}
}

var controller = new GroupController();


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
		}
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
	
	$('#students , #teachers, #day1, #day2, #startTime1, #startTime2, #endTime1, #endTime2').combobox();
	
	loadGrid();
	loadTeachers();
	$('#dlabel, #dlabel2').children('span').children('input').css('width','110px');
	$('#sTimelabel, #eTimelabel, #sTimelabel2, #eTimelabel2').children('span').children('input').addClass('time');
		
	$('#slabel, #tlabel, #dlabel, #dlabel2, #sTimelabel, #eTimelabel, #sTimelabel2, #eTimelabel2').children('span').children('input').addClass('mandatory');
	
	$('.mandatory').focus(function(e) {
		$(this).removeClass("ui-state-error");
	});
});

function save(){
	
	if (validations('fieldsetCad')) {
		$("#msgDesc").text("Deseja cadastrar esta Turma?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.save(
							{"group":{
						            "name": $('#name').val(),
						            "teacherId": $('#teachers').val(),
						            "day1": ($('#day1').val() == '-1') ? "" : $('#day1').val(),
						            "startTime1" : $('#startTime1').val(),
						            "endTime1" : $('#endTime1').val(),
						            "day2": ($('#day2').val() == '-1') ? "" : $('#day2').val(),
						            "startTime2" : $('#startTime2').val(),
						            "endTime2" : $('#endTime2').val()
						            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Turma cadastrada com sucesso.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					clearFields();
						    					$('#tbgroup_wrapper').remove();
						    					$('#grid').css('height','276px');
						    					$(this).dialog( "close" );
						    					loadGrid();
						    				}
						    			}
						    		});
						    	}else{
						    		$("#msgDesc").text("Houve um erro ao cadastrar a Turma.");
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
		$("#msgDesc").text("Deseja editar esta Turma?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.edit(
							{"group":{
								"id" : $('#idGroup').val(),
					            "name": $('#name').val(),
					            "teacherId": $('#teachers').val(),
					            "day1": ($('#day1').val() == '-1') ? "" : $('#day1').val(),
					            "startTime1" : $('#startTime1').val(),
					            "endTime1" : $('#endTime1').val(),
					            "day2": ($('#day2').val() == '-1') ? "" : $('#day2').val(),
					            "startTime2" : $('#startTime2').val(),
					            "endTime2" : $('#endTime2').val()
					            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Turma editada com sucesso.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					clearFields();
						    					$('#tbgroup_wrapper').remove();
						    					$('#grid').css('height','276px');
						    					$(this).dialog( "close" );
						    					loadGrid();
						    				}
						    			}
						    		});
						    	}else{
						    		$("#msgDesc").text("Houve um erro ao editar a Turma.");
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
	
	$("#msgDesc").text("Deseja deletar esta Turma?");
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
							"id" : $('#tdidGroup' + n).val(),
					    },
					    function(data){
					    	if(data.string == "success"){
					    		$('#loader').hide();
					    		$("#msgDesc").text("Turma deletada com sucesso.");
					    		$("#boxMsg").dialog({
					    			resizable: false,
					    			height:180,
					    			modal: true,
					    			buttons: {
					    				Ok: function() {
					    					clearFields();
					    					$('#tbgroup_wrapper').remove();
					    					$('#grid').css('height','276px');
					    					$(this).dialog( "close" );
					    					loadGrid();
					    				}
					    			}
					    		});
					    	}else{
					    		$('#loader').hide();
					    		$("#msgDesc").text("Houve um erro ao deletar a Turma.");
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

function loadGrid(){
	$('#tbgroup_wrapper').remove();
	$('#gridload').show();
	$('#gdiv').load('${pageContext.request.contextPath}/group/gridgroup', function() {
		$('#gdiv').hide();
		$('#gridload').hide();
		$('#gdiv').fadeIn('slow');
		$('#grid').css('height','auto');
	});
	
}

function loadTeachers(){
	$('#teacherLoader').css('display', 'block');
	$('#teachers').load('${pageContext.request.contextPath}/teacher/listTeachers', function() {
		$('#teacherLoader').css('display', 'none');
	});
}

function switchEdit(n){
	clearFields();
	$('#fieldsetCad').hide();
	$('#idGroup').val($('#tdidGroup' + n).val());
	$('#name').val($('#tdname' + n).text());
	$('#teachers').val($('#tdteacherId' + n).val());
	$('#tlabel').children('span').children('input').val($('#tdteacher' + n).text());
	$('#day1').val($('#tdday1' + n).val());
	$('#dlabel').children('span').children('input').val($('#tdday1' + n).val());
	$('#startTime1').val($('#tdtimeStart1' + n).val());
	$('#sTimelabel').children('span').children('input').val($('#tdtimeStart1' + n).val());
	$('#endTime1').val($('#tdtimeEnd1' + n).val());
	$('#eTimelabel').children('span').children('input').val($('#tdtimeEnd1' + n).val());
	$('#day2').val($('#tdday2' + n).val());
	$('#dlabel2').children('span').children('input').val($('#tdday2' + n).val())
	$('#startTime2').val($('#tdtimeStart2' + n).val());
	$('#sTimelabel2').children('span').children('input').val($('#tdtimeStart2' + n).val());
	$('#endTime2').val($('#tdtimeEnd2' + n).val());
	$('#eTimelabel2').children('span').children('input').val($('#tdtimeEnd2' + n).val());
	
	$('#legendCad').text('Editar Turma');
	$('#btnSave').attr('value','Editar');
	$('#btnSave').attr('onclick','edit()');
	
	$('#fieldsetCad').show('slide', 150);
}

function switchCad(){
	clearFields();
	$('#fieldsetCad').hide();
	$('#legendCad').text('Cadastrar Turma');
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
		        val++;
	        }
	    }
	});
	
	
	if(val != 0){
		$("#msgDesc").text("Preencha os campos obrigat�rios (*).");
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
	$('input:text').val('');
	$('input:text').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
	$('#legendCad').text('Cadastrar Turma');
	$('#btnSave').attr('value','Salvar');
	$('#btnSave').attr('onclick','save()');
}
</script>
</tiles:putAttribute>

<tiles:putAttribute name="content">
	<div id="panel" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
        <span class="panel-title" style="width: 230px;">Gerenciar Turmas</span>

		<fieldset id="fieldsetCad" class="fieldsetclass">
			<legend id="legendCad">Cadastrar Turma</legend>
			
			<div style="margin: auto;width: 600px;">
				<input id="idGroup" type="hidden">
				
				<label style="float: left;margin-left: 61px;width: 150px;">Nome:
					<input style="display: block;text-transform: none;" id="name" type="text" class="text ui-widget-content ui-corner-all mandatory">
				</label>				
				
				<label id="tlabel" style=" display: block;width: 265px;float: left;margin-left: 54px;">Professor*:
					<span style="display: block;">
						<select id="teachers" style="width: 150px;">
						</select>
					</span>
				</label>
				<img id="teacherLoader" style="display: block;float: left;height: 16px;margin-left: -4px;margin-top: 18px;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
				
				
				<fieldset class="fieldsetclass" style="float: left;width: 553px;">
					<legend style="font-size: 13px;padding: 3px;">Hor�rios</legend>
					
					<label id="dlabel" style=" display: block;float: left;margin-left: 54px;width: 150px;">Dia*:
						<span style="display: block;">
							<select id="day1" style="width: 135px;">
								<option selected="selected" value="-1"></option>
								<option value="Segunda">Segunda</option>
								<option value="Ter�a">Ter�a</option>
								<option value="Quarta">Quarta</option>
								<option value="Quinta">Quinta</option>
								<option value="Sexta">Sexta</option>
								<option value="S�bado">S�bado</option>
							</select>
						</span>
					</label>
					
					
					<label id="sTimelabel" style=" display: block;float: left;margin-left: 54px;width: 90px;">�nicio*:
						<span style="display: block;">
							<select id="startTime1" style="width: 135px;">
								<option selected="selected" value=""> </option>
								<option>08:00</option><option>09:00</option><option>10:00</option>
								<option>11:00</option><option>12:00</option><option>13:00</option>
								<option>14:00</option><option>15:00</option>
								<option>16:00</option><option>17:00</option><option>18:00</option>
								<option>19:00</option><option>20:00</option><option>21:00</option>
							</select>
						</span>
					</label>
					
					<label id="eTimelabel" style=" display: block;float: left;margin-left: 40px;width: 90px;">Fim*:
						<span style="display: block;">
							<select id="endTime1" style="width: 135px;">
								<option selected="selected" value=""> </option>
								<option>08:00</option><option>09:00</option><option>10:00</option>
								<option>11:00</option><option>12:00</option>
								<option>13:00</option><option>14:00</option><option>15:00</option>
								<option>16:00</option><option>17:00</option><option>18:00</option>
								<option>19:00</option><option>20:00</option><option>21:00</option>
							</select>
						</span>
					</label>
					
					<label id="dlabel2" style=" display: block;float: left;margin-left: 54px;width: 150px;">Dia*:
						<span style="display: block;">
							<select id="day2" style="width: 135px;">
								<option selected="selected" value="-1"></option>
								<option value="Segunda">Segunda</option>
								<option value="Ter�a">Ter�a</option>
								<option value="Quarta">Quarta</option>
								<option value="Quinta">Quinta</option>
								<option value="Sexta">Sexta</option>
								<option value="S�bado">S�bado</option>
							</select>
						</span>
					</label>
					
					<label id="sTimelabel2" style=" display: block;float: left;margin-left: 54px;width: 90px;">�nicio*:
						<span style="display: block;">
							<select id="startTime2" style="width: 135px;">
								<option selected="selected" value=""> </option>
								<option>08:00</option><option>09:00</option><option>10:00</option>
								<option>11:00</option><option>12:00</option><option>13:00</option>
								<option>13:00</option><option>14:00</option><option>15:00</option>
								<option>16:00</option><option>17:00</option><option>18:00</option>
								<option>19:00</option><option>20:00</option><option>21:00</option>
							</select>
						</span>
					</label>
					
					<label id="eTimelabel2" style=" display: block;float: left;margin-left: 40px;width: 90px;">Fim*:
						<span style="display: block;">
							<select id="endTime2" style="width: 135px;">
								<option selected="selected" value=""> </option>
								<option>08:00</option><option>09:00</option><option>10:00</option>
								<option>11:00</option><option>12:00</option><option>13:00</option>
								<option>13:00</option><option>14:00</option><option>15:00</option>
								<option>16:00</option><option>17:00</option><option>18:00</option>
								<option>19:00</option><option>20:00</option><option>21:00</option>
							</select>
						</span>
					</label>
					
				</fieldset>
				
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