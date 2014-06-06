<table class=view>
	<tr>
		<th class=title>Задача
		<th class=close><a href="/tasks/<TMPL_VAR NAME=p_id>/">X</a>
	<tr>	
		<td>Кратко: 
		<td><TMPL_VAR NAME=t_name>	
	<tr>
		<td>Тип:
		<td><TMPL_VAR NAME=t_type_name>
	<tr>
		<td>Компонент:
		<td><TMPL_VAR NAME=t_component_name>
	<tr>
		<td>Приоритет:
		<td><TMPL_VAR NAME=t_priority_name>
	<tr>
		<td>Детали:
		<td><TMPL_VAR ESCAPE="NONE" NAME=t_description>
	<tr>
		<th colspan=2 class=action>
			<a href="/task_edit/<TMPL_VAR NAME=p_id>/<TMPL_VAR NAME=t_id>/">Редактировать</a>
</table>
