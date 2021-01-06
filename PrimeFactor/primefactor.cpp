#include <iostream>
#include <cmath>
#include <stdlib.h>
#include <cstdio>



using namespace std;
extern "C" void asmMain(); // link function asmMain() to asm
extern "C" int AllPrimeFactors(int N);  // link function AllPrimeFactors() to asm

int AllPrimeFactors(int N); // prototype Allprimefactors()

int main() {
    asmMain();  // execute asmMain()

    return 0;
}

int AllPrimeFactors(int N) {


    //bool bl;
    int counter = 0;

    if (N > 1) {
        for (int num = 2; num <= N; num++) {

            //bl = true;

            /*for (int div = 2; div <= sqrt(num); div++) {
                if (num % div == 0) {
                    bl = false;
                    break;
                }   // if num is not a prime, doing break and try next number
            }*/


            if (N % num == 0) {

                while (N % num == 0) {
                    N = N / num;
                }
                if (N == 1) {
                    cout << num << endl;
                }
                else {
                    cout << num << " ";
                }
                ++counter;

            }
        }
    }
    else {
        if (N <= 1) {
            cout << endl;
            counter = 0;
        }
    }
    return counter;
}