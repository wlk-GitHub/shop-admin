<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2020/1/21
  Time: 14:55
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
            <a class="navbar-brand" href="#">会员</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">嘻嘻嘻嘻</a></li>
            </ul>
        </div>
    </div>
</nav>
<script>


    $(function(){
        //初始化查询条件面板中的过期日期
        initDateTimePicker("#minBirthday","YYYY-MM-DD");
        initDateTimePicker("#maxBirthday","YYYY-MM-DD");
        //初始化表格
        initEmpTable();
        initArea(0);

    });

    function initArea(id,obj) {
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            type:"get",
            url:"http://localhost:8083/area/findChilds",
            data:{"id":id},
            success:function (result) {
                if(result.code==200){
                    var v_areaArr = result.data;

                    if(v_areaArr.length>0){
                        var v_areaHtml = '<div class="col-sm-2">\n' +
                            '                        <select class="form-control" onchange="initArea(this.value,this)" name="areaSelect"><option value="-1">===请选择===</option>';
                        for (let area of v_areaArr){
                            v_areaHtml+='<option value="'+area.id+'" data-area-name="'+area.areaName+'">'+area.areaName+'</option>';
                        }
                        v_areaHtml+='</select></div>';
                        $("#areaDiv").append(v_areaHtml);
                    }

                }
            }
        })
    }


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

    //用于存放所有产地的数组


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
                url:"<%=request.getContextPath()%>/guanli/queryList.do",
                data:function(param){
                    //DataTables在发送ajax请求的时候会发送一些自己的参数，比如说每页显示条数，起始条数等等。。。
                    //通过param这个参数咱们可以设置自己需要传递的参数，比如说条件查询的值
                    param.memberName = $("#memberName").val();
                    param.realName = $("#realName").val();
                    param.minBirthday = $("#minBirthday").val();
                    param.maxBirthday = $("#maxBirthday").val();
                    var shengId = $($("select[name='areaSelect']")[0]).val();
                    var shiId = $($("select[name='areaSelect']")[1]).val();
                    var xianId = $($("select[name='areaSelect']")[2]).val();
                    param.shengId=shengId;
                    param.shiId=shiId;
                    param.xianId=xianId;
                }
            },
            columns:[
                {
                    "data":"id","title":"<input type=\"checkbox\"  onclick='checkAll(this)' />",
                    "render":function(data){
                        return "<input type=\"checkbox\" name=\"che\" value=\"" + data + "\" />";
                    }
                },
                {data:"memberName"},
                {data:"password"},
                {data:"realName"},
                {
                    data:"birthday",
                },


                {data:"mail"},
                {data:"phone"},
                {data:"areaName"},
                {
                    data:"id",
                    render:function(data){
                        return '<div class="btn-group btn-group-xs">'+
                            '<button type="button" onclick="showUpdateEmpDialog(' + data + ')" class="btn btn-primary">'+
                            '<span class=""></span>&nbsp;修改'+
                            '</button>'+
                            '<button type="button" onclick="deleteEmp(' + data + ')" class="btn btn-danger">'+
                            '<span class=""></span>&nbsp;删除'+
                            '</button>'+
                            '</div>';
                    }}
            ]
        });
    }



    // 全选
    var arr = document.getElementsByName("che");
    function checkAll(obj){
        for(var i=0; i<arr.length; i++){
            arr[i].checked = obj.checked;
        }
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
</script>



<!-- 查询条件面板 -->
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">
            查询条件
        </h3>
    </div>
    <div class="panel-body">
        <form class="form-horizontal" role="form">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">会员名:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="memberName">
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">生日:</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="minBirthday" class="form-control">
                                    <span class="input-group-addon">--</span>
                                    <input type="text" id="maxBirthday" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">真实姓名:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="realName">
                            </div>
                        </div>
                    </div>
                </div>


                        <div class="form-group" id="areaDiv">
                            <label class="col-sm-2 control-label">地区:</label>
                        </div>



                <div class="row">
                    <div class="col-md-12" style="text-align:center">
                        <button type="button" class="btn btn-primary" onclick="search()">
                            <span class=""></span>&nbsp;查询
                        </button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="reset" class="btn btn-danger" onclick="history.go(0)">
                            <span class=""></span>&nbsp;重置
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>



<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">
            会员列表
        </h3>
    </div>
    <div class="panel-body">
        <div style="margin-bottom:10px">
            <button onclick="showAddEmpDialog()" type="button" class="btn btn-primary">
                <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
            </button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <button onclick="batchDeleteEmp()" type="reset" class="btn btn-danger">
                <span class="glyphicon glyphicon-minus"></span>&nbsp;批量删除
            </button>
        </div>

        <table id="empTable" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" />
                </th>
                <th>会员名</th>
                <th>密码</th>
                <th>真实姓名</th>
                <th>生日</th>
                <th>邮箱</th>
                <th>电话</th>
                <th>地区</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
</body>
</html>
