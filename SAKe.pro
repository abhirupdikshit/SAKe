TEMPLATE = app
QT += xml
QT += qml quick

greaterThan(QT_MAJOR_VERSION, 4) :QT+= widgets printsupport #declarative
#CONFIG += force_debug_info
#DEFINES += QT_NO_DEBUG
CONFIG += console

SOURCES += main.cpp \
    CustomPlotItem.cpp \
    SAke/SAKeEA.cpp \
    SAke/SAKeController.cpp \
    SAke/eoGraphFitenessStat.cpp \
    SAKeStart.cpp \
    CustomPlotMobilityFunction.cpp \
    CustomPlotKernel.cpp \
    updateprojects.cpp \
    xmlmanager.cpp \
    ValidationController.cpp \
    HandlerCSV.cpp \
    Regression/parameters.cpp \
    Regression/regressioncontroller.cpp \
    CustomPlotRegression.cpp \
    TreeModel.cpp \
    tablemodel.cpp \
    controlpoints.cpp \
    CustomPlotRegressionPreviewKernel.cpp \
    Regression/funtciontype.cpp \
    qcustomplot.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    CustomPlotItem.h \
    SAke/Activation.h \
    SAke/eoSAKe.h \
    SAke/eoSAKeEvalFunc.h \
    SAke/eoSAKeInit.h \
    SAke/eoSAKeMutation.h \
    SAke/eoSAKeQuadCrossover.h \
    SAke/make_genotype_SAKe.h \
    SAke/make_op_SAKe.h \
    SAke/Ym.h \
    SAke/db/DBmanager.h \
    SAke/Rain.h \
    SAke/SAKeController.h \
    SAke/eoGraphFitenessStat.h \
    SAke/make_checkpoint_my.h \
    SAKeStart.h \
    MyEventFilter.h \
    CustomPlotMobilityFunction.h \
    SAke/eoGenContinueMy.h \
    SAke/make_continue_my.h \
    CustomPlotKernel.h \
    SAke/make_algo_scalar_my.h \
    SAke/eoElitistReplacement.h \
    SAke/eoMySelection.h \
    SAke/eoMySGA.h \
    update.h \
    updateprojects.h \
    xmlmanager.h \
    ValidationController.h \
    HandlerCSV.h \
    SAke/selectionfitness.h \
    SAke/selectiondeltacr.h \
    SAke/selectionmomentoprimoordine.h \
    SAke/selectionsize.h \
    SAke/selectionstrategy.h \
    SAke/eoSGAGenerational.h \
    SAke/eoSGAGenerationalMultiObjects.h \
    SAke/eoSGASteadyState.h \
    SAke/eoSGASteadyStateMultiObjects.h \
    Regression/eoOneMax.h \
    Regression/eoOneMaxEvalFunc.h \
    Regression/eoOneMaxInit.h \
    Regression/eoOneMaxMutation.h \
    Regression/eoOneMaxQuadCrossover.h \
    Regression/make_algo_scalar_my.h \
    Regression/make_genotype_OneMax.h \
    Regression/make_op_OneMax.h \
    Regression/parameters.h \
    Regression/regressioncontroller.h \
    strptime.h \
    Regression/eoGraphFitenessStat.h \
    CustomPlotRegression.h \
    Regression/make_checkpoint_my.h \
    Regression/eoGenContinueMy.h \
    Regression/make_continue_my.h \
    TreeModel.h \
    tablemodel.h \
    controlpoints.h \
    CustomPlotRegressionPreviewKernel.h \
    Regression/funtciontype.h \
    Regression/eoSGAGenerational.h \
    Regression/eoMySGA.h \
    Regression/eoSGASteadyState.h \
    SAke/eosakedettournamentselect.h \
    SAke/eosakestochtournamentselect.h \
    SAke/make_pop_my.h \
    qcustomplot.h

CONFIG += c++11
QMAKE_CXXFLAGS += -march=i686
QMAKE_LFLAGS+= --enable-auto-import
QMAKE_CXXFLAGS+= -fopenmp
QMAKE_CXXFLAGS+=  -static -static-libgcc
QMAKE_CXXFLAGS+= -static-libstdc++
QMAKE_LFLAGS +=  -fopenmp
#CONFIG += static

#LIBS += -fopenm



#QMAKE_CXXFLAGS+= -D__NO_INLINE__

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/ -leo
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/ -leo
else:unix: LIBS += -L$$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/ -leo

INCLUDEPATH += $$PWD/../paradiseo-master/paradiseo-master/eo/src
DEPENDPATH += $$PWD/../paradiseo-master/paradiseo-master/eo/src

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/libeo.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/libeo.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/eo.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/eod.lib
else:unix: PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/libeo.a


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/ -leoutils
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/ -leoutils
else:unix: LIBS += -L$$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/ -leoutils

INCLUDEPATH += $$PWD/../paradiseo-master/paradiseo-master/eo/src
DEPENDPATH += $$PWD/../paradiseo-master/paradiseo-master/eo/src

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/libeoutils.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/libeoutils.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/eoutils.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/eoutilsd.lib
else:unix: PRE_TARGETDEPS += $$PWD/../paradiseo-master/paradiseo-master/build5.3/lib/libeoutils.a


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/ -lboost_date_time-mgw53-mt-1_60
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/ -lboost_date_time-mgw53-mt-d-1_60
else:unix: LIBS += -L$$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/ -lboost_date_time-mgw53-mt-1_60

INCLUDEPATH += $$PWD/../boost_1_60_0/boost_1_60_0/
DEPENDPATH += $$PWD/../boost_1_60_0/boost_1_60_0/

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/libboost_date_time-mgw53-mt-1_60.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/libboost_date_time-mgw53-mt-d-1_60.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/boost_date_time-mgw53-mt-1_60.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/boost_date_time-mgw53-mt-d-1_60.lib
else:unix: PRE_TARGETDEPS += $$PWD/../boost_1_60_0/boost_1_60_0/stage/lib/libboost_date_time-mgw53-mt-1_60.a
