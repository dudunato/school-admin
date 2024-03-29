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

#tbtimetable{
	border-collapse: collapse;
    text-align: center;
    width: 100% !important;
    font-size: 11px;
}

#tbtimetable_wrapper{
	margin: auto;
    width: 822px;
}

#tbtimetable_length{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbtimetable_filter{
	float: right;
    margin: 4px;
    font-size: 12px;
}

#tbtimetable_info{
	float: left;
	margin: 4px;
	font-size: 12px;
}

#tbtimetable_paginate{
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

table#tbtimetable tbody tr:nth-child(odd) {
	background-color: #FFFFFF;
}

table#tbtimetable tbody tr:nth-child(even) {
	background-color: #E8E8E8;
}

table#tbtimetable tbody tr:nth-child(odd):hover,table#tbtimetable tbody tr:nth-child(even):hover{
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

function TimetableController(){ DJR.call(this); }
TimetableController.prototype.routes = {
	"save":{
		url: "${pageContext.request.contextPath}/timetable/save", method: "POST"
	},
	"edit":{
		url: "${pageContext.request.contextPath}/timetable/edit", method: "POST"
	},
	"del":{
		url: "${pageContext.request.contextPath}/timetable/del", method: "POST"
	}
}

var controller = new TimetableController();


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
	
	$('#students , #groups').combobox();
	
	loadGrid();
	loadStudents();
	loadGroups();
		
	$('#slabel, #tlabel').children('span').children('input').addClass('mandatory');
	
	$('.mandatory').focus(function(e) {
		$(this).removeClass("ui-state-error");
	});
});

function save(){
	
	if (validations('fieldsetCad')) {
		$("#msgDesc").text("Deseja cadastrar esta Grade?");
		$("#boxMsg").dialog({
			resizable: false,
			height:180,
			modal: true,
			buttons: {
				Ok: function() {
					lockSetButton();
					$('#loader').css('display', 'block');
					controller.save(
							{"timetable":{
						            "groupId": $('#groups').val(),
						            "studentId": $('#students').val()
						            }
						    },
						    function(data){
						    	if(data.string == "success"){
						    		$('#loader').hide();
						    		$("#msgDesc").text("Grade cadastrada com sucesso.");
						    		$("#boxMsg").dialog({
						    			resizable: false,
						    			height:180,
						    			modal: true,
						    			buttons: {
						    				Ok: function() {
						    					clearFields();
						    					$('#tbtimetable_wrapper').remove();
						    					$('#grid').css('height','276px');
						    					$(this).dialog( "close" );
						    					loadGrid();
						    				}
						    			}
						    		});
						    	}else{
						    		$("#msgDesc").text("Houve um erro ao cadastrar a Grade.");
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
	
	$("#msgDesc").text("Deseja deletar esta Grade?");
	$("#boxMsg").dialog({
		resizable: false,
		height:180,
		modal: true,
		buttons: {
			Ok: function() {
				lockSetButton();
				$('#loader').css('display', 'block');
				controller.del(
						{"timetable":{
				            "groupId": $('#tdgroupId' + n).val(),
				            "studentId": $('#tdstudentId' + n).val()
				            }
					    },
					    function(data){
					    	if(data.string == "success"){
					    		$('#loader').hide();
					    		$("#msgDesc").text("Grade deletada com sucesso.");
					    		$("#boxMsg").dialog({
					    			resizable: false,
					    			height:180,
					    			modal: true,
					    			buttons: {
					    				Ok: function() {
					    					clearFields();
					    					$('#tbtimetable_wrapper').remove();
					    					$('#grid').css('height','276px');
					    					$(this).dialog( "close" );
					    					loadGrid();
					    				}
					    			}
					    		});
					    	}else{
					    		$('#loader').hide();
					    		$("#msgDesc").text("Houve um erro ao deletar a Grade.");
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
	$('#tbtimetable_wrapper').remove();
	$('#gridload').show();
	$('#gdiv').load('${pageContext.request.contextPath}/timetable/gridtimetable', function() {
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

function loadGroups(){
	$('#groupLoader').css('display', 'block');
	$('#groups').load('${pageContext.request.contextPath}/group/list', function() {
		$('#groupLoader').css('display', 'none');
	});
}

function switchEdit(n){
	clearFields();
	$('#fieldsetCad').hide();
	$('#students').val($('#tdstudentId' + n).val());
	$('#slabel').children('span').children('input').val($('#tdstudent' + n).text());
	$('#groups').val($('#tdteacherId' + n).val());
	$('#tlabel').children('span').children('input').val($('#tdteacher' + n).text());
	
	$('#legendCad').text('Editar Grade Hor�ria');
	$('#btnSave').attr('value','Editar');
	$('#btnSave').attr('onclick','edit()');
	
	$('#fieldsetCad').show('slide', 150);
}

function switchCad(){
	clearFields();
	$('#fieldsetCad').hide();
	$('#legendCad').text('Cadastrar Grade Hor�ria');
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
	
	var tb = $('#tbtimetable').dataTable().fnGetData();
	for (var i in tb) {
	    if ($('#students').val() == tb[i][2]) {
	    	$("#msgDesc").text("Aluno j� alocado em alguma turma.");
			$("#boxMsg").dialog({
				resizable: false,
				height:180,
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog( "close" );
						$('#slabel').children('span').children('input').addClass('ui-state-error');
						$('#tbtimetable_filter').children('label').children('input').val($('#slabel').children('span').children('input').val());
						$('#tbtimetable_filter').children('label').children('input').keyup();
					}
				}
			});
			return false;
	    }
	}
	
	return true;
}

function clearFields(){
	$('input:text').val('');
	$('input:text').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
}
</script>
</tiles:putAttribute>

<tiles:putAttribute name="content">
	<div id="panel" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
        <span class="panel-title" style="width: 186px;">Grade Hor�ria</span>

		<fieldset id="fieldsetCad" class="fieldsetclass">
			<legend id="legendCad">Cadastrar Grade Hor�ria</legend>
			
			<div style="margin: auto;width: 600px;">
				
				<label id="tlabel" style=" display: block;width: 265px;float: left;">Turma*:
					<span style="display: block;">
						<select id="groups" style="width: 150px;">
						</select>
					</span>
				</label>
				<img id="groupLoader" style="display: block;height: 16px;margin-left: 259px;margin-top: 17px;position: absolute;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
				
				<label id="slabel" style=" display: block;width: 265px;float: left;margin-left: 54px;">Aluno*:
					<span style="display: block;">
						<select id="students" style="width: 150px;">
						</select>
					</span>
				</label>
				<img id="studentLoader" style="display: block;float: left;height: 16px;margin-left: -4px;margin-top: 18px;width: 16px;" alt="..." src="${pageContext.request.contextPath}/images/ajax-loader.gif">
				
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