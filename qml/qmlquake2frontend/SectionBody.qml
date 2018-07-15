import QtQuick 1.1

Item{
	id: root;

	property alias container: layout;
	width: parent.width;
	height: layout.height;

	/*
	property int theight: 0;
	property bool fullShow: height === theight;

	state: "show";
	states: [
		State{
			name: "show";
			PropertyChanges {
				target:  root;
				height: theight;
			}
		}
		,
		State{
			name: "noshow";
			PropertyChanges {
				target:  root;
				height: 0;
			}
		}
	]
	transitions:  [
		Transition {
			from: "noshow";
			to: "show";
			NumberAnimation{
				target: root;
				property: "height";
				duration: 400;
				easing.type: Easing.OutExpo;
			}
		}
		,
		Transition {
			from: "show";
			to: "noshow";
			NumberAnimation{
				target: root;
				property: "height";
				duration: 400;
				easing.type: Easing.InExpo;
			}
		}
	]
	*/

	Column{
		id:  layout;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
	}

	function addItem(item)
	{
		if(!item)
		{
			return;
		}
		item.parent = layout;
		//layout.children.push(item);
	}

	function removeAll()
	{
		layout.children = [];
		for(var i = 0; i < layout.children.length; i++)
		{
			destroy(layout.children[i]);
		}
	}
}
