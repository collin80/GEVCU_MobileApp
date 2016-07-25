#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "blehandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BLEHandler bleHandler;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/QML/MainForm.qml")));

    return app.exec();
}
