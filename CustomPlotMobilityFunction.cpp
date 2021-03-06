#include "CustomPlotMobilityFunction.h"
using boost::posix_time::ptime;
using namespace boost::gregorian;
using namespace boost::posix_time;
#include <QDebug>

CustomPlotMobilityFunction::CustomPlotMobilityFunction( QQuickItem* parent ) : QQuickPaintedItem( parent )
  , m_CustomPlot( nullptr )
{
    setFlag( QQuickItem::ItemHasContents, true );
    // setRenderTarget(QQuickPaintedItem::FramebufferObject);
    // setAcceptHoverEvents(true);
    setAcceptedMouseButtons( Qt::AllButtons );



    connect( this, &QQuickPaintedItem::widthChanged, this, &CustomPlotMobilityFunction::updateCustomPlotSize );
    connect( this, &QQuickPaintedItem::heightChanged, this, &CustomPlotMobilityFunction::updateCustomPlotSize );
}

CustomPlotMobilityFunction::~CustomPlotMobilityFunction()
{
    delete m_CustomPlot;
    m_CustomPlot = nullptr;
}

void CustomPlotMobilityFunction::initCustomPlotMobilityFunction()
{
    m_CustomPlot = new QCustomPlot();

    updateCustomPlotSize();

    setupQuadraticDemo( m_CustomPlot );

    // add the text label at the top: activation_size

    for(int i = 0; i < activation_size;i++){
        QCPItemText *textLabel = new QCPItemText(m_CustomPlot);
        //m_CustomPlot->addItem(textLabel);
        textLabel->setPositionAlignment(Qt::AlignTop);
        //textLabel->position->setType(QCPItemPosition::ptPlotCoords);
        //textLabel->position->setCoords(15, 18); // place position at center/top of axis rect
        textLabel->setText("Text Item Demo");
        //textLabel->setFont(QFont(font().family(), 16)); // make font a bit larger
        textLabel->setPen(QPen(Qt::black)); // show black border around text
        widgetArray.push_back(textLabel);

        QCPItemLine *arrow = new QCPItemLine(m_CustomPlot);
        //m_CustomPlot->addItem(arrow);
        arrow->start->setParentAnchor(textLabel->bottom);
        arrow->end->setType(QCPItemPosition::ptPlotCoords);
        //arrow->end->setCoords(0.23, 1.6); // point to (4, 1.6) in x-y-plot coordinates
        arrow->setHead(QCPLineEnding::esSpikeArrow);
        arrowArray.push_back(arrow);
    }


    // add the arrow:


    connect( m_CustomPlot, &QCustomPlot::afterReplot, this, &CustomPlotMobilityFunction::onCustomReplot );

    m_CustomPlot->replot();
}


void CustomPlotMobilityFunction::paint( QPainter* painter )
{
    if (m_CustomPlot)
    {



        QPixmap    picture( boundingRect().width(),boundingRect().height());
        //QPixmap    picture( boundingRect().size().toSize());
        QCPPainter qcpPainter( &picture );

        //m_CustomPlot->replot();
        m_CustomPlot->toPainter( &qcpPainter );
        painter->drawPixmap( QPoint(), picture );
    }
}

void CustomPlotMobilityFunction::mousePressEvent( QMouseEvent* event )
{
    //qDebug() << Q_FUNC_INFO;
    routeMouseEvents( event );
}

void CustomPlotMobilityFunction::mouseReleaseEvent( QMouseEvent* event )
{
    //qDebug() << Q_FUNC_INFO;
    routeMouseEvents( event );
}

void CustomPlotMobilityFunction::mouseWheel()
{
    // if an axis is selected, only allow the direction of that axis to be zoomed
    // if no axis is selected, both directions may be zoomed

    if (m_CustomPlot->xAxis->selectedParts().testFlag(QCPAxis::spAxis))
        m_CustomPlot->axisRect()->setRangeZoom(m_CustomPlot->xAxis->orientation());
    else if (m_CustomPlot->yAxis->selectedParts().testFlag(QCPAxis::spAxis))
        m_CustomPlot->axisRect()->setRangeZoom(m_CustomPlot->yAxis->orientation());
    else
        m_CustomPlot->axisRect()->setRangeZoom(Qt::Horizontal|Qt::Vertical);
}

