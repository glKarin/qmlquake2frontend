import QtQuick 1.1
import com.nokia.meego 1.1

Item{
	id: root;
	objectName: "karinSelectionSetting";
	property string name;
	width: parent.width;
	height: col.height;

	Column{
		id: col;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		// height: label.height + buttons.height;
		LineText{
			id: label;
			anchors.horizontalCenter: parent.horizontalCenter;
			width: parent.width;

		}
		ButtonColumn{
			id:  buttons;
			width: parent.width;
			exclusive: true;
			spacing: 4;
		}
	}

	Component{
		id: checkbox;
		CheckBox{
			property string value;
			width: parent.width;
			onClicked: {
				frontend.setSetting(root.name, value);
			}
		}
	}

	function dest()
	{
		destroyAll(buttons.children);
		buttons.children = [];
	}

	function init(setting)
	{
		if(!setting)
		{
			return;
		}
		if(setting.type !== constant._ListSetting)
		{
			return;
		}

		root.name = setting.name;
		label.text = setting.title;
		label.info = setting.desc;
		for(var i = 0; i < setting.values.length; i++)
		{
			var s = setting.values[i];
			var item = checkbox.createObject(buttons);
			item.text = s.name + "(" + s.desc + ")";
			item.value = s.value;
			//console.log(s.value, setting.current);
			item.checked = (setting.current == i);
			//item.clicked.connect(setSetting);
		}
		setting.currentChanged.connect(function(c){
			buttons.children[c].checked = true;
		});
	}

	Component.onDestruction:{
		console.log("[Destroy]: " + objectName);
	}
}
