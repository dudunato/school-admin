<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="image/png" href="${pageContext.request.contextPath}/images/ico.png" rel="shortcut icon">
<title>WS Admin</title>
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

#panel{
    background: white;
    color: #544E41;
    font-family: Trebuchet MS !important;
    font-size: 13px;
    height: 133px;
    left: 50%;
    margin: -66.5px auto auto -200px;
    padding-bottom: 15px;
    position: absolute;
    top: 50%;
    width: 400px;
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
    width: 50px;
}

p {
	float: left;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript">
$(function (){
	$("a").button();
});

</script>
</head>
<body>

	<div id="panel" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" >
			<span class="panel-title"> Erro</span>

		<div style=" margin: 26px auto auto; width: 210px;">
			<p>Usu&aacute;rio n&atilde;o logado no sistema.</p>
			<p style="margin-top: 5px;">Por favor, fa&ccedil;a o login:</p>
			<a class="fg-button fg-button-icon-left ui-state-default ui-corner-all ui-button ui-widget ui-button-text-only" href="${pageContext.request.contextPath}/login/signin" style="height: 15px; width: 17px; margin-left: 2px; margin-top: 5px;float: left;"><span style="margin-left: -12px; margin-top: -6px;" class="ui-icon ui-icon-power" title="Login"></span></a>
		</div>
	</div>

</body>
</html>