#include "setting_group.h"

SettingGroup::SettingGroup(QObject *parent)
	: QObject(parent),
	_name(""),
	_desc("")
{
}

	SettingGroup::SettingGroup(const QString &name, const QString &desc, QObject *parent)
: QObject(parent),
	_name(name),
	_desc(desc)
{
}

SettingGroup::~SettingGroup()
{
	while(_settings.size())
	{
		SettingItem *item = dynamic_cast<SettingItem *>(_settings.takeAt(0));
		delete item;
	}
}

QList<QObject *> & SettingGroup::operator<<(QObject *o)
{
	if(o)
	{
		_settings.push_back(o);
		emit settingsChanged(_settings);
	}
	return _settings;
}


QString SettingGroup::name() const
{
	return _name;
}

void SettingGroup::setName(const QString &n)
{
	if(_name != n)
	{
		_name = n;
		emit nameChanged(_name);
	}
}

QString SettingGroup::desc() const
{
	return _desc;
}

void SettingGroup::setDesc(const QString &d)
{
	if(_desc != d)
	{
		_desc = d;
		emit descChanged(_desc);
	}
}

const QList<QObject *> & SettingGroup::settings() const
{
	return _settings;
}

void SettingGroup::setSettings(const QList<QObject *> &s)
{
	if(_settings != s)
	{
		_settings = s;
		emit settingsChanged(_settings);
	}
}

SettingItem * SettingGroup::findSettingItem(const QString &name) const
{
	for(QList<QObject *>::const_iterator itor = _settings.begin(); itor != _settings.end(); ++itor)
	{
		SettingItem *item = dynamic_cast<SettingItem *>(*itor);
		if(item->name() == name)
			return item;
	}
	return 0;
}

