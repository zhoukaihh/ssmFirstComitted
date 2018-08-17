<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="menuModalLabel">修改菜单</h4>
		    </div>
		    
   			<div class="modal-body">
   				<form role="form" id="menuUpdateForm" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">编号</label>
                        <div class="col-sm-10">
                        	<input class="form-control" name="no" value="${menu.no}" readonly="readonly">
                        	<input type="hidden" class="form-control" name="id" value="${menu.id}" >
                        	
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入名称" name="name" value="${menu.name }">
                        </div>
                    </div>
                   	<div class="form-group">
                        <label class="col-sm-2 control-label">图标</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入图标" name="icon" value="${menu.icon }">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">URL</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入URL" name="url" value="${menu.url }">
                        </div>
                    </div>
                </form>
   			</div>
   			
   			<div class="modal-footer">
   				<button type="button" class="btn btn-default" onclick="submitMenuUpdateForm ();">提交</button>
                <button type="reset" class="btn btn-default">重置</button>
   			</div>
   		</div>
   		<script type="text/javascript">
   		$(document).ready (function () {
   			$('#menuUpdateForm').bootstrapValidator ({
   				fields : {
   					no : {
   						validators: {
	                        notEmpty: {
	                            message: '编号不能为空'
	                        }
   						}
   					},
   					name : {
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
	                            regexp: /^[a-zA-Z0-9_\. \u4e00-\u9fa5 ]+$/,
	                            message: '用户名只能由字母、数字、点、下划线和汉字组成 '
	                        }
	                    }
   					},
   					URL : {
	                	validators: {
	                        notEmpty: {
	                            message: 'URL不能为空！'
	                        }
	                    }
	                }
   				}	
   			});	
   		});
   		
   		function submitMenuUpdateForm () {
   			var bv = $('#menuUpdateForm').data ('bootstrapValidator');
   			bv.validate ();
   			if (!bv.isValid()) {
   				return;
   			}
    		$.post ('${pageContext.request.contextPath}/menu/update', $('#menuUpdateForm').serializeArray(), function (result) {
    			if (result.success) {
    				$('#menuDialog').modal ('hide');
    				$('#page-wrapper').load ('${pageContext.request.contextPath}/menu');
    			} else {
    				alert (result.message);
    			}
    		});
    	}
   		</script>
   	</div>
   	