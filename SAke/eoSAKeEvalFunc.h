/** -*- mode: c++; c-indent-level: 4; c++-member-init-indent: 8; comment-column: 35; -*-

 The above line is usefulin Emacs-like editors
 */

/*
 Template for evaluator in EO, a functor that computes the fitness of an EO
 ==========================================================================
 */

#ifndef _eoSAKeEvalFunc_h
#define _eoSAKeEvalFunc_h

// include whatever general include you need
#include <stdexcept>
#include <fstream>
#include <ctime>
using namespace std;
#define DAYS  ((60) (*) (60) (*) (24))
#define HOURS ((60) (*) (60))

// include the base definition of eoEvalFunc
#include "eoEvalFunc.h"
#include "Rain.h"
#include "Ym.h"
#include "Activation.h"
#include "boost/date_time/posix_time/posix_time.hpp"
#include "boost/date_time/local_time_adjustor.hpp"
#include "boost/date_time/c_local_time_adjustor.hpp"
using boost::posix_time::ptime;
using namespace boost::gregorian;
using namespace boost::posix_time;
/**
 Always write a comment in this format before class definition
 if you want the class to be documented by Doxygen
 */
template<class EOT>
class eoSAKeEvalFunc: public eoEvalFunc<EOT> {
public:
	/// Ctor - no requirement
// START eventually add or modify the anyVariable argument
	eoSAKeEvalFunc(Rain * _rain, int _rain_size, Activation* _activation,
			int _activation_size)
			//  eoSAKeEvalFunc( varType  _anyVariable) : anyVariable(_anyVariable)
// END eventually add or modify the anyVariable argument
			{
		rain = _rain;
		rain_size = _rain_size;
		activations = _activation;
        activations_size = _activation_size;
        numeroValitazioni=0;
		// START Code of Ctor of an eoSAKeEvalFunc object
		// END   Code of Ctor of an eoSAKeEvalFunc object
	}

	double * getY(Rain *& P, double *&Fi, int tb) {
//        printf("rain_size %d \n",rain_size);
//        for (int i = 0; i < tb; i++) {
//               printf("Fi[%d] %f \n",i, Fi[i]);

//        }
//        printf("tb %d %d  \n",tb,rain_size);
//        ofstream myfile;
//        myfile.open ("C:\\Users\\Alessio\\Documents\\workspace\\calibration\\seed1\\calibration.csv",ios::out);
//                for (int i = 0; i < tb; i++) {
//                     //  printf("Fi[%d] %f \n",i, Fi[i]);
//                    myfile << "Fi[ " << i<<"] = " << Fi[i] << "\n";
//                }
		double * Y = new double[rain_size];
		for (int t = 0; t < rain_size; t++) {
			double ym = 0;
			Y[t] = 0;
			for (int r = 0; r < t; r++)
				if ((t - r) < tb){
					ym += Fi[t - r] * P[r].getRainMm();
                   // myfile << "Fi[t - r] = " << Fi[t - r] << ", P[r].getRainMm() " << rain[r].getRainMm() << "\n";
				}
			Y[t] = ym;
//            myfile << "Y[" << t << "] " << ym << "\n";
            //printf("Y[%d] %f \n",t, ym);

        }
//        myfile.close();

        return Y;

	}

    static int  compareDouble (const void * a, const void * b)
	{
		// - perche decrescente
      if( (double)(((Ym*)a)->getValue()) > (double)(((Ym*)b)->getValue()) ){
          return -1;
      }
      if( (double)(((Ym*)a)->getValue()) < (double)(((Ym*)b)->getValue()) ){
          return 1;
      }
      if( (double)(((Ym*)a)->getValue()) == (double)(((Ym*)b)->getValue()) ){
          return 0;
      }
	}

	void getYmDecr(Ym*&ym,int &size){
		qsort (ym, size, sizeof(Ym),compareDouble);

	}

	int getDifferenceTime(tm temp1,tm temp2){
        ptime rain0 = ptime_from_tm(temp1);
        ptime rainLast = ptime_from_tm(temp2);
        boost::posix_time::time_duration diff1 =(rain0-ptime(date(1970, Jan, 1)));
        boost::posix_time::time_duration diff2 =(rainLast-ptime(date(1970, Jan, 1)));
        std::time_t x = diff1.total_seconds();
        std::time_t y = diff2.total_seconds();
	    if ( x != (std::time_t)(-1) && y != (std::time_t)(-1) )
	    {
            //TODO [differenza in minuti] [differenza in ore] [ differenza in giorni ]
	        int difference = std::difftime(y, x) / (60*60*24);
//	        std::cout << std::ctime(&x);
//	        std::cout << std::ctime(&y);
//	        std::cout << "difference = " << difference << " days" << std::endl;
			return difference;
	    }
		return -1;
	}


