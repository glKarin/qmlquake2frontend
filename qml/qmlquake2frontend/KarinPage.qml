import QtQuick 1.1
import com.nokia.meego 1.1

Page{
	id: root;
	property alias title: header.title;
	property alias headerHeight: header.height;
	property alias headerBottom: header.bottom;
	
	orientationLock: PageOrientation.LockPortrait;

	KarinHeader{
		id: header;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
	}

	/*
	WaterWaveShader{
		id: gl;
		item: header;
		center: Qt.point(header.height / 2, header.width / 2);
		radiusLimit: root.width;
		waterColor: "lightskyblue";
		z: 1;
		//mouse: false;
		waveFactory: 0.02;
		waveSpeed: 10;
		waveRollSpeed: 0.2;
		waveWidth: 80;
		waterIdentity: 0.0;
		interval: 120;
	}
	*/

}

