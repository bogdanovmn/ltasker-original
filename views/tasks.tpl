<TMPL_IF NAME=tasks>
	<style type="text/css">
		table.tasks th.header {
			background-image: url(//img/no_sort.gif);
			cursor: pointer;
			background-repeat: no-repeat;
			background-position: center left;
			padding: 3px 20px;
		}

		table.tasks th.headerSortUp {
			background-image: url(//img/asc.gif);
			background-color: #B17ECF;
		}
		table.tasks th.headerSortDown {
			background-image: url(//img/desc.gif);
			background-color: #B17ECF;
		}
	</style>

	<table id=tasks class=tasks>
		<thead>
		<tr>
			<th>Кратко
			<th>Тип
			<th>Приоритет
			<th>Компонент
			<th>Создана
			<th>Статус
			<th>Закрыта
			<th>...
		</thead>
		<tbody>
		<TMPL_LOOP NAME=tasks>
			<tr>
			<td class=name>
				<a 
					href="/task_view/<TMPL_VAR NAME=project_id>/<TMPL_VAR NAME=id>/" 
					title='<b>Детали задачи:</b><br><br><TMPL_VAR NAME=description>'
					name=helper
				>
					<TMPL_VAR NAME=name><TMPL_VAR NAME=ver>
				</a>
			<td class=type><TMPL_VAR NAME=type>
			<td class=priority><TMPL_VAR NAME=priority>
			<td class=component><TMPL_VAR NAME=component>
			<td class=date><TMPL_VAR NAME=create_date>
			<td class=status><TMPL_VAR NAME=status>
			<td class=date><TMPL_VAR NAME=close_date>
			<td class=action>
				<a href="/task_edit/<TMPL_VAR NAME=status_action>/<TMPL_VAR NAME=project_id>/<TMPL_VAR NAME=id>/"><TMPL_VAR NAME=status_action_name></a>
		</TMPL_LOOP>
		</tbody>
	</table>

	<script type="text/javascript">
		$(document).ready(
			function() {
				$("#tasks").tablesorter({ 
					headers : { 
						7 : { sorter : false }
					},
					textExtraction : "complex"
				});
			}
		);
	</script>
<TMPL_ELSE>
	<h2>Список задач пуст. <a href="/new_task/<TMPL_VAR NAME=p_id>/">Открыть задачу</a></h2>
</TMPL_IF>
