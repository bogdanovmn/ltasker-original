<TMPL_INCLUDE NAME='inc/error_msg.tpl'>

<form name=task method=post>
	<table class=view>
		<tr>
			<th class=title>Новая задача
			<th class=close><a href="/tasks/<TMPL_VAR NAME=p_id>/">X</a>
			
		<tr>
			<td>Кратко:
			<td><input class="validate[required,length[10,255]] text-input" size=50 type=text name=name value=''>
		
		<tr>
			<td>Тип:
			<td>
				<select name=type>
					<TMPL_LOOP NAME=types>
						<option value="<TMPL_VAR NAME=id>"><TMPL_VAR NAME=name></option>
					</TMPL_LOOP>
				</select>
		<tr>	
			<td>Компонент:
			<td>
				<select name=component>
					<TMPL_LOOP NAME=components>
						<option value="<TMPL_VAR NAME=id>"><TMPL_VAR NAME=name></option>
					</TMPL_LOOP>
				</select>
		<tr>	
			<td>Приоритет:
			<td>
				<select name=priority>
					<TMPL_LOOP NAME=priorities>
						<option value="<TMPL_VAR NAME=id>"><TMPL_VAR NAME=name></option>
					</TMPL_LOOP>
				</select>
		
		<tr>
			<td>Описание:
			<td><textarea class="validate[required,length[10,3000]] text-input" cols=50 rows=10 name=description></textarea>
		
		<tr>
			<th colspan=2 class=action>
				<input type=submit name=task_submit value='Добавить'>
	</table>
	<input type=hidden name=action value='add'>
	<input type=hidden name=project_id value='<TMPL_VAR NAME=p_id>'>
</form>
