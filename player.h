#ifndef PLAYER_H
#define PLAYER_H

#include <QString>

class Player
{

public:
    int age;
    QString name;
   int score;
   QString avator;
   int time;
   int steps;

public:
    Player();
    Player(QString name , int age);

};

#endif // PLAYER_H
