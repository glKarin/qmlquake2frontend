import QtQuick 1.1
import "../js/main.js" as Main

QtObject{
	id: root;

	property string _AppBin: "APP_BIN";
	property string _AppName: "APP_NAME";
	property string _AppDev: "APP_DEV";
	property string _AppRelease: "APP_RELEASE";
	property string _AppVer: "APP_VER";
	property string _AppCode: "APP_CODE";
	property string _AppEmail: "APP_EMAIL";
	property string _AppTMO: "APP_TMO";
	property string _AppOpenRepos: "APP_OPENREPOS";

	// bar
	property string _HideState: "hide";
	property string _ShowState: "";
	property int _BarHeight: 64;
	property int _BarStateAnimationDuration: 400;
	property color _BarTitleColor: "white";
	property int _BarButtonWidth: 48;
	property color _BarColor: "black";
	property real _BarOpacity: 0.8;
	property int _BarStateTimerInterval: 6000;
	property int _SeparatorWidth: 2;
	property color _SeparatorColor: "gray";

	// setting
	property string _BooleanSetting: "qboolean";
	property string _ListSetting: "qlist";
	property string _IntRangeSetting: "qint_range";
	property string _CStringSetting: "qc_string";

	property string _BooleanTrue: "1";
	property string _BooleanFalse: "0";

	// UI color
	property color _HeaderBGColor: "lightgreen";
	property color _HeaderLabelColor: "#9E1B29";
	property int _HeaderHeight: 80;

	// UI font
	property color _ItemTextColor: "black";
	property color _LabelTextColor: "black";
	property color _SectionTextColor: "blue";
	property string _FontFamily: "Nokia Pure Text";
	property int _LabelTextSize: 26;

	// about
	property string _AboutTitleText: qsTr("About");
	property string _AboutContentText: frontend.getString(constant._AppName)
	+ " "
	+ qsTr("is booter for GLquake2 on MeeGo Harmattan.")
	+ "<br/>"
	+ qsTr("It must be install glquake2 package on device.")
	+ "<br/>"
	+ qsTr("The settings of frontend is only for not in game's option menu.")
	+ "<br/>"
	+ qsTr("Game data(pak files) put into")
	+ " \"" + "/home/user/.quake2/baseq2" + "\""
    + "<br/>"
    + qsTr("Depends") + ": "
    + "<br/>"
       + qsTr("Using OpenGL renderer") + ": "
    + "opengles-sgx-img-common, libgles1-sgx-img"
       + "<br/>"
       + qsTr("Using SDL renderer") + ": "
    + "libsdl-image1.2"
       + "<br/>"
    + qsTr("Suggest setting") + ": "
	+ "<br/>"
	+ qsTr("Using OpenGL renderer. The quality of SDL renderer is bad. X11 renderer is not virtual-buttons yet.")
	+ "<br/>"
	+ qsTr("If using OpenGL renderer, enable shadows, disable OpenGL Multi-Texture, and enable OpenGL Point-Parameters.")
	+ "<br/>"
	+ "<br/>"
	+ qsTr("Package") + ": " + frontend.getString(constant._AppBin)
	+ "<br/>"
	+ qsTr("Version") + ": " + frontend.getString(constant._AppVer)
	+ "<br/>"
	+ qsTr("Release") + ": " + frontend.getString(constant._AppRelease)
	+ "<br/>"
	+ qsTr("DevCode") + ": " + frontend.getString(constant._AppCode)
	+ "<br/>"
	+ qsTr("Dev") + ": " + frontend.getString(constant._AppDev)
	+ "<br/>"
	+ qsTr("Mail to") + ": " + Main.href(frontend.getString(constant._AppEmail), "mail")
	+ "<br/>"
	+ qsTr("TMO") + ": " + Main.href(frontend.getString(constant._AppTMO), "link", "talk.maemo.org")
	+ "<br/>"
    + qsTr("OpenRepos") + ": " + Main.href(frontend.getString(constant._AppOpenRepos), "link", "openrepos.net")
	;
}
