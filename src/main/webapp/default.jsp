<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EFM Admin</title>
<link type="image/png" href="${pageContext.request.contextPath}/images/ico.png" rel="shortcut icon">
<style type="text/css">
@IMPORT url("${pageContext.request.contextPath}/css/cssreset.css");
@IMPORT url("${pageContext.request.contextPath}/css/custom-theme/jquery-ui-1.8.16.custom.css");

body {
	background-color: #F1F1F1;
}

#main{ 
	min-height: 100%; 
	position: relative; 
	height: auto; 
}

#header {
	background: url("${pageContext.request.contextPath}/images/barratopo.png") repeat-x scroll 0 0;
    height: 80px;
    width: 100%;
}


#boxlogin {
	width: 255px;
	height: 51px;
	float: right;
	margin-top: 7px;
	font-family: Verdana,Arial,sans-serif;
	font-size: 13px;
}

#boxlogin a{
	text-decoration: none;
}

#userlogged {
    color: #544E41;
    display: block;
    float: left;
    font-size: 12px;
    font-weight: bold;
    margin-left: 82px;
    margin-top: 23px;
    width: 80px;
}

#onoff {
    cursor: pointer;
    display: block;
    float: right;
    margin-right: 46px;
    margin-top: 23px;
    color: #544E41;
    text-decoration: none;
    font-weight: bold;
    font-size: 12px;
}


#onoff:HOVER {
    cursor: pointer;
    display: block;
    float: right;
    margin-right: 46px;
    margin-top: 23px;
    color: orange;
    text-decoration: none;
    font-weight: bold;
    font-size: 12px;
}

#onoff:ACTIVE:HOVER {
    cursor: pointer;
    display: block;
    float: right;
    margin-right: 46px;
    margin-top: 23px;
    color: orange;
    text-decoration: none;
    font-weight: bold;
    font-size: 12px;
}

#content {
	padding-bottom: 100px;
}

#footer {
	background: url("${pageContext.request.contextPath}/images/barratopo.png") repeat-x scroll 0 0;
	height: 80px;
    width: 100%;
    position: absolute;
    bottom: 0;
}

#menutab{
	background-image: url("${pageContext.request.contextPath}/images/menutab.png");
    background-position: 34px 0;
    cursor: pointer;
    float: left;
    height: 149px;
    margin-top: 36px;
    position: absolute;
    width: 34px;
    z-index: 3;
}

#menutab:HOVER{
	background-image: url("${pageContext.request.contextPath}/images/menutab.png");
    background-position: -39px 0;
    float: left;
    height: 149px;
    margin-top: 36px;
    cursor: pointer;
    position: absolute; 
    width: 34px;
    z-index: 3;
}

#menutab:ACTIVE:HOVER{
	background-image: url("${pageContext.request.contextPath}/images/menutab.png");
    background-position: 0px 0;
    float: left;
    height: 149px;
    margin-top: 36px;
    cursor: pointer;
    position: absolute; 
    width: 34px;
    z-index: 3;
}

.ui-widget {
    font-family: Verdana, Geneva, sans-serif;
    font-size: 1.3em;
}

.ui-accordion {
	width: 189px;
	
}

.ui-accordion .ui-accordion-header a {
	font-size:13px;
}

.ui-widget-content {
    color: #544E41;
}

.ui-widget-content a {
    color: #544E41;
}

#menu h3 {
	height: 15px;
}

#menu h3 a {
    display: block;
    float: left;
    margin-top: -2px;
}

#menu h3 span {
    float: right;
}

#menu div span {
	margin-left: -20px;
}

#menu div span a:hover {
	color: orange;
}

.ui-dialog .ui-dialog-buttonpane button {
    cursor: pointer;
    margin: 0.5em 0.4em 0.5em 0;
    font-size: 10px;
}

.ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited {
    color: orange;
    text-decoration: none;
}

.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active {
    color: orange;
    font-weight: bold;
}

