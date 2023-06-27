<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/22
  Time: 17:13
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
<%--
<c:if test="${type.id!=-2&&type.id!=-3}">
    <jsp:include page="header.jsp?flag=2"/>
</c:if>
--%>

<c:if test="${type.id==2}">
    <jsp:include page="header.jsp?flag=3"/>
</c:if>
<c:if test="${type.id==3}">
    <jsp:include page="header.jsp?flag=4"/>
</c:if>
<!--end header-->


<!--products-->
<div class="products">
    <div class="container">
        <h2>
            ${type.id==2?"热销系列":"新品系列"}
        </h2>

        <div class="col-md-12 product-model-sec">

            <c:forEach var="g" items="${pageInfo.list}">
                <div class="product-grid">
                    <a href="${ctx}/goods_detail?id=${g.goods.id}">
                        <div class="more-product"><span> </span></div>
                        <div class="product-img b-link-stripe b-animate-go  thickbox">
                            <img src="${ctx}${g.goods.cover}" class="img-responsive" alt="${g.goods.name}" width="240" height="240">
                            <div class="b-wrapper">
                                <h4 class="b-animate b-from-left  b-delay03">
                                    <button href="/goods_detail?id=${g.goods.id}">查看详情</button>
                                </h4>
                            </div>
                        </div>
                    </a>
                    <div class="product-info simpleCart_shelfItem">
                        <div class="product-info-cust prt_name">
                            <h4>${g.goods.name}</h4>
                            <span class="item_price">¥ ${g.goods.price}</span>
                            <input type="button" class="item_add items" value="加入购物车" onclick="buy(${g.goods.id})">
                            <div class="clearfix"> </div>
                        </div>
                    </div>
                </div>
            </c:forEach>



        </div>



        <c:if test="${not empty pageInfo.pages}">
            <div style="text-align:center;">
                <a class="btn btn-info" href="${ctx}/goods_types?&typeId=${type.id}&page=1">首页</a>
                <a class="btn btn-info" href="${ctx}/goods_types?typeId=${type.id}&page=${pageInfo.prePage}">上一页</a>
                <h3 style="display:inline;">[${pageInfo.pageNum}/${pageInfo.pages}]</h3>
                <h3 style="display:inline;">[${pageInfo.total}]</h3>
                <a class="btn btn-info" href="${ctx}/goods_types?typeId=${type.id}&page=${pageInfo.nextPage}">下一页</a>
                <a class="btn btn-info" href="${ctx}/goods_types?typeId=${type.id}&page=${pageInfo.pages}">尾页</a>
                <form action="${ctx}/goods_types?typeId=${type.id}" method="post">
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
