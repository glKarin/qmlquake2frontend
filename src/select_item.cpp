#include "select_item.h"

SelectItem::SelectItem(QObject *parent)
	: QObject(parent),
	_name(""),
	_desc(""),
	_type("unknow"),
	_value("")
{
}

	SelectItem::SelectItem(const QString &name, const QString &desc, const QString &type, const QString &var, QObject *parent)
: QObject(parent),
	_name(name),
	_desc(desc),
	_type(type),
	_value(var)
{
}

SelectItem::~SelectItem()
{
}

QString SelectItem::name() const
{
	return _name;
}

void SelectItem::setName(const QString &n)
{
	if(_name != n)
	{
		_name = n;
			emit nameChanged(_name);
	}
}

QString SelectItem::SelectItem::desc() const
{
	return _desc;
}

void SelectItem::setDesc(const QString &d)
{
	if(_desc != d)
	{
		_desc = d;
			emit descChanged(_desc);
	}
}

QString SelectItem::type() const
{
	return _type;
}

void SelectItem::setType(const QString &t)
{
	if(_type != t)
	{
		_type = t;
			emit typeChanged(_type);
	}
}

QString SelectItem::value() const
{
	return _value;
}

void SelectItem::setValue(const QString &v)
{
	if(_value != v)
	{
		_value = v;
			emit valueChanged(_value);
	}
}

