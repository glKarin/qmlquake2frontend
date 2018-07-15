#include "q2.h"

#include <QSettings>
#include <QCoreApplication>
#include <QDebug>

Quake2FrontEnd::Quake2FrontEnd(QObject *parent)
	: QObject(parent),
	settings(new QSettings(this)),
    process(new QProcess(this)),
      _running(false)
{
    connect(process, SIGNAL(stateChanged ( QProcess::ProcessState)), this, SLOT(setRunning(QProcess::ProcessState)));
	initDefaultSetting();

	SettingGroup *group = 0;
	SettingItem *item = 0;

	// General
	{
		group = new SettingGroup(tr("General"), "");
		{
			item = new SettingItem(tr("Show FPS"), "cl_drawfps", tr("Render FPS text"),	Q2BOOLEAN);
			*item << new SelectItem("true", tr("Visible"), Q2BOOLEAN, "0") << new SelectItem("false", tr("Invisible"), Q2BOOLEAN, "1");
			QString s = getSetting("cl_drawfps");
			item->updateCurrent(s);
			*group << item;
			settingCache.insert("cl_drawfps", s);
		}
		{
			item = new SettingItem(tr("View Fov"), "fov", tr("View fov angle"),	Q2INTRANGE);
			*item << new SelectItem("cur", tr("Current Value"), Q2INTEGER, "0") << new SelectItem("min", tr("Minium Value"), Q2INTEGER, "0") << new SelectItem("max", tr("Maxium Value"), Q2INTEGER, "180") << new SelectItem("step", tr("Step Value"), Q2INTEGER, "1");
			QString s = getSetting("fov");
			item->updateCurrent(s);
			*group << item;
			settingCache.insert("fov", s);
		}
		{
			item = new SettingItem(tr("Hand"), "hand", tr("Weapon postion"),	Q2LIST);
			*item << new SelectItem(tr("Right"), tr("Right-Hand"), Q2INTEGER, "0") << new SelectItem(tr("Left"), tr("Left-Hand"), Q2INTEGER, "1") << new SelectItem(tr("None"), tr("Invisible"), Q2INTEGER, "2");
			QString s = getSetting("hand");
			item->updateCurrent(s);
			settingCache.insert("hand", s);
			*group << item;
		}
		{
			item = new SettingItem(tr("Player Name"), "name", tr("Player name in game"),	Q2STRING);
			*item << new SelectItem("cur", tr("Current Value"), Q2STRING, "1") << new SelectItem("placeholder", tr("Placeholder Text"), Q2STRING, tr("Please input player name"));
			QString s = getSetting("name");
			item->updateCurrent(s);
			*group << item;
			settingCache.insert("name", s);
		}
		_settingGroups.push_back(group);
	}
	// Renderer
	{
		group = new SettingGroup(tr("Renderer"), "");
		{
			item = new SettingItem(tr("Renderer"), "vid_ref", tr("Game renderer"),	Q2LIST);
			*item << new SelectItem(tr("OpenGL"), tr("Hardware-Rendering"), Q2STRING, "glx") << new SelectItem(tr("SDL"), tr("Software-Rendering"), Q2STRING, "softsdl") << new SelectItem(tr("X11"), tr("Software-Rendering"), Q2STRING, "softx");
			QString s = getSetting("vid_ref");
			item->updateCurrent(s);
			settingCache.insert("vid_ref", s);
			*group << item;
		}
		_settingGroups.push_back(group);
	}
	// OpenGL
	{
		group = new SettingGroup(tr("OpenGL"), "");
		{
			item = new SettingItem(tr("Shadow"), "gl_shadows", tr("Render model lighting shadows"),	Q2BOOLEAN);
			*item << new SelectItem("true", tr("Enable"), Q2BOOLEAN, "0") << new SelectItem("false", tr("Disable"), Q2BOOLEAN, "1");
			QString s = getSetting("gl_shadows");
			item->updateCurrent(s);
			settingCache.insert("gl_shadows", s);
			*group << item;
		}
		{
			item = new SettingItem(tr("OpenGL Stencil-Buffer for Shadow"), "gl_stencilshadow", tr("Using OpenGL stencil-buffer for shadows"),	Q2BOOLEAN);
			*item << new SelectItem("true", tr("Enable"), Q2BOOLEAN, "0") << new SelectItem("false", tr("Disable"), Q2BOOLEAN, "1");
			QString s = getSetting("gl_stencilshadow");
			item->updateCurrent(s);
			settingCache.insert("gl_stencilshadow", s);
			*group << item;
		}
		{
			item = new SettingItem(tr("Saturaltel Lighting"), "gl_saturatelighting", tr("If enabled saturaltel lighting, view is bright"),	Q2BOOLEAN);
			*item << new SelectItem("true", tr("Enable"), Q2BOOLEAN, "0") << new SelectItem("false", tr("Disable"), Q2BOOLEAN, "1");
			QString s = getSetting("gl_saturatelighting");
			item->updateCurrent(s);
			*group << item;
			settingCache.insert("gl_saturatelighting", s);
		}
		{
			item = new SettingItem(tr("OpenGL Multi-Texture"), "gl_ext_multitexture", tr("Render lighting effects with OpenGL Multi-Texture"),	Q2BOOLEAN);
			*item << new SelectItem("true", tr("Enable"), Q2BOOLEAN, "0") << new SelectItem("false", tr("Disable"), Q2BOOLEAN, "1");
			QString s = getSetting("gl_ext_multitexture");
			item->updateCurrent(s);
			settingCache.insert("gl_ext_multitexture", s);
			*group << item;
		}
		{
			item = new SettingItem(tr("OpenGL Point-Parameters"), "gl_ext_pointparameters", tr("Render particle effects with OpenGL Point-Parameters"),	Q2BOOLEAN);
			*item << new SelectItem("true", tr("Enable"), Q2BOOLEAN, "0") << new SelectItem("false", tr("Disable"), Q2BOOLEAN, "1");
			QString s = getSetting("gl_ext_pointparameters");
			item->updateCurrent(s);
			settingCache.insert("gl_ext_pointparameters", s);
			*group << item;
		}
		_settingGroups.push_back(group);
	}
}

