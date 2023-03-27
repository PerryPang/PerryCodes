<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="../js/html5.js"></script>
<script type="text/javascript" src="../js/respond.min.js"></script>
<script type="text/javascript" src="../js/PIE_IE678.js"></script>
<![endif]-->
<link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="../css/style.css"/>
<link href="../assets/css/codemirror.css" rel="stylesheet">
<link rel="stylesheet" href="../assets/css/ace.min.css" />
<link rel="stylesheet" href="../Widget/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="../assets/css/font-awesome.min.css" />
<!--[if IE 7]>
  <link rel="stylesheet" href="../assets/css/font-awesome-ie7.min.css" />
<![endif]-->
<link href="../Widget/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="../Widget/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />

<title>新增图片</title>
</head>
<body>
<div class="clearfix" id="add_picture">
   <div>
   <div class="type_title">添加商品</div>
	<form action="" method="post" class="form form-horizontal" id="form-article-add">
		<div class="clearfix cl">
         <label class="form-label col-2"><span class="c-red">*</span>图片标题：</label>
		 <div class="formControls col-10"><input type="text" class="input-text" value="" placeholder="" id="" name=""></div>
		</div>
		<div class=" clearfix cl">
         <label class="form-label col-2">简略标题：</label>
	     <div class="formControls col-10"><input type="text" class="input-text" value="" placeholder="" id="" name=""></div>
		</div>
		<div class=" clearfix cl">
			
			<div class="Add_p_s">
            <label class="form-label col-2">产品编号：</label>
			<div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name=""></div>
            </div>
			<div class="Add_p_s">
             <label class="form-label col-2">产&nbsp;&nbsp;&nbsp;&nbsp;地：</label>	
			 <div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name=""></div>
			</div>
            <div class="Add_p_s">
             <label class="form-label col-2">材&nbsp;&nbsp;&nbsp;&nbsp;质：</label>	
			 <div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name=""></div>
			</div>
            <div class="Add_p_s">
             <label class="form-label col-2">品&nbsp;&nbsp;&nbsp;&nbsp;牌：</label>	
			 <div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name=""></div>
			</div>
             <div class="Add_p_s">
             <label class="form-label col-2">产品重量：</label>	
			 <div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name="" >kg</div>
			</div>
             <div class="Add_p_s">
             <label class="form-label col-2">单位：</label>	
			 <div class="formControls col-2"><span class="select-box">
				<select class="select">
					<option>请选择</option>
					<option value="1">件</option>
					<option value="2">斤</option>
					<option value="3">KG</option>
					<option value="4">吨</option>
					<option value="5">套</option>
				</select>
				</span></div>
			</div>
            <div class="Add_p_s">
             <label class="form-label col-2">展示价格：</label>	
			 <div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name="" >元</div>
			</div>
            <div class="Add_p_s">
             <label class="form-label col-2">市场价格：</label>	
			 <div class="formControls col-2"><input type="text" class="input-text" value="" placeholder="" id="" name="" >元</div>
			</div>
           
			
		</div>
		
		<div class="clearfix cl">
			<label class="form-label col-2">关键词：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="" placeholder="" id="" name="">
			</div>
		</div>
		<div class="clearfix cl">
			<label class="form-label col-2">内容摘要：</label>
			<div class="formControls col-10">
				<textarea name="" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="备注不能为空！" onKeyUp="textarealength(this,200)"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/200</p>
			</div>
		</div>
		
		<div class="clearfix cl">
			<label class="form-label col-2">图片上传：</label>
			<div class="formControls col-10">
				<div class="uploader-list-container"> 
					<div class="queueList">
						<div id="dndArea" class="placeholder">
							<div id="filePicker-2"></div>
							<p>或将照片拖到这里，单次最多可选300张</p>
						</div>
					</div>
					<div class="statusBar" style="display:none;">
						<div class="progress"> <span class="text">0%</span> <span class="percentage"></span> </div>
						<div class="info"></div>
						<div class="btns">
							<div id="filePicker2"></div>
							<div class="uploadBtn">开始上传</div>
						</div>
					</div>
				</div>
			</div>
		</div>
         <div class="clearfix cl">
         <label class="form-label col-2">详细内容：</label>
			<div class="formControls col-10">
				<script id="editor" type="text/plain" style="width:100%;height:400px;"></script> 
             </div>
        </div>
        <div class="clearfix cl">
         <label class="form-label col-2">允许评论：</label>
			<div class="formControls col-2 skin-minimal">
			 <div class="check-box" style=" margin-top:9px"><input type="checkbox" id="checkbox-1"><label for="checkbox-1">&nbsp;</label></div>
             </div>
        </div>
		<div class="clearfix cl">
			<div class="Button_operation">
				<button onClick="article_save_submit();" class="btn btn-primary radius" type="submit"><i class="icon-save "></i>保存并提交审核</button>
				<button onClick="article_save();" class="btn btn-secondary  btn-warning" type="button"><i class="icon-save"></i>保存草稿</button>
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
    </div>
</div>
</div>
<script src="../js/jquery-1.9.1.min.js"></script>
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/typeahead-bs2.min.js"></script>
<script src="../assets/layer/layer.js" type="text/javascript" ></script>
<script src="../assets/laydate/laydate.js" type="text/javascript"></script>
<script type="text/javascript" src="../Widget/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="../Widget/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="../Widget/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="../Widget/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="../Widget/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="../Widget/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="../Widget/ueditor/1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" src="../Widget/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script> 
<script src="../js/lrtk.js" type="text/javascript" ></script>
<script type="text/javascript" src="../js/H-ui.js"></script>
<script type="text/javascript" src="../js/H-ui.admin.js"></script>
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
$(function(){
	var ue = UE.getEditor('editor');
});
</script>
<script type="text/javascript">
</script>
</body>
</html>