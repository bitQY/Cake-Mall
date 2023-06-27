<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/15
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>后台管理首页</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/materialdesignicons.min.css" rel="stylesheet">
    <link href="css/style.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<br>
<br>
<div class="alert alert-success" role="alert">恭喜你! 登录成功了</div>


</body>
</html>
