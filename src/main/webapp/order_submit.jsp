<%@ page import="com.miaoqy.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/28
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>支付</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/style.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/js/cart.js"></script>
    <link rel="stylesheet" href="${ctx}/css/flexslider.css">
    <link rel="stylesheet" href="${ctx}/js/theme/default/layer.css">
</head>
<body>
<!--header-->
<jsp:include page="header.jsp"/>
<!--end header-->
<%
    User user = (User) session.getAttribute("loginuser");
    if (user==null){
        request.setAttribute("failMsg","您尚未登录，请登录后购买商品");
        request.getRequestDispatcher("user_login.jsp").forward(request,response);
    }
%>

<div class="cart-items">
    <div class="container">
        <h2>确认收货信息</h2>
        <form class="form-horizontal" action="${ctx}/order_confirm" method="post" id="payform">
            <div class="row">
                <label class="control-label col-md-1">收货人</label>
                <div class="col-md-6">
                    <input type="text" class="form-control" name="name" value="${loginuser.name}" style="height:auto;padding:10px;" placeholder="输入收货人" required="required"><br>
                </div>
            </div>
            <div class="row">
                <label class="control-label col-md-1">收货电话</label>
                <div class="col-md-6">
                    <input type="text" class="form-control" name="phone" value="${loginuser.phone}" style="height:auto;padding:10px;" placeholder="输入收货电话" required="required"><br>
                </div>
            </div>
            <div class="row">
                <label class="control-label col-md-1">收货地址</label>
                <div class="col-md-6">
                    <input type="text" class="form-control" name="address" value="${loginuser.address}" style="height:auto;padding:10px;" placeholder="输入收货地址" required="required"><br>
                </div>
            </div>

            <br><hr><br>

            <h2>选择支付方式</h2>
            <h3>支付金额: ${order.total}</h3><br><br>


            <div class="col-sm-6 col-md-4 col-lg-3 ">
                <label>
                    <div class="thumbnail">
                        <input type="radio" name="paytype" value="1" checked="checked">
                        <img src="${ctx}/images/wechat.jpg" alt="微信支付">
                    </div>
                </label>
            </div>
            <div class="col-sm-6 col-md-4 col-lg-3 ">
                <label>
                    <div class="thumbnail">
                        <input type="radio" name="paytype" value="2">
                        <img src="${ctx}/images/alipay.jpg" alt="支付宝支付">
                    </div>
                </label>
            </div>

            <div class="clearfix"> </div>
            <div class="register-but text-center">
                <input type="submit" value="确认订单">
                <div class="clearfix"> </div>
            </div>
        </form>
    </div>
</div>

<!--footer-->
<jsp:include page="footer.jsp"/>
<!--end footer-->
<script type="text/javascript">
    function dopay(paytype){
        $("#paytype").val(paytype);
        $("#payform").submit();
    }
</script>
</body>
</html>
