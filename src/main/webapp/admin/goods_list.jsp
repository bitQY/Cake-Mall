<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/19
  Time: 21:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>商品列表</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp?flag=3"/>
<div class="container-fluid">

    <div class="text-right"><a class="btn btn-warning" href="${ctx}/admin/goods_add.jsp">添加商品</a></div>
    <br>

    <ul role="tablist" class="nav nav-tabs">
        <li <c:if test="${type==0}">class="active"</c:if> role="presentation"><a href="${ctx}/admin/goods">全部商品</a></li>
        <li <c:if test="${type==1}">class="active"</c:if> role="presentation"><a href="${ctx}/admin/goods?type=1">条幅推荐</a></li>
        <li <c:if test="${type==2}">class="active"</c:if> role="presentation"><a href="${ctx}/admin/goods?type=2">热销推荐</a></li>
        <li <c:if test="${type==3}">class="active"</c:if> role="presentation"><a href="${ctx}/admin/goods?type=3">新品推荐</a></li>
    </ul>



    <br>

    <table class="table table-bordered table-hover">

        <tbody><tr>
            <th width="5%">ID</th>
            <th width="10%">图片</th>
            <th width="10%">名称</th>
            <th width="20%">介绍</th>
            <th width="10%">价格</th>
            <th width="10%">类目</th>
            <th width="25%">操作</th>
        </tr>

<c:forEach var="g" items="${pageInfo.list}">
    <tr>
        <td><p>${g.id}</p></td>
        <td><p><a href="http://localhost:8084/goods_detail?id=9" target="_blank"><img src="${ctx}/${g.cover}" width="100px" height="100px"></a></p></td>
        <td><p><a href="http://localhost:8084/goods_detail?id=9" target="_blank">${g.name}</a></p></td>
        <td><p>${g.intro}</p></td>
        <td><p>${g.price}</p></td>
        <td><p>${g.type.name}</p></td>
        <td>
            <p>
                    <%--条幅 --%>
                <c:if test="${g.recommend.type==1 }">
                    <a class="btn btn-info" href="${ctx}/admin/goodsrecommend?id=${g.id }&method=remove&typeTarget=1&page=${pageInfo.pageNum}&type=${type}">移出条幅</a>
                </c:if>
                <c:if test="${g.recommend.type!=1}">
                    <a class="btn btn-primary" href="${ctx}/admin/goodsrecommend?id=${g.id }&method=add&typeTarget=1&page=${pageInfo.pageNum}&type=${type}">加入条幅</a>
                </c:if>
                    <%--热销 --%>
                <c:if test="${g.recommend.type==2 }">
                    <a class="btn btn-info" href="${ctx}/admin/goodsrecommend?id=${g.id }&method=remove&typeTarget=2&page=${pageInfo.pageNum}&type=${type}">移出热销</a>
                </c:if>
                <c:if test="${g.recommend.type!=2}">
                    <a class="btn btn-primary" href="${ctx}/admin/goodsrecommend?id=${g.id }&method=add&typeTarget=2&page=${pageInfo.pageNum}&type=${type}">加入热销</a>
                </c:if>
                    <%--新品 --%>
                <c:if test="${g.recommend.type==3 }">
                    <a class="btn btn-info" href="${ctx}/admin/goodsrecommend?id=${g.id }&method=remove&typeTarget=3&page=${pageInfo.pageNum}&type=${type}">移出新品</a>
                </c:if>
                <c:if test="${g.recommend.type!=3}">
                    <a class="btn btn-primary" href="${ctx}/admin/goodsrecommend?id=${g.id }&method=add&typeTarget=3&&page=${pageInfo.pageNum}&type=${type}">加入新品</a>
                </c:if>
            </p>
            <a class="btn btn-success" href="${ctx}/admin/goodsedit?id=${g.id}&page=${pageInfo.pageNum}&type=${type}">修改</a>
            <a class="btn btn-danger" href="javascript:void(0)" onclick="deleteGoods(${g.id})">删除</a>
        </td>
    </tr>
</c:forEach>



        </tbody></table>

    <br>



    <div style="text-align:center;">
        <a class="btn btn-info" href="${ctx}/admin/goods?page=1&type=${type}">首页</a>
        <a class="btn btn-info" href="${ctx}/admin/goods?page=${pageInfo.prePage}&type=${type}">上一页</a>
        <h3 style="display:inline;">[${pageInfo.pageNum}/${pageInfo.pages}]</h3>
        <a class="btn btn-info" href="${ctx}/admin/goods?page=${pageInfo.nextPage}&type=${type}">下一页</a>
        <a class="btn btn-info" href="${ctx}/admin/goods?page=${pageInfo.pages}&type=${type}">尾页</a>
        <input type="text" class="form-control" style="display:inline;width:60px;" value=""><a class="btn btn-info" href="javascript:void(0);" onclick="location.href=&quot;${ctx}/admin/goods?page=&quot;+(this.previousElementSibling.value)+&quot;&amp;type=${type}&quot;">GO</a>
    </div>

    <br>
</div>
<script>
    function deleteGoods(goodsid) {
        if (confirm("确定删除？")){
            $.post("${ctx}/admin/goodsdelete",{gid:goodsid},function (data) {
                if (data=="ok"){
                    location.reload();
                }
            })
        }
    }
</script>
</body>
</html>
