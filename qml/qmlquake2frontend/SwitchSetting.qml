import QtQuick 1.1
import com.nokia.meego 1.1

Item {
	id: root;
	objectName: "karinSwitchSetting";
	property string name;

	width: parent.width;
	height: 50;
	Row{
		anchors.fill: parent;
		LineText{
			id: label;
			anchors.verticalCenter:parent.verticalCenter;
			style:"left";
			width:parent.width - switcher.width;
		}
		Switch{
			id: switcher;
			anchors.verticalCenter:parent.verticalCenter;
		}
	}

	function init(setting)
	{
		if(!setting)
		{
			return;
		}
		if(setting.type !== constant._BooleanSetting)
		{
			return;
		}
		root.name = setting.name;
		label.text = setting.title;
		label.info = setting.desc;
		switcher.checked = setting.values[setting.current].value === constant._BooleanTrue;
		setting.currentChanged.connect(function(c){
			switcher.checked = setting.values[c].value === constant._BooleanTrue;
		});
		switcher.checkedChanged.connect(function(c){
			frontend.setSetting(root.name, switcher.checked ? constant._BooleanTrue : constant._BooleanFalse);
		});
	}

	Component.onDestruction:{
		console.log("[Destroy]: " + objectName);
	}
}
