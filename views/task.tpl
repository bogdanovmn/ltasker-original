<TMPL_INCLUDE NAME='head.tpl'>

<table class=view>
	<tr>
		<th class=title>������
		<th class=close><a href="<TMPL_VAR NAME='web_root'>tasks.cgi?project_id=<TMPL_VAR NAME='p_id'>">X</a>
	<tr>	
		<td>������: 
		<td><TMPL_VAR NAME="t_name">	
	<tr>
		<td>���:
		<td><TMPL_VAR NAME="t_type_name">
	<tr>
		<td>���������:
		<td><TMPL_VAR NAME="t_component_name">
	<tr>
		<td>���������:
		<td><TMPL_VAR NAME="t_priority_name">
	<tr>
		<td>������:
		<td><TMPL_VAR ESCAPE="NONE" NAME="t_description">
	<tr>
		<th colspan=2 class=action>
			<a href="<TMPL_VAR NAME='web_root'>task_edit.cgi?task_id=<TMPL_VAR NAME='t_id'>&action=edit">�������������</a>
</table>

<TMPL_INCLUDE NAME='foot.tpl'>
