import QtQuick 1.1

Item{
	id: root;

	objectName: "karinSettingSection";
	width: parent.width;
	height: header.height + body.height;
	SectionHeader{
		id: header;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		item: body;
	}

	SectionBody{
		id: body;
		anchors.top: header.bottom;
		anchors.left: parent.left;
		anchors.right: parent.right;
	}

	function dest()
	{
		destroyAll(body.container.children);
		body.container.children = [];
	}

	function init(group)
	{
		if(!group)
		{
			return;
		}
		header.text = group.name;

		for(var m = 0; m < group.settings.length; m++)
		{
			var si = group.settings[m];
			//console.log(si.title);
			var qmlfile = null;
			if(si.type == constant._BooleanSetting)
			{
				qmlfile = "SwitchSetting.qml";
			}
			else if(si.type == constant._ListSetting)
			{
				qmlfile = "SelectionSetting.qml";
			}
			else if(si.type == constant._IntRangeSetting)
			{
				qmlfile = "SliderSetting.qml";
			}
			else if(si.type == constant._CStringSetting)
			{
				qmlfile = "StringSetting.qml";
			}
			else
			{
				console.log("Setting<%1> type<%2> is not supported.".arg(si.name).arg(si.type));
				continue;
			}

			var item = createSettingComponent(qmlfile, body.container);
			if(item)
			{
				item.init(si);
			}
			else
			{
				console.log("Setting <%1> component create fail from file<%2>!".arg(si.name).arg(qmlfile));
			}
		}
	}

	Component.onDestruction:{
		console.log("[Destroy]: " + objectName);
	}
}

