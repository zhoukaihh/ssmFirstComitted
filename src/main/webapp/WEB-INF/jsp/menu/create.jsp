<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="menuModalLabel">创建菜单</h4>
		    </div>
		    
   			<div class="modal-body">
   				<form role="form" id="menuCreateForm" class="form-horizontal">
   					<div class="form-group">
                        <label class="col-sm-2 control-label">编号</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入编号" name="no">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入名称" name="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">图标</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入图标" name="icon" >
                        </div>
                    </div>
                   	<div class="form-group">
                        <label class="col-sm-2 control-label">URL</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入URL" name="url">
                        </div>
                    </div>
                    
                </form>
   			</div>
   			
   			<div class="modal-footer">
   				<button type="button" onclick="submitMenuCreateForm ();" class="btn btn-default">提交</button>
                <button type="reset" class="btn btn-default">重置</button>
   			</div>
   		</div>
   		<script type="text/javascript">
	   	    $(document).ready(function () {	
	   			$('#menuCreateForm').bootstrapValidator({
		            // 默认错误消息
	   				message: '输入值不合法',
	   				// 设置验证成功或者失败的图标
		            feedbackIcons: {
		                valid: 'glyphicon glyphicon-ok',
		                invalid: 'glyphicon glyphicon-remove',
		                validating: 'glyphicon glyphicon-refresh'
		            },
		            // 设置不同字段的验证规则和错误信息
		            fields: {
		            	 no: {
			                    message: '编号不合法',
			                    validators: {
			                        notEmpty: {
			                            message: '编号不能为空'
			                        },
			                        stringLength: {
			                            min: 2,
			                            max: 4,
			                            message: '请输入2到4个字符'
			                        },
			                        regexp: {
			                            regexp: /^[0-9]+$/,
			                            message: '密码只能由数字组成 '
			                        }
			                    }
			                },
		            	name: {
		                    message: '名称不合法',
		                    validators: {
		                        notEmpty: {
		                            message: '名称不能为空'
		                        },
		                        stringLength: {
		                            min: 2,
		                            max: 30,
		                            message: '请输入2到30个字符'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z_ \u4e00-\u9fa5 ]+$/,
		                            message: '用户名只能由字母、下划线和汉字组成 '
		                        }
		                    }
		                },
		               
		            }
		        });
	   			
	   			// $('#menuCreateForm').data('bootstrapValidator').enableFieldValidators('roleIds', false);
		    });
   	    
		   	function submitMenuCreateForm () {
				// 获取关联的bootstrapValidator对象	
		   		var bv = $('#menuCreateForm').data('bootstrapValidator');
		        bv.validate();
		        if (!bv.isValid()) {
		        	return;
		        }
		        $.post ('${pageContext.request.contextPath}/menu/create', $('#menuCreateForm').serializeArray(), function (result) {
		 			if (result.success) {
		 				$('#page-wrapper').load ('${pageContext.request.contextPath}/menu');
		 				$('#menuDialog').modal ('hide');
		 			} else {
		 				alert (result.message);
		 			}
		 		});
		 	}
   		</script>
   	</div>
