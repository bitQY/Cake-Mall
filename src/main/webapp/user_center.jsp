<%--
  Created by IntelliJ IDEA.
  User: MQY
  Date: 2022/11/20
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>个人中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/style.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/simpleCart.min.js"></script>
</head>
<body>
<!--header-->
<jsp:include page="header.jsp?flag=8"/>
<!--end header-->

<!--account-->
<div class="account">
    <div class="container">
        <div class="register">
            <c:if test="${!empty msg }">
                <div class="alert alert-success">${msg }</div>
            </c:if>
            <c:if test="${!empty failMsg }">
                <div class="alert alert-danger">${failMsg }</div>
            </c:if>

            <div class="register-top-grid">
                <h3>个人中心</h3>
                <form action="${ctx}/user_update" method="post">
                    <input type="hidden" name="id" value="${loginuser.id}">
                    <!-- 收货信息 start -->
                    <h4>收货信息</h4>
                    <div class="input">
                        <span>收货人<label></label></span>
                        <input type="text" name="name" value="${loginuser.name}" placeholder="请输入收货人">
                    </div>
                    <div class="input">
                        <span>收货电话</span>
                        <input type="text" name="phone" value="${loginuser.phone}" placeholder="请输入收货电话">
                    </div>
                    <div class="input">
                        <span>收货地址</span>
                        <input type="text" name="address" value="${loginuser.address}" placeholder="请输入收货地址">
                    </div>
                    <div class="register-but text-center">
                        <input type="submit" value="提交">
                    </div>
                    <!-- 收货信息 end -->
                </form>
                <hr>
                <form action="${ctx}/user_updatepwd" method="post">
                    <input type="hidden" name="id" value="${loginuser.id}">
                    <h4>安全信息</h4>
                    <div class="input">
                        <span>原密码</span>
                        <input type="text" id="oldpassword" placeholder="请输入原密码"><div id="div1"></div>
                    </div>
                    <div class="input">
                        <span>新密码</span>
                        <input type="text" name="password" placeholder="请输入新密码">
                    </div>
                    <div class="clearfix"> </div>
                    <div class="register-but text-center">
                        <input type="submit" value="提交">
                    </div>
                </form>
            </div>

            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<!--//account-->


<!--footer-->
<jsp:include page="footer.jsp"/>
<!--end footer-->
<script>
    $("#oldpassword").blur(function () {
        $.ajax({
            type:"get",
            url:"checkPasssword",
            data:{password:$("#oldpassword").val(),id:${loginuser.id}},
            dataType:"html",
            success:function (data) {
                if (data==1){
                    $("#div1").html("<font color='red'>原密码错误</font>")
                }
                else {
                    $("#div1").html("<font color='green'>☑</font>")
                }
            }
        });

    });

</script>

</body>
</html>
