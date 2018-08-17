<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.qfedu.demo.ssh.dto.MenuDto" %>
<%
	List<MenuDto> menus = (List<MenuDto>) request.getAttribute("menus"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>

    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath}/sb-admin2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${pageContext.request.contextPath}/sb-admin2/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="${pageContext.request.contextPath}/sb-admin2/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="${pageContext.request.contextPath}/sb-admin2/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/sb-admin2/dist/css/sb-admin-2.min.css" rel="stylesheet">

	<!-- bootstrap validator -->
    <link href="${pageContext.request.contextPath}/sb-admin2/vendor/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet">
    
    <!-- Custom Fonts -->
    <link href="${pageContext.request.contextPath}/sb-admin2/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">SB Admin v2.0</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href='javascript:void(0)'>
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href='javascript:void(0)'><i class="fa fa-gear fa-fw"></i> 修改密码</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out fa-fw"></i> 退出</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control input-sm" placeholder="Search/sb-admin2.">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                        <% for (MenuDto m : menus) { %>
                        <li>
                            <a href='javascript:void(0)' class="<%=m.getActiveCls()%>"><i class="fa <%=m.getIcon()%> fa-fw"></i> <%=m.getName()%><span class="fa arrow"></span></a>
                            <% if (m.getChildren().size() > 0) { %>
                            <ul class="nav nav-second-level">
                            	<% for (MenuDto c : m.getChildren()) { %>
                                <li>
                                    <a href='javascript:void(0)' menuURL="<%=c.getUrl()%>" class="<%=c.getActiveCls()%>"><i class="fa <%=c.getIcon()%> fa-fw"></i> <%=c.getName()%></a>
                                </li>
                                <% } %>
                            </ul>
                            <% } %>
                        </li>
                        <% } %>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

		<div>
        <div id="page-wrapper">
            
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    	
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="${pageContext.request.contextPath}/sb-admin2/dist/js/sb-admin-2.min.js"></script>

	<!-- bootstrap validator -->
    <script src="${pageContext.request.contextPath}/sb-admin2/vendor/bootstrap-validator/js/bootstrapValidator.min.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
    	// 设置菜单的点击事件
        $('#side-menu').on ('click', 'li a', function () {
        	// 去掉所有菜单的active样式
        	$('#side-menu').find('li a').removeClass('active');
        	// 从菜单a标签上获取属性menuURL
        	var url = $(this).attr ('menuURL');
        	if (url) {
        		$('#page-wrapper').load ('${pageContext.request.contextPath}' + url);
        	}
        	$(this).addClass('active');
        });
        // 查找active的菜单，并触发菜单点击事件
        $('#side-menu').find('li a.active').click ();
    });
    </script>

</body>
</html>