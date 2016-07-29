#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include "blehandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BLEHandler bleHandler;

    QQuickView *view = new QQuickView;
    view->rootContext()->setContextProperty("bleHandler", &bleHandler);
    view->setSource(QUrl("qrc:/QML/MainForm.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();
    return app.exec();
}
