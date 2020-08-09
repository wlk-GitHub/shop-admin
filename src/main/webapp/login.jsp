
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>登录</title>
    <!-- Bootstrap -->
    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>


<div class="row">
    <div class="col-md-12">
        <form class="form-horizontal">
            <div class="form-group">
                <label  class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="memberName" placeholder="请输入用户名...">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">密码</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="password" placeholder="请输入密码...">
                </div>
            </div>


            <div class="row">
                <div class="col-md-8" style="text-align:center">
                    <button type="button" class="btn btn-primary" onclick="login()">
                        <span class=""></span>&nbsp;<i class="glyphicon glyphicon-ok"></i>登陆
                    </button>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="reset" class="btn btn-danger" onclick="history.go(0)">
                        <span class=""></span>&nbsp;<i class="glyphicon glyphicon-refresh"></i>重置
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>


<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="/js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="/js/bootstrap3/js/bootstrap.min.js"></script>
<script>
    function login() {
        // js验证
        var v_memberName = $("#memberName").val();
        var v_password = $("#password").val();
        $.ajax({
            type:"post",
            url:"<%=request.getContextPath()%>/user/login",
            data:{"userName":v_memberName,"password":v_password},
            success:function (result) {
                if (result.code == 200) {
                    location.href="<%=request.getContextPath()%>/product/toList";
                } else {
                    alert(result.msg);
                }
            }
        })
    }
</script>
</body>
</html>
