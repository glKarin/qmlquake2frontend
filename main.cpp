#include "src/q2.h"

#include <QApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeComponent>
#include "qmlapplicationviewer.h"
#include <QLocale>
#include <QTranslator>
#include <QTextCodec>
#include "QDebug"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
	QApplication *a = createApplication(argc, argv);
	a->setApplicationName(APP_NAME);
	a->setOrganizationName(APP_DEV);
	a->setApplicationVersion(APP_VER);
	QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF-8"));

	QTranslator translator;
#ifdef _DEBUG
	if(translator.load(QString(APP_BIN".zh_CN.qm"),"i18n/"))
	{
		qDebug()<<"Load i18n -> \""APP_BIN".zh_CN.qm\"";
#else
	QString locale = QLocale::system().name();

	if(translator.load(QString(APP_BIN".") + locale,"/opt/"APP_BIN"/i18n/"))
	{
		qDebug()<<"Load i18n -> \""APP_BIN"."<<locale<<".qm\"";
#endif
		a->installTranslator(&translator);
	}

	QScopedPointer<QApplication> app(a);

	qmlRegisterType<Quake2FrontEnd>("karin.quake2", 1, 0, "Quake2FrontEnd");
	qmlRegisterType<SettingGroup>("karin.setting", 1, 0, "SettingGroup");
	qmlRegisterType<SettingItem>("karin.setting", 1, 0, "SettingItem");
	qmlRegisterType<SelectItem>("karin.setting", 1, 0, "SelectItem");

	QmlApplicationViewer viewer;
	viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

	viewer.setMainQmlFile(QLatin1String("qml/"APP_BIN"/main.qml"));
	viewer.showExpanded();

	/*
		 VVerena verena;
		 verena.search(QString("nokia n950"));
		 */

	return app->exec();
}