void CustomPlotMobilityFunction::mousePress()
{
    qDebug() << Q_FUNC_INFO;
//     if an axis is selected, only allow the direction of that axis to be dragged
//     if no axis is selected, both directions may be dragged

//    if (m_CustomPlot->xAxis->selectedParts().testFlag(QCPAxis::spAxis))
//        m_CustomPlot->axisRect()->setRangeDrag(m_CustomPlot->xAxis->orientation());
//    else if (m_CustomPlot->yAxis->selectedParts().testFlag(QCPAxis::spAxis))
//        m_CustomPlot->axisRect()->setRangeDrag(m_CustomPlot->yAxis->orientation());
//    else
//        m_CustomPlot->axisRect()->setRangeDrag(Qt::Horizontal|Qt::Vertical);
}


void CustomPlotMobilityFunction::wheelEvent(QWheelEvent *event){
    double factor;
    double wheelSteps = event->delta()/120.0; // a single step delta is +/-120 usually
    factor = qPow(m_CustomPlot->axisRect()->rangeZoomFactor(Qt::Horizontal), wheelSteps);
    if (m_CustomPlot->axisRect()->rangeZoomAxis(Qt::Horizontal))
        m_CustomPlot->axisRect()->rangeZoomAxis(Qt::Horizontal)->scaleRange(factor,  m_CustomPlot->axisRect()->rangeZoomAxis(Qt::Horizontal)->pixelToCoord(event->pos().x()));
    factor = qPow(m_CustomPlot->axisRect()->rangeZoomFactor(Qt::Vertical), wheelSteps);
    if (m_CustomPlot->axisRect()->rangeZoomAxis(Qt::Vertical))
        m_CustomPlot->axisRect()->rangeZoomAxis(Qt::Vertical)->scaleRange(factor, m_CustomPlot->axisRect()->rangeZoomAxis(Qt::Vertical)->pixelToCoord(event->pos().y()));
    m_CustomPlot->replot();
    //cout <<"wheeeel" << endl;
}


void CustomPlotMobilityFunction::mouseMoveEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}

void CustomPlotMobilityFunction::mouseDoubleClickEvent( QMouseEvent* event )
{
    //qDebug() << Q_FUNC_INFO;
    routeMouseEvents( event );
}

void CustomPlotMobilityFunction::graphClicked( QCPAbstractPlottable* plottable )
{
    //qDebug() << Q_FUNC_INFO << QString( "Clicked on graph '%1 " ).arg( plottable->name() );
}

void CustomPlotMobilityFunction::routeMouseEvents( QMouseEvent* event )
{
    if (m_CustomPlot)
    {
        QMouseEvent* newEvent = new QMouseEvent( event->type(), event->localPos(), event->button(), event->buttons(), event->modifiers() );
        //QCoreApplication::sendEvent( m_CustomPlot, newEvent );
        QCoreApplication::postEvent( m_CustomPlot, newEvent );
        m_CustomPlot->replot();
    }
}

void CustomPlotMobilityFunction::updateCustomPlotSize()
{

    if (m_CustomPlot)
    {
        std::cout << "Mobility Function width() "<< width() << "  height() " << height() << std::endl;
        m_CustomPlot->setGeometry( 0, 0, width(), height() );
        m_CustomPlot->setViewport(QRect(0, 0, (int)width(), (int)height()));
        //m_CustomPlot->scale(width(), height());
    }
}

void CustomPlotMobilityFunction::onCustomReplot()
{
    //qDebug() << Q_FUNC_INFO;
    update();
}

