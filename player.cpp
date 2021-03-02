#include "player.h"

Player::Player()
{
        this->score = 0;
}

Player::Player(QString name, int age)
{
    this->name = name;
    this->age = age;
}
