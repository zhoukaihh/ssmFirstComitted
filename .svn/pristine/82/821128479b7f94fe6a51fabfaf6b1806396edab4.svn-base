<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="userModalLabel">创建数据字典</h4>
		    </div>
		    
   			<div class="modal-body">
   				<form role="form" id="dictionaryCreateForm" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入类型" name="type">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入名称" name="name">
                        </div>
                    </div>
                   	<div class="form-group">
                        <label class="col-sm-2 control-label">值</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入值" name="value">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入描述" name="description">
                        </div>
                    </div>
                </form>
   			</div>
   			
   			<div class="modal-footer">
   				<button type="button" onclick="submitDictionaryCreateForm ();" class="btn btn-default">提交</button>
                <button type="reset" class="btn btn-default">重置</button>
   			</div>
   		</div>
   		<script type="text/javascript">
	   	    $(document).ready(function () {	
	   			$('#dictionaryCreateForm').bootstrapValidator({
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
		                type: {
		                    validators: {
		                        notEmpty: {
		                            message: '类型不能为空'
		                        },
		                        stringLength: {
		                            min: 1,
		                            max: 30,
		                            message: '请输入1到30个字符'
		                        }
		                    }
		                },
		                name: {
		                    validators: {
		                        notEmpty: {
		                            message: '名称不能为空'
		                        },
		                        stringLength: {
		                            min: 1,
		                            max: 30,
		                            message: '请输入1到30个字符'
		                        }
		                    }
		                },
		                value: {
		                    validators: {
		                        notEmpty: {
		                            message: '值不能为空'
		                        },
		                        stringLength: {
		                            min: 1,
		                            max: 20,
		                            message: '请输入1到20个字符'
		                        }
		                    }
		                }
		            }
		        });
	   			
	   			// $('#dictionaryCreateForm').data('bootstrapValidator').enableFieldValidators('roleIds', false);
		    });
   	    
		   	function submitDictionaryCreateForm () {
				// 获取关联的bootstrapValidator对象	
		   		var bv = $('#dictionaryCreateForm').data('bootstrapValidator');
		        bv.validate();
		        if (!bv.isValid()) {
		        	return;
		        }
		        $.post ('${pageContext.request.contextPath}/dictionary/create', $('#dictionaryCreateForm').serializeArray(), function (result) {
		 			if (result.success) {
		 				$('#page-wrapper').load ('${pageContext.request.contextPath}/dictionary');
		 				$('#dictionaryDialog').modal ('hide');
		 			} else {
		 				alert (result.message);
		 			}
		 		});
		 	}
   		</script>
   	</div>
