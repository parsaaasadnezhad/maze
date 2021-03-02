#include "maze.h"

Maze::Maze(QObject *parent) : QObject(parent)
{
    this->col   = 16;
    this->row = 21;
    this->filePath = QDir::currentPath() + QDir::separator() + "parsikola.txt";

    getSpace();
    read_file("");
    setBoolArray();
}

void Maze::getSpace()
{
    this->maze = new char *[col];
    this->visited = new bool*[col];
    this->path = new bool*[col];
    this->visited2 = new bool*[col];

    for(int i=0 ; i<col ; i++)
    {
        this->maze[i] = new char[row];
        this->visited[i] = new bool[row];
        this->path[i] = new bool[row];
        this->visited2[i] = new bool[row];
    }
}

void Maze::read_file(QString path)
{
    path = filePath;
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly))
        qInfo()<<"Cant opent the File.";
    else{

        char ch;
        for(int i=0 ; i<col ; i++)
        {
            for(int j=0 ; j<row ; j++)
            {
                file.read(&ch , 1);

                if(ch == 'S')
                {
                    this->start_i = i     ;    this->start_j = j   ;
                    this->current_i = i ;    this->current_j=j ;
                }
                else if(ch == 'E')
                { this->end_i   = i     ;       this->end_j = j  ; }

                this->maze[i][j] = ch;
            }
            file.read(&ch , 1);file.read(&ch , sizeof(char));          //this line of code is just for escaping from         \r\n
        }
    }
    file.close();
}

void Maze::setBoolArray()
{
    for(int i=0 ; i<col ; i++)
        for(int j=0 ; j<row ; j++)
        {
            this->path[i][j] = false;
            this->visited[i][j] = false;
            //this->visited2[i][j] = false;
        }
}

void Maze::setPath()
{
    for(int i=0; i<col ; i++)
        for(int j=0 ; j<row ; j++)
        {
            if(path[i][j])
                maze[i][j]='*';
        }
    maze[start_i][start_j] = 'S';
}

void Maze::backToFirst()
{
    for(int i=0; i<col ; i++)
        for(int j=0 ; j<row ; j++)
        {
            if(maze[i][j] == '*' || maze[i][j] == 'S')
                maze[i][j]=' ';
        }
    maze[start_i][start_j] = 'S';
    current_i = this->start_i;
    current_j = this->start_j;
    maze[end_i][end_j] = 'E';
}

bool Maze::recursiveSolve(int x, int y)
{
    if(maze[x][y] == 'E')  return true;
    if(maze[x][y] == '+' || visited[x][y]) return false;

    visited[x][y] = true;
    //maze[x][y]='v';

    //top
    if (x != 1) // Checks if not on left edge
        if (recursiveSolve(x-1, y)) { // Recalls method one to the left
            path[x][y] = true; // Sets that path value to true;
            return true;
        }
    //right
    if (y != row - 2) // Checks if not on bottom edge
        if (recursiveSolve(x, y+1)) { // Recalls method one down
            path[x][y] = true;
            return true;
        }
    //bottom
    if (x != col - 2) // Checks if not on right edge
        if (recursiveSolve(x+1, y)) { // Recalls method one to the right
            path[x][y] = true;
            return true;
        }
    //left
    if (y != 1)  // Checks if not on top edge
        if (recursiveSolve(x, y-1)) { // Recalls method one up
            path[x][y] = true;
            return true;
        }

    return false;
}


int Maze::movment(int flag , int count)
{

    if(flag == 0){      //press W
        if( maze[current_i-1][current_j] != '+')
        {
            maze[current_i][current_j] = ' ';
            current_i--;
            count++;
        }
    }
    else if(flag == 1){      //press D
        if(maze[current_i][current_j+1] != '+')
        {
            maze[current_i][current_j] = ' ';
            current_j++;
            count++;
        }
    }

    else if(flag == 2){
        if(maze[current_i+1][current_j] != '+')
        {
            maze[current_i][current_j] = ' ';
            current_i++;
            count++;
        }
    }

    else if(flag == 3)
        if(maze[current_i][current_j-1] != '+')
        {
            maze[current_i][current_j] = ' ';
            current_j--;
            count++;
        }

    maze[current_i][current_j] = 'S';
    if(current_i == this->end_i && current_j==this->end_j)
        return count-10000;
    return count;

}

int Maze::getStartI()
{
    return this->start_i;
}

int Maze::getStariJ()
{
    return this->start_j;
}

int Maze::solve()
{
    this->rq.clear();
    this->cq.clear();
    this->move_count = 0;
    this->nodes_left_in_layer = 1;
    this->nodes_next_in_layer = 0;
    this->reached_end = false;

    for(int i=0 ; i<col ; i++)
            for(int j=0; j <row ; j++)
                visited2[i][j] = false;


    this->rq.enqueue(this->start_j);
    this->cq.enqueue(this->start_i);
    visited2[start_i][start_j] = true;

    while (rq.size() > 0) {
        int r = rq.dequeue();
        int c = cq.dequeue();
        if(maze[c][r] == 'E')
        {
            reached_end = true;
            break;
        }
        explore_neighbours(r,c);
        this->nodes_left_in_layer--;
        if(nodes_left_in_layer == 0){
            nodes_left_in_layer = nodes_next_in_layer;
            nodes_next_in_layer = 0;
            move_count++;
        }
    }
    if(this->reached_end)
        return this->move_count;
    return -1;
}

void Maze::explore_neighbours(int r, int c)
{
    int dr[4] = {0 , 1 , 0 , -1};
    int dc[4] = {-1 , 0 , 1 , 0};
    for(int i=0 ; i<4 ; i++){
        int rr = r +dr[i];
        int cc = c +dc[i];
        if(rr<0 || cc<0)
            continue;
        if(rr>=row || cc>=col)
            continue;
        if(visited2[cc][rr])
            continue;
        if(maze[cc][rr] == '+')
            continue;

        rq.enqueue(rr);
        cq.enqueue(cc);
        visited2[cc][rr] = true;
        this->nodes_next_in_layer++;
    }

}



QString Maze::getMaze(int modelData)
{
    int x = modelData / row;
    int y = modelData % row;

    if(this->maze[x][y])
    {
        if(this->maze[x][y] == ' ')
            return "";
        else if(maze[x][y] == '+')
            return "qrc:/icon/icon/wall.png";
        else if(maze[x][y] == 'S')
            return "qrc:/icon/icon/dog.png";
        else if(maze[x][y] == 'E')
            return "qrc:/icon/icon/cat.png";
        else if(maze[x][y] == '*')
            return "qrc:/icon/icon/bone.png";
        else
            return "";
    }
    else
        return "";

}

int Maze::getRow()
{
    if(this->row != NULL)
        return this->row;
    return 1;

}

int Maze::getCol()
{
    if(this->col != NULL)
        return this->col;
    else
        return 1;
}
