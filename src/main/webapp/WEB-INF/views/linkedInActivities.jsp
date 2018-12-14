<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div>
    <c:forEach items="${activities}" var="activity">
        <div>
            <p>${activity.firstName} ${activity.lastName}</p>
            <p>${activity.text}</p>
            <p>${activity.time}</p>
        </div>
    </c:forEach>
</div>
