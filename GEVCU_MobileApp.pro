TEMPLATE = app

QT += qml quick bluetooth
CONFIG += c++11

SOURCES += main.cpp \
    blehandler.cpp \
    bledeviceinfo.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    blehandler.h \
    bledeviceinfo.h

DISTFILES += \
    android-sources/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