.block-text {
	background: none repeat scroll 0 0 #CCCCCC !important;
    border-color: #CECECE !important;
}

.block-button {
	background: none repeat scroll 0 0 #CCCCCC !important;
    border-color: #CECECE !important;
}


#panel {
    background: white;
    color: #544E41;
}

.panel-title {
    color: #6D1311;
    display: block;
    float: none;
    font-size: 22px;
    font-weight: bold;
    height: 20px;
    margin: 11px auto auto;
    padding-top: 1px;
    width: 280px;
}
</style>
<tiles:insertAttribute name="head" defaultValue="" />
</head>
<body>
	
	<div id="main">
		<div id="header">
		<div style="height: 80px;margin: auto;width: 1000px;">
			<img style="display: block;float: left;margin-left: 29px;margin-top: 3px;" alt="English for Missions" width="110" height="71" src="${pageContext.request.contextPath}/images/efm-logon.png">
			<div id="boxlogin">
				<span id="userlogged"><span title="login" class="ui-icon ui-icon-person" style="float: left;margin-top: 0px;"></span><c:out value="${user.name}"></c:out></span>
				<a href="${pageContext.request.contextPath}/login/signout"><span id="onoff"><span title="login" class="ui-icon ui-icon-power" style="float: left;margin-top: 1px;"></span>sair</span></a>
                <span style="clear: left;color: #544E41;display: block;float: right;font-size: 9px;font-style: italic;margin-right: -11px;margin-top: 5px;width: 180px;">Bem vindo ao EFM Admin!</span>
			</div>
		</div>		
		</div>
		
		<div id="menu" style="float: left; margin-right: 0px; margin-top: 2%; position: absolute; z-index: 3; display: none;">
			<h3><a href="#">Professores</a></h3>
			<div>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/teacher/managerteachers">Gerenciar Professores</a></span>
			</div>
			<h3><a href="#">Alunos</a></h3>
			<div>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/students/managerstudents">Gerenciar Alunos</a></span>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/students/managerstudentse">Alunos Inativos/Exp.</a></span>
			</div>
			<h3><a href="#">Contratos</a></h3>
			<div>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/contracts/managercontracts">Gerenciar Contratos</a></span>
			</div>
			<h3><a href="#">Turmas</a></h3>
			<div>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/group/managergroup">Gerenciar Turmas</a></span>
			</div>
			<h3><a href="#">Grade de Hor&aacute;rios</a></h3>
			<div>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/timetable/managertimetable">Grade Alunos</a></span>
				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/timetableExp/managertimetableexp">Grade - Alunos Exp.</a></span>
