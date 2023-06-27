<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/28
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>成功</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/style.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/js/cart.js"></script>
    <link rel="stylesheet" href="${ctx}/css/flexslider.css">
    <link rel="stylesheet" href="${ctx}/js/theme/default/layer.css">
<body>

<!--header-->
<jsp:include page="header.jsp"/>
<!--end header-->

<!--cart-items-->
<div class="cart-items">
    <div class="container">


        <div class="alert alert-success">订单支付成功！</div>


        <p><a class="btn btn-success" href="${ctx}/order_list">查看我的订单</a></p>
    </div>
</div>
<!--//cart-items-->

<!--footer-->
<jsp:include page="footer.jsp"/>
<!--end footer-->
</body>
</html>
