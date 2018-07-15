.pragma library

function href(url, type, name)
{
	if(!url)
		return;
	var fmt = "";
	var t = type.toLowerCase();
	if(t === "mail")
		fmt = "<a href=\"mailto:%1\">%2</a>";
	else
		fmt = "<a href=\"%1\">%2</a>";
	return fmt.arg(url).arg(name ? name : url);
}