<%-- 				<span style="display: block; font-size: 12px;"><a href="${pageContext.request.contextPath}/timetableVip/managertimetablevip">Grade Horária VIP</a></span> --%>
			</div>
			<h3><a href="#">Configurações</a></h3>
			<div>
				<span style="display: block; font-size: 12px;"><a href="#" onclick="editPass()">Alterar Senha</a></span>
			</div>
		</div>
		<div id="menutab">
		</div>
		
		<div id="content">
			<tiles:insertAttribute name="content" defaultValue="" />
			<div id="boxMsg" title="Alerta">
				<span id="msgDesc" style=" display: table;margin: 30px auto auto;"></span>
				<img id="loader" style="display: none;margin: 12px auto auto;" alt="..." height="16" width="16" src="${pageContext.request.contextPath}/images/ajax-loader.gif">
			</div>
            <div id="editPassBox" title="Alterar Senha" style="display: none;">
                <label style="display: block;margin: 6px auto auto;width: 150px;">Nova Senha:
                    <input style="display: block;text-transform: none;" id="newPass" type="password" class="text ui-widget-content ui-corner-all mandatory">
                </label>
                <label style="display: block;margin: 6px auto auto;width: 150px;">Confirme a Senha:
                    <input style="display: block;text-transform: none;" id="newPassc" type="password" class="text ui-widget-content ui-corner-all mandatory">
                </label>

            </div>


        </div>
		
		<div id="footer">
			<span style=" color: #544E41;display: block;font-family: Verdana,Arial,sans-serif;font-size: 10px;font-weight: bold;margin: 33px auto auto;width: 215px;">©2013 English For Missions by VIDE</span>
		</div>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.16.custom.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/djr.js"></script>
	<script type="text/javascript">
    function StudentsControllerS(){ DJR.call(this); }
    StudentsControllerS.prototype.routes = {
        "updatePass":{
            url: "${pageContext.request.contextPath}/students/updatePass", method: "POST"
        }
    }

    var controllerS = new StudentsControllerS();


	$(function() {
		$("td a, input:button").button();
		$("#menu").show();
		$("#menu").accordion({event: "mouseover"});
		$("#menu").hide();
		
		$('#menutab').toggle(
				function (){
					$('#menutab').css('margin-left','189px');
					$('#menu').show();
				},
				function (){
					$('#menutab').css('margin-left','0px');
					$('#menu').hide();
				}
		);

        $("#editPassBox input").keyup(function(){
            $(this).removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
        });
	});
	
	function enableCombo(id) {
		var input = $(id).children('span').children('input');
		var button = $(id).children('span').children('button');
		
		input.prop("disabled", false);
		button.prop("disabled", false);
	    input.removeClass('block-text');
	    button.removeClass('block-button');
	    input.focus();
	}

	function disableCombo(id) {
		var input = $(id).children('span').children('input');
		var button = $(id).children('span').children('button');
		
		input.val('');
		input.prop("disabled", true);
		button.prop("disabled", true);
	    input.addClass('block-text');
	    button.addClass('block-button');    
	}
	
	function lockSetButton(){
		$('.ui-dialog-buttonset').children('button').prop("disabled", true);
		$('.ui-dialog-buttonset').children('button').addClass('block-button');
	}
	
	function unlockSetButton(){
		$('.ui-dialog-buttonset').children('button').prop("disabled", false);
		$('.ui-dialog-buttonset').children('button').removeClass('block-button');
	}

    function editPass(){
        $("#editPassBox").dialog({
            resizable: false,
            height:180,
            modal: true,
            buttons: {
                Ok: function() {
                    var np = $('#newPass').val();
                    var npc = $('#newPassc').val();

                    if (np == npc && np != '' && npc != '') {

                        $("#editPassBox").parent().append(" <img id='loaderEP' style='margin-left: 160px;margin-top: -29px;position: absolute;' alt='...' height='16' width='16' src='${pageContext.request.contextPath}/images/ajax-loader.gif'>");
                        controllerS.updatePass(
                                {
                                    "newPass" : np
                                },
                                function(data){
                                    if(data.string == "success"){
                                        $('#loaderNP').hide();
                                        $("#msgDesc").text("Senha alterada com sucesso.");
                                        $("#boxMsg").dialog({
                                            resizable: false,
                                            height:180,
                                            modal: true,
                                            buttons: {
                                                Ok: function() {
                                                    $(this).dialog( "close" );
                                                    $("#editPassBox").dialog('close');
                                                    $("#newPass, #newPassc").val('');
                                                    $("#loaderEP").remove();
                                                }
                                            }
                                        });
                                    }else{
                                        $("#msgDesc").text("Houve um erro ao alterar a Senha.");
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
                        var aux = 0;

                        $("#editPassBox input").each(function(){
                            if($(this).hasClass('mandatory')){
                                $(this).addClass("ui-state-error");
                                aux++;
                            }
                        });


                        if(aux != 0){
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
                        }
                    }


                },
                Cancelar: function() {
                    $(this).dialog('close');
                    $("#newPass, #newPassc").val('');
                }
            }
        });
    }
	</script>
	<tiles:insertAttribute name="js" defaultValue="" />
</body>
</html>