#ifndef HEAPSORT_H
#define HEAPSORT_H

#include<QObject>
#include <QDebug>
#include "player.h"

class HeapSort : public QObject
{
    Q_OBJECT
private:
    Player * list;
    int count;
public:
    HeapSort(QObject* parent =nullptr);
    void heapsort(Player *arr , int n);
    void heapify(Player arr[], int n, int i);
    void swap(Player &a , Player &b);

    bool addButtonEnable;
    int currentIndex;


public slots:
    void setlist(QString name , int age , QString avator);
    QString getname(int i);
    int getage(int i);
    int getCount();
    QString getavator(int i);
    void deleteZeroIndex();
    void setAddButtonEnable(bool val);
    bool getAddButtonEnable();
    void setCurrentIndex();
    int getCurrentIndex();
    int getscore(int i);

    void setPlayerInfo(int steps , int minSteps , int time);

};

#endif // HEAPSORT_H
