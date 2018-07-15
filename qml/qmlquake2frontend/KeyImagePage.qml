import QtQuick 1.1
import com.nokia.meego 1.1

Page{
	id: root;
	
	//orientationLock: PageOrientation.LockLandscape;

	Rectangle {
		id: bg;
		anchors.fill: parent;
		color: "black";
	}

	/*
	WaterWaveShader{
		id: gl;
		item: pathView;
		center: Qt.point(pathView.height / 2, pathView.width / 2);
		radiusLimit: root.width;
		waterColor: "lightskyblue";
		z: 3;
		mouse: false;
		waveFactory: 0.02;
		waveSpeed: 10;
		waveRollSpeed: 0.2;
		waveWidth: 80;
		waterIdentity: 0.0;
		interval: 120;
	}
	*/

	ImagePathView{
		id: pathView;
		anchors.fill: parent;
		z: 2;
		onClicked: {
			bottomBar.state = bottomBar.state === constant._ShowState ? constant._HideState : constant._ShowState;
		}
		onCurrentIndexChanged: {
			if(currentIndex != -1)
			{
				label.text = pathView.model.get(pathView.currentIndex).name;
			}
		}
	}

	Timer {
		id: timer;
		running: bottomBar.state === constant._ShowState;
		interval: constant._BarStateTimerInterval;
		onTriggered: {
			bottomBar.state = constant._HideState;
		}
	}

	Rectangle {
		id: bottomBar;
		width: parent.width;
		height: constant._BarHeight;
		y: parent.height - constant._BarHeight;
		color: constant._BarColor;
		opacity: constant._BarOpacity;
		z: 10;

		MouseArea{
			anchors.fill: parent;
		}

		states: [
			State {
				name: constant._HideState;
				PropertyChanges {
					target: bottomBar;
					y: root.height;
					opacity: 0.0;
				}
			}
		]
		transitions: [
			Transition {
				from: constant._ShowState; 
				to: constant._HideState;
				reversible: true;
				ParallelAnimation {
					PropertyAnimation {
						properties: "opacity";
						easing.type: Easing.InOutExpo;
						duration: constant._BarStateAnimationDuration;
					}
					PropertyAnimation {
						properties: "y";
						easing.type: Easing.InOutExpo;
						duration: constant._BarStateAnimationDuration;
					}
				}
			}
		]

		Button {
			id: backbutton;
			platformStyle: ButtonStyle {
				buttonWidth: constant._BarButtonWidth;
				buttonHeight: constant._BarButtonWidth;
				inverted: true;
			}
			iconSource: "image://theme/icon-m-toolbar-back-white"
			anchors {
				left: parent.left;
				leftMargin: 10;
				verticalCenter: parent.verticalCenter;
			}
			onClicked: {
				pageStack.pop();
			}
		}
		Button {
			id: prev_button;
			platformStyle: ButtonStyle {
				buttonWidth: constant._BarButtonWidth;
				buttonHeight: constant._BarButtonWidth;
				inverted: true;
			}
			iconSource: "image://theme/icon-m-toolbar-previous-white"
			anchors {
				right: separatorLeft.left;
				rightMargin: 2;
				verticalCenter: parent.verticalCenter;
			}
			onClicked: {
				pathView.prev();
				timer.restart();
			}
		}
		Rectangle {
			id: separatorLeft;
			width: constant._SeparatorWidth;
			color: constant._SeparatorColor;
			anchors {
				top: parent.top;
				bottom: parent.bottom;
				right: label.left;
				margins: 2;
			}
		}
		Text {
			id: label;
			font.family: constant._FontFamily;
			color: constant._BarTitleColor;
			font.pixelSize: 30;
			width: 200;
			anchors {
				horizontalCenter: parent.horizontalCenter;
				top: parent.top;
				bottom: parent.bottom;
			}
			elide: Text.ElideRight;
			verticalAlignment: Text.AlignVCenter;
			horizontalAlignment: Text.AlignHCenter;
		}
		Rectangle {
			id: separatorRight;
			width: constant._SeparatorWidth;
			color: constant._SeparatorColor;
			anchors {
				top: parent.top;
				bottom: parent.bottom;
				left: label.right;
				margins: 2;
			}
		}
		Button {
			id: next_button;
			platformStyle: ButtonStyle {
				buttonWidth: constant._BarButtonWidth;
				buttonHeight: constant._BarButtonWidth;
				inverted: true;
			}
			iconSource: "image://theme/icon-m-toolbar-next-white"
			anchors {
				left: separatorRight.right;
				leftMargin: 2;
				verticalCenter: parent.verticalCenter;
			}
			onClicked: {
				pathView.next();
				timer.restart();
			}
		}
	}

	Component.onCompleted: {
		pathView.model.append( { source: Qt.resolvedUrl("../../resc/key_Game.png"), name: qsTr("Game") });
		pathView.model.append( { source: Qt.resolvedUrl("../../resc/key_Console.png"), name: qsTr("Console") });
		pathView.model.append( { source: Qt.resolvedUrl("../../resc/key_Menu.png"), name: qsTr("Menu") });
		label.text = pathView.model.get(pathView.currentIndex).name;
	}

}
