<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

[
<c:forEach var="e" items="${list }" varStatus="status">
	<c:if test="${not status.first }">,</c:if>
	{num:${e.num }, name:'${e.name }', sale:'${e.sale}'} 
</c:forEach>
]
