#ifndef KARIN_Q2_SELECTITEM_H
#define KARIN_Q2_SELECTITEM_H

#include <QObject>

#include "q2_std.h"

class SettingItem;

class SelectItem : public QObject
{
	Q_OBJECT
		Q_PROPERTY(QString name READ name NOTIFY nameChanged FINAL)
		Q_PROPERTY(QString desc READ desc NOTIFY descChanged FINAL)
		Q_PROPERTY(QString type READ type NOTIFY typeChanged FINAL)
		Q_PROPERTY(QString value READ value NOTIFY valueChanged FINAL)

	public:
		SelectItem(QObject *parent = 0);
		SelectItem(const QString &name, const QString &desc, const QString &type, const QString &var, QObject *parent = 0);
		~SelectItem();

	public:
		QString name() const;
		void setName(const QString &n);

		QString desc() const;
		void setDesc(const QString &d);

		QString type() const;
		void setType(const QString &t);

		QString value() const;
		void setValue(const QString &v);

Q_SIGNALS:
		void nameChanged(const QString &n);
		void descChanged(const QString &d);
		void typeChanged(const QString &t);
		void valueChanged(const QString &v);

	private:
		QString _name;
		QString _desc;
		QString _type;
		QString _value;

		friend class SettingItem;
};

#endif

