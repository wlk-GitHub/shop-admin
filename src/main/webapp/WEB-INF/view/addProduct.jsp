<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/14
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <!-- Bootstrap -->
    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link type="text/css" rel="stylesheet" href="/js/fileinput5/css/fileinput.css" />
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <form class="form-horizontal">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">商品名</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="productName" placeholder="请输入商品名...">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">主图</label>
                    <div class="col-sm-10">
                        <input type="file" id="mainImage" name="imageInfo">
                        <input type="text" id="mainImagePath"/>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">商品价格</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="price" placeholder="请输入商品价格...">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">品牌</label>
                    <div class="col-sm-10">
                        <select id="addBrand" class="form-control">
                            <option value="-1">请选择</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">创建时间</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="createDate" placeholder="请选择时间...">
                    </div>
                </div>
                <div style="text-align: center;">
                    <button type="button" class="btn btn-primary" onclick="addProduct();"><i class="glyphicon glyphicon-ok"></i> 增加</button>
                    <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>


    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="/js/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="/js/bootstrap3/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/js/fileinput5/js/fileinput.min.js"></script>
    <script src="/js/fileinput5/js/locales/zh.js"></script>


    <script>
        $(function () {
            //初始化查询条件面板中产地下拉框
            initBrandSelect();
            initDate();
            initMainImage();
        })

        //初始化图片上传
        function initMainImage() {
            var s = {
                language: 'zh',
                uploadUrl: "/file/uploadImage",
                showUpload : false,
                showRemove : false,
                allowedFileExtensions : [ 'jpg', 'png', 'jpeg', 'gif'] //上传的文件的后缀名
            };
            $("#mainImage").fileinput(s).on("fileuploaded", function (event, r, previewId, index){
                var result = r.response;
                if (result.code == 200) {
                    // 赋值
                    $("#mainImagePath").val(result.data);
                }
            });
        }

        //初始化时间插件
        function initDate() {
            $('#createDate').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: 'zh-CN',
                showClear: true
            });
        }


        //用于存放所有品牌的数组
        var brandArr;
        function initBrandSelect(){
            $.ajax({
                url:"<%=request.getContextPath()%>/brand/queryBrandList",
                dataType:"json",
                success:function(result){
                    if(result.code == 200){
                        brandArr = result.data;
                        var optionsHTML = "";
                        for(var i = 0 ; i < result.data.length ; i ++ ){
                            optionsHTML += "<option value='" + result.data[i].id + "'>" + result.data[i].brandName + "</option>";
                        }
                        $("#addBrand").append(optionsHTML);
                    }else{
                        alert("查询失败!");
                    }
                },
                error:function(){
                    alert("查询失败!");
                }
            });
        }



        //新增商品
        function addProduct() {
            var param ={};
            param.productName = $("#productName").val();
            param.price = $("#price").val();
            param.brandId = $("#addBrand").val();
            param.createDate = $("#createDate").val();
            param.mainImagePath = $("#mainImagePath").val();

            $.ajax({
                type:"post",
                url:"/product/addProduct",
                data:param,
                success:function (result) {
                    // 在浏览器端打印信息
                    console.log(result);
                    if (result.code == 200) {
                        location.href="/product/toList";
                    }
                }
            })

        }
    </script>
</body>
</html>
