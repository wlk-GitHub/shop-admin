<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/6/30
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- Bootstrap -->
    <link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
    <link href="/js/DataTables/DataTables-1.10.20/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link type="text/css" rel="stylesheet" href="/js/fileinput5/css/fileinput.css" />
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap3/js/bootstrap.min.js"></script>
    <script src="/js/DataTables/DataTables-1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="/js/DataTables/DataTables-1.10.20/js/dataTables.bootstrap.min.js"></script>
    <script src="/js/bootbox/bootbox.min.js"></script>
    <script src="/js/bootbox/bootbox.locales.min.js"></script>
    <script src="/js/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/js/fileinput5/js/fileinput.min.js"></script>
    <script src="/js/fileinput5/js/locales/zh.js"></script>

    <style>
        td.details-control {
            background: url('/js/DataTables/DataTables-1.10.20/images/details_open.png') no-repeat center center;
            cursor: pointer;
        }
        tr.shown td.details-control {
            background: url('/js/DataTables/DataTables-1.10.20/images/details_close.png') no-repeat center center;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">商品</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">商品管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="row">

    <div class="col-md-12">
        <div class="panel panel-primary">
            <div class="panel-heading">商品查询</div>
            <div class="panel-body">
                <form class="form-horizontal" id="productForm">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">商品名</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productName" name="productName" placeholder="请输入商品名...">
                        </div>
                        <label  class="col-sm-2 control-label">价格范围</label>
                        <div class="col-sm-4">

                            <div class="input-group">
                                <input type="text" class="form-control" id="minPrice" name="minPrice" placeholder="请输入最小价格...">
                                <span class="input-group-addon" ><i class="glyphicon glyphicon-yen"></i> </span>
                                <input type="text" class="form-control" id="maxPrice" name="maxPrice" placeholder="请输入最大价格...">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">品牌</label>
                        <div class="col-sm-4">
                            <select id="brandId" class="form-control">
                                <option value="-1">请选择</option>
                            </select>
                        </div>
                        <label  class="col-sm-2 control-label">日期范围</label>
                        <div class="col-sm-4">

                            <div class="input-group">
                                <input type="text" class="form-control" id="minCreateDate" name="minCreateDate" placeholder="请输入最小日期...">
                                <span class="input-group-addon" ><i class="glyphicon glyphicon-calendar"></i> </span>
                                <input type="text" class="form-control" id="maxCreateDate" name="maxCreateDate" placeholder="请输入最大日期...">
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center;">
                        <button type="button" class="btn btn-primary" onclick="search();"><i class="glyphicon glyphicon-search"></i> 查询</button>
                        <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary">
            <div class="panel-heading">
                商品列表
                <button type="button" class="btn btn-success" onclick="toAdd();"><i class="glyphicon glyphicon-plus"></i> 增加</button>
                <button type="button" class="btn btn-danger" onclick="deleteBatch();"><i class="glyphicon glyphicon-trash"></i>批量删除</button>
                <button type="button" class="btn btn-success" onclick="exportExcel();"><i class="glyphicon glyphicon-download"></i>导出Excel</button>
                <button type="button" class="btn btn-success" onclick="importExcel();"><i class="glyphicon glyphicon-upload"></i>导入Excel</button>
                <button type="button" class="btn btn-success" onclick="exportWord();"><i class="glyphicon glyphicon-download"></i>导出Word</button>
                <button type="button" class="btn btn-success" onclick="exportPdf();"><i class="glyphicon glyphicon-download"></i>导出PDF</button>
                <button type="button" class="btn btn-success" onclick="clearCache();"><i class="glyphicon glyphicon-download"></i>清空缓存</button>

            </div>
            <table id="empTable" class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr>
                    <th></th>
                    <th>选择</th>
                    <th>商品id</th>
                    <th>商品名</th>
                    <th>主图</th>
                    <th>是否热销</th>
                    <th>状态</th>
                    <th>价格</th>
                    <th>品牌名</th>
                    <th>生产日期</th>
                    <th>录入时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
                </thead>

                <tfoot>
                <tr>
                    <th></th>
                    <th>选择</th>
                    <th>商品id</th>
                    <th>商品名</th>
                    <th>主图</th>
                    <th>是否热销</th>
                    <th>状态</th>
                    <th>价格</th>
                    <th>品牌名</th>
                    <th>生产日期</th>
                    <th>录入时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
                </tfoot>
            </table>
        </div>

    </div>
</div>



<!--新增商品的DIV-->
    <div id="addProductDiv" style="display: none">
    <!--新增药品的form表单-->
    <form id="addProductForm" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名称</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addProductName" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">价格</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addPrice">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10">
                <select id="addBrand" class="form-control">
                    <option value="-1">请选择</option>
                </select>
            </div>
        </div>


        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addCreateDate">
            </div>
        </div>



        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <label class="radio-inline">
                    <input type="radio" name="addIsHot" value="1"> 热销
                </label>
                <label class="radio-inline">
                    <input type="radio" name="addIsHot" value="0">非热销
                </label>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">是否上架:</label>
            <div class="col-sm-10">
                <label class="radio-inline">
                    <input type="radio" name="addStatus" value="1"> 上架
                </label>
                <label class="radio-inline">
                    <input type="radio" name="addStatus" value="0">下架
                </label>
            </div>
        </div>

        <div class="form-group">
            <label  class="col-sm-2 control-label">主图</label>
            <div class="col-sm-10">
                <input type="file" id="mainImage" name="imageInfo">
                <input type="text" id="mainImagePath"/>
            </div>
        </div>



        <div class="form-group">
            <label class="col-sm-2 control-label">库存</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="addStock">
            </div>
        </div>
    </form>
</div>


    <script>
        var addProductDivHTML;



        $(function () {

            addProductDivHTML = $("#addProductDiv").html();
            //初始化查询条件面板中的过期日期
            initDateTimePicker("#minCreateDate","YYYY-MM-DD");
            initDateTimePicker("#maxCreateDate","YYYY-MM-DD");
            //初始化表格
            initEmpTable();
            //初始化查询条件面板中产地下拉框
            initBrandSelect();

            initMainImage();
        })

        function search(){
            empTable.ajax.reload();
        }

        function initDateTimePicker(selector,abc){
            abc = abc == undefined ? "YYYY-MM-DD" : abc;
            $(selector).datetimepicker({
                format:abc,
                locale:"zh-CN",
                showClear:true
            });
        }



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

        var empTable;
        function initEmpTable(){
            empTable = $("#empTable").DataTable({
                searching:false,
                ordering:false,
                serverSide:true, //开启服务端模式
                lengthMenu:[3,5,10,15],
                processing:true,//是否显示正在处理中
                language:chinese,
                ajax:{
                    url:"<%=request.getContextPath()%>/product/queryList.do",
                    data:function(param){
                        //DataTables在发送ajax请求的时候会发送一些自己的参数，比如说每页显示条数，起始条数等等。。。
                        //通过param这个参数咱们可以设置自己需要传递的参数，比如说条件查询的值
                        var v_param = {};
                        v_param.productName = $("#productName").val();
                        v_param.minPrice = $("#minPrice").val();
                        v_param.maxPrice = $("#maxPrice").val();
                        v_param.brandInfoId = $("#brandSelect").val();
                        v_param.minCreateDate = $("#minCreateDate").val();
                        v_param.maxCreateDate = $("#maxCreateDate").val();
                    }
                },
                columns:[
                    {
                        "className":      'details-control',
                        "orderable":      false,
                        "data":           null,
                        "defaultContent": ''
                    },
                    {
                        "data":"id",
                        "render": function (data, type, row, meta) {
                            return "<input type='checkbox' name='ids' value='"+data+"'/>"
                        }
                    },
                    { "data": "id" },
                    { "data": "productName" },
                    {
                        "data": "mainImagePath",
                        "render": function (data, type, row, meta) {
                            return "<img src='"+data+"' width='100px' height='100px'/>"
                        }

                    },
                    {
                        "data": "isHot",
                        "render": function (data, type, row, meta) {
                            return data==0?"非热销":"热销";
                        }

                    },
                    {
                        "data": "status",
                        "render": function (data, type, row, meta) {
                            return data==0?"下架":"上架";
                        }

                    },
                    { "data": "price" },
                    { "data": "brandName" },
                    { "data": "createDate" },
                    { "data": "insertTime" },
                    { "data": "updateTime" },
                    {
                        "data": "id",
                        "render": function (data, type, row, meta) {
                            var v_isHot = row.isHot;
                            var v_text = "";
                            var v_icon = "";
                            var v_color = "";
                            var v_hot_status;

                            var v_status = row.status;
                            var v_status_text = "";
                            var v_status_icon = "";
                            var v_status_color = "";
                            var v_up_status;

                            if (v_isHot == 1) {
                                // 非热销
                                v_text = "非热销";
                                v_hot_status = 0;
                                v_icon = "glyphicon glyphicon-hand-down";
                                v_color = "btn btn-default";
                            } else {
                                v_text = "热销";
                                v_hot_status = 1;
                                v_icon = "glyphicon glyphicon-fire";
                                v_color = "btn btn-success";
                            }
                            if (v_status == 1) {
                                // 下架
                                v_status_text = "下架";
                                v_status_icon = "glyphicon glyphicon-arrow-down";
                                v_status_color = "btn btn-default";
                                v_up_status = 0;
                            } else {
                                // 上架
                                v_status_text = "上架";
                                v_status_icon = "glyphicon glyphicon-arrow-up";
                                v_status_color = "btn btn-success";
                                v_up_status = 1;
                            }
                            return "<button type=\"button\" class=\"btn btn-warning\" onclick=\"editProduct('"+data+"');\"><i class=\"glyphicon glyphicon-pencil\"></i>修改</button>\n" +
                                " <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteProduct('"+data+"')\"><i class=\"glyphicon glyphicon-trash\"></i>删除</button>" +
                                " <button type=\"button\" class=\""+v_color+"\" onclick=\"updateHotStatus('"+data+"','"+v_hot_status+"')\"><i class=\""+v_icon+"\"></i>"+v_text+"</button>"+
                                " <button type=\"button\" class=\""+v_status_color+"\" onclick=\"updateStatus('"+data+"','"+v_up_status+"')\"><i class=\""+v_status_icon+"\"></i>"+v_status_text+"</button>";
                        }
                    },
                ]
            });
        }



        function updateHotStatus(id, status) {
            // 停止事件冒泡
            event.stopPropagation();
            $.ajax({
                type:"post",
                url:"/product/updateHotStatus?id="+id+"&status="+status,
                success:function (result) {
                    if (result.code == 200) {
                        search();
                    }
                }
            })
        }

        function updateStatus(id, status) {
            // 停止事件冒泡
            event.stopPropagation();
            $.ajax({
                type:"post",
                url:"/product/updateStatus?id="+id+"&status="+status,
                success:function (result) {
                    if (result.code == 200) {
                        search();
                    }
                }
            })
        }

        // 全选
        var arr = document.getElementsByName("che");
        function checkAll(obj){
            for(var i=0; i<arr.length; i++){
                arr[i].checked = obj.checked;
            }
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
                        $("#brandId").append(optionsHTML);
                    }else{
                        alert("查询失败!");
                    }
                },
                error:function(){
                    alert("查询失败!");
                }
            });
        }


        //新增
        function toAdd() {
            location.href = "/product/toAdd";

            /*//初始化新增药品表单中的过期时间
            initDateTimePicker("#addCreateDate","YYYY-MM-DD");
            //初始化新增药品表单中产地下拉框
            var brandOptionsHTML = "";
            for(var i = 0 ; i < brandArr.length ; i ++ ){
                brandOptionsHTML += "<option value='" + brandArr[i].id + "'>" + brandArr[i].brandName + "</option>";
            }
            $("#addBrand").append(brandOptionsHTML);

            //使用bootbox弹框插件弹出新增的对话框
            bootbox.confirm({
                title:"新增商品",
                message:$("#addProductDiv").children(),
                buttons:{
                    confirm:{
                        label:"确认"
                    },
                    cancel:{
                        label:"取消",
                        className:"btn btn-danger"
                    }
                },
                callback:function(result){
                    //如果点击了确认按钮
                    if(result){
                        var param = {};
                        //获取新增表单中的数据
                        param.productName = $("#addProductName").val();
                        param.price = $("#addPrice").val();
                        param.brandId = $("#addBrand").val();
                        param.isHot = $("[name=addIsHot]:checked").val();
                        param.status = $("[name=addStatus]:checked").val();
                        param.createDate = $("#addCreateDate").val();
                        param.stock = $("#addStock").val();


                        //发起一个新增药品的ajax请求
                        $.ajax({
                            url:"<%=request.getContextPath()%>/product/addProduct.do",
                            type:"post",
                            data:param,
                            dataType:"json",
                            success:function(result){
                                if(result.code == 200){
                                    //重新加载表格中的数据
                                    search();
                                }else{
                                    alert("新增失败!");
                                }
                            },
                            error:function(){
                                alert("新增失败!");
                            }
                        });
                    }
                    $("#addProductDiv").html(addProductDivHTML);
                }
            });*/

        }


      function editProduct(id) {
          event.stopPropagation();
          location.href = "/product/toEdit?id="+id;
        }


        function deleteProduct(id) {
            bootbox.confirm({
                message: "你确定删除吗?",
                size: 'small',
                title: "提示信息",
                buttons: {
                    confirm: {
                        label: '<span class="glyphicon glyphicon-ok"></span>确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '<span class="glyphicon glyphicon-remove"></span>取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if (result) {
                        // 发送请求，进行删除
                        $.ajax({
                            type:"post",
                            url:"/product/deleteProduct",
                            data:{"id":id},
                            success:function (result) {
                                if (result.code == 200) {
                                    // 刷新
                                    search();
                                }
                            }
                        })
                    }
                }
            })

        }




        var chinese = {
            "sProcessing": "处理中...",
            "sLengthMenu": "显示 _MENU_ 项结果",
            "sZeroRecords": "没有匹配结果",
            "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
            "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
            "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
            "sInfoPostFix": "",
            "sSearch": "搜索:",
            "sUrl": "",
            "sEmptyTable": "表中数据为空",
            "sLoadingRecords": "载入中...",
            "sInfoThousands": ",",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "上页",
                "sNext": "下页",
                "sLast": "末页"
            },
            "oAria": {
                "sSortAscending": ": 以升序排列此列",
                "sSortDescending": ": 以降序排列此列"
        }
        };



        function clearCache() {
            $.ajax({
                type:"post",
                url:"/product/clearCache",
                success:function (result) {
                    if (result.code == 200) {
                        alert("刷新成功")
                    }
                }
            })
        }


    </script>
</body>
</html>
