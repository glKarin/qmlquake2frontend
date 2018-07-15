#ifndef KARIN_Q2_SETTINGITEM_H
#define KARIN_Q2_SETTINGITEM_H

#include <QObject>
#include <QVariant>

#include "q2_std.h"
#include "select_item.h"

class SettingGroup;

class SettingItem : public QObject
{
	Q_OBJECT

		Q_PROPERTY(QString title READ title NOTIFY titleChanged FINAL)
		Q_PROPERTY(QString name READ name NOTIFY nameChanged FINAL)
		Q_PROPERTY(QString desc READ desc NOTIFY descChanged FINAL)
		Q_PROPERTY(QString type READ type NOTIFY typeChanged FINAL)
		Q_PROPERTY(int current READ current NOTIFY currentChanged FINAL)
		Q_PROPERTY(QList<QObject *> values READ values NOTIFY valuesChanged FINAL)

	public:
		SettingItem(QObject *parent = 0);
		SettingItem(const QString &title, const QString &name, const QString &desc, const QString &type, QObject *parent = 0);
		~SettingItem();
		QList<QObject *> & operator<<(QObject *o);


	public:
		QString title() const;
		void setTitle(const QString &t);

		QString name() const;
		void setName(const QString &n);

		QString desc() const;
		void setDesc(const QString &d);

		QString type() const;
		void setType(const QString &t);

		int current() const;
		void setCurrent(int c);

		const QList<QObject *> & values() const;
		void setValues(const QList<QObject *> &v);

	public:
		Q_INVOKABLE int updateCurrent(const QString &var);
		int getSelectIndex(const QString &var) const;

Q_SIGNALS:
		void titleChanged(const QString &t);
		void nameChanged(const QString &n);
		void descChanged(const QString &d);
		void typeChanged(const QString &t);
		void currentChanged(int c);
		void valuesChanged(const QList<QObject *> &v);


	private:
		QString _title;
		QString _name;
		QString _desc;
		QString _type;
		int _current;
		QList<QObject *> _values;

		friend class SettingGroup;
};

#endif

