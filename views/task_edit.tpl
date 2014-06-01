<TMPL_INCLUDE NAME='head.tpl'>

<form name=task method=post>
	<table class=view>
		<tr>
			<th class=title>������
			<th class=close><a href="<TMPL_VAR NAME='web_root'>task.cgi?task_id=<TMPL_VAR NAME='t_id'>">X</a>
		<tr>
			<td>������:
			<td><input class="validate[required,length[10,255]] text-input" size=91 type=text name=name value='<TMPL_VAR NAME="t_name">'>
		<tr>
			<td>���:
			<td>
				<select name=type>
					<TMPL_LOOP NAME="types">
						<option <TMPL_IF NAME="selected">selected</TMPL_IF> value="<TMPL_VAR NAME='id'>"><TMPL_VAR NAME="name"></option>
					</TMPL_LOOP>
				</select>
		<tr>
			<td>���������:
			<td>
				<select name=component>
					<TMPL_LOOP NAME="components">
						<option <TMPL_IF NAME="selected">selected</TMPL_IF> value="<TMPL_VAR NAME='id'>"><TMPL_VAR NAME="name"></option>
					</TMPL_LOOP>
				</select>
		<tr>
			<td>���������:
			<td>
				<select name=priority>
					<TMPL_LOOP NAME="priorities">
						<option <TMPL_IF NAME="selected">selected</TMPL_IF> value="<TMPL_VAR NAME='id'>"><TMPL_VAR NAME="name"></option>
					</TMPL_LOOP>
				</select>
		<tr>
			<td>������:
			<td><textarea class="validate[required,length[10,3000]] text-input" cols=70 rows=20 name=description><TMPL_VAR NAME="t_description"></textarea>
		
		<tr>
		<th colspan=2 class=action>
			<input type=submit name=task_submit value='��������'>
	</table>
	<input type=hidden name=action value='update'>
	<input type=hidden name=task_id value='<TMPL_VAR NAME="t_id">'>
	<input type=hidden name=project_id value='<TMPL_VAR NAME="p_id">'>
</form>

<TMPL_INCLUDE NAME='foot.tpl'>