/* Dillon Tidgewell
 * ID: 002285452
 * email: tidge101@mail.chapman.edu
 */

#include "../common/book.h"
#include <stdio.h>
#include <cstdlib>
#include <iostream>

using namespace std;

// Kernel function that has each thread save its id
__global__ void save_id(int n, ){
	for(int i = 0; i < n; i++){

	}
}

int main(int argc, char* argv[]){
	int numThreads;
	if(argc == 2) {numThreads = atoi(argv[1]);}
	else {numThreads = 512;}
	cout << "Number of threads created: " << numThreads << "\n";

	// Create appropriate variables and allocate memory on device
	int tid;
	int *dev_tid;
	HANDLE_ERROR( cudaMalloc( (void**)&dev_tid, sizeof(int) ) );
	// Call kernel function
	save_id<<<numThreads,1>>>;

	// Copy thread id's to host

	// Print thread id's

	// Free the memory we allocated
	cudaFree(dev_tid);
}
