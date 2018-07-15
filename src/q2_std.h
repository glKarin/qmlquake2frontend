#ifndef KARIN_Q2_STD_H
#define KARIN_Q2_STD_H

#define Q2BOOLEAN "qboolean"
#define Q2FLOAT "qfloat"
#define Q2INTEGER "qint"
#define Q2STRING "qc_string"
#define Q2INTRANGE "qint_range"
#define Q2FLOATRANGE "qfloat_range"
#define Q2LIST "qlist"
#define Q2MLIST "qmulti-list"

#define Q2TRUE "1"
#define Q2FALSE "0"

#define QUAKE2 "/usr/bin/sdlquake2"

#define PROPERTY(name, T)  Q_PROPERTY(T q2##name READ q2##name WRITE set_q2##name NOTIFY q2##name##Changed FINAL)

#define PROPERTY_DECL(name, T) \
	public: \
T q2##name() const; \
void set_q2##name(const T &t); \
Q_SIGNALS: \
void q2##name##Changed(const T &t); \
private: \
T name;

#define PROPERTY_DEF(name, T, clazz) \
	T clazz::q2##name() const \
{ \
	return name; \
} \
void clazz::set_q2##name(const T &t) \
{ \
	if(name != t) \
	{ \
		name = t; \
		emit q2##name##Changed(name); \
	} \
}

#define APP_BIN "qmlquake2frontend"
#define APP_NAME "QML Quake2 FrontEnd"
#define APP_DEV "karin"
#define APP_RELEASE "20150824"
#define APP_VER "0.3-3natasha1"
#define APP_CODE "Natasha"
#define APP_EMAIL "beyondk2000@gmail.com"
#define APP_TMO "http://talk.maemo.org/showthread.php?t=100395"
#define APP_OPENREPOS "https://openrepos.net/content/karinzhao/quake-2-gl-touch"

#endif