void CustomPlotMobilityFunction::setupQuadraticDemo( QCustomPlot* customPlot )
{

    // set locale to english, so we get english month names:
    customPlot->setLocale(QLocale(QLocale::English, QLocale::UnitedKingdom));

    customPlot->addGraph();
    QPen pen;
    pen.setColor(QColor(0, 0, 255, 200));
    customPlot->graph( 0 )->setPen( QPen( Qt::red ) );
    //customPlot->graph( 0 )->setSelectedPen( QPen( Qt::blue, 2 ) );
    customPlot->yAxis->setRange( 0,20 );

    customPlot->addGraph();
    customPlot->graph(1)->setPen( QPen( Qt::gray ) );

    QVector<double> timetmp(rain_size),ytime(rain_size);
    for (int i=0; i<rain_size; i++){
        timetmp[i]=(ptime_from_tm(rain[i].getTime())-ptime(date(1970, Jan, 1))).total_seconds();
        ytime[i]=0;
    }

    customPlot->graph(1)->setData(timetmp, ytime);

    customPlot->addGraph();

    customPlot->graph(2)->setPen( QPen( Qt::blue ) );

    customPlot->graph(2)->setData(timetmp, ytime);

    customPlot->addGraph();
    customPlot->graph(3)->setPen( QPen( Qt::blue ) );
    customPlot->graph(3)->setLineStyle(QCPGraph::lsNone);
    customPlot->graph(3)->setScatterStyle(QCPScatterStyle(QCPScatterStyle::ssCircle, 7));



    //}
    // configure bottom axis to show date and time instead of number:
    QSharedPointer<QCPAxisTickerDateTime> dateTimeTicker(new QCPAxisTickerDateTime);
    dateTimeTicker->setDateTimeSpec(Qt::UTC);
    dateTimeTicker->setDateTimeFormat("dd\nMMMM\nyyyy");
    //customPlot->xAxis->setTicker(dateTimeTicker);
    //customPlot->xAxis->setDateTimeFormat("dd\nMMMM\nyyyy");
    // set a more compact font size for bottom and left axis tick labels:
    customPlot->xAxis->setTickLabelFont(QFont(QFont().family(), 8));
    customPlot->yAxis->setTickLabelFont(QFont(QFont().family(), 8));
    // set a fixed tick-step to one tick per month:
   // customPlot->xAxis->setAutoTickStep(true);
   // customPlot->xAxis->setTickStep(2628000); // one month in seconds

    customPlot->xAxis->setLabel("Date");
    customPlot->yAxis->setLabel("y");


    ptime rain0 = ptime_from_tm(rain[0].getTime());
    ptime rainLast = ptime_from_tm(rain[rain_size-1].getTime());
    boost::posix_time::time_duration diff1 =(rain0-ptime(date(1970, Jan, 1)));
    boost::posix_time::time_duration diff2 = (rainLast-ptime(date(1970, Jan, 1)));
    //      cout << diff1.total_seconds()<< " "<<diff2.total_seconds() << endl;

    customPlot->xAxis->setRange(diff1.total_seconds(), diff2.total_seconds());
    customPlot->yAxis->setRange( 0, 20 );


    customPlot ->setInteractions( QCP::iRangeDrag | QCP::iRangeZoom | QCP::iSelectPlottables );
    connect( customPlot, SIGNAL( plottableClick( QCPAbstractPlottable*, QMouseEvent* ) ), this, SLOT( graphClicked( QCPAbstractPlottable* ) ) );
    connect(customPlot, SIGNAL(mousePress(QMouseEvent*)), this, SLOT(mousePress()));
    connect(customPlot, SIGNAL(mouseWheel(QWheelEvent*)), this, SLOT(mouseWheel()));
    first = true;
    int graphnum=4;
    if(first){
        QVector<double> x(100), y(100);
        for (int j=0; j<activation_size; j++)
        {     tm a1=activation[j].getStart();
            //a1.tm_mday-=1;
            //cout << a1.tm_mday<< " "<<a1.tm_mon<< " "<<a1.tm_year << endl;
            tm a2=activation[j].getEnd();
            // cout << a1.tm_mday<< " "<<a1.tm_mon<< " "<<a1.tm_year<< endl;
            //a2.tm_mday+=2;
            for (int k=0; k<2; k++)
            {
                customPlot->addGraph();
                for (int i=0; i<(int)100; i++)
                {

                    if(k%2==0){

                        customPlot->graph( graphnum )->setPen( QPen( Qt::green) );

                        ptime tmp1 = ptime_from_tm(a1);
                        //ptime t11 = local_adj::utc_to_local(tmp1);

                        ptime utcepoch = ptime(date(1970, Jan, 1));
                        //ptime utcepoch1 = local_adj::utc_to_local(utcepoch);
                        //std::cout << (raindate-ptime(date(1970, Jan, 1))).total_milliseconds() << "\n";
                        boost::posix_time::time_duration diff =(tmp1-utcepoch);
                        //diff.total_milliseconds();
                        x[i] = diff.total_seconds();
                    }else{

                        customPlot->graph( graphnum )->setPen( QPen( Qt::blue) );
                        ptime tmp2 = ptime_from_tm(a2);
                        x[i] =(tmp2-ptime(date(1970, Jan, 1))).total_seconds();
                    }
                    y[i] = i;

                    //cout << x[i] << " "<< y[i]  << endl;
                }

                customPlot->graph(graphnum)->setData(x, y);
                // customPlot->graph(graphnum)->rescaleAxes(true);
                graphnum++;
            }


        }
        first =false;

    }


    customPlot->replot();
    //cout << max << endl;

}

