#ifndef KARIN_Q2_FRONTEND_H
#define KARIN_Q2_FRONTEND_H

#include <QObject>
#include <QHash>
#include <QProcess>

#include "q2_std.h"
#include "setting_group.h"

class QSettings;

class Quake2FrontEnd : public QObject
{
	Q_OBJECT
		Q_PROPERTY(QList<QObject *> settingGroups READ settingGroups NOTIFY settingGroupsChanged FINAL)
        Q_PROPERTY(bool running READ running NOTIFY runningChanged FINAL)

	public:
		Quake2FrontEnd(QObject *parent = 0);
		~Quake2FrontEnd();
		QList<QObject *> & operator<<(QObject *o);

	public:
		QList<QObject *> settingGroups() const;
		void setSettingGroups(const QList<QObject *> &s);
        bool running() const;

	public:
		Q_INVOKABLE void setSetting(const QString &name, const QString &value);
		Q_INVOKABLE QString getSetting(const QString &name, bool *suc = 0);
        Q_INVOKABLE void runQuake2(bool exit = false);
		Q_INVOKABLE void kill();
		Q_INVOKABLE void reset();
		Q_INVOKABLE QString getString(const QString &name) const;

Q_SIGNALS:
		void settingGroupsChanged(const QList<QObject *> &s);
        void runningChanged(bool r);

private Q_SLOTS:
        void setRunning(QProcess::ProcessState s);

	private:
		QStringList makeCommand() const;
		void initDefaultSetting();

	private:
		QSettings *settings;
		QList<QObject *> _settingGroups;
		QHash<QString, QString> settingCache;
		QProcess *process;
		QHash<QString, QString> defaultSetting;
        bool _running;

};

#endif
