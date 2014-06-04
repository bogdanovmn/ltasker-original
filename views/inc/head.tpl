<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>Lite Tasker</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/css/main.css" type="text/css">
	<link rel="stylesheet" href="/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
	<link rel="stylesheet" href="/css/jquery.tooltip.css" type="text/css">
	
	<link rel="icon" type="image/png" href="/img/favicon.ico">
	
	<script type="text/javascript" src="/js/jquery.js"></script> 
	<script type="text/javascript" src="/js/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="/js/jquery.tablesorter.js"></script> 
	<script type="text/javascript" src="/js/jquery.tooltip.js"></script> 
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

<TMPL_IF NAME=user_auth>
	<table class=top_menu>
		<tr>
			<td class=user>
				Захотелось поработать, <a href="/user.cgi?user_id=<TMPL_VAR NAME=user_id>"><TMPL_VAR NAME=user_name></a>?
			<td class=menu>
				<a href="/projects/">Проекты</a>
				<TMPL_IF NAME=p_id>
					:: <a href="/project_view/<TMPL_VAR NAME=p_id>/"><TMPL_VAR NAME=p_name></a>
					:: <a href="/tasks/<TMPL_VAR NAME=p_id>/">Задачи</a>
					<TMPL_IF NAME=tasks_list>
						:: <a href="/new_task/<TMPL_VAR NAME=p_id>/">Новая задача</a>
					</TMPL_IF>
				<TMPL_ELSE>
					<TMPL_IF NAME=user_view>
						| <a href="/user/">Профиль</a> 
						:: <a href="/user_edit/">Редактировать</a>
					<TMPL_ELSE>
						:: <a href="/new_project/">Создать новый</a>
					</TMPL_IF>
				</TMPL_IF>
			<td class=logout>
				<a href="/logout/">X</a>
	</table>
</TMPL_IF>
