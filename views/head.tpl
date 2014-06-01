<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>Lite Tasker</title>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
	<link rel="stylesheet" href="<TMPL_VAR NAME='web_root'>css/main.css" type="text/css">
	<link rel="stylesheet" href="<TMPL_VAR NAME='web_root'>css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
	<link rel="stylesheet" href="<TMPL_VAR NAME='web_root'>css/jquery.tooltip.css" type="text/css">
	
	<link rel="icon" type="image/png" href="<TMPL_VAR NAME='web_root'>img/favicon.ico">
	
	<script type="text/javascript" src="<TMPL_VAR NAME='web_root'>js/jquery.js"></script> 
	<script type="text/javascript"src="<TMPL_VAR NAME='web_root'>js/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="<TMPL_VAR NAME='web_root'>js/jquery.tablesorter.js"></script> 
	<script type="text/javascript" src="<TMPL_VAR NAME='web_root'>js/jquery.tooltip.js"></script> 
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
		$("helper").tooltip({ 
			delay: 800, 
			showURL: false, 
			opacity: 0.8,
			fade: 500
		}); 
	});
			
</script>

<div class=main>

<TMPL_IF NAME="user_auth">
	<table class=top_menu>
		<tr>
			<td class=user>
				Захотелось поработать, <a href="<TMPL_VAR NAME='web_root'>user.cgi?user_id=<TMPL_VAR NAME='user_id'>"><TMPL_VAR NAME="user_name"></a>?
			<td class=menu>
				<a href="<TMPL_VAR NAME='web_root'>projects.cgi">Проекты</a>
				<TMPL_IF NAME='p_id'>
					:: <a href="<TMPL_VAR NAME='web_root'>project_view.cgi?project_id=<TMPL_VAR NAME='p_id'>"><TMPL_VAR NAME='p_name'></a>
					:: <a href="<TMPL_VAR NAME='web_root'>tasks.cgi?project_id=<TMPL_VAR NAME='p_id'>">Задачи</a>
					<TMPL_IF NAME="tasks_list">
						:: <a href="<TMPL_VAR NAME='web_root'>task_edit.cgi?project_id=<TMPL_VAR NAME='p_id'>">Новая задача</a>
					</TMPL_IF>
				<TMPL_ELSE>
					<TMPL_IF NAME="user_view">
						| <a href="<TMPL_VAR NAME='web_root'>user.cgi">Профиль</a> 
						:: <a href="<TMPL_VAR NAME='web_root'>user_edit.cgi?action=edit">Редактировать</a>
					<TMPL_ELSE>
						:: <a href="<TMPL_VAR NAME='web_root'>project_edit.cgi?action=new">Создать новый</a>
					</TMPL_IF>
				</TMPL_IF>
			<td class=logout>
				<a href="<TMPL_VAR NAME='web_root'>login.cgi?action=out">X</a>
	</table>
</TMPL_IF>
