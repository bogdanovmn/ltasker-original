<TMPL_INCLUDE NAME='head.tpl'>

<table class=view>
	<tr>
		<th class=title>Пользователь
		<th class=close><a href="<TMPL_VAR NAME='web_root'>projects.cgi">X</a>
	<tr>	
		<td>Имя:
		<td><TMPL_VAR NAME="user_name">	
	<tr>
		<td>email:
		<td><TMPL_VAR NAME="user_email">
	<tr>
		<th class=action colspan=2>
			<a href="<TMPL_VAR NAME='web_root'>user_edit.cgi?user_id=<TMPL_VAR NAME='user_id'>&action=edit">Редактировать</a>
</table>

<TMPL_INCLUDE NAME='foot.tpl'>
