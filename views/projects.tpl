<TMPL_INCLUDE NAME='head.tpl'>

<h1><TMPL_VAR NAME="ver"></h1>

<TMPL_IF NAME="permission_failed">
	<h2>������ ��������</h2>
<TMPL_ELSE>
	<TMPL_IF NAME="projects">
		<TMPL_LOOP NAME="projects">
			<div class=project>
				<a href="<TMPL_VAR NAME='web_root'>tasks.cgi?project_id=<TMPL_VAR NAME='id'>">
					<TMPL_VAR NAME="name">
				</a>
				<p class=info><b>������:</b> <TMPL_VAR NAME="create_date"></p>
				<p class=action>
					<a href="<TMPL_VAR NAME='web_root'>project_view.cgi?project_id=<TMPL_VAR NAME='id'>">��������</a>
			</div>
		</TMPL_LOOP>
	<TMPL_ELSE>
		<h2>������ �������� ����. <a href="<TMPL_VAR NAME='web_root'>project_edit.cgi?action=new">������� ������</a></h2>
	</TMPL_IF>
</TMPL_IF>

<TMPL_INCLUDE NAME='foot.tpl'>
