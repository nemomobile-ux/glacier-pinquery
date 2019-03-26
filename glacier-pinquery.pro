PROJECT_NAME = glacier-pinquery
TEMPLATE = app
CONFIG += ordered hide_symbols
QT += qml quick dbus
TARGET = $$PROJECT_NAME

CONFIG += link_pkgconfig
PKGCONFIG += glacierapp
PKGCONFIG += qofono-qt5

LIBS += -lglacierapp

SOURCES += src/main.cpp \
           src/ofonosimif.cpp

HEADERS += src/ofonosimif.h

QML_FILES = qml/*.qml
JS_FILES = *qml/.js

OTHER_FILES += $${QML_FILES} $${JS_FILES}

target.path = /usr/bin/
INSTALLS += target

desktop.files = $${PROJECT_NAME}.desktop
desktop.path = /usr/share/applications
INSTALLS += desktop

qml.files = qml/glacier-pinquery.qml\
            qml/NumButton.qml\
            qml/PinEntry.qml\
            qml/PinNumPad.qml\
            qml/PinPage.qml

qml.path = /usr/share/$${PROJECT_NAME}/qml/
INSTALLS += qml

systemd.files = $${PROJECT_NAME}.service
systemd.path = /usr/lib/systemd/user/
INSTALLS += systemd

OTHER_FILES += rpm/*
