<h1><TMPL_VAR NAME=ver></h1>

<TMPL_IF NAME=projects>
	<TMPL_LOOP NAME=projects>
		<div class=project>
			<a href="/tasks/<TMPL_VAR NAME=id>/">
				<TMPL_VAR NAME=name>
			</a>
			<p class=info><b>Создан:</b> <TMPL_VAR NAME=create_date></p>
			<p class=action>
				<a href="/project_view/<TMPL_VAR NAME=id>/">Описание</a>
		</div>
	</TMPL_LOOP>
<TMPL_ELSE>
	<h2>Список проектов пуст. <a href="/new_project/">Создать проект</a></h2>
</TMPL_IF>
