#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "midnighttimer.h"

int main(int argc, char *argv[])
{
    //MidnightTimer m;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //engine.rootContext()->setContextProperty("midnight", &m);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
