import QtQuick 1.1
import com.nokia.meego 1.1

Item{
	id: root;

	objectName: "karinStringSetting";
	property string name;
	width:parent.width;
	height: col.height;
	Column{
		id: col;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		LineText{
			id:  label;
			anchors.horizontalCenter: parent.horizontalCenter;
			width: parent.width;
		}
		Row{
			width: parent.width;
			height: tf.height;
			spacing: 8;
			TextField{
				id: tf;
				signal inputFinished;

				width: parent.width - doneIcon.width - parent.spacing;
				platformSipAttributes:SipAttributes {
					actionKeyLabel: qsTr("OK");
					actionKeyHighlighted: actionKeyEnabled;
					actionKeyEnabled: tf.text.length !== 0;
				}
				Keys.onReturnPressed:{
					tf.inputFinished();
				}
				platformStyle: TextFieldStyle {
					paddingLeft: 10;
					paddingRight: clearButton.width;
				}
				ToolIcon {
					id: clearButton;
					anchors { right: parent.right; verticalCenter: parent.verticalCenter; }
					platformIconId: "toolbar-close";
					visible: !tf.readOnly && tf.text.length !== 0;
					enabled: visible;
					z: 2;
					onClicked: {
						tf.text = "";
						//root.setFocus(true);
					}
				}
			}
			Button {
				id: doneIcon;
				anchors.verticalCenter: parent.verticalCenter;
				visible: !tf.readOnly && tf.text.length !== 0;
				enabled: visible;
				platformStyle:ButtonStyle {
					buttonWidth: buttonHeight; 
				}
				iconSource: "image://theme/icon-m-toolbar-done";
				onClicked: {
					tf.inputFinished();
				}
			}
		}
	}

	function setFocus(f)
	{
		if(f)
		{
			forceActiveFocus();
			platformOpenSoftwareInputPanel();
		}
		else
		{
			platformCloseSoftwareInputPanel();
		}
	}

	function init(setting)
	{
		if(!setting)
		{
			return;
		}
		if(setting.type !== constant._CStringSetting)
		{
			return;
		}
		root.name = setting.name;
		label.text = setting.title;
		label.info = setting.desc;
		var v = setting.values[0];
		tf.placeholderText = setting.values[1].value;
		tf.text = v.value;
		v.valueChanged.connect(function(c){
			tf.text = c;
		});
		tf.inputFinished.connect(function(){
			frontend.setSetting(root.name, tf.text);
		});
	}

	Component.onDestruction:{
		console.log("[Destroy]: " + objectName);
	}
}
