/* Dillon Tidgewell
 * ID: 002285452
 * email: tidge101@mail.chapman.edu
 */

#include "book.h"
#include <stdio.h>
#include <cstdlib>
#include <iostream>

using namespace std;

// Kernel function that has each thread save its id
__global__ void save_id(int n, int *dev_tid){
	for(int i = 0; i < n; i++){
		*dev_tid = blockIdx.x;
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
	save_id<<<numThreads,1>>>(numThreads, dev_tid);

	// Copy thread id's to host
	HANDLE_ERROR( cudaMemcpy( &tid, dev_tid, sizeof(int),
														cudaMemcpyDeviceToHost ) );

	// Print thread id's
	for(int i = 0; i < numThreads; i++){
		printf("ID of Thread[%d]: %d", i, i.dev_tid);
	}

	// Free the memory we allocated
	cudaFree(dev_tid);
}
