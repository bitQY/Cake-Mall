<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/15
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>类目列表</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/materialdesignicons.min.css" rel="stylesheet">
    <link href="css/style.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp?flag=4"/>
<div class="container-fluid">
<br>

<div>
    <form class="form-inline" method="post" action="${ctx}/admin/typeAdd">
        <input type="text" class="form-control" id="input_name" name="name" placeholder="输入类目名称" required="required" style="width: 500px">
        <input type="submit" class="btn btn-warning" value="添加类目">
    </form>
</div>
<br>

<br>

<table class="table table-bordered table-hover">

    <tbody><tr>
        <th width="5%">ID</th>
        <th width="10%">名称</th>
        <th width="10%">操作</th>
    </tr>

    <c:forEach var="t" items="${list}">
    <tr>
        <td><p>${t.id}</p></td>
        <td><p>${t.name}</p></td>
        <td>
            <%--<a class="btn btn-primary" href="${ctx}/admin/type?action=get&id=${t.id}">修改</a>--%>
            <button type="button" class="btn btn-primary" data-target="#myModal1" onclick="RunAlg(this)">
                修改
            </button>
                <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">修改</h4>
                            </div>
                            <form method="post" action="${ctx}/admin/typeUpdate">
                                <div class="modal-body">
                                    类目编号：<input type="text" name="id" value="" id="type_id"><br>
                                    类别名称：<input type="text" name="name" value="" id="type_name"><br>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    <input type="submit" class="btn btn-primary" value="提交">
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

        <a class="btn btn-danger" href="${ctx}/admin/typeDelete?id=${t.id}">删除</a>
        </td>
    </tr>
    </c:forEach>

    </tbody>
</table>
</div>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="js/main.min.js"></script>

<script>
    function RunAlg(ths){
        $("#myModal1").modal('show');
        var $td = $(ths).parent().parent().find('td');
        var nid1 = $td.eq(0).text();
        var nid2 = $td.eq(1).text();
        $("#type_id").val(nid1);
        $("#type_name").val(nid2);
    }
</script>
</body>
</html>
