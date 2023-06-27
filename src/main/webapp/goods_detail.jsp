<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/22
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>商品详情页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/style.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/js/cart.js"></script>
    <link rel="stylesheet" href="${ctx}/css/flexslider.css">
    <link rel="stylesheet" href="${ctx}/js/theme/default/layer.css">
    <!--图片滚动和样式-->
    <script type="text/javascript" src="${ctx}/js/jquery.flexslider.js"></script>
    <script>
        $(function() {
            $('.flexslider').flexslider({
                animation: "slide",
                controlNav: "thumbnails"
            });
        });
    </script>
</head>
<body>
<!--header-->
<jsp:include page="header.jsp?flag=2"/>
<!--end header-->

<!--//single-page-->
<div class="single">
    <div class="container">
        <div class="single-grids">
            <div class="col-md-4 single-grid">
                <div class="flexslider">
                    <ul class="slides">
                        <li data-thumb="${ctx}${good.cover}">
                            <div class="thumb-image"> <img src="${ctx}${good.cover}" data-imagezoom="true" class="img-responsive"> </div>
                        </li>
                        <li data-thumb="${ctx}${good.image1}">
                            <div class="thumb-image"> <img src="${ctx}${good.image1}" data-imagezoom="true" class="img-responsive"> </div>
                        </li>
                        <li data-thumb="${ctx}${good.image2}">
                            <div class="thumb-image"> <img src="${ctx}${good.image2}" data-imagezoom="true" class="img-responsive"> </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-md-4 single-grid simpleCart_shelfItem">
                <h3>${good.name}</h3>
                <div class="tag">
                    <p>分类 : <a href="http://localhost:8083/goods_list?typeid=2">${good.type.typename}</a></p>
                </div>
                <p>${good.intro}</p>
                <div class="galry">
                    <div class="prices">
                        <h5 class="item_price">${good.price}</h5>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="btn_form">
                    <a href="javascript:;" class="add-cart item_add" onclick="buy(${good.id})">加入购物车</a>
                </div>
            </div>
            <div class="col-md-4 single-grid1">
                <!-- <h2>商品分类</h2> -->
                <ul>
                    <li><a href="http://localhost:8083/goods_list">全部系列</a></li>
                    <c:forEach var="t" items="${typeList}">
                        <li><a href="${ctx}/goods_list?typeId=${t.id}">${t.name}</a></li>
                    </c:forEach>

                </ul>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>


<!--footer-->
<jsp:include page="footer.jsp"/>
<!--end footer-->
</body>
</html>
