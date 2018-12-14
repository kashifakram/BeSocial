<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div>
    <c:forEach items="${timeline}" var="tweet">
        <div>
            <p>${tweet.name}</p>
            <p>${tweet.text}</p>
            <p>${tweet.time}</p>
        </div>
    </c:forEach>
</div>