void CustomPlotMobilityFunction::setActivation(Activation *value,int _activation_size)
{
    activation = value;
    activation_size=_activation_size;
}

Rain *CustomPlotMobilityFunction::getRain() const
{
    return rain;
}

void CustomPlotMobilityFunction::setRain(Rain *value,int _rain_size)
{
    rain = value;
    rain_size =_rain_size;
}

void CustomPlotMobilityFunction::updateGraph(double *Y,Ym YmMin,Ym YmMin2,std::vector<Ym> bests){
    if (m_CustomPlot)
    {
        m_CustomPlot->axisRect()->setRangeDrag(0);
        m_CustomPlot->axisRect()->setRangeZoom(0);

        std::sort(bests.begin(), bests.end(), [](Ym a, Ym b) { return a.getValue() > b.getValue(); });


        for(unsigned int i = 0; i < bests.size();i++){

            ptime bestTmp = ptime_from_tm(bests[i].getTime());
            boost::posix_time::time_duration diff =(bestTmp-ptime(date(1970, Jan, 1)));
            widgetArray[i]->position->setCoords(diff.total_seconds(), bests[i].getValue()+8);

            //DateTime time = DateTime(t.tm_year+1900, t.tm_mon+1, t.tm_day, t.tm_hour, t.tm_min, t.tm_sec);
            int year = bests[i].getTime().tm_year +1900;
            int mon = bests[i].getTime().tm_mon +1;
            int day = bests[i].getTime().tm_mday ;
            //std::cout << "year " << year << " mon " << mon << " day " << day << std::endl;
////            string year = std::to_string(1900);
////            string mon = bests[i].getTime().tm_mon+std::to_string(1);
////            string day = bests[i].getTime().day;

            QString a = QString("%1 %2 %3 - %4").arg(year).arg(mon).arg(day).arg(i+1);
            widgetArray[i]->setText(a);
            arrowArray[i]->end->setCoords(diff.total_seconds(), bests[i].getValue());
        }


        m_CustomPlot->graph( 0 )->setPen( QPen( Qt::red ) );
        //    qDebug() << "aggiorno" << endl;
        double max =-1;
        QVector<double> time(rain_size), value(rain_size);
        for (int i=0; i<rain_size; i++)
        {
            ptime raintime = ptime_from_tm(rain[i].getTime());
            boost::posix_time::time_duration diff =(raintime-ptime(date(1970, Jan, 1)));
            time[i] = diff.total_seconds();
            value[i]=Y[i];
            if(value[i] > max)
                max=value[i];
        }

        m_CustomPlot->graph(0)->setData(time, value);

        QVector<double> timetmp(rain_size),ytime(rain_size),ytime2(rain_size);
        for (int i=0; i<rain_size; i++){
            //timetmp[i]=(ptime_from_tm(rain[i].getTime())-ptime(date(1970, Jan, 1))).total_seconds();
            ytime[i]=YmMin.getValue();
            ytime2[i]=YmMin2.getValue();
        }
        m_CustomPlot->graph(1)->setData(time, ytime);
        m_CustomPlot->graph(2)->setData(time, ytime2);

        QVector<double> yPoint(2),xPoint(2);

        yPoint[0]=YmMin.getValue();
        yPoint[1]=YmMin2.getValue();
        xPoint[0]=(ptime_from_tm(YmMin.getTime())-ptime(date(1970, Jan, 1))).total_seconds();
        xPoint[1]=(ptime_from_tm(YmMin2.getTime())-ptime(date(1970, Jan, 1))).total_seconds();
        m_CustomPlot->graph(3)->setData(xPoint, yPoint);
        m_CustomPlot->axisRect()->setRangeDrag(Qt::Horizontal|Qt::Vertical);
        m_CustomPlot->axisRect()->setRangeZoom(Qt::Horizontal|Qt::Vertical);

        m_CustomPlot->replot();
    }

}

