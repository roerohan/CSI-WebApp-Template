// Compile with: g++ -c test.cpp -o csi-cli

#include <iostream>
using namespace std;

int main(int argc, char ** argv) {

    cout << "args are : ";

    for (int i = 0; i < argc; i++) {
        cout << argv[i] << " ";
    }

    cout << "\n";

    return 0;
}
