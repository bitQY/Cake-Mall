<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/20
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>商品添加</title>
    <link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>
<div class="container-fluid">


    <br><br>
    <form class="form-horizontal" action="${ctx}/admin/goodsadd" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="input_name" class="col-sm-1 control-label">名称</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="input_name" name="name" value="" required="required">
            </div>
        </div>
        <div class="form-group">
            <label for="input_name1" class="col-sm-1 control-label">价格</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="input_name1" name="price" value="">
            </div>
        </div>
        <div class="form-group">
            <label for="input_name2" class="col-sm-1 control-label">介绍</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="input_name2" name="intro" value="">
            </div>
        </div>
        <div class="form-group">
            <label for="input_name3" class="col-sm-1 control-label">库存</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="input_name3" name="stock" value="">
            </div>
        </div>
        <div class="form-group">
            <label for="input_file1" class="col-sm-1 control-label">封面图片</label>
            <div class="col-sm-6">
                <input type="file" name="cover" id="input_file1">推荐尺寸: 500 * 500
            </div>
        </div>
        <div class="form-group">
            <label for="input_file2" class="col-sm-1 control-label">详情图片1</label>
            <div class="col-sm-6">
                <input type="file" name="image1" id="input_file2">推荐尺寸: 500 * 500
            </div>
        </div>
        <div class="form-group">
            <label for="input_file3" class="col-sm-1 control-label">详情图片2</label>
            <div class="col-sm-6">
                <input type="file" name="image2" id="input_file3">推荐尺寸: 500 * 500
            </div>
        </div>
        <div class="form-group">
            <label for="select_topic" class="col-sm-1 control-label">类目</label>
            <div class="col-sm-6">
                <select class="form-control" id="select_topic" name="type_id">
                    <c:forEach var="t" items="${typeList}">
                        <option value="${t.id}">${t.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-1 col-sm-10">
                <button type="submit" class="btn btn-success">提交</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
