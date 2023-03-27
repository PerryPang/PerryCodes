<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ include file="taglib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" /> 
        <link href="${ctx}/static/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${ctx}/static/css/style.css"/>
        <link rel="stylesheet" href="${ctx}/static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome.min.css" />
        <link rel="stylesheet" href="${ctx}/static/Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
        <link href="${ctx}/static/Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
		<!--[if IE 7]>
		  <link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="${ctx}/static/assets/css/ace-ie.min.css" />
		<![endif]-->
	    <script src="${ctx}/static/js/jquery-1.9.1.min.js"></script>   
        <script src="${ctx}/static/assets/js/bootstrap.min.js"></script>
        <script src="${ctx}/static/assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/static/assets/js/jquery.dataTables.min.js"></script>
		<script src="${ctx}/static/assets/js/jquery.dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/H-ui.js"></script> 
        <script type="text/javascript" src="${ctx}/static/js/H-ui.admin.js"></script> 
        <script src="${ctx}/static/assets/layer/layer.js" type="text/javascript" ></script>
        <script src="${ctx}/static/assets/laydate/laydate.js" type="text/javascript"></script>
        <script type="text/javascript" src="${ctx}/static/Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
        <script src="${ctx}/static/js/lrtk.js" type="text/javascript" ></script>
<title>任务列表</title>
</head>
<body>
<div class=" page-content clearfix">
 <div id="products_style">
    <div class="search_style">
        <%--@elvariable id="${queryForm}" type="com"--%>
        <form:form id="taskqueryForm" modelAttribute="${queryForm}" action="${ctx}/task/list" method="post">
          <ul class="search_content clearfix">
           <li><label class="l_f">任务名称</label><input name="name" value="${name}" type="text"  class="text_add" placeholder="输入任务名称"  style=" width:250px"/></li>
           <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="createTime" value="" style=" margin-left:10px;"></li>
           <li style="width:90px;"><button type="button" class="btn_search" id="queryButton"><i class="icon-search"></i>查询</button></li>
          </ul>
        </form:form>
    </div>

    <div class="border clearfix">
       <span class="l_f">
        <a href="${ctx}/task/form" title="新增" class="btn btn-warning Order_form"><i class="icon-plus"></i>添加任务</a>
       </span>
       <span class="r_f">共：<b>${dataSize}</b>个监控任务</span>
    </div>

    <div class="table_menu_list" id="testIframe">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
            <thead>
             <tr>
                <th width="25px"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
                <th width="180px">名称</th>
                <th width="250px">监控对象</th>
                <th width="100px">频率</th>
                <th width="100px">任务状态</th>
                 <th width="180px">最后检测时间</th>
                 <th width="180px">创建时间</th>
                <th width="100px">操作</th>
             </tr>
            </thead>
            <tbody>
                <c:forEach items="${allTask}" var="data">
                    <tr>
                        <td width="25px"><label><input type="checkbox" class="ace" value="${data.id}"><span class="lbl"></span></label></td>
                        <td>${data.name}</td>
                        <td>${data.url}</td>
                        <td>${data.frequencyCN}</td>
                        <td class="enabled">${data.enabledCN}</td>
                        <td><fmt:formatDate value="${data.lastRunTime}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${data.createTime}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                        <td class="option">
                            <a id="editButton" href="${ctx}/task/form?taskId=${data.id}">编辑</a>
                            <c:if test="${data.enabled == 0}">
                                <a id="optionButton" href="javascript:void(0)" onclick="changeEnabled(${data.id},1,this)">启动</a>
                            </c:if>
                            <c:if test="${data.enabled == 1}">
                                <a id="optionButton" href="javascript:void(0)" onclick="changeEnabled(${data.id},0,this)">停止</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
  </div>
 </div>
</div>
</body>
</html>
<script>
jQuery(function($) {
        $('table th input:checkbox').on('click' , function(){
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
            .each(function(){
                this.checked = that.checked;
                $(this).closest('tr').toggleClass('selected');
            });
        });

        $('#queryButton').on('click' , function(){
            $("#taskqueryForm").submit();
        });

        $('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
        function tooltip_placement(context, source) {
            var $source = $(source);
            var $parent = $source.closest('table')
            var off1 = $parent.offset();
            var w1 = $parent.width();

            var off2 = $source.offset();
            var w2 = $source.width();

            if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
            return 'left';
        }
    });
 laydate({
    elem: '#createTime',
    event: 'focus' 
});
$(function() { 
	$("#products_style").fix({
		float : 'left',
		//minStatue : true,
		skin : 'green',	
		durationTime :false,
		spacingw:30,//设置隐藏时的距离
	    spacingh:260,//设置显示时间距
	});
});
</script>
<script type="text/javascript">
//初始化宽度、高度  
 $(".widget-box").height($(window).height()-215);
$(".table_menu_list").width($(window).width()-260);
 $(".table_menu_list").height($(window).height()-215);
  //当文档窗口发生改变时 触发
    $(window).resize(function(){
	$(".widget-box").height($(window).height()-215);
	 $(".table_menu_list").width($(window).width()-260);
	  $(".table_menu_list").height($(window).height()-215);
	})

/*产品-编辑*/
function member_edit(title,url,id,w,h){
	layer_show(title,url,w,h);
}

function changeEnabled(id,status,link){
    $.ajax({
        url: '${ctx}/task/changeEnabled', //请求地址
        type: 'post', //请求方式
        dataType: 'json', //返回的数据格式
        data: {taskId:id,status:status},
        success:function(dat) {
            if(dat != null){
                var curTR = $(link).parent().parent();
                curTR.find(".enabled").html(dat.enabledCN);
                if(dat.enabled == 1){
                    alert("启动成功!");
                    curTR.find(".option").html('<a id="optionButton" href="javascript:void(0)" onclick="changeEnabled('+dat.id+',0,this)">停止</a>');
                }else{
                    alert("停止成功!");
                    curTR.find(".option").html('<a id="optionButton" href="javascript:void(0)" onclick="changeEnabled('+dat.id+',1,this)">启动</a>');
                }
            }else{
                alert('操作失败!')
            }
        },
        error:function(e) {
            console.log(e);
            alert('操作失败!')
        }
    });
}

/*产品-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$(obj).parents("tr").remove();
		layer.msg('已删除!',{icon:1,time:1000});
	});
}
//面包屑返回值
var index = parent.layer.getFrameIndex(window.name);
parent.layer.iframeAuto(index);

</script>
