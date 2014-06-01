<TMPL_INCLUDE NAME='head.tpl'>

<div class=login>

<h1>Lite Tasker</h1>

<form method=post>
	<table class=view>
		<tr>
			<th class=title>Пользователь
			<th class=close><a href="<TMPL_VAR NAME='web_root'>user.cgi">X</a>
		<tr>	
			<td>Имя 
			<td><input class="validate[required,length[3,50]] text-input" type=text name=login value='<TMPL_VAR NAME="user_name">'>	
		<tr>
			<td>email:
			<td><input class="validate[required] text-input" type=text name=email value='<TMPL_VAR NAME="user_email">'>
		<TMPL_IF NAME="new">
			<tr>
				<td>Пароль:
				<td><input class="validate[required,length[6,12]] text-input" type=password name=password id=password value=''>
			<tr>
				<td>Пароль (повтор):
				<td><input class="validate[required,confirm[password]] text-input" type=password name=password_verify value=''-->
		</TMPL_IF>
		<tr>
			<th class=action colspan=2><input type=submit name=submit value='ok'> 
	</table>
	<input type=hidden name=user_id value='<TMPL_VAR NAME="user_id">'>
	<input type=hidden name=action value='<TMPL_IF NAME="new">add<TMPL_ELSE>update</TMPL_IF>'>
</form>

</div>

<TMPL_INCLUDE NAME='foot.tpl'>
