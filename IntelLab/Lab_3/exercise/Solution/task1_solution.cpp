//==============================================================
//  2020 UC Davis
// =============================================================
#include <CL/sycl.hpp>
#include <CL/sycl/intel/fpga_extensions.hpp>

#include <iostream>

#include <chrono>
#define NS (1000000000.0) // number of nanoseconds in a second



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

      

      //Buffer creation happens within a separate C++ scope.
     {
         
    //Profiling setup
    //Set things up for profiling at the host
    std::chrono::high_resolution_clock::time_point t1_host, t2_host;
    sycl::cl_ulong t1_kernel, t2_kernel;
    double time_kernel;
    auto property_list = sycl::property_list{sycl::property::queue::enable_profiling()};
         
         
       //gpu_selector selector;
      //intel::fpga_selector selector;
      default_selector selector;
      //host_selector selector;
          
          
      queue myq(selector,NULL,property_list);
      
      std::cout << "Target Device: "
      << myq.get_device().get_info<info::device::name>() <<"\n";
    
         
         
      buffer<int,1> mybufA(A, range<1>{42});
      buffer<int,1> mybufB(B, range<1>{42});
      buffer<int,1> mybufC(C, range<1>{42});
         

        
         /*
      auto e = myq.submit([&](handler& h)
      {
          auto accA = mybufA.get_access<access::mode::write>(h);
          auto accB = mybufB.get_access<access::mode::read>(h);
          auto accC = mybufC.get_access<access::mode::read>(h);
          h.parallel_for<class theKernel>(range<1>{4}, [=](id<1> myID)
          {
              //acc[myID]++;
              accA[myID] = accB[myID] * accC[myID];
          });
      });
      e.wait();
         */
		 
      auto e = myq.submit([&](handler& h)
      {
          auto accA = mybufA.get_access<access::mode::write>(h);
          auto accB = mybufB.get_access<access::mode::read>(h);
          auto accC = mybufC.get_access<access::mode::read>(h);
          h.single_task<class theKernel>([=]()
          {
              //acc[myID]++;
              for (int i=0;i<100;i++)
              accA[i] = accB[i] * accC[i];
          });
      });
      e.wait();
	  
	  
        // Report kernel execution time and throughput
    t1_kernel = e.get_profiling_info<sycl::info::event_profiling::command_start>();
    t2_kernel = e.get_profiling_info<sycl::info::event_profiling::command_end>();
    time_kernel = (t2_kernel - t1_kernel) / NS;
    std::cout << "Kernel execution time: " << time_kernel << " seconds" << std::endl;
         
      // Creating host accessor is a blocking call and will only return after all
      // enqueued DPC++ kernels that modify the same buffer in any queue completes
      // execution and the data is available to the host via this host accessor.
          auto haccA = mybufA.get_access<access::mode::read>();

          for(int i =0;i<4;i++)
          {
              std::cout << "host_acc:" << haccA[i] << "\n";  
          }
     }
     //When execution advances beyond this scope, buffer destructor is invoked which
    //relinquishes the ownership of data and copies back the data to the host memory.
          for(int i =0;i<4;i++)
          {
              std::cout << "host: " << A[i] << "\n";  
          }

              
  return 0;
}