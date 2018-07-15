import QtQuick 1.1

Item{
	id:root;
	property alias text: title.text;
	property alias pixelSize: title.font.pixelSize;
	property alias textAnchors: title.anchors;
	property alias textColor: title.color;
	property string style: "middle";
	property string info;

	width:parent.width;
	height:title.height + 10;
	Rectangle{
		anchors{
			left:parent.left;
			right:title.left;
			leftMargin:5;
			rightMargin:5;
			verticalCenter:parent.verticalCenter;
		}
		height:3;
		radius:5;
		smooth:true;
		color:"lightslategrey";
		opacity:0.8;
	}
	Text{
		id:title;
		anchors.verticalCenter:parent.verticalCenter;
		anchors.horizontalCenter: root.style === "middle" ? root.horizontalCenter : undefined;
		anchors.left: root.style === "left" ? root.left : undefined;
		anchors.leftMargin: root.style === "left" ? 13 : 0;
		z:2;
		font.pixelSize: constant._LabelTextSize;
		font.family: constant._FontFamily;
		color: constant._LabelTextColor;
		MouseArea{
			anchors.fill: parent;
			onClicked: {
				setMsg(root.info);
			}
		}
	}
	Rectangle{
		anchors{
			left:title.right;
			right:parent.right;
			leftMargin:5;
			rightMargin:5;
			verticalCenter:parent.verticalCenter;
		}
		width:parent.width;
		height:3;
		radius:5;
		smooth:true;
		opacity:0.8;
		color:"lightslategrey";
	}
}
