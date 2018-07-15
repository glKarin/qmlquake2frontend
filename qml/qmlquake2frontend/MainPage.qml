import QtQuick 1.1
import com.nokia.meego 1.1

KarinPage{
	id:root;
	property variant dialogComponent: null;

	title: frontend.getString(constant._AppName);

	Flickable{
		id: flick;
		anchors.fill:parent;
		anchors.topMargin: headerHeight;
		contentWidth:width;
		clip:true;
		contentHeight:mainlayout.height;
		Column{
			id:mainlayout;
			width:parent.width;
			spacing: 8;
		}
	}
	ScrollDecorator { flickableItem: flick; }

	tools:ToolBarLayout{
		Button{
            text:qsTr("Run");
            enabled: !frontend.running;
            anchors.verticalCenter: parent.verticalCenter;
			platformStyle:ButtonStyle{
                buttonWidth: 180;
			}
			onClicked:{
                setMsg(qsTr("Running Quake II ..."));
                frontend.runQuake2();
			}
		}
        Button{
            text:qsTr("Terminate");
            enabled: frontend.running;
            anchors.verticalCenter: parent.verticalCenter;
            visible: enabled;
            platformStyle:ButtonStyle{
                buttonWidth: 180;
            }
            onClicked:{
                setMsg(qsTr("Terminate Quake II ..."));
                frontend.kill();
            }
        }
		ToolIcon {
			platformIconId: "toolbar-view-menu";
			onClicked: {
				mainMenu.open();
			}
		}
	}

	Menu {
		id: mainMenu;
		MenuLayout {
			MenuItem {
				text: qsTr("Key Help");
				onClicked: {
					pageStack.push(Qt.resolvedUrl("KeyImagePage.qml"));
				}
			}
			MenuItem {
				text:qsTr("Reset");
				onClicked:{
					frontend.reset();
				}
			}
			MenuItem {
				text:qsTr("About");
				onClicked: {
					openDialog(constant._AboutTitleText + frontend.getString(constant._AppBin), constant._AboutContentText, Qt.openUrlExternally);
				}
			}
			MenuItem {
				text:qsTr("Quit");
				onClicked: {
					Qt.quit();
				}
			}
		}
	}

	function dest()
	{
		destroyAll(mainlayout.children);
		mainlayout.children = [];
	}

	function makeSettingComponent(group)
	{
		if(!group)
		{
			return;
		}
		for(var i = 0; i < group.length; i++)
		{
			//console.log(i, group[i].name);
			var sec = createSettingComponent("Section.qml", mainlayout);
			sec.init(group[i]);
		}
	}

	function openDialog(title, msg, func)
	{
		if(!title || !msg)
		{
			return;
		}
		if(!dialogComponent)
		{
			dialogComponent = Qt.createComponent("MessageDialog.qml");
		}
		var dialog = dialogComponent.createObject(pageStack.currentPage, {titleText: title, message: msg});
		if(func && typeof(func) === "function")
		{
			dialog.linkActivated.connect(func);
		}
		dialog.open();
	}

}

