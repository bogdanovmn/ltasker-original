<TMPL_INCLUDE NAME='head.tpl'>

<form name=project method=post>
	<table class=view>
		<tr>
			<th class=title>������
			<th class=close><a href="<TMPL_VAR NAME='web_root'>project_view.cgi?project_id=<TMPL_VAR NAME='p_id'>">X</a>
		<tr>
			<td>��������:
			<td><input class="validate[required] text-input" size=50 type=text name=name value='<TMPL_VAR NAME="p_name">'>
		
		<tr>
			<td>��������:
			<td><textarea class="validate[required,length[10,3000]] text-input" cols=50 rows=10 name=description><TMPL_VAR NAME="p_description"></textarea>
			
		<tr>
			<td>����������:
			<td><TMPL_LOOP NAME="p_components">
					<TMPL_VAR NAME="name"> 
					[ <a href="<TMPL_VAR NAME='web_root'>project_edit.cgi?action=del_component&project_id=<TMPL_VAR NAME='project_id'>&component_id=<TMPL_VAR NAME='id'>">�������</a> ]<br>
				</TMPL_LOOP>
		<tr>
			<td>����� ����������:
			<td>
			<textarea name=new_components cols=20 rows=7></textarea>
			<br>
			<input type=submit name=component_submit value='��������'>
		
		<tr>
		<th colspan=2 class=action>
			<input type=submit name=project_submit value='��������'>
	</table>
	<input type=hidden name=project_id value="<TMPL_VAR NAME='p_id'>">
	<input type=hidden name=action value="update">
</form>

<TMPL_INCLUDE NAME='foot.tpl'>