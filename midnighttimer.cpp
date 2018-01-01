#include "midnighttimer.h"

#include <QDateTime>

MidnightTimer::MidnightTimer(QObject *parent) : QObject(parent)
{
    m_timer = new QTimer();
    m_timer->setInterval(1000);

    connect(m_timer, SIGNAL(timeout()), this, SLOT(checkTime()));
    m_thread = new QThread(this);
    m_timer->moveToThread(m_thread);
    m_thread->start();
}

void MidnightTimer::checkTime()
{
    QTime d = QDateTime::currentDateTime().time();
    if (d > QTime(23, 38, 0, 0)) {
        m_timer->stop();
        emit ora();
    }
    else {
        m_timer->start();
    }
}
