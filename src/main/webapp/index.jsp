<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/14
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
  <head>
    <title>首页</title>
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
  </head>
  <body>

  <!--header-->
  <jsp:include page="header.jsp?flag=1"/>
  <!--end header-->

  <!--banner-->

  <!--banner 条幅-->
  <div class="banner">
    <div class="container">
      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

        <!-- Wrapper for slides -->
        <!--轮播图-->
        <div class="carousel-inner" role="listbox" id="lunbotu" style="width: 100%; height: 432px;">
          <!--遍历条幅-->

          <c:forEach var="g" items="${bannergoodslist}" varStatus="status">
          <div class="item ${status.first?'active':''}">
            <h2 class="hdng"><a href="${ctx}/goods_detail?id=${g.goods.id}">${g.goods.name}</a><span></span></h2>
            <p>今日精选推荐</p>
            <a class="banner_a" href="javascript:;" onclick="buy(${g.goods.id})">立刻购买</a>
            <div class="banner-text">
              <a href="${ctx}/goods_detail?id=${g.goods.id}">
                <img src="${ctx}${g.goods.cover}" alt="${g.goods.name}" width="350" height="350">
              </a>
            </div>
          </div>
          </c:forEach>

        </div>
        <!--end 轮播图-->
        <!-- Controls -->
        <a style="background-image: none;position: relative;left: 5%;top:-100px" class="left carousel-control" href="${ctx}/#carousel-example-generic" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        </a>
        <a style="background-image: none;position: relative;left: 95%;top:-100px" class="right carousel-control" href="${ctx}/#carousel-example-generic" role="button" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        </a>
      </div>
    </div>
  </div>
  <!--end banner-->
  <!--//banner-->
  <div class="subscribe2"></div>
  <!--热销推荐-->
  <!--gallery-->
  <div class="gallery">
    <div class="container">
      <div class="alert alert-danger">热销推荐</div>
      <div class="gallery-grids">
        <%--遍历热销推荐--%>

        <c:forEach var="g" items="${hotgoodslist}">
        <div class="col-md-4 gallery-grid glry-two">
          <a href="${ctx}/goods_detail?id=${g.goods.id}">
            <img src="${ctx}${g.goods.cover}" class="img-responsive" alt="${g.goods.name}" width="350" height="350">
          </a>
          <div class="gallery-info galrr-info-two">
            <p>
              <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
              <a href="${ctx}/goods_detail?id=${g.goods.id}">查看详情</a>
            </p>
            <a class="shop" href="javascript:;" onclick="buy(${g.goods.id})">立刻购买</a>
            <div class="clearfix"></div>
          </div>
          <div class="galy-info">
            <p>${g.types.name} &gt; ${g.goods.name}</p>
            <div class="galry">
              <div class="prices">
                <h5 class="item_price">¥ ${g.goods.price}</h5>
              </div>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
        </c:forEach>


      </div>
      <!--end 热销推荐-->
      <!--新品推荐-->
      <div class="clearfix"></div>
      <div class="alert alert-info">新品推荐</div>
      <div class="gallery-grids">
        <%--遍历新品推荐--%>

        <c:forEach var="g" items="${newgoodslist}">
        <div class="col-md-3 gallery-grid ">
          <a href="${ctx}/goods_detail?id=${g.goods.id}">
            <img src="${ctx}${g.goods.cover}" class="img-responsive" alt="${g.goods.name}">
          </a>
          <div class="gallery-info">
            <p>
              <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
              <a href="${ctx}/goods_detail?id=${g.goods.id}">查看详情</a>
            </p>
            <a class="shop" href="javascript:;" onclick="buy(${g.goods.id})">立刻购买</a>
            <div class="clearfix"></div>
          </div>
          <div class="galy-info">
            <p>${g.types.name}&gt; ${g.goods.name}</p>
            <div class="galry">
              <div class="prices">
                <h5 class="item_price">¥ ${g.goods.price}</h5>
              </div>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
        </c:forEach>


      </div>
      <!--end 新品推荐-->
    </div>
  </div>
  <div class="subscribe"></div>

  <!--footer-->
  <jsp:include page="footer.jsp"/>
  <!--end footer-->
  </body>
</html>
