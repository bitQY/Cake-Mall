<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/20
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>
<div class="container-fluid">


  <br><br>
  <form class="form-horizontal" action="${ctx}/admin/goodsupdate" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${g.id}">
    <input type="hidden" name="cover" value="${g.cover}">
    <input type="hidden" name="image1" value="${g.image1}">
    <input type="hidden" name="image2" value="${g.image2}">
    <input type="hidden" name="page" value="${page}">
    <input type="hidden" name="type1" value="${type}">
    <div class="form-group">
      <label for="input_name" class="col-sm-1 control-label">名称</label>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="input_name" name="name" value="${g.name}" required="required">
      </div>
    </div>
    <div class="form-group">
      <label for="input_name1" class="col-sm-1 control-label">价格</label>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="input_name1" name="price" value="${g.price}">
      </div>
    </div>
    <div class="form-group">
      <label for="input_name2" class="col-sm-1 control-label">介绍</label>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="input_name2" name="intro" value="${g.intro}">
      </div>
    </div>
    <div class="form-group">
      <label for="input_name3" class="col-sm-1 control-label">库存</label>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="input_name3" name="stock" value="${g.stock}">
      </div>
    </div>
    <div class="form-group">
      <label for="input_file1" class="col-sm-1 control-label">封面图片</label>
      <div class="col-sm-6"><img src="${ctx}/${g.cover}" width="100" height="100">
        <input type="file" name="cover1" id="input_file1">推荐尺寸: 500 * 500
      </div>
    </div>
    <div class="form-group">
      <label for="input_file2" class="col-sm-1 control-label">详情图片1</label>
      <div class="col-sm-6"><img src="${ctx}/${g.image1}" width="100" height="100">
        <input type="file" name="image11" id="input_file2">推荐尺寸: 500 * 500
      </div>
    </div>
    <div class="form-group">
      <label for="input_file3" class="col-sm-1 control-label">详情图片2</label>
      <div class="col-sm-6"><img src="${ctx}/${g.image2}" width="100" height="100">
        <input type="file" name="image21" id="input_file3">推荐尺寸: 500 * 500
      </div>
    </div>
    <div class="form-group">
      <label for="select_topic" class="col-sm-1 control-label">类目</label>
      <div class="col-sm-6">
        <select class="form-control" id="select_topic" name="typeId">
          <c:forEach var="t" items="${typeList}">
            <option <c:if test="${g.typeId==t.id}">selected="selected"</c:if> value="${t.id}">${t.name}</option>
          </c:forEach>
        </select>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-offset-1 col-sm-10">
        <button type="submit" class="btn btn-success">提交修改</button>
      </div>
    </div>
  </form>
</div>

</body>
</html>