void CustomPlotMobilityFunction::updateGraph(double *Y,double YmMin){


    if (m_CustomPlot)
    {

        m_CustomPlot->graph( 0 )->setPen( QPen( Qt::red ) );
        //    qDebug() << "aggiorno" << endl;
        double max =-1;
        QVector<double> time(rain_size), value(rain_size);
        for (int i=0; i<rain_size; i++)
        {
            // qDebug() << mktime(&(rain[i].getTime()));
            // boost::posix_time::time_duration diff1 =(rain0-ptime(date(1970, Jan, 1)));
            ptime raintime = ptime_from_tm(rain[i].getTime());
            boost::posix_time::time_duration diff =(raintime-ptime(date(1970, Jan, 1)));
            time[i] = diff.total_seconds();
            value[i]=Y[i];
            if(value[i] > max)
                max=value[i];
        }

        m_CustomPlot->graph(0)->setData(time, value);
        //m_CustomPlot->yAxis->setRange( 0,max );



        QVector<double> timetmp(rain_size),ytime(rain_size),ytime2(rain_size);
        for (int i=0; i<rain_size; i++){
            //timetmp[i]=(ptime_from_tm(rain[i].getTime())-ptime(date(1970, Jan, 1))).total_seconds();
            ytime[i]=YmMin;
            ytime2[i]=0;
        }
        //    m_CustomPlot->graph(1)->setLineStyle((QCPGraph::LineStyle)0);
        m_CustomPlot->graph(1)->setData(time, ytime);
        m_CustomPlot->graph(2)->setData(time, ytime2);

        QVector<double> yPoint(2),xPoint(2);

        yPoint[0]=YmMin;
        yPoint[1]=0;
        xPoint[0]=0;
        xPoint[1]=0;
        m_CustomPlot->graph(3)->setData(xPoint, yPoint);


        m_CustomPlot->replot();
    }

}

void CustomPlotMobilityFunction::updateGraph1(QVector<double> x,QVector<double> y){


    if(x.size() > 20)
        m_CustomPlot->xAxis->setRange( 0, x.size() );
    m_CustomPlot->graph( 1 )->setData( x, y);



    m_CustomPlot->replot();

}


void CustomPlotMobilityFunction::resizeEvent(QResizeEvent *event)
{
    //    cout << "CustomPlotMobilityFunction " << endl;
    m_CustomPlot->resize(event->size());
}
