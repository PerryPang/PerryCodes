<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ include file="taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="${ctx}/static/js/html5.js"></script>
<script type="text/javascript" src="${ctx}/static/js/respond.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/PIE_IE678.js"></script>
<![endif]-->
<link href="${ctx}/static/assets/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${ctx}/static/css/style.css"/>
<link href="${ctx}/static/assets/css/codemirror.css" rel="stylesheet">
<link rel="stylesheet" href="${ctx}/static/assets/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/static/Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome.min.css" />
<!--[if IE 7]>
  <link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome-ie7.min.css" />
<![endif]-->
<link href="${ctx}/static/Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/Widget/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />

<title>新增图片</title>
</head>
<body>
<div class="clearfix" id="add_picture">
   <div>
   <div class="type_title">添加任务</div>
	<form  id="form-article-add" action="" method="post" class="form form-horizontal">
		<input type="hidden" name="id" value="${taskForm.id}"/>
		<div class="clearfix cl">
			 <label class="form-label col-2"><span class="c-red">*</span>监控名称：</label>
			 <div class="formControls col-10">
				 <input type="text" class="input-text" value="${taskForm.name}" placeholder="" id="name" name="name" >
			 </div>
		</div>
		<div class="clearfix cl">
			<label class="form-label col-2"><span class="c-red">*</span>监控对象：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="${taskForm.url}" placeholder="" id="url" name="url">
			</div>
		</div>
		<div class="clearfix cl">
			<label class="form-label col-2"><span class="c-red">*</span>监控节点：</label>
			<div class="formControls col-10">
				<input type="hidden" value="${taskForm.nodes}" placeholder="" id="nodesId" name="nodesId" readonly="readonly">
				<input type="text" class="input-text" value="${taskForm.nodesName}" placeholder="" id="nodesName" name="nodesName" readonly="readonly">
				<button style="width: 100px;height: 40px;" class="btn btn-default radius" onclick="selectPoint()" value="" type="button">选择节点</button>
			</div>
		</div>
		<div class="clearfix cl">
			<label class="form-label col-2"><span class="c-red">*</span>监控频率：</label>
			<div class="formControls col-10">
				<select name="frequency">
					<c:forEach items="${typeList}" var="t">
						<option label="${t.name}" value="${t.id}"></option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="clearfix cl">
			<div class="Button_operation">
				<button type="button" onClick="article_save(this);" class="btn btn-secondary  btn-warning"><i class="icon-save"></i>保存</button>
				<button type="button" onClick="window.history.back()" class="btn btn-default radius">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
    </div>
</div>
</div>
<script src="${ctx}/static/js/jquery-1.9.1.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/static/assets/js/typeahead-bs2.min.js"></script>
<script src="${ctx}/static/assets/layer/layer.js" type="text/javascript" ></script>
<script src="${ctx}/static/assets/laydate/laydate.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/Widget/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="${ctx}/static/Widget/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="${ctx}/static/Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/static/Widget/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="${ctx}/static/Widget/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctx}/static/Widget/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/static/Widget/ueditor/1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" src="${ctx}/static/Widget/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script> 
<script src="${ctx}/static/js/lrtk.js" type="text/javascript" ></script>
<script type="text/javascript" src="${ctx}/static/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/static/js/H-ui.admin.js"></script>
<script>
$( document).ready(function(){
//初始化宽度、高度
   $(".widget-box").height($(window).height());
   $(".page_right_style").height($(window).height()); 
   $(".page_right_style").width($(window).width()-220); 
  //当文档窗口发生改变时 触发  
    $(window).resize(function(){
	 $(".widget-box").height($(window).height());
	 $(".page_right_style").height($(window).height()); 
	 $(".page_right_style").width($(window).width()-220); 
	});	
});

function article_save(button){
	$(button).attr({"disabled":"disabled"});
	$.ajax({
		url: '${ctx}/task/save', //请求地址
		type: 'post', //请求方式
		dataType: 'text', //返回的数据格式
		data:$("#form-article-add").serialize(),
		success:function(dat) {
			$(button).attr({"disabled":false});
			if(dat == "success"){
				alert("保存成功!");
				window.history.back();
			}
		},
		error:function(e) {
			$(button).attr({"disabled":false});
			console.log(e);
			alert('保存失败')
		}
	});
}

function selectPoint(){
	const curnodesIds = $("#nodes").val();
	const modal = window.open("${ctx}/task/selectPoint?nodeIds=" + curnodesIds, 'modal',
			"height=600, width=800, top=100, left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
</script>
<script type="text/javascript">
</script>
</body>
</html>