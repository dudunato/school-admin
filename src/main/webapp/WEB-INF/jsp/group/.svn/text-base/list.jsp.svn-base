<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="group" items="${listGroup}" varStatus="idx">
	<option value="<fmt:formatNumber type="number" value="${group.id}" />">${group.name}</option>
</c:forEach>