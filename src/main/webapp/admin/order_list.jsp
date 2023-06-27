<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/22
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>订单列表</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp?flag=1"/>
<div class="container-fluid">
    <br>

    <ul role="tablist" class="nav nav-tabs">
        <li <c:if test="${status==0}">class="active"</c:if>role="presentation"><a href="${ctx}/admin/order?">全部订单</a></li>
        <li <c:if test="${status==1}">class="active"</c:if>role="presentation"><a href="${ctx}/admin/order?status=1">未付款</a></li>
        <li <c:if test="${status==2}">class="active"</c:if>role="presentation"><a href="${ctx}/admin/order?status=2">已付款</a></li>
        <li <c:if test="${status==3}">class="active"</c:if>role="presentation"><a href="${ctx}/admin/order?status=3">配送中</a></li>
        <li <c:if test="${status==4}">class="active"</c:if>role="presentation"><a href="${ctx}/admin/order?status=4">已完成</a></li>
    </ul>

    <br>

    <table class="table table-bordered table-hover">

        <tbody><tr>
            <th width="5%">ID</th>
            <th width="5%">总价</th>
            <th width="15%">商品详情</th>
            <th width="20%">收货信息</th>
            <th width="10%">订单状态</th>
            <th width="10%">支付方式</th>
            <th width="10%">下单用户</th>
            <th width="10%">下单时间</th>
            <th width="10%">操作</th>
        </tr>

        <c:forEach items="${orderDtoPage.records}" var="order">
            <tr>
                <td><p>${order.id}</p></td>
                <td><p>${order.total}</p></td>
                <td>
                    <c:forEach items="${order.orderItemDtoList}" var="item">
                        <p>${item.goods.name}(${item.price})✖${item.amount}</p>
                    </c:forEach>

                </td>
                <td>
                    <p>${order.name}</p>
                    <p>${order.phone}</p>
                    <p>${order.address}</p>
                </td>
                <td>
                    <p>
                        <c:if test="${order.status==2}"><span style="color:red;">已付款</span></c:if>
                        <c:if test="${order.status==3}"><span style="color:orange;">已发货</span></c:if>
                        <c:if test="${order.status==4}"><span style="color:green;">已完成</span></c:if>

                    </p>
                </td>
                <td>
                    <p>
                        <c:if test="${order.paytype==1}">微信</c:if>
                        <c:if test="${order.paytype==2}">支付宝</c:if>
                        <c:if test="${order.paytype==3}">货到付款</c:if>
                    </p>
                </td>
                <td><p>${order.user.username}</p></td>
                <td><p>${order.datetime}</p></td>
                <td>
                    <c:if test="${order.status==2}">
                        <a class="btn btn-success" href="${ctx}/admin/orderUpdate?id=${order.id}&page=${orderDtoPage.current}&status=3">发货</a>
                    </c:if>
                    <c:if test="${order.status==3}">
                        <a class="btn btn-success" href="${ctx}/admin/orderUpdate?id=${order.id}&page=${orderDtoPage.current}&status=4">完成</a>
                    </c:if>
                     <a class="btn btn-danger" href="javascript:void(0)" onclick="deleteOrder(${order.id})">删除</a>
                </td>
            </tr>
        </c:forEach>

        </tbody></table>

    <br>

    <div style="text-align:center;">
        <a class="btn btn-info" href="${ctx}/admin/order?page=1">首页</a>
        <a class="btn btn-info" href="${ctx}/admin/order?status=${status}&page=${orderDtoPage.current-1<=0?1:orderDtoPage.current-1}">上一页</a>
        <h3 style="display:inline;">[${orderDtoPage.current}/${orderDtoPage.pages}]</h3>
        <a class="btn btn-info" href="${ctx}/admin/order?status=${status}&page=${orderDtoPage.current+1<orderDtoPage.pages?orderDtoPage.current+1:orderDtoPage.pages}">下一页</a>
        <a class="btn btn-info" href="${ctx}/admin/order?status=${status}&page=${orderDtoPage.pages}">尾页</a>
        <input type="text" class="form-control" style="display:inline;width:60px;" value=""><a class='btn btn-info' href='javascript:void(0);' onclick='location.href="${ctx}/admin/order?page="+(this.previousElementSibling.value)+"&status=${status}"'>GO</a>
    </div>

    <br>
</div>
</body>
<script>
    function deleteOrder(Orderid) {
        if (confirm("确定删除？")){
            $.post("${ctx}/admin/orderDelete",{oid:Orderid},function (data) {
                if (data=="ok"){
                    location.reload();
                }
            })
        }
    }
</script>

</html>
