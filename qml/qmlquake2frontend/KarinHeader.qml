import QtQuick 1.1
import com.nokia.meego 1.1

Rectangle{
	id: root;
	property alias title: show.text;

	height: constant._HeaderHeight;
	z: 100;
	color: constant._HeaderBGColor;
	width: parent.width;

	Text{
		id: show;
		anchors.verticalCenter: parent.verticalCenter;
		width: parent.width;
		horizontalAlignment: Text.AlignHCenter;
		elide: Text.ElideRight;
		font.pixelSize: 36;
		font.family: constant._FontFamily;
		z: 10;
		color: constant._HeaderLabelColor;
		clip: true;
	}

}

