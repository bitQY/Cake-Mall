<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/27
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>购物车</title>
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
<jsp:include page="header.jsp?flag=2"/>
<!--end header-->


<!--cart-items-->
<div class="cart-items">
    <div class="container">



        <h2>我的购物车</h2>

        <c:forEach var="item" items="${order.itemMap}">
            <div class="cart-header col-md-6">
                <div class="cart-sec simpleCart_shelfItem">
                    <div class="cart-item cyc">
                        <a href="${ctx}/goods_detail?id=${item.value.goodsId}">
                            <img src="${ctx}${item.value.goods.cover}" class="img-responsive">
                        </a>
                    </div>
                    <div class="cart-item-info">
                        <h3><a href="${ctx}/goods_detail?id=${item.value.goodsId}">${item.value.goods.name}</a></h3>
                        <h3><span>单价: ¥ ${item.value.goods.price}</span></h3>
                        <h3><span>数量: ${item.value.amount}</span></h3>
                        <a class="btn btn-info" href="javascript:buy(${item.value.goodsId});">增加</a>
                        <a class="btn btn-warning" href="javascript:lessen(${item.value.goodsId});">减少</a>
                        <a class="btn btn-danger" href="javascript:deletes(${item.value.goodsId});">删除</a>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </c:forEach>



        <div class="cart-header col-md-12">
            <hr>
            <h3>订单总金额: ¥ ${order.total}</h3>
            <a class="btn btn-success btn-lg" style="margin-left:74%" href="${ctx}/order_submit.jsp">提交订单</a>
        </div>



    </div>
</div>
<!--//cart-items-->


<!--footer-->
<jsp:include page="footer.jsp"/>
<!--end footer-->
</body>
</html>
