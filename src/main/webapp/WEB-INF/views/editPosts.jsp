<%--
  Created by IntelliJ IDEA.
  User: yuxia
  Date: 2018/9/26
  Time: 19:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Post</title>
    <style type="text/css">
        .error {
            color: red;
        }
        table {
            width: 50%;
            border-collapse: collapse;
            border-spacing: 0px;
        }
        table td {
            border: 1px solid #565454;
            padding: 20px;
        }
    </style>
</head>
<body>
<h1>Input Form</h1>
<form:form action="addUser" method="post" modelAttribute="post">
    <table>
        <tr>
            <td>id</td>
            <td>
                <form:input path="id" /> <br />
                <form:errors path="id" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td>accid</td>
            <td>
                <form:input path="accId" /> <br />
                <form:errors path="accId" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td>account</td>
            <td>
                <form:input path="account" /> <br />
                <form:errors path="account" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td colspan="2"><button type="submit">Submit</button></td>
        </tr>
    </table>
</form:form>
<h2>Users List</h2>
<table>
    <tr>
        <td><strong>id</strong></td>
        <td><strong>Account</strong></td>
    </tr>
    <c:forEach items="${posts}" var="post">
        <tr>
            <td>${post.id}</td>
            <td>${post.accId}</td>
            <td>${post.account}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
