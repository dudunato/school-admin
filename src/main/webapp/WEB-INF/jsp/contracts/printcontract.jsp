<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Contrato do Aluno</title>
<link type="image/png" href="${pageContext.request.contextPath}/images/ico.png" rel="shortcut icon">
<style type="text/css">
@IMPORT url("${pageContext.request.contextPath}/css/cssreset.css");
@IMPORT url("${pageContext.request.contextPath}/css/custom-theme/jquery-ui-1.8.16.custom.css");

@page { 
@top-left{ 
content: "";
} 
@bottom-center { 
content: ""; 
} 
}

body {
	background-color: #999999;
	font-size: 12px !important;
	font-family: "arial" !important;
}

#page {
	font-size: 12px !important;
	font-family: "arial" !important;
	height: 27.1cm;
    width: 18.4cm;
    background: none repeat scroll 0 0 #FFFFFF;
    border-radius: 3px 3px 3px 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.4);
    margin: 1.5cm auto;
    overflow: hidden;
    padding: 1.3cm;
    position: relative;
}


#page p {
/* 	margin: auto; */
/*     width: 650px; */
margin: auto auto auto 45px;
    width: 100%;
}

</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.printElement.min.js"></script>

<script type="text/javascript">

</script>
</head>
<body>

	<div id="page">
		<img alt="..." style="display: block;margin:auto;height: 1.9cm; width: 5.6cm;" src="${pageContext.request.contextPath}/images/imgContract.png">
		<h3 style="font-weight: bolder;" align="center">CONTRATO DE PRESTA��O DE SERVI�OS EDUCACIONAIS</h3>
		
		<p style="margin-top: 25px;display: block;">CONTRATADA (0): Casar�u Comunica��o e Cultura Ltda, inscrito no C.N.P.J./M.F. sob o n� 061427990002-18, com</p>
		<p>sede na cidade de Uberl�ndia, Estado de Minas Gerais, � Rua Vig�rio Dantas, 138 - Fundinho, por seu registro legal;</p>
		<p>CONTRATO DE PRESTA��O DE SERVI�OS CURSOS DE INGL�S - &nbsp;&nbsp;(   ) 1� SEMESTRE <span style="margin-left: 20px;">(   ) 2� SEMESTRE</span></p>
		<p>CONTRATANTE: <span style="text-transform: uppercase;color: black;font-weight: bold;padding: 10px;">${student.name}</span></p>
		<p>Estado Civil: _______________ Profiss�o:______________________ CI/RG: <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${student.rg}</span></p>
		<p>Exp.:__________ CPF/CIC: <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${student.cpf}</span> Email: <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${student.email}</span></p>
		<p>Endere�o: <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${student.address}, ${student.numberHouse}</span></p>
		<p>Bairro: <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${student.neighborhood}</span> Cidade:__________________________Estado:_________ CEP: <span style="text-transform: uppercase;color: black;font-weight: bold;">${student.cep}</span></p>
		<p>Telefone: ${student.tel} Celular: <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${student.cel}</span></p>
		<p>Declara- se ciente   e concorda com o cumprimento das disposi��es como reza esse contrato.</p>
		<p>Curso: curso de Ingl�s Brazilian Way</p>
		<p>Hor�rio: <span style="margin-left: 80px;">Matutino (  )</span>  <span style="margin-left: 80px;">Vespertino (  )</span>  <span style="margin-left: 80px;">Noturno (  )</span></p>
		<p>Pelo presente instrumento de CONTRATO DE PRESTA��O DE SERVI�OS EDUCACIONAIS, Contratada e Contratante</p>
		<p>tem entre si justo e contrato o seguinte:</p>
		<p>Cl�usula 1&ordf; - O presente Contrato � celebrado sob a �gide da Lei n� 8.078, de 11 de setembro de 1.990 e demais</p>
		<p>disposi��es legais vigentes.</p>
		<p>Cl�usula 2&ordf; - A Contratada obriga- se a ministrar instru��o, por meio de aulas e demais atividades, de acordo com a</p>
		<p>sua caracter�stica e peculiaridade para o curso de Ingl�s Brazilian Way, no per�odo de </p>
		<p><span style="padding: 10px 10px 10px 0;text-transform: uppercase;color: black;font-weight: bold;">${contract.beginDate}</span> <span style="color: black;font-weight: bold;">a </span> <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">${contract.endDate}</span> , sendo 2 horas/aula  por semana, salvo quando houver feriados, e </p>
		<p>recesso de 15 dias ao fim de cada semestre.</p>
		<p>Cl�usula 3&ordf; - As aulas ser�o ministradas nas salas, ou em local que a Contratada indicar, tendo em vista a natureza de</p>
		<p>conte�do e da t�cnica pedag�gica necess�ria.</p>
		<p>Cl�usula 4&ordf; - O servi�o, objeto do presente Contrato, destina-se a grupo formado por no m�nimo 5 alunos e m�ximo</p>
		<p>de 10. A contratada reserva o direito de adiar o curso caso o n�mero m�nimo de alunos n�o seja atingido. </p>
		<p>Cl�usula 5&ordf; - � de atribui��o exclusiva da Contratada o planejamento e a presta��o dos servi�os de ensino, em</p>
		<p>especial o que se refere � orienta��o did�tica - pedag�gica e educacional, sele��o de material did�tico, designa��o</p>
		<p>de professores e eventual altera��o, fixa��o do in�cio das aulas, carga hor�ria do curso, al�m de outras provid�ncias</p>
		<p>que as atividades docentes exigirem, obedecendo a seu exclusivo crit�rio, sem inger�ncia do(s) Contratantes(s).</p>
		<p>Cl�usula 6&ordf; - Como contrapresta��o pelos servi�os ora contratados, o(s) Contratante(s) pagar� (�o) � Contratada o</p>
		<p>respectivo valor por modulo: </p>
		<p><span style="padding: 10px 10px 10px 0;text-transform: uppercase;color: black;font-weight: bold;">R$ ${contract.totalValue }</span> (_____________________________________________________________________________)</p>
		<p>� vista:  <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">R$ ${contract.entryValue }</span>   (__) X <span style="padding: 10px;text-transform: uppercase;color: black;font-weight: bold;">R$ ${contract.monthlyPaymentValue }</span>   (__) X <span style="text-transform: uppercase;color: black;font-weight: bold;">R$ ${ contract.alternativePaymentValue }</span></p>
		<p><span>Modulo I (   )</span> <span style="margin-left: 80px;">Modulo II  (   )</span> <span style="margin-left: 80px;">Modulo III  (   )</span></p>
		<p>Curso:__________________________________________________________________________________________</p>
		<p>As parcelas dever�o ser pagas antecipadas no ato da assinatura desse contrato, podendo ser efetuado por meio de</p>
		<p>cheque pr�-datado (do contratante) ou cart�o de cr�dito ou boleto banc�rio.</p>
		<p>O aluno que por algum motivo n�o possa dar continuidade ao curso dever� arcar com 50% do valor total at� o final</p>
		<p>do contrato, para que os demais alunos que permanecerem no curso n�o sejam prejudicados. </p>
		<p>Cl�usula 7&ordf; - Na hip�tese de outra empresa vir a suceder a (o) "Contratada" (o) as cl�usulas ora pactuadas ficar�o </p>
		<p>automaticamente ratificadas, devendo, todavia, os pagamentos serem efetuados a favor da sucessora, conforme</p>
		<p>comunica��o a ser efetuada por escrito na ocasi�o.</p>
		<p>Cl�usula 8-&ordf; - Para dirimir quest�es oriundas desse Contrato, fica eleito o Foro da Cidade de Uberl�ndia (sede da</p>
		<p>mantenedora). E por estarem justos e contratados, assinam o presente instrumento, em duas vias de igual teor e</p>
		<p>forma, na presen�a das testemunhas subscritas, a fim de que se produzam os eleitos legais.</p>
		<p>Uberl�ndia,  ______ de _________________________ de ___________.</p>
		<div style="float: left;margin-left: 40px;margin-top: 15px;line-height: 100% !important;">
			<span style="float: left;">.......................................................</span>
			<span style="float: left;clear: left;">Contratante(s) </span>
		</div>
		<div style="float: left;margin-left: 80px;margin-top: 15px;line-height: 100% !important;">
			<span style="float: left;">.......................................................</span>
			<span style="float: left;clear: left;">Contratada(o)   (Mantenedor)</span>
		</div>
		<div style="float: left; clear: left;margin-left: 40px;margin-top: 15px;line-height: 100% !important;">
			<span style="float: left;">.......................................................</span>
			<span style="float: left;clear: left;">Testemunha</span>                                
		</div>
		<div style="float: left;margin-left: 80px;margin-top: 15px;line-height: 100% !important;">
			<span style="float: left;">.......................................................</span>
			<span style="float: left;clear: left;">Testemunha</span>
		</div>
	</div>

</body>
</html>