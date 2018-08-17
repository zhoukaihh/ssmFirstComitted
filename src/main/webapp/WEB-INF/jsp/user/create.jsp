<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.qfedu.demo.ssh.dto.RoleDto" %>
<%@ page import="com.qfedu.demo.ssh.dto.DictionaryDto" %>
<%@ page import="java.util.List" %>
<%
	List<RoleDto> roles = (List<RoleDto>)request.getAttribute("roles");
	List<DictionaryDto> dics = (List<DictionaryDto>)request.getAttribute("dictionaries");
%>
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="userModalLabel">创建用户</h4>
		    </div>
		    
   			<div class="modal-body">
   				<form role="form" id="userCreateForm" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">登录名</label>
                        <div class="col-sm-10">
                        	<input class="form-control" placeholder="请输入登录名" name="loginName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入密码" name="password" type="password">
                        </div>
                    </div>
                   	<div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                        <input class="form-control" placeholder="请输入姓名" name="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-10">
                        <%for (RoleDto r : roles) { %>
                        <label class="col-sm-12">
                            <input type="checkbox" value="<%=r.getId()%>" name="roleIds"> <%=r.getName()%>
                        </label>
                        <% } %>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                        <%for (DictionaryDto d : dics) { %>
                        <label class="col-sm-12">
                            <input type="radio" value="<%=d.getValue()%>" name="gender"> <%=d.getName()%>
                        </label>
                        <% } %>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">创建时间</label>
                        <div class="col-sm-10">
                        	<input type="datetime-local" class="form-control" placeholder="请输入时间" name="createTime">
                        </div>
                    </div>
                </form>
   			</div>
   			
   			<div class="modal-footer">
   				<button type="button" onclick="submitUserCreateForm ();" class="btn btn-default">提交</button>
                <button type="reset" class="btn btn-default">重置</button>
   			</div>
   		</div>
   		<script type="text/javascript">
	   	    $(document).ready(function () {	
	   			$('#userCreateForm').bootstrapValidator({
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
		                loginName: {
		                    message: '用户名不合法',
		                    validators: {
		                        notEmpty: {
		                            message: '用户名不能为空'
		                        },
		                        stringLength: {
		                            min: 3,
		                            max: 30,
		                            message: '请输入3到30个字符'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z0-9_\. \u4e00-\u9fa5 ]+$/,
		                            message: '用户名只能由字母、数字、点、下划线和汉字组成 '
		                        }
		                    }
		                },
		                password: {
		                    message: '密码不合法',
		                    validators: {
		                        notEmpty: {
		                            message: '密码不能为空'
		                        },
		                        stringLength: {
		                            min: 3,
		                            max: 30,
		                            message: '请输入3到30个字符'
		                        },
		                        regexp: {
		                            regexp: /^[a-zA-Z0-9_\.]+$/,
		                            message: '密码只能由字母、数字、点、下划线组成 '
		                        }
		                    }
		                },
		                roleIds : {
		                	validators: {
		                        notEmpty: {
		                            message: '角色不能为空！'
		                        }
		                    }
		                }
		            }
		        });
	   			
	   			// $('#userCreateForm').data('bootstrapValidator').enableFieldValidators('roleIds', false);
		    });
   	    
		   	function submitUserCreateForm () {
				// 获取关联的bootstrapValidator对象	
		   		var bv = $('#userCreateForm').data('bootstrapValidator');
		        bv.validate();
		        if (!bv.isValid()) {
		        	return;
		        }
		        $.post ('${pageContext.request.contextPath}/user/create', $('#userCreateForm').serializeArray(), function (result) {
		 			if (result.success) {
		 				$('#page-wrapper').load ('${pageContext.request.contextPath}/user');
		 				$('#userDialog').modal ('hide');
		 			} else {
		 				alert (result.message);
		 			}
		 		});
		 	}
   		</script>
   	</div>
