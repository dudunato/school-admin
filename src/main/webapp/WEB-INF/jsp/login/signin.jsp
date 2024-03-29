<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="image/png" href="${pageContext.request.contextPath}/images/ico.png" rel="shortcut icon">
<title>EFM Admin</title>
<style type="text/css">
@IMPORT url("${pageContext.request.contextPath}/css/cssreset.css");
@IMPORT url("${pageContext.request.contextPath}/css/custom-theme/jquery-ui-1.8.16.custom.css");

body {
    background: rgb(238,238,238); /* Old browsers */
    background: -moz-linear-gradient(top, rgba(238,238,238,1) 0%, rgba(204,204,204,1) 100%); /* FF3.6+ */
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(238,238,238,1)), color-stop(100%,rgba(204,204,204,1))); /* Chrome,Safari4+ */
    background: -webkit-linear-gradient(top, rgba(238,238,238,1) 0%,rgba(204,204,204,1) 100%); /* Chrome10+,Safari5.1+ */
    background: -o-linear-gradient(top, rgba(238,238,238,1) 0%,rgba(204,204,204,1) 100%); /* Opera 11.10+ */
    background: -ms-linear-gradient(top, rgba(238,238,238,1) 0%,rgba(204,204,204,1) 100%); /* IE10+ */
    background: linear-gradient(to bottom, rgba(238,238,238,1) 0%,rgba(204,204,204,1) 100%); /* W3C */
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#eeeeee', endColorstr='#cccccc',GradientType=0 ); /* IE6-9 */
}

#box {
   	color: #544E41;
    font-family: Trebuchet MS;
    height: 126px;
    left: 50%;
    margin-left: -225px;
    margin-top: -63px;
    position: absolute;
    top: 50%;
    width: 450px;
}

#wstitle {
    display: block;
    float: left;
    font-family: Trebuchet MS;
    font-size: 27px;
    height: 37px;
    margin-left: 40px;
    margin-top: -16px;
    width: 150px;
}

#partition {
	background-image: url("${pageContext.request.contextPath}/images/divisoria.png");
    display: block;
    height: 100%;
    margin: auto;
    width: 4px;
}

.ui-widget-content {
    color: #003366;
}

.ui-widget-content a {
    color: #003366;
}

.ui-widget {
    font-family: Trebuchet MS;
    font-size:13px;
}
.ui-dialog .ui-dialog-buttonpane button {
    cursor: pointer;
    margin: 0.5em 0.4em 0.5em 0;
    font-size: 10px;
}

label {
	font-size: 13px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/djr.js"></script>
<script type="text/javascript">
	function LoginController(){ DJR.call(this); }
	LoginController.prototype.routes = {
		"authenticate":{
			url: "${pageContext.request.contextPath}/login/authenticate", method: "POST"
		}
	}
	
	var controller = new LoginController();
	$(function() {
		$("input:button").button();
		
		
		$('#login').focus();
		$('#login').keypress(function(e) {
			$('#login').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
			//$('#msgerror').hide();
			if(e.keyCode == 13){
				$('#go').click();
			}
		});
		$('#key').keypress(function(e) {
			$('#key').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
			//$('#msgerror').hide();
			if(e.keyCode == 13){
				$('#go').click();
			}
		});
	});
	
	
	function authenticate(){
		var login = $('#login').val();
		var key = $('#key').val();
		
	//	if (key != undefined && key != '') {
	//		var shaObj = new jsSHA(key, "ASCII");
	//		key = shaObj.getHash("SHA-512", "HEX");
	//	}
	
		if(login == ""){
			$('#login').addClass("text ui-widget-content ui-corner-all ui-state-error");
			$('#login').focus();	
			return;
		}
		if(key == ""){	
			$('#key').addClass("text ui-widget-content ui-corner-all ui-state-error");
			$('#key').focus();
			return;
		}
		
		$('#loader').css('display', 'block');
		controller.authenticate(
				{ "user": {
					"name": login,
			     	"pass": key
					}
			    },
			    function(data){
			    	if(data.string == "success"){
			    		$('#loader').hide();
			    		$('#success').css('display', 'block');
			    		location.href = '${pageContext.request.contextPath}/teacher/managerteachers'
			    	}
	
			    	if(data.string == "error"){
			    		$('#loader').hide();
			    		$("#msgDesc").text("Usu�rio ou senha inv�lida.");
			    		$("#boxMsg").dialog({
			    			resizable: false,
			    			height:180,
			    			modal: true,
			    			buttons: {
			    				Ok: function() {
			    					$(this).dialog( "close" );
			    					$('#login').addClass("text ui-widget-content ui-corner-all ui-state-error");
			    					$('#key').addClass("text ui-widget-content ui-corner-all ui-state-error");
			    					$('#login').focus();
			    				}
			    			}
			    		});
			    	}
			    	
			    	if(data.string == "errormodule"){
			    		$('#loader').hide();
			    		$("#msgDesc").text("M�dulo Admin desconectado!");
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
	}
	
	function clearFields(){
		$('#login').val("");
		$('#login').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");	
		$('#key').val("");
		//$('#msgerror').hide();
		$('#key').removeClass("text ui-widget-content ui-corner-all ui-state-error").addClass("text ui-widget-content ui-corner-all");
	}
	</script>

</head>
<body>
	
	<div id="box">
        <img style="display: block;float: right;margin-right: 38px;margin-top: 7px;" alt="English for Missions" width="150" height="97" src="${pageContext.request.contextPath}/images/efm-logo.png">
		<span id="wstitle" >EFM Admin </span>

		<label style=" clear: left;float: left;margin-top: 5px;" >Usu&aacute;rio: <input id="login" type="text" class="text ui-widget-content ui-corner-all"></label>
		<label style=" clear: left;float: left; margin-left: 9px;margin-top: 7px;">Senha: <input id="key" type="password" class="text ui-widget-content ui-corner-all"></label>
		
		<span id="success" style="display: none; color: darkgreen;float: left;font-size: 10px;margin-left: 41px;margin-top: 78px;position:absolute;">Usu&aacute;rio logado com sucesso...</span>
		
		<div style="clear: left;float: left;margin-left: 37px;margin-top: 20px;">
			<input id="go" type="button" value="Ok" style="font-size: 10px;font-weight: bold;width: 63px;" onclick="authenticate()">
			<input type="button" value="Limpar" style="font-size: 10px; font-weight: bold;width: 63px;" onclick="clearFields()">
			<img id="loader" style="display: none;margin-left: 135px;margin-top: -20px;position: absolute;" alt="..." height="16" width="16" src="${pageContext.request.contextPath}/images/ajax-loader.gif">
		</div>
		
		<span id="partition" ></span>
		
		<div id="boxMsg" title="Alerta">
			<span id="msgDesc" style="display: block;margin: 30px auto auto;width: 185px;"></span>
		</div>
	</div>
</body>
</html>