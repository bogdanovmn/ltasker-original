<TMPL_INCLUDE NAME='head.tpl'>

<div class=login>
	<h1>Lite Tasker <span class=version>v<TMPL_VAR NAME="version"></span></h1>
	
	<TMPL_IF NAME="error_msg"><span class=error_msg><TMPL_VAR NAME="error_msg"></span></TMPL_IF>
	<form name=login method=post>
		<table class=view>
			<tr>
				<th class=title colspan=2>Авторизация
			<tr>
			<td>Имя:
			<td><input class="validate[required] text-input" size=14 type=text name=name value=''>
			
			<tr>
			<td>Пароль:
			<td><input class="validate[required] text-input" size=14 type=password name=password value=''>
			
			<tr>
				<th class=action>
					<a href="<TMPL_VAR NAME='web_root'>user_edit.cgi">Регистрация</a>
				<th class=action>
					<input type=submit name=login_submit value='Войти'> 
		</table>
		<input type=hidden name=action value='in'>
	</form>
</div>

<TMPL_INCLUDE NAME='foot.tpl'>
