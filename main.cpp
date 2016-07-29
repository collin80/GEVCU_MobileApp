#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "blehandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BLEHandler bleHandler;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/QML/MainForm.qml")));
    engine.rootContext()->setContextProperty("bleHandler", &bleHandler);

    return app.exec();
}