Quake2FrontEnd::~Quake2FrontEnd()
{
	while(_settingGroups.size())
	{
		SettingGroup *group = dynamic_cast<SettingGroup *>(_settingGroups.takeAt(0));
		delete group;
	}
	kill();
}

QList<QObject *> Quake2FrontEnd::settingGroups() const
{
	return _settingGroups;
}

void Quake2FrontEnd::setSettingGroups(const QList<QObject *> &s)
{
	if(_settingGroups != s)
	{
		_settingGroups = s;
		emit settingGroupsChanged(_settingGroups);
	}
}

QList<QObject *> & Quake2FrontEnd::operator<<(QObject *o)
{
	if(o)
	{
		_settingGroups << o;
		emit settingGroupsChanged(_settingGroups);
	}
	return _settingGroups;
}

bool Quake2FrontEnd::running() const
{
    return _running;
}

void Quake2FrontEnd::setRunning(QProcess::ProcessState s)
{
    bool b = (s != QProcess::NotRunning);
    if(_running != b)
    {
        _running = b;
        emit runningChanged(_running);
    }
}

void Quake2FrontEnd::setSetting(const QString &name, const QString &value)
{
	settings->setValue(name, value);
	settingCache[name] = value;
	for(QList<QObject *>::iterator itor = _settingGroups.begin(); itor != _settingGroups.end(); ++itor)
	{
		SettingGroup *group = dynamic_cast<SettingGroup *>(*itor);
		SettingItem *item = group->findSettingItem(name);
		if(!item)
			continue;
		item->updateCurrent(value);
	}
}

void Quake2FrontEnd::initDefaultSetting()
{
	if(defaultSetting.size() == 0)
	{
		defaultSetting.insert("gl_ext_multitexture", "0");
		defaultSetting.insert("gl_ext_pointparameters", "1");
		defaultSetting.insert("cl_drawfps", "0");
		defaultSetting.insert("fov", "90");
		defaultSetting.insert("name", "Player");
		defaultSetting.insert("gl_shadows", "1");
		defaultSetting.insert("gl_stencilshadow", "1");
		defaultSetting.insert("vid_ref", "glx");
		defaultSetting.insert("hand", "0");
		defaultSetting.insert("gl_saturatelighting", "0");
	}
}

QString Quake2FrontEnd::getSetting(const QString &name, bool *suc)
{
	if(!defaultSetting.contains(name))
	{
		if(suc)
			*suc = false;
		return QString();
	}

	if(suc)
		*suc = true;
	return settings->value(name, defaultSetting[name]).toString();
}

void Quake2FrontEnd::runQuake2(bool exit)
{
	if(process->state() != QProcess::NotRunning)
		return;
    QStringList args = makeCommand();
    QString cmd;
    //cmd += "/usr/bin/meego-terminal -e ";
    //cmd += '"';
    cmd += QUAKE2;
    cmd += ' ';
    cmd += args.join(" ");
    //cmd += '"';
    qDebug() << cmd;
	if(exit)
	{
        qApp->quit();
        QProcess::startDetached(cmd);
	}
	else
	{
        if(process->state() == QProcess::NotRunning)
            process->start(QUAKE2, args);
        else
            qDebug() << "Process is still running!";
	}
}

void Quake2FrontEnd::kill()
{
	if(process->state() != QProcess::NotRunning)
	{
		process->kill();
	}
}

QStringList Quake2FrontEnd::makeCommand() const
{
#define SET_BOOLEAN_IF(name) \
	if(settingCache[#name] == "1") \
	{ \
		args << "+set" << #name << "1"; \
	}
#define SET_LIST(name) \
	args << "+set" << #name << settingCache[#name];
	QStringList args;
	args << "+set" << "basedir" << "/home/user/.quake2";
	SET_LIST(vid_ref)
	SET_LIST(cl_drawfps)
	SET_LIST(gl_saturatelighting)
	SET_LIST(fov)
	SET_LIST(name)
	SET_LIST(hand)
	if(settingCache["vid_ref"] == "glx")
	{
		args << "+set" << "gl_driver" << "libGLES_CM.so";
		SET_LIST(gl_shadows)
		SET_LIST(gl_stencilshadow)
		SET_LIST(gl_ext_multitexture)
		SET_LIST(gl_ext_pointparameters)
	}
	return args;
#undef SET_LIST
#undef SET_BOOLEAN_IF
}

void Quake2FrontEnd::reset()
{
	for(QHash<QString, QString>::const_iterator itor = defaultSetting.begin(); itor != defaultSetting.end(); ++itor)
		setSetting(itor.key(), itor.value());
}

QString Quake2FrontEnd::getString(const QString &name) const
{
#define APP_DEF(name) _appInfo.insert(#name, name)
	static QHash<QString, QString> _appInfo;
	if(_appInfo.size() == 0)
	{
		APP_DEF(APP_BIN);
		APP_DEF(APP_NAME);
		APP_DEF(APP_DEV);
		APP_DEF(APP_RELEASE);
		APP_DEF(APP_VER);
		APP_DEF(APP_CODE);
		APP_DEF(APP_EMAIL);
		APP_DEF(APP_TMO);
		APP_DEF(APP_OPENREPOS);
	}
	return _appInfo[name];
#undef APP_DEF
}
