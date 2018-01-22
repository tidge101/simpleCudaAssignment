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
__global__ void save_id(int n, float *tid){
	for(int i = 0; i < n; i++){
		tid[i] = threadIdx.x;
	}
}

int main(int argc, char* argv[]){
	int numThreads;
	if(argc == 2) {numThreads = atoi(argv[1]);}
	else {numThreads = 512;}
	cout << "Number of threads created: " << numThreads << "\n";

	// Create appropriate variables and allocate memory on device
	float *tid, *dev_tid;
	tid = (float*)malloc(numThreads*sizeof(float));
	HANDLE_ERROR( cudaMalloc(&dev_tid, numThreads*sizeof(float)));
	// Call kernel function
	save_id<<<1, numThreads>>>(numThreads, dev_tid);

	// Copy thread id's to host
	HANDLE_ERROR( cudaMemcpy( tid, dev_tid, numThreads*sizeof(float),
														cudaMemcpyDeviceToHost ) );

	// Print thread id's
	for(int i = 0; i < numThreads; i++){
		printf("ID of Thread[%d]: %d\n", i, tid[i]);
	}

	// Free the memory we allocated
	cudaFree(dev_tid);
	free(tid);

	return 0;
}
