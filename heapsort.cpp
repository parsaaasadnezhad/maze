#include "heapsort.h"

HeapSort::HeapSort(QObject *parent):QObject(parent)
{
    this->list = new Player [5];

    this->count = 0;
    this->currentIndex = 0;
    this->addButtonEnable = true;
}

void HeapSort::heapsort(Player *arr, int n)
{
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
        // Move current root to end
        swap(arr[0], arr[i]);

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

void HeapSort::heapify(Player arr[], int n, int i)
{
    int largest = i; // Initialize largest as root
    int l = 2 * i + 1; // left = 2*i + 1
    int r = 2 * i + 2; // right = 2*i + 2

    // If left child is larger than root
    if (l < n && arr[l].age > arr[largest].age)
        largest = l;

    // If right child is larger than largest so far
    if (r < n && arr[r].age > arr[largest].age)
        largest = r;

    // If largest is not root
    if (largest != i) {
        swap(arr[i], arr[largest]);

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

void HeapSort::swap(Player &a, Player &b)
{
    Player* temp = new Player(a);
    a = b;
    b = *temp;
}

void HeapSort::setlist(QString name, int age , QString avator)
{
    if(count < 5 && age != 0){
        this->list[count].age = age;
        this->list[count].name = name;
        this->list[count].avator = avator;
        count++;
        this->heapsort(this->list , count);

    }
}

QString HeapSort::getname(int i)
{
    return this->list[i].name;
}

int HeapSort::getage(int i)
{
    return this->list[i].age;
}

int HeapSort::getCount()
{
    return this->count;
}

QString HeapSort::getavator(int i)
{
    return this->list[i].avator;
}

void HeapSort::deleteZeroIndex()
{
    for(int i=0 ; i<this->count - 1 ; i++)
    {
        this->list[i] = this->list[i+1];
    }
    count--;
}

void HeapSort::setAddButtonEnable(bool val)
{
    this->addButtonEnable = val;
}

bool HeapSort::getAddButtonEnable()
{
    return this->addButtonEnable;
}

void HeapSort::setCurrentIndex()
{
    if(currentIndex < count)
        this->currentIndex++;
}

int HeapSort::getCurrentIndex()
{
    return this->currentIndex;
}

int HeapSort::getscore(int i)
{
    return this->list[i].score;
}

void HeapSort::setPlayerInfo(int steps, int minSteps, int time)
{
    this->list[currentIndex].time = time;
    this->list[currentIndex].steps = steps;
    this->list[currentIndex].score = (steps - minSteps) * time;

}