    double getFitness(double *& Y,EOT & _eo){

		double f=0;
		Ym * ym= new Ym[rain_size];
		int countYm=0;

		for (int t = 1; t < rain_size-1; t++) {
            bool cross = (((Y[t] - Y[t - 1]) * (Y[t + 1] - Y[t])) < 0) && (Y[t] > Y[t - 1]);
			if(cross){
				// trovato un picco deve essere considerato
				ym[countYm].setValue(Y[t]);
				ym[countYm].setTime(rain[t].getTime());
				countYm++;
			}
		}

		getYmDecr(ym,countYm);

//        for (int i = 0; i < countYm; i++) {
//               printf("ym[%d] %f \n",i, ym[i].getValue());

//        }
//        printf("countYm %d \n",countYm);


        double YsMin = 999999999;
        int iMin =-1;
        std::vector<Ym> bests;
        for (int s = 0; s < activations_size; s++) {
            for (int i = 0; i < countYm; i++) {
                //TODO inserire variabili intervallo giorni
                int result1 = getDifferenceTime(activations[s].getStart(),ym[i].getTime());
                int result2 = getDifferenceTime(ym[i].getTime(),activations[s].getEnd());
                if(result1>=-2 && result2>=-1){
                    //if(i<countYm)
                    //if(i<(activations_size)){
//                       printf("i %d \n",i);

                        f += 1 / (double)(i + 1);
//                        printf("f %f \n",f);
                        bests.push_back(ym[i]);
//                        int year = ym[i].getTime().tm_year +1900;
//                        int mon = ym[i].getTime().tm_mon +1;
//                        int day = ym[i].getTime().tm_mday ;
//                        std::cout << "year " << year << " mon " << mon << " day " << day << std::endl;
//                        std::cout << "ym[i] value " << ym[i].getValue() << std::endl;
                        //printf("+  %f \n",(1 / (double)(i + 1)));
                        if(ym[i].getValue() < YsMin){
                            YsMin =ym[i].getValue();
                            iMin=i;
                        }//if
                        break;
                    //}
                    // calcolo valori per calcolare dYcr per risparmiare calcoli

                }//if
            }//for
        }//for
        //std::cout << std::endl;
        _eo.setBests(bests);
		if(iMin < 0)  iMin = 0;
		if(iMin > countYm-1)  iMin = countYm-1;
        int index=(iMin+1);
        double dYcr = (YsMin-ym[index].getValue())/YsMin;
//        printf("dYcr %f \n",dYcr);
//        printf("YsMin %f \n",YsMin);
//        printf("YsMin2 %f \n",ym[index].getValue());
        _eo.setdYcr(dYcr);
        //_eo.setYsMin(YsMin);
        //_eo.setYsMin2(ym[index].getValue());
        //_eo.setiMin(iMin);
        Ym ymMin= ym[iMin];
        Ym ymMin2 = ym[index];
        _eo.setYmMin(ymMin);
        _eo.setYmMin2(ymMin2);


		double fMax=0;
//        printf("activations_size %d \n",activations_size);
        for (int i = 1; i <= activations_size; i++) {
            fMax +=(double)(1/(double)i);
		}

//       printf("f %f fMax %f fitness = %f \n",f,fMax,(double) (f/fMax));

		delete []ym;

        return (double) (f/fMax);
	}

	/** Actually compute the fitness
	 *
	 * @param EOT & _eo the EO object to evaluate
	 *                  it should stay templatized to be usable
	 *                  with any fitness type
	 */
	void operator()(EOT & _eo) {
        numeroValitazioni++;
        //printf("numeroValitazioni  %d ",numeroValitazioni);
        // test for invalid to avoid recomputing fitness of unmodified individuals
        //if (_eo.invalid()) {
			int tb = _eo.getSize();
            //printf("valito individuo con tb %d \n",tb);

			//Prelevo kernels
			double * Fi = _eo.getFi();
            //Calcolo funzione di mobilità
			double * Y = getY(rain, Fi, tb);
//			il primo elemento il dato relativo alla prima piogge
//			tm temp = rain[0].getTime();
            double f = getFitness(Y,_eo);

            double momentoDelPrimoOrdine = 0;
            for (int i = 0; i < tb; i++) {
                momentoDelPrimoOrdine += Fi[i]*((i+1)-0.5);
            }
            _eo.setMomentoDelPrimoOrdine(momentoDelPrimoOrdine);

			delete []Y;
			_eo.fitness(f);
        //}
	}

private:
// START Private data of an eoSAKeEvalFunc object
	//  varType anyVariable;		   // for example ...
	Rain * rain;
	int rain_size;
	Activation * activations;
    int activations_size;
    int numeroValitazioni;
// END   Private data of an eoSAKeEvalFunc object
};

#endif
