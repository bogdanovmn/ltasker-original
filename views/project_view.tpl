<TMPL_INCLUDE NAME='head.tpl'>

<table class=view>
	<tr>
		<th class=title>Проект
		<th class=close><a href="<TMPL_VAR NAME='web_root'>tasks.cgi?project_id=<TMPL_VAR NAME='p_id'>">X</a>
		
	<tr>
		<td>Назваие:
		<td><TMPL_VAR NAME="p_name">
	
	<tr>
		<td>Описание:
		<td><TMPL_VAR ESCAPE="NONE" NAME="p_description">
	
	<tr>
		<td>Компоненты:
		<td>
			<TMPL_LOOP NAME="p_components">
				<TMPL_VAR NAME="name"><br>
			</TMPL_LOOP>
	
	<tr>
		<td>Дата создания:
		<td><TMPL_VAR NAME="p_create_date">
	
	<tr>
		<th colspan=2 class=action>
			<a href="<TMPL_VAR NAME='web_root'>project_edit.cgi?project_id=<TMPL_VAR NAME='p_id'>&action=edit">Редактировать</a>
</table>

<TMPL_INCLUDE NAME='foot.tpl'>
