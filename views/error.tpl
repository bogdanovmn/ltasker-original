<TMPL_INCLUDE NAME="head.tpl">

<div class=error>
	<center><p class=error_title><TMPL_VAR NAME="msg"></p></center>
	<TMPL_IF NAME="debug">
		<pre>
			<TMPL_VAR NAME="debug">
		</pre>
	</TMPL_IF>
	</div>

<!-- Bottom -->
<TMPL_INCLUDE NAME="foot.tpl">
