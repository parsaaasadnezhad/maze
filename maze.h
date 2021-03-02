#ifndef MAZE_H
#define MAZE_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QIODevice>
#include <QDebug>
#include <QStack>
#include <QPair>
#include <QQueue>

class Maze : public QObject
{
    Q_OBJECT
public:
    explicit Maze(QObject *parent = nullptr);
    void getSpace();
    void read_file(QString path);
    void setBoolArray();
    //bool DFS();
    Q_INVOKABLE void setPath();
    Q_INVOKABLE void backToFirst();


    Q_INVOKABLE bool recursiveSolve(int x , int y);


    Q_INVOKABLE QString getMaze(int modelData);
    Q_INVOKABLE int getRow();
    Q_INVOKABLE int getCol();
     Q_INVOKABLE int  movment(int flag , int count);
    Q_INVOKABLE int getStartI();
    Q_INVOKABLE int getStariJ();

    Q_INVOKABLE int solve();
    void explore_neighbours(int r ,int c);

public:
    QString filePath;
    int col;
    int row;
    char **maze;

    bool **path;
    bool **visited;

    int current_i;
    int current_j;
    int start_i;
    int start_j;
    int end_i;
    int end_j;

    QQueue<int> rq;
    QQueue<int> cq;
    int move_count;
    int nodes_left_in_layer;
    int nodes_next_in_layer;
    bool reached_end;
    bool **visited2;

};

#endif // MAZE_H
