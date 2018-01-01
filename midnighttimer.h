#ifndef MIDNIGHTTIMER_H
#define MIDNIGHTTIMER_H

#include <QObject>
#include <QTimer>
#include <QThread>

class MidnightTimer : public QObject
{
    Q_OBJECT
public:
    explicit MidnightTimer(QObject *parent = 0);

signals:
    void ora();

public slots:
    void checkTime();

private:
    QTimer* m_timer;
    QThread* m_thread;
};

#endif // MIDNIGHTTIMER_H
