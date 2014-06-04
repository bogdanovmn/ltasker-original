<form id=new_project name=project method=post>
	<table class=view>
		<tr>
			<th class=title>Новый проект
			<th class=close><a href="/projects/">X</a>
		<tr>
			<td>Название:
			<td><input class="validate[required] text-input" size=50 type=text name=name value=''>
		
		<tr>
			<td>Описание:
			<td><textarea class="validate[required,length[10,3000]] text-input" cols=50 rows=10 name=description></textarea>
		
		<tr>
			<td>Компоненты:
			<td><textarea class="validate[required,length[3,300]] text-input" cols=30 rows=7 name=new_components></textarea>
		
		<tr>
			<th colspan=2 class=action>
				<input type=submit name=project_submit value='Создать'>
	</table>
	<input type=hidden name=action value='add'>
</form>
