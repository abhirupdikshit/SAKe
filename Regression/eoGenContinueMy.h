#ifndef EOGENCONTINUEMY
#define EOGENCONTINUEMY


#include <eoContinue.h>
#include <utils/eoParam.h>
#include <QtQuick>
#include <utils/eoLogger.h>
#include <fstream>
#include <algorithm>    // std::sort
using namespace std;

/**
    Generational continuator: continues until a number of generations is reached

    @ingroup Continuators
*/
template< class EOT>
class eoGenContinueMy: public eoCountContinue<EOT>, public eoValueParam<unsigned>
{
public:

    using eoCountContinue<EOT>::thisGeneration;
    using eoCountContinue<EOT>::thisGenerationPlaceholder;

    /// Ctor for setting a
    eoGenContinueMy( QString _savePath)
        : eoCountContinue<EOT>( ),
          eoValueParam<unsigned>(0, "Generations", "Generations"),
          stop( false )

    {
        //_savePath.remove(0,8);
        savePath=_savePath+"/kernel.csv";
    }


    /** Returns false when a certain number of generations is
         * reached */
    virtual bool operator() ( const eoPop<EOT>& _vEO ) {

        //SALVATAGGIO ULTIMA GENERAZIONE
        ofstream myfile;
        myfile.open (savePath.toStdString(),ios::out);

        for (int t = 0; t < _vEO.best_element().getYCombinataConst().size(); t++) {
            myfile <<  _vEO.best_element().getYCombinataConst(t) << " ;";
        }

        myfile.close();

        thisGeneration++;
        if(stop){
            eo::log << eo::logging << "STOP in eoGenContinue: stop execution \n";
            return false;
        }
        return true;
    }

    /** Sets the number of generations to reach
            and sets the current generation to 0 (the begin)

        @todo replace this by an "init" method
    */
    virtual void setStop( bool _stop ) {
        stop = _stop;
        eoCountContinue<EOT>::reset();
    }

    /** Returns the number of generations to reach*/
    virtual bool getStop( )
    {
        return stop;
    }

    virtual std::string className(void) const { return "eoGenContinueMy"; }



private:
    bool stop;
    QString savePath;
    QObject *gen;
};


#endif // EOGENCONTINUEMY

