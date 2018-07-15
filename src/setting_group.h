#ifndef KARIN_Q2_SETTINGROUP_H
#define KARIN_Q2_SETTINGROUP_H

#include <QObject>
#include <QList>

#include "q2_std.h"
#include "setting_item.h"

class SettingGroup : public QObject
{
	Q_OBJECT

		Q_PROPERTY(QString name READ name NOTIFY nameChanged FINAL)
		Q_PROPERTY(QString desc READ desc NOTIFY descChanged FINAL)
		Q_PROPERTY(QList<QObject *> settings READ settings NOTIFY settingsChanged FINAL)

	public:
		SettingGroup(QObject *parent = 0);
		SettingGroup(const QString &name, const QString &desc, QObject *parent = 0);
		~SettingGroup();
		QList<QObject *> & operator<<(QObject *o);


	public:
		QString name() const;
		void setName(const QString &n);

		QString desc() const;
		void setDesc(const QString &d);

		const QList<QObject *> & settings() const;
		void setSettings(const QList<QObject *> &s);

	public:
		Q_INVOKABLE SettingItem * findSettingItem(const QString &name) const;

Q_SIGNALS:
		void nameChanged(const QString &n);
		void descChanged(const QString &d);
		void settingsChanged(const QList<QObject *> &s);

	private:
		QString _name;
		QString _desc;
		QList<QObject *> _settings;
};

#endif
