<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2023/3/16
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>客户列表</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/materialdesignicons.min.css" rel="stylesheet">
    <link href="css/style.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp?flag=2"/>
<div class="card-body">
    <form action="${ctx}/admin/user" method="post">
        <div class="row">
            <div class="col-xs-3">
                用户名：<input class="form-control" type="text" placeholder="输入用户名" name="username">
            </div>
            <div class="col-xs-3">
                邮箱：<input class="form-control" type="text" placeholder="输入邮箱" name="email">
            </div>
            <div class="form-group">
                <br>
                <button class="btn btn-primary" type="submit">搜索</button>
            </div>
        </div>

    </form>
    <div class="text-right">
        <button type="button" class="btn btn-warning " data-target="#myModal2" data-toggle="modal">
            添加客户
        </button>
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-left">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">添加</h4>
                    </div>
                    <div class="text-left">
                        <form method="post" action="${ctx}/admin/userAdd">
                            <div class="modal-body">
                                <input type="hidden" name="id" value="">
                                用户名：<input type="text" value="" name="username"><br>
                                邮箱：<input type="text" value="" name="email"><br>
                                密码：<input type="text" value="" name="password"><br>
                                收货人：<input type="text" value="" name="name"><br>
                                电话：<input type="text" value="" name="phone"><br>
                                地址：<input type="text" value="" name="address"><br>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <input type="submit" class="btn btn-primary" value="提交">
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="text-right"><a class="btn btn-warning" href="${ctx}/admin/export">导出用户</a></div>
</div>
<div class="container-fluid">

    <c:if test="${!empty msg }">
        <div class="alert alert-success">${msg }</div>
    </c:if>
    <c:if test="${!empty failMsg }">
        <div class="alert alert-danger">${failMsg }</div>
    </c:if>
    <br>
    <br>

    <table class="table table-bordered table-hover">

        <tbody><tr>
            <th width="5%">ID</th>
            <th width="10%">用户名</th>
            <th width="10%">邮箱</th>
            <th width="10%">收件人</th>
            <th width="10%">电话</th>
            <th width="10%">地址</th>
            <th width="12%">操作</th>
        </tr>


        <c:forEach var="t" items="${userPage.records}">
        <tr>
            <td><p>${t.id}</p></td>
            <td><p>${t.username}</p></td>
            <td><p>${t.email}</p></td>
            <td><p>${t.name}</p></td>
            <td><p>${t.phone}</p></td>
            <td><p>${t.address}</p></td>
            <td>
                <%--<a class="btn btn-info" href="${ctx}/admin/user?action=get2&id=${t.id}&pno=${pno}">重置密码</a>--%>

                <button type="button" class="btn btn-info" data-target="#myModal" onclick="RunAlg(this)">
                    重置密码
                </button>
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">重置</h4>
                            </div>
                            <div class="text-left">
                                <form method="post" action="${ctx}/admin/userUpdatePassword">
                                    <div class="modal-body">
                                        <input type="hidden" name="id" value="" id="user_id">
                                        用户名：<input type="text" value="" id="user_username"><br>
                                        新密码：<input type="text" name="password" value=""><br>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <input type="submit" class="btn btn-primary" value="提交">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

               <%-- <a class="btn btn-primary" href="${ctx}/admin/user?action=get&id=${t.id}&pno=${pno}">修改</a>--%>

                    <button type="button" class="btn btn-info" data-target="#myModal1" onclick="RunAlg1(this)">
                        修改
                    </button>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel1">修改</h4>
                                </div>
                                <div class="text-left">
                                    <form method="post" action="${ctx}/admin/userUpdate">
                                        <div class="modal-body">
                                            ID:<input type="text" name="id" value="" id="user_id1"><br>
                                            用户名：<input type="text" value="" name="username" id="user_username1"><br>
                                            邮箱：<input type="text" value="" name="email" id="user_email"><br>
                                            收件人：<input type="text" value="" name="name" id="user_name"><br>
                                            电话：<input type="text" value="" name="phone" id="user_phone"><br>
                                            地址：<input type="text" value="" name="address" id="user_address"><br>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                            <input type="submit" class="btn btn-primary" value="提交">
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                <a class="btn btn-danger" href="${ctx}/admin/userdelete?id=${t.id}">删除</a>
            </td>
        </tr>
        </c:forEach>

        </tbody></table>

    <br>

    <div style="text-align:center;">
        <a class="btn btn-info"  href="${ctx}/admin/user?page=1&username=${username}&email=${email}">首页</a>
        <c:if test="${userPage.current!=1}">
        <a class="btn btn-info"  href="${ctx}/admin/user?page=${userPage.current-1}&username=${username}&email=${email}">上一页</a>
        </c:if>
        <h3 style="display:inline;">[${userPage.current}/${userPage.pages}]</h3>
        <c:if test="${userPage.current<userPage.pages}">
        <a class="btn btn-info"  href="${ctx}/admin/user?page=${userPage.current+1}&username=${username}&email=${email}">下一页</a>
        </c:if>
        <a class="btn btn-info"  href="${ctx}/admin/user?page=${userPage.pages}&username=${username}&email=${email}">尾页</a>
        <input type="text" class="form-control" style="display:inline;width:60px;" value=""><a class="btn btn-info" href="javascript:void(0);" onclick="location.href=&quot;${ctx}/admin/user?&page=&quot;+(this.previousElementSibling.value)+&quot;&quot;&username=${username}&email=${email}">GO</a>
    </div>

    <br>
</div>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="js/main.min.js"></script>

<script>
    function RunAlg(ths){
        $("#myModal").modal('show');
        var $td = $(ths).parent().parent().find('td');
        var nid1 = $td.eq(0).text();
        var nid2 = $td.eq(1).text();
        $("#user_id").val(nid1);
        $("#user_username").val(nid2);
    }

    function RunAlg1(ths){
        $("#myModal1").modal('show');
        var $td = $(ths).parent().parent().find('td');
        var nid1 = $td.eq(0).text();
        var nid2 = $td.eq(1).text();
        var nid3 = $td.eq(2).text();
        var nid4 = $td.eq(3).text();
        var nid5 = $td.eq(4).text();
        var nid6 = $td.eq(5).text();
        $("#user_id1").val(nid1);
        $("#user_username1").val(nid2);
        $("#user_email").val(nid3);
        $("#user_name").val(nid4);
        $("#user_phone").val(nid5);
        $("#user_address").val(nid6);
    }



</script>
</body>
</html>
