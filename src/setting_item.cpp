#include "setting_item.h"

SettingItem::SettingItem(QObject *parent)
	: QObject(parent),
	_type("unknow"),
	_current(-1)
{
}

SettingItem::SettingItem(const QString &title, const QString &name, const QString &desc, const QString &type, QObject *parent)
	: QObject(parent),
	_title(title),
	_name(name),
	_desc(desc),
	_type(type),
	_current(-1)
{
}

SettingItem::~SettingItem()
{
	while(_values.size())
	{
		SelectItem *i = dynamic_cast<SelectItem *>(_values.takeAt(0));
		delete i;
	}
}

QList<QObject *> & SettingItem::operator<<(QObject *o)
{
	if(o)
	{
		_values.push_back(o);
		emit valuesChanged(_values);
	}
	return _values;
}

QString SettingItem::title() const
{
	return _title;
}

void SettingItem::setTitle(const QString &t)
{
	if(_title != t)
	{
		_title = t;
		emit titleChanged(_title);
	}
}

QString SettingItem::name() const
{
	return _name;
}

void SettingItem::setName(const QString &n)
{
	if(_name != n)
	{
		_name = n;
		emit nameChanged(_name);
	}
}

QString SettingItem::desc() const
{
	return _desc;
}

void SettingItem::setDesc(const QString &d)
{
	if(_desc != d)
	{
		_desc = d;
		emit descChanged(_desc);
	}
}

QString SettingItem::type() const
{
	return _type;
}

void SettingItem::setType(const QString &t)
{
	if(_type != t)
	{
		_type = t;
		emit typeChanged(_type);
	}
}

int SettingItem::current() const
{
	return _current;
}

void SettingItem::setCurrent(int c)
{
	if(_current != c)
	{
		_current = c;
		emit currentChanged(_current);
	}
}
const QList<QObject *> & SettingItem::values() const
{
	return _values;
}

void SettingItem::setValues(const QList<QObject *> &v)
{
	if(_values != v)
	{
		_values = v;
		emit valuesChanged(_values);
	}
}

int SettingItem::updateCurrent(const QString &var)
{
	int i;
	if(_type == Q2INTRANGE || _type == Q2STRING)
	{
		dynamic_cast<SelectItem *>(_values[0])->setValue(var);
		i = 0;
	}
	else
		i = getSelectIndex(var);
	if(i != -1)
		setCurrent(i);
	return _current;
}

int SettingItem::getSelectIndex(const QString &var) const
{
	for(int i = 0; i < _values.size(); i++)
	{
		const SelectItem *item = dynamic_cast<SelectItem *>(_values.at(i));
		if(item->value() == var)
		{
			return i;
		}
	}
	return -1;
}
