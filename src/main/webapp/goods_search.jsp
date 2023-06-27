<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/24
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>商品列表</title>
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


<!--products-->
<div class="products">
    <div class="container">
        <h2>${keyword}</h2>

        <div class="col-md-12 product-model-sec">

            <c:forEach var="g" items="${goodsPage.records}">
                <div class="product-grid">
                    <a href="${ctx}/goods_detail?id=${g.id}">
                        <div class="more-product"><span> </span></div>
                        <div class="product-img b-link-stripe b-animate-go  thickbox">
                            <img src="${ctx}${g.cover}" class="img-responsive" alt="${g.name}" width="240" height="240">
                            <div class="b-wrapper">
                                <h4 class="b-animate b-from-left  b-delay03">
                                    <button href="/goods_detail?id=${g.id}">查看详情</button>
                                </h4>
                            </div>
                        </div>
                    </a>
                    <div class="product-info simpleCart_shelfItem">
                        <div class="product-info-cust prt_name">
                            <h4>${g.name}</h4>
                            <span class="item_price">¥ ${g.price}</span>
                            <input type="button" class="item_add items" value="加入购物车" onclick="buy(${g.id})">
                            <div class="clearfix"> </div>
                        </div>
                    </div>
                </div>
            </c:forEach>



        </div>




        <c:if test="${not empty goodsPage.total}">
            <div style="text-align:center;">
                <a class="btn btn-info" href="${ctx}/goods_search?keyword=${keyword}&page=1">首页</a>
                <a class="btn btn-info"${page==1?'disabled':''} href="${ctx}/goods_search?keyword=${keyword}&page=${goodsPage.current-1}">上一页</a>
                <h3 style="display:inline;">[${goodsPage.current}/${goodsPage.pages}]</h3>
                <h3 style="display:inline;">[${goodsPage.total}]</h3>
                <a class="btn btn-info" ${page==goodsPage.pages?'disabled':''}href="${ctx}/goods_search?keyword=${keyword}&page=${goodsPage.current+1}">下一页</a>
                <a class="btn btn-info" href="${ctx}/goods_search?keyword=${keyword}&page=${goodsPage.pages}">尾页</a>
                <form action="${ctx}/goods_search?keyword=${keyword}" method="post">
                    <input type="text" class="form-control" style="display:inline;width:60px;" name="page">
                    <input type="submit" class="btn btn-info" value="GO">
                </form>
            </div>
        </c:if>

    </div>
</div>

<!--//products-->

<!--footer-->
<jsp:include page="footer.jsp"/>
<!--end footer-->
</body>
</html>
