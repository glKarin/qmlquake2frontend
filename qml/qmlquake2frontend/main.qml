import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import karin.quake2 1.0

PageStackWindow{
	id: app;

	showStatusBar: inPortrait;
	initialPage: MainPage{
		id: mainPage;
		Component.onCompleted: {
			makeSettingComponent(frontend.settingGroups);
		}
	}

	InfoBanner {
		id: infoBanner; 
		topMargin: 50;
		leftMargin: 5;
		height: text.height + 10;
	}

	function setMsg(text) {
		infoBanner.text = text;
		infoBanner.show();
	}

	Quake2FrontEnd{
		id: frontend;
		onSettingGroupsChanged: {
			mainPage.makeSettingComponent(settingGroups);
		}
	}

	Constant{
		id: constant;
	}

	function createSettingComponent(file, parent)
	{
		if(!file)
		{
			return;
		}
		var item = null;
		var component = Qt.createComponent(Qt.resolvedUrl(file));
		if(component.status === Component.Ready){
			item = component.createObject(parent);
		}else{
			console.log(component.errorString());
		}
		return item;
	}

	function destroyAll(ch)
	{
		if(!ch || !Array.isArray(ch))
		{
			return;
		}
		for(var i = 0; i < ch.length; i++)
		{
			destroy(ch[i]);
		}
	}

}


