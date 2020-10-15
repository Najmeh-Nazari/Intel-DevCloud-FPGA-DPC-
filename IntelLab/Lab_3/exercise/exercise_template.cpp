//==============================================================
//  2020 UC Davis
// =============================================================

#include <iostream>


using namespace sycl;

  int main() 
  {
      
    int A[4], B[4], C[4];
    for(int i =0 ; i< 4; i++)
    {
        A[i] = 0;
        B[i] = 2;
        C[i] = 3;
    }

	for (int i=0;i<100;i++)
        A[i] = B[i] + C[i];
	
    for(int i=0; i<4; i++)
    {
        std::cout << "host: " << A[i] << "\n";  
    }

              
  return 0;
}