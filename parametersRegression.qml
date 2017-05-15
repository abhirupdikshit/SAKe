import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2
import QtQuick.Window 2.0
import CustomPlotRegressionPreviewKernel 1.0

ApplicationWindow {
    id: applicationWindow1
    visible: true
    title: qsTr("Sake software")
    property  string pathrain;
    property  string pathactivation;
    width: 1420
    height: 920
    color:"#f2f2f2"

    property  string infoSelection : "
<html>
<head>
<style>

table, th, td {
    border: 2px solid black;
   padding-left:10px;
}
</style>
</head>

<body>
<table border='1'>
<thead>
<tr>
<td><b>Selection Type</b></td>
<td><b>Specification </b></td>
</tr>
</thead>
<tbody>
<tr>
<td >DetTour(t)</td>
<td>selecting an individual from a population of individuals with rate t between 0.55 - 1 </td>
</tr>

  <tr>
<td>StochTour(t)</td>
<td>a selection method that selects ONE individual by binary stochastic tournament with rate t between 0.55 - 1</td>
</tr>

  <tr>
<td>Ranking(p,e)</td>
<td>select an individual by roulette wheel on its rank.
        <table>
<tr>
<td>p </td>
<td>the selective pressure, should be in [1,2] (2 is the default)</td>
</tr>

<tr>
<td>e </td>
<td>exponent (1 == linear) positive integer</td>
</tr>
        </table>
</tr>

  <tr>
<td>Roulette</td>
<td>select an individual proportional to her stored fitness value. </td>
</tr>
  <tr>
<td>Sequential(ordered/unordered)</td>
<td>Looping back to the beginning when exhausted, can be from best to worse, or in random order.</td>
</tr>

  <tr>
<td>Generational</td>
<td> </td>
</tr>

  <tr>
<td>Steady-State</td>
<td> </td>
</tr>



</tbody>
</table>
</body>
</html>
";

    property  int typeProject : 0;
    property  string projectName : "";
    function initNewPar(){

        textFieldGammaFunctions.showLabelFirstTime();
        textFieldGammaFunctionsGreaterthan1.showLabelFirstTime();
        textFieldLinearFunction.showLabelFirstTime();

    }

    function loadParameter(parameter,listGamma1,listGamma2,listLinear){
        typeProject=1;
//        console.log( "AAAAAAAAAAA typeProject " +typeProject)


        projectName=parameter[0]
        textProjectName.visible = false;
        applicationWindow1.title = "Project name               "  + parameter[0]
        if(parameter[1]==="StochTour(t)"){
                    comboSelection.currentIndex=0
                    parameter1.text=parameter[2]
                }else
                    if(parameter[1]==="DetTour(T)"){
                        comboSelection.currentIndex=1
                        parameter1.text=parameter[2]
                    }else
                        if(parameter[1]==="Ranking(p,e)"){
                            comboSelection.currentIndex=2
                            parameter1.text=parameter[2]
                            parameter2.text=parameter[3]
                        }else
                            if(parameter[1]==="Roulette"){
                                    comboSelection.currentIndex=3
                                }


        textFieldPopulationSize.text=parameter[4]
        textFieldNumberProcessor.text=parameter[5]
        textFieldProbabiltyCrossOver.text=parameter[6]
        textFieldProbabiltyMutation.text=parameter[7]
        textFieldMaxGeneration.text=parameter[8]

        var split = parameter[9].split("/")
        textfileRain.text = "../"+split[split.length-1]
        pathrain=parameter[9]
        customPlotKernelRegression1.initCustomPlotRegressionPreviewKernel(pathrain)
        var checkNTmp=parameter[10]
        if(checkNTmp){
            checkUseControlPointsWithN.checked= true;
        }

        var textN=parameter[11]
        textPercentageN.text = textN;



        var typrExecution=parameter[12]
//        console.log(" typrExecution = "+typrExecution)
        if(typrExecution==="0")
            checkControlPoints.checked = true;
        else
            if(typrExecution==="1")
                checkKernel.checked = true;
            else
                if(typrExecution ==="2")
                    checkN.checked = true;
        comboReplacament.currentIndex = parameter[13]
        replacementParameter.text = parameter[14]
        var count=1;
        var i=0;
        textFieldGammaFunctions.text=listGamma1.length/9;
        textFieldGammaFunctionsGreaterthan1.text=listGamma2.length/9;
        textFieldLinearFunction.text=listLinear.length/9;
        tableModel.clear()
        for(i=0; i < listGamma1.length; i+=9)
        {
            tableModel.append({ nFunction:count,
                                  amax: listGamma1[i],
                                  amin: listGamma1[i+1],
                                  bmax: listGamma1[i+2],
                                  bmin: listGamma1[i+3],
                                  wmax: listGamma1[i+4],
                                  wmin: listGamma1[i+5],
                                  pa: listGamma1[i+6],
                                  pb: listGamma1[i+7],
                                  pw: listGamma1[i+8],
                                  tmin: "2",
                                  tmax: "0",
                                  tp: "0.01"})
            count++;

        }
        tableView1.model = tableModel;
        count=1;

        tableModel2.clear()
        for(i=0; i < listGamma2.length; i+=9)
        {
            tableModel2.append({ nFunction:count,
                                   amax: listGamma2[i],
                                   amin: listGamma2[i+1],
                                   bmax: listGamma2[i+2],
                                   bmin: listGamma2[i+3],
                                   wmax: listGamma2[i+4],
                                   wmin: listGamma2[i+5],
                                   pa: listGamma2[i+6],
                                   pb: listGamma2[i+7],
                                   pw: listGamma2[i+8],
                                   tmin: "2",
                                   tmax: "0",
                                   tp: "0.01"})
            count++;

        }
        count=1;
        tableModel3.clear()
        for(i=0; i < listLinear.length; i+=9)
        {
            tableModel3.append({ nFunction:count,
                                   amax: listLinear[i],
                                   amin: listLinear[i+1],
                                   bmax: listLinear[i+2],
                                   bmin: listLinear[i+3],
                                   wmax: listLinear[i+4],
                                   wmin: listLinear[i+5],
                                   pa: listLinear[i+6],
                                   pb: listLinear[i+7],
                                   pw: listLinear[i+8],
                                   tmin: "2",
                                   tmax: "0",
                                   tp: "0.01"})
            count++;

        }



    }

    property string infoPropSelection;
    property string infoPropCrossover;
    property string infoPropMutation;
    property string infoMaxGen;
    property string infoNumberProcessor;
    property string infoN;
    property string infoCheckN;

//    Layout.minimumHeight: height
//    Layout.minimumWidth: width
//    Component.onCompleted: {
//        setX(Screen.width / 2 - width / 2);
//        setY(Screen.height / 2 - height / 2);
//    }

    ScrollView {
        id: scrollView1
        width: parent.width
        height: parent.height

        Rectangle{
            id: parameter
            x: 0
            y: 0
            color:"#f2f2f2"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            width: 1400
            height: 920

            ColumnLayout {
                id: columnLayout5
                height: parent.width
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0

                Label {
                    id: label1
                    text: qsTr("Regression Parameters")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.bold: true
                    font.pointSize: 22

                }

                GridLayout {
                    id: gridLayout2
                    height: 881
                    Layout.fillWidth: false
                    layoutDirection: Qt.RightToLeft
                    flow: GridLayout.TopToBottom
                    rows: 1
                    columns: 2

                    Rectangle {
                        id: columnLayout2
                        width: 676
                        //spacing: 0

                        RowLayout {
                            id: rowLayout
                            x: 0
                            y: -421
                            spacing: 20
                            anchors.bottomMargin: 10

                            Label {
                                id: textFieldProjectName
                                text: qsTr("Project Name")
                                Layout.alignment: Qt.AlignHCenter
                            }

                            TextField {
                                id: textProjectName
                                text: qsTr("")
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }




//                            GridLayout {
//                                id: gridLayout1
//                                y: 10
//                                width: 63
//                                height: 350
//                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
//                                rowSpacing: 19
//                                columnSpacing: 22
//                                scale: 1
//                                transformOrigin: Item.Center
//                                rows: 4
//                                columns: 1

//                                Layout.preferredWidth: -1
//                                Layout.preferredHeight: -1

//                                ColumnLayout {
//                                    id: columnLayout4
//                                    width: 100
//                                    height: 100

//                                    GridLayout {
//                                        id: gridLayout5
//                                        Label {
//                                            id: labelSelection
//                                            text: qsTr("Selection")
//                                            scale: 1
//                                            transformOrigin: Item.Center
//                                        }

//                                        ComboBox {
//                                            id: comboSelection
//                                            currentIndex: 0
//                                            function show( currentIndex){
//                                                                                    if(currentIndex === 0 ||
//                                                                                       currentIndex === 1  ){
//                                                                                        selectionParameter.visible=true;
//                                                                                    }else
//                                                                                        selectionParameter.visible=false;

//                                                                                    if(currentIndex ===2){
//                                                                                        selectParameterRanking1.visible=true;
//                                                                                        selectParameterRanking2.visible=true;
//                                                                                    }else
//                                                                                    {
//                                                                                        selectParameterRanking1.visible=false;
//                                                                                        selectParameterRanking2.visible=false;

//                                                                                    }
//                                                                                    if(currentIndex ===4){
//                                                                                        comboSelectinParameterSequential.visible=true;
//                                                                                    }else{
//                                                                                        comboSelectinParameterSequential.visible=false;
//                                                                                    }

//                                                if(currentIndex ===5 || currentIndex ===6){
//                                                    selectionParameterTournamentWithoutReplacement.visible=true;
//                                                }else{
//                                                    selectionParameterTournamentWithoutReplacement.visible=false;
//                                                }
//                                            }
//                                            model: ListModel {
//                                                id: selections
//                                                ListElement { text: "StochTour(t)";  }
//                                                ListElement { text: "DetTour(T)";  }
//                                                ListElement { text: "Ranking(p,e)";  }
//                                                ListElement { text: "Roulette"; }
//                                                ListElement { text: "Sequential(ordered/unordered)";  }
//                                                ListElement { text: "Generational"; }
//                                                ListElement { text: "Steady-State"; }

//                                            }
//                                            onCurrentIndexChanged: show(currentIndex)
//                                        }

//                                        Image {
//                                            source: "qrc:/img/info.jpg"

//                                            width: 20
//                                            height: 20
//                                            Layout.preferredWidth: 20
//                                            Layout.preferredHeight: 20
//                                            MouseArea {
//                                                anchors.fill: parent
//                                                Popup {
//                                                        id: popupSelection
//                                                        width: 500
//                                                        height: 400
//                                                        modal: true
//                                                        focus: true
//                                                        topPadding: 0.1
//                                                        leftPadding: 0.1
//                                                        rightPadding: 0.1
//                                                        bottomPadding: 0.1

//                                                        TextArea{
//                                                            readOnly: true
//                                                            width: parent.width
//                                                            height: parent.height
//                                                            textFormat: Text.RichText
//                                                            text: infoSelection
//                                                            font.family: "Helvetica"
//                                                            font.pointSize: 9
//                                                        }

//                                                        closePolicy:Popup.CloseOnReleaseOutside| Popup.CloseOnReleaseOutsideParent |Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
//                                               }
//                                                onClicked: {
//                                                    console.log("You chose: ")

//                                                    popupSelection.open()
//                                                }
//                                            }

//                                        }

//                                        TextField {
//                                            id: selectionParameterTournamentWithoutReplacement
//                                            text: "8"
//                                            validator: RegExpValidator {
//                                                regExp: /^[1-9]\d+/
//                                            }
//                                            visible: true
//                                        }

//                                        TextField {
//                                            id: selectionParameter
//                                            width: 39
//                                            height: 31
//                                            text: "0"
//                                            visible: false
//                                        }

//                                        TextField {
//                                            id: selectParameterRanking2
//                                            width: 45
//                                            height: 31
//                                            text: "0"
//                                            visible: false
//                                        }

//                                        TextField {
//                                            id: selectParameterRanking1
//                                            width: 45
//                                            height: 31
//                                            text: "0"
//                                            visible: false
//                                        }

//                                        ComboBox {
//                                            id: comboSelectinParameterSequential
//                                            model: ListModel {
//                                                id: comboSelectinParameterSequentialList
//                                                ListElement {
//                                                    text: "ordered"
//                                                }

//                                                ListElement {
//                                                    text: "unorder"
//                                                }
//                                            }
//                                            visible: false
//                                            currentIndex: 1
//                                        }
//                                        columns: 5
//                                        rows: 1
//                                        columnSpacing: 20
//                                    }
//                                }

                                Rectangle {
                                    id: rectangle8
                                    x: 0
                                    y: -399
                                    width: 455
                                    height: 37
                                    //color: "#ffffff"
                                    color:"#f2f2f2"
                                    //border.width: 1

                                    Label {
                                        id: labelSelection
                                        x: 0
                                        y: 15
                                        text: qsTr("Selection")
                                        scale: 1
                                        transformOrigin: Item.Center
                                    }



                                    ComboBox {
                                        id: comboSelection
                                        x: 68
                                        y: 12
                                        currentIndex: 3
                                        function show( currentIndex){

                                            if(currentIndex === 0  ){
                                                labelstochpar1.visible = true;
                                                parameter1.text = "0.55"
                                            }else
                                            {
                                                labelstochpar1.visible = false;
                                            }

                                            if(currentIndex === 1  ){
                                                labeldetpar1.visible = true;
                                                parameter1.text = "3"
                                            }else
                                            {
                                                labeldetpar1.visible = false;
                                            }


                                            if(currentIndex ===2){
                                                labelrankpar1.visible = true;
                                                labelrankpar2.visible = true;
                                                parameter1.text = "1.1"
                                                parameter2.text = "1.0"
                                            }else
                                            {
                                                labelrankpar1.visible = false;
                                                labelrankpar2.visible = false;
                                            }

                                            if(currentIndex === 0  || currentIndex === 1){
                                                parameter1.visible = true;
                                                parameter2.visible = false;
                                            }else{
                                                if(currentIndex === 2){
                                                    parameter1.visible = true;
                                                    parameter2.visible = true;
                                                }else
                                                    if(currentIndex === 3)
                                                    {
                                                        parameter1.visible = false;
                                                        parameter2.visible = false;
                                                    }
                                            }


                                        }

                                        model: ListModel {
                                            id: selections
                                            ListElement { text: "StochTour(t)";  }
                                            ListElement { text: "DetTour(T)";  }
                                            ListElement { text: "Ranking(p,e)";  }
                                            ListElement { text: "Roulette"; }
                                        }
                                        onCurrentIndexChanged: show(currentIndex)
                                    }


                                    Label {
                                        id: labelrankpar1
                                        x: 214
                                        y: 15
                                        visible: false
                                        text: "p (selective pressure 1 < p <= 2)"
                                    }
                                    Label {
                                        id: labelrankpar2
                                        x: 465
                                        y: 15
                                        visible: false
                                        text: "e (exponent 1=linear)"
                                    }

                                    Label {
                                        id: labelstochpar1
                                        x: 215
                                        y: 15
                                        visible: false
                                        text: "Tr (tournament rate 0.55 <= Tr <= 1)"
                                    }

                                    Label {
                                        id: labeldetpar1
                                        x: 215
                                        y: 15
                                        visible: false
                                        text: "Ts (tournament size 2 <= Ts <=N)"
                                    }

                                    TextField {
                                        id: parameter1
                                        x: 411
                                        y: 14
                                        width: 31
                                        height: 16
                                        visible: false
                                        text: "0"
                                    }
                                    TextField {
                                        id: parameter2
                                        x: 586
                                        y: 14
                                        width: 38
                                        height: 15
                                        visible: false
                                        text: "0"
                                    }
                                    //                TextField {
                                    //                    id: selectParameterRanking2
                                    //                    width: 31
                                    //                    height: 31
                                    //                    text: "0"
                                    //                    visible: false
                                    //                }

                                    //                TextField {
                                    //                    id: selectParameterRanking1
                                    //                    width: 31
                                    //                    height: 31
                                    //                    text: "0"
                                    //                    visible: false
                                    //                }



                                    //border.color: "#110000"
                                }

                                RowLayout {
                                    x: 0
                                    y: -356

                                    Label {
                                        id: label12
                                        x: 15
                                        y: 72
                                        text: qsTr("Replacement")
                                    }

                                    ComboBox {
                                        id: comboReplacament

                                        x: 130
                                        y: 68
                                        width: 138
                                        height: 18
                                        activeFocusOnPress: true

                                        function show( currentIndex){

                                            if(currentIndex === 1 ){
                                                replacementParameter.visible=true;
                                                labelselectionParameterTournamentWithoutReplacement.visible=true;
                                            }else{
                                                replacementParameter.visible=false;
                                                labelselectionParameterTournamentWithoutReplacement.visible=false;
                                            }

                                        }

                                        model: ListModel {
                                            id: patterns1
                                            ListElement {
                                                text: "generational"
                                            }

                                            ListElement {
                                                text: "elitist/steady state"
                                            }
                                        }
                                        currentIndex: 0
                                        onCurrentIndexChanged:show(currentIndex)
                                    }



                                    Label {
                                        id: labelselectionParameterTournamentWithoutReplacement

                                        visible: false
                                        text: "number of elitists"
                                    }
                                    TextField {
                                        id: replacementParameter

                                        width: 39
                                        height: 16
                                        visible: false
                                        text: "2"
                                    }


                                }


                                Rectangle {
                                    x: 0
                                    y: -331

                                    Layout.preferredWidth: 309
                                    Layout.preferredHeight: 50
                                    width: 650
                                    height: 157







                                    Label {
                                        id: labelPopulationSize
                                        x: 6
                                        y: 0
                                        text: qsTr("Population Size")
                                    }

                                    TextField {
                                        id: textFieldPopulationSize
                                        x: 153
                                        y: 0
                                        width: 63
                                        height: 17
                                        text: "20"
                                        placeholderText: qsTr("Population Size")
                                        validator: RegExpValidator {
                                            regExp: /^[1-9]\d+/
                                        }
                                    }



//                                    Label {
//                                        id: labelProbabiltySelection
//                                        text: qsTr("Probabilty Selection")
//                                    }

//                                    TextField {
//                                        id: textFieldProbabiltySelection
//                                        width: 63
//                                        text: "0.35"
//                                        placeholderText: qsTr("Probabilty Selection")
//                                        validator:  RegExpValidator { regExp: /0[.]\d{1,3}/ }
//                                    }


                                    Label {
                                        id: labelProbabiltyCrossOver
                                        x: 6
                                        y: 74
                                        text: qsTr("Probabilty CrossOver")
                                    }

                                    TextField {
                                        id: textFieldProbabiltyCrossOver
                                        x: 153
                                        y: 70
                                        width: 63
                                        height: 17
                                        text: "0.65"
                                        placeholderText: qsTr("Probabilty CrossOver")
                                        validator:  RegExpValidator { regExp: /0[.]\d{1,3}/ }
                                    }

                                    Label {
                                        id: labelProbabiltyMutation
                                        x: 6
                                        y: 49
                                        text: qsTr("Probabilty Mutation")
                                    }

                                    TextField {
                                        id: textFieldProbabiltyMutation
                                        x: 153
                                        y: 47
                                        width: 63
                                        height: 17
                                        text: "0.35"
                                        placeholderText: qsTr("Probabilty Mutation")
                                        validator:  RegExpValidator { regExp: /0[.]\d{1,3}/ }
                                    }

                                    Label {
                                        id: labelNumberProcessor
                                        x: 6
                                        y: 25
                                        text: qsTr("Number of processor")
                                    }
                                    TextField {
                                        id: textFieldNumberProcessor
                                        x: 153
                                        y: 23
                                        width: 63
                                        height: 17
                                        text: "4"
                                        validator: RegExpValidator { regExp: /^[1-9]\d+/ }
                                        placeholderText: qsTr("")
                                    }


                                    Label {
                                        id: labelMaxGeneration
                                        x: 6
                                        y: 97
                                        text: qsTr("Max Number of Generation")
                                        transformOrigin: Item.Center
                                    }

                                    TextField {
                                        id: textFieldMaxGeneration
                                        x: 153
                                        y: 95
                                        width: 63
                                        height: 17
                                        text: "1000000"
                                        placeholderText: "Max Number of Generation"
                                        validator: RegExpValidator {
                                            regExp: /^[1-9]\d+/
                                        }
                                    }

                                    Label {
                                        id: labelPercentageWeight
                                        x: 6
                                        y: 121
                                        width: 20
                                        height: 14
                                        text: qsTr("N")
                                        transformOrigin: Item.Center
                                    }
                                    TextField {
                                        id: textPercentageN
                                        x: 153
                                        y: 119
                                        width: 63
                                        height: 17
                                        text: "0"
                                        //text: "30"
                                        //inputMethodHints: Qt.ImhDigitsOnly
                                        validator:  RegExpValidator { regExp: /0[.]\d{1,3}|^[1-9]\d+/ }
                                        placeholderText: "N"
                                        onTextChanged: {
                                            if(text >0 && pathrain != ""){
                                                if(checkUseControlPointsWithN.checked){
                                                    customPlotKernelRegression1.customPlotRegressionSubdivideFromControlPoints(textPercentageN.text)
                                                }
                                                else{
                                                    customPlotKernelRegression1.customPlotRegressionSubdivideFromKernel(textPercentageN.text)
                                                }
                                            }
                                        }
                                    }
//                                    Image {
//                                        source: "qrc:/img/info.jpg"

//                                        width: 20
//                                        height: 20
//                                        Layout.preferredWidth: 20
//                                        Layout.preferredHeight: 20
//                                        MouseArea {
//                                            anchors.fill: parent
//                                            Popup {
//                                                    id: popupN
//                                                    width: 200
//                                                    height: 300
//                                                    modal: true
//                                                    focus: true
//                                                    topPadding: 0.1
//                                                    leftPadding: 0.1
//                                                    rightPadding: 0.1
//                                                    bottomPadding: 0.1

//                                                    TextArea{
//                                                        readOnly: true
//                                                        width: parent.width
//                                                        height: parent.height
//                                                        text: infoN
//                                                        font.family: "Helvetica"
//                                                        font.pointSize: 9
//                                                    }

//                                                    closePolicy:Popup.CloseOnReleaseOutside| Popup.CloseOnReleaseOutsideParent |Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
//                                           }
//                                            onClicked: {
//                                                console.log("You chose: ")

//                                                popupN.open()
//                                            }
//                                        }

//                                    }

                                    CheckBox {
                                        id:checkUseControlPointsWithN;
                                        x: 6
                                        y: 139
                                        text: qsTr("Use Control Points")
                                        onCheckedChanged: {
                                            if(textPercentageN.text >0 && pathrain != ""){
                                                if(checkUseControlPointsWithN.checked){
                                                    customPlotKernelRegression1.customPlotRegressionSubdivideFromControlPoints(textPercentageN.text)
                                                }
                                                else{
                                                    customPlotKernelRegression1.customPlotRegressionSubdivideFromKernel(textPercentageN.text)
                                                }
                                            }
                                        }
                                    }




                                }







                        ColumnLayout {
                            id: columnLayout3
                            x: 0
                            y: -168
                            width: 500
                            height: 100
                            Layout.fillWidth: false
                            scale: 1
                            spacing: 2
                            Layout.minimumHeight: height
                            Layout.minimumWidth: width
                            Layout.fillHeight: false
                            visible: true

                            RowLayout {
                                id: rowLayout2
                                width: 100
                                height: 50
                                visible: true
                                spacing: 2

                                Label {
                                    id: labelGammaFunctions
                                    width: 211
                                    text: qsTr("Number of gamma functions with alfa < 1")
                                    transformOrigin: Item.Center




                                }

                                TextField {
                                    id: textFieldGammaFunctions

                                    function showLabel(text){

                                        if(text >= 0 && text !== ""){
                                            if(text > tableModel.count){
//                                                console.log("text > tableModel.count  " + text + " > " + tableModel.count);
                                                for(var i = 0;i< tableModel.count;i++){
//                                                    console.log("elimino = " + i);
                                                    tableModel.set(i,{ nFunction:i+1,
                                                                       amax: tableModel.get(i).amax,
                                                                       amin: tableModel.get(i).amin,
                                                                       bmax: tableModel.get(i).bmax,
                                                                       bmin: tableModel.get(i).bmin,
                                                                       wmax: tableModel.get(i).wmax,
                                                                       wmin: tableModel.get(i).wmin,
                                                                       pa: tableModel.get(i).pa,
                                                                       pb: tableModel.get(i).pb,
                                                                       pw: tableModel.get(i).pw,
                                                                       tmin: tableModel.get(i).tmin,
                                                                       tmax: tableModel.get(i).tmax,
                                                                       tp: tableModel.get(i).tp})
                                                }
                                                for(var i = tableModel.count;i< text;i++){
//                                                    console.log("elimino2 = " + i);
                                                    tableModel.set(i,{nFunction:i+1,
                                                                       amax: "0.8",
                                                                       amin: "0.2",
                                                                       bmax: "50",
                                                                       bmin: "5",
                                                                       wmax: "2",
                                                                       wmin: "0.02",
                                                                       pa: "0.03",
                                                                       pb: "0.03",
                                                                       pw: "0.03",
                                                                       tmin: "2",
                                                                       tmax: "0",
                                                                       tp: "0.01"})
                                                }
                                            }
                                            else
                                                if(text < tableModel.count){
                                                    for(var i = 0;i < text;i++){
                                                        tableModel.set(i,{ nFunction:i+1,
                                                                           amax: tableModel.get(i).amax,
                                                                           amin: tableModel.get(i).amin,
                                                                           bmax: tableModel.get(i).bmax,
                                                                           bmin: tableModel.get(i).bmin,
                                                                           wmax: tableModel.get(i).wmax,
                                                                           wmin: tableModel.get(i).wmin,
                                                                           pa: tableModel.get(i).pa,
                                                                           pb: tableModel.get(i).pb,
                                                                           pw: tableModel.get(i).pw,
                                                                           tmin: tableModel.get(i).tmin,
                                                                           tmax: tableModel.get(i).tmax,
                                                                           tp: tableModel.get(i).tp})
                                                    }
                                                    var tmp = tableModel.count;
                                                    for(var i = text;i < tmp;i++){
                                                        tableModel.remove(text);
                                                    }


                                                }
                                        }

                                    }
                                    function showLabelFirstTime(text){
//                                        console.log( "AAAAAAAAAAA typeProject " +typeProject)
                                        if(typeProject === 0){
                                        for(var i = 0;i< text;i++){
                                            tableModel.append({ nFunction:i+1,
                                                                  amax: "0.8",
                                                                  amin: "0.2",
                                                                  bmax: "50",
                                                                  bmin: "5",
                                                                  wmax: "2",
                                                                  wmin: "0.02",
                                                                  pa: "0.03",
                                                                  pb: "0.03",
                                                                  pw: "0.03",
                                                                  tmin: "0",
                                                                  tmax: "0",
                                                                  tp: "0"})
                                        }
                                        textFieldGammaFunctions.text="1"
                                        }
                                    }


                                    width: 63
                                    //text: showLabelFirstTime()
                                    //                                text: showLabelFirstTime(1)
                                    placeholderText: "Number of gamma functions"
                                    validator: RegExpValidator {
                                        regExp: /^[0-9]\d+/
                                    }
                                    //                                editingFinished: console.log("CIAO")
                                    onTextChanged: showLabel(text)



                                }


                            }

                            ListModel {
                                id: tableModel
                                dynamicRoles: true
                                //                    ListElement {
                                //                        amax: ""
                                //                        amin: ""
                                //                        bmax: ""
                                //                        bmin: ""
                                //                        wmax: ""
                                //                        wmin: ""
                                //                        pa: ""
                                //                        pb: ""
                                //                        pw: ""
                                //                    }
                            }


                            TableView {
                                id: tableView1
                                width: 672
                                height: 53
                                visible: true
                                Layout.fillWidth: false
                                selectionMode: 0
                                Layout.minimumWidth:  width
                                Layout.fillHeight: false

                                TableViewColumn {
                                    width: 20
                                    movable: false
                                    title: "N."
                                    role: "nFunction"
                                    delegate: Text {
                                        text: model.nFunction
                                    }
                                }

                                TableViewColumn {

                                    width: 50
                                    movable: false
                                    title: "α max"
                                    role: "amax"
                                    delegate: TextField {
                                        text: model.amax
                                        validator:  RegExpValidator { regExp:  /0[.]\d{1,3}|1/}
                                        onTextChanged: {
                                            if (tableModel.get(styleData.row).amax !== text)
                                            tableModel.get(styleData.row).amax = text
                                            if(parseFloat(tableModel.get(styleData.row).amin) > parseFloat(tableModel.get(styleData.row).amax)){
                                                tableModel.get(styleData.row).amin=0;
                                            }
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "α min"
                                    role: "amin"
                                    delegate: TextField {
                                        //validator:
                                        text: model.amin
                                        validator:  RegExpValidator { regExp:  /0[.]\d{1,3}|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).amin !== text)
                                            tableModel.get(styleData.row).amin = text
                                            if(parseFloat(tableModel.get(styleData.row).amax) < parseFloat(tableModel.get(styleData.row).amin)){
                                                tableModel.get(styleData.row).amax=1;
                                            }
                                        }
                                    }
                                    resizable: false

                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "β max"
                                    role: "bmax"
                                    delegate: TextField {
                                        text: model.bmax

                                        validator:  RegExpValidator { regExp:  /^([0123][0-9][0-9]|400)$/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).bmax !== text)
                                            tableModel.get(styleData.row).bmax = text
                                            if( parseFloat(tableModel.get(styleData.row).bmin) > parseFloat(tableModel.get(styleData.row).bmax)){

                                                tableModel.get(styleData.row).bmin=0;
                                            }
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "β min"
                                    role: "bmin"
                                    delegate: TextField {
                                        text: model.bmin
                                        validator:  RegExpValidator { regExp:  /^([0123][0-9][0-9]|400)$/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).bmin !== text)
                                            tableModel.get(styleData.row).bmin = text
                                            if(parseFloat(tableModel.get(styleData.row).bmax) < parseFloat(tableModel.get(styleData.row).bmin)){
                                                tableModel.get(styleData.row).bmax=400;
                                            }
                                        }
                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 70
                                    movable: false
                                    title: "Weight max"
                                    role: "wmax"
                                    delegate: TextField {
                                        text: model.wmax
                                        validator:  RegExpValidator { regExp:  /^([0-9][0-9][0-9][0-9])$/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).wmax !== text)
                                            tableModel.get(styleData.row).wmax = text
                                            if(parseFloat(tableModel.get(styleData.row).wmin) > parseFloat(tableModel.get(styleData.row).wmax)){
                                                tableModel.get(styleData.row).wmin=0;
                                            }
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 70
                                    movable: false
                                    title: "Weight min"
                                    role: "wmin"
                                    delegate: TextField {
                                        text: model.wmin
                                        validator:  RegExpValidator { regExp:  /^([0-9][0-9][0-9][0-9])$/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).wmin !== text)
                                                tableModel.get(styleData.row).wmin = text
                                        }
                                    }
                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Percentage α"
                                    role: "pa"
                                    delegate: TextField {
                                        text: model.pa
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).pa !== text)
                                           tableModel.get(styleData.row).pa = text
                                        }

                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Percentage β"
                                    role: "pb"
                                    delegate: TextField {
                                        text: model.pb
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).pb !== text)
                                                   tableModel.get(styleData.row).pb = text
                                        }
                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 100
                                    movable: false
                                    title: "Percentage Weight "
                                    role: "pw"
                                    delegate: TextField {
                                        text: model.pw
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).pw !== text)
                                                   tableModel.get(styleData.row).pw = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Translation max"
                                    role: "tmax"
                                    delegate: TextField {
                                        text: model ? model.tmax : "0"
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).tmax !== text)
                                               tableModel.get(styleData.row).tmax = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Translation min"
                                    role: "tmin"
                                    delegate: TextField {
                                        text: model.tmin
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).tmin !== text)
                                            tableModel.get(styleData.row).tmin = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 100
                                    movable: false
                                    title: "Translation percentage"
                                    role: "tp"
                                    delegate: TextField {
                                       text: model ? model.tp : "0"
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel.get(styleData.row).tp !== text)
                                            tableModel.get(styleData.row).tp = text
                                        }

                                    }

                                    resizable: false
                                }

                                objectName: "tableView1"
                                model: tableModel
                                backgroundVisible: true
                                alternatingRowColors: false
                            }

                            RowLayout {
                                id: rowLayout3
                                width: 100
                                height: 50
                                visible: true
                                spacing: 15

                                Label {
                                    id: labelGammaFunctionsGreaterthan1
                                    width: 213
                                    text: qsTr("Number of gamma functions with alfa >= 1")
                                    transformOrigin: Item.Center




                                }

                                TextField {
                                    id: textFieldGammaFunctionsGreaterthan1

                                    function showLabel(text){

                                        if(text >= 0 && text !== ""){
                                            if(text > tableModel2.count){
                                                for(var i = 0;i< tableModel2.count;i++){
                                                    tableModel2.set(i,{ nFunction:i+1,
                                                                        amax: tableModel2.get(i).amax,
                                                                        amin: tableModel2.get(i).amin,
                                                                        bmax: tableModel2.get(i).bmax,
                                                                        bmin: tableModel2.get(i).bmin,
                                                                        wmax: tableModel2.get(i).wmax,
                                                                        wmin: tableModel2.get(i).wmin,
                                                                        pa: tableModel2.get(i).pa,
                                                                        pb: tableModel2.get(i).pb,
                                                                        pw: tableModel2.get(i).pw,
                                                                        tmin: tableModel2.get(i).tmin,
                                                                        tmax: tableModel2.get(i).tmax,
                                                                        tp: tableModel2.get(i).tp})
                                                }
                                                for(var i = tableModel2.count;i< text;i++){
                                                    tableModel2.set(i,{nFunction:i+1,
                                                                        bmax: "8",
                                                                        bmin: "1",
                                                                        amax: "200",
                                                                        amin: "20",
                                                                        wmax: "2",
                                                                        wmin: "0.02",
                                                                        pa: "0.03",
                                                                        pb: "0.03",
                                                                        pw: "0.03",
                                                                        tmin: "2",
                                                                        tmax: "0",
                                                                        tp: "0.01"
                                                                    })
                                                }
                                            }
                                            else
                                                if(text < tableModel2.count){
                                                    for(var i = 0;i< text;i++){
                                                        tableModel2.set(i,{ nFunction:i+1,
                                                                            amax: tableModel2.get(i).amax,
                                                                            amin: tableModel2.get(i).amin,
                                                                            bmax: tableModel2.get(i).bmax,
                                                                            bmin: tableModel2.get(i).bmin,
                                                                            wmax: tableModel2.get(i).wmax,
                                                                            wmin: tableModel2.get(i).wmin,
                                                                            pa: tableModel2.get(i).pa,
                                                                            pb: tableModel2.get(i).pb,
                                                                            pw: tableModel2.get(i).pw,
                                                                            tmin: tableModel2.get(i).tmin,
                                                                            tmax: tableModel2.get(i).tmax,
                                                                            tp: tableModel2.get(i).tp})
                                                    }
                                                    var tmp = tableModel2.count;
                                                    for(var i = text;i < tmp;i++){
                                                        tableModel2.remove(text);
                                                    }

                                                }
                                        }
                                    }

                                    function showLabelFirstTime(){
                                        if(typeProject === 0){
                                        textFieldGammaFunctionsGreaterthan1.text="3"
                                        tableModel2.clear()

                                        tableModel2.append({ nFunction:1,
                                                               bmax: "8",
                                                               bmin: "1",
                                                               amax: "200",
                                                               amin: "20",
                                                               wmax: "2",
                                                               wmin: "0.2",
                                                               pa: "0.03",
                                                               pb: "0.03",
                                                               pw: "0.03",
                                                               tmin: "0",
                                                               tmax: "0",
                                                               tp: "0"})
                                        tableModel2.append({ nFunction:2,
                                                               bmax: "80",
                                                               bmin: "20",
                                                               amax: "30",
                                                               amin: "2",
                                                               wmax: "2",
                                                               wmin: "0.2",
                                                               pa: "0.03",
                                                               pb: "0.03",
                                                               pw: "0.03",
                                                               tmin: "0",
                                                               tmax: "0",
                                                               tp: "0"})
                                        tableModel2.append({ nFunction:3,
                                                               bmax: "350",
                                                               bmin: "150",
                                                               amax: "7",
                                                               amin: "2",
                                                               wmax: "2",
                                                               wmin: "0.2",
                                                               pa: "0.03",
                                                               pb: "0.03",
                                                               pw: "0.03",
                                                               tmin: "0",
                                                               tmax: "0",
                                                               tp: "0"})
                                        }


                                    }

                                    width: 63
                                    placeholderText: "Number of gamma functions"
                                    validator: RegExpValidator {
                                        regExp: /^[0-9]\d+/
                                    }
                                     //text: showLabelFirstTime()
                                    onTextChanged: showLabel(text)


                                }


                            }

                            ListModel {
                                id: tableModel2
                                dynamicRoles: true
                                //                    ListElement {
                                //                        amax: ""
                                //                        amin: ""
                                //                        bmax: ""
                                //                        bmin: ""
                                //                        wmax: ""
                                //                        wmin: ""
                                //                        pa: ""
                                //                        pb: ""
                                //                        pw: ""
                                //                    }
                            }

                            TableView {
                                id: tableView2
                                width: 672
                                height: 50
                                Layout.minimumWidth:  width
                                Layout.fillHeight: false

                                TableViewColumn {
                                    width: 20
                                    movable: false
                                    title: "N."
                                    role: "nFunction"
                                    delegate: Text {
                                        text: model.nFunction
                                    }
                                }




                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "β max"
                                    role: "bmax"
                                    delegate: TextField {
                                        text: model.bmax
                                        onTextChanged: {
                                            if (tableModel2.get(styleData.row).bmax !== text)
                                            tableModel2.get(styleData.row).bmax = text
                                            if( parseFloat(tableModel2.get(styleData.row).bmin) > parseFloat(tableModel2.get(styleData.row).bmax)){

                                                tableModel2.get(styleData.row).bmin=0;
                                            }
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "β min"
                                    role: "bmin"
                                    delegate: TextField {
                                        text: model.bmin
                                        onTextChanged: {
                                if (tableModel2.get(styleData.row).bmin !== text)
                                            tableModel2.get(styleData.row).bmin = text
                                            if(parseFloat(tableModel2.get(styleData.row).bmax) < parseFloat(tableModel2.get(styleData.row).bmin)){
                                                tableModel2.get(styleData.row).bmax=400;
                                            }
                                        }
                                    }
                                    resizable: false
                                }


                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "α max"
                                    role: "amax"
                                    delegate: TextField {
                                        id: textid
                                        text: model.amax


//                                        if( 0 < (tableModel2.get(styleData.row).bmax + tableModel2.get(styleData.row).bmin) &&
//                                        1 > (tableModel2.get(styleData.row).bmax + tableModel2.get(styleData.row).bmin))
                                        RegExpValidator {regExp:  /(^0[.]\d{1,3})|1/}

                                        onTextChanged: {
                                            if (tableModel2.get(styleData.row).amax !== text)
                                                tableModel2.get(styleData.row).amax = text;
                                        }

//


                                        }
                                    }



//                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "α min"
                                    role: "amin"
                                    delegate: TextField {
                                        text: model.amin
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).amin !== text)
                                            tableModel2.get(styleData.row).amin = text
                                        }
                                    }
                                    resizable: false

                                }
                                TableViewColumn {
                                    width: 70
                                    movable: false
                                    title: "Weight max"
                                    role: "wmax"
                                    delegate: TextField {
                                        text: model.wmax
                                        onTextChanged: {
                                            if (tableModel2.get(styleData.row).wmax !== text)
                                            tableModel2.get(styleData.row).wmax = text
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 70
                                    movable: false
                                    title: "Weight min"
                                    role: "wmin"
                                    delegate: TextField {
                                        text: model.wmin
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).wmin !== text)
                                            tableModel2.get(styleData.row).wmin = text
                                        }
                                    }
                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Percentage α"
                                    role: "pa"
                                    delegate: TextField {
                                        text: model.pa
                                        //validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).pa !== text)
                                            tableModel2.get(styleData.row).pa = text
                                        }


                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Percentage β"
                                    role: "pb"
                                    delegate: TextField {
                                        text: model.pb
                                        //validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).pb !== text)
                                            tableModel2.get(styleData.row).pb = text
                                        }
                                    }

                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 100
                                    movable: false
                                    title: "Percentage Weight "
                                    role: "pw"
                                    delegate: TextField {
                                        text: model.pw
                                        // validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).pw !== text)
                                            tableModel2.get(styleData.row).pw = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Translation max"
                                    role: "tmax"
                                    delegate: TextField {
                                        text: model.tmax
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).tmax !== text)
                                            tableModel2.get(styleData.row).tmax = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Translation min"
                                    role: "tmin"
                                    delegate: TextField {
                                        text: model.tmin
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).tmin !== text)
                                            tableModel2.get(styleData.row).tmin = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 100
                                    movable: false
                                    title: "Translation percentage"
                                    role: "tp"
                                    delegate: TextField {

                                        text: model.tp
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel2.get(styleData.row).tp !== text)
                                            tableModel2.get(styleData.row).tp = text
                                        }

                                    }

                                    resizable: false
                                }

                                objectName: "tableView1"
                                model: tableModel2
                                backgroundVisible: true
                                alternatingRowColors: false
                            }

                            RowLayout {
                                id: rowLayout4
                                width: 100
                                height: 50
                                visible: true
                                spacing: 15

                                Label {
                                    id: labelGammaFunctionsLinear
                                    text: qsTr("Number of linear function")
                                    transformOrigin: Item.Center




                                }

                                TextField {
                                    id: textFieldLinearFunction

                                    function showLabel(text){
                                        if(text >= 0 && text !== ""){
                                            if(text > tableModel3.count){
                                                for(var i = 0;i< tableModel3.count;i++){
                                                    tableModel3.set(i,{ nFunction:i+1,
                                                                        amax: tableModel3.get(i).amax,
                                                                        amin: tableModel3.get(i).amin,
                                                                        bmax: tableModel3.get(i).bmax,
                                                                        bmin: tableModel3.get(i).bmin,
                                                                        wmax: tableModel3.get(i).wmax,
                                                                        wmin: tableModel3.get(i).wmin,
                                                                        pa: tableModel3.get(i).pa,
                                                                        pb: tableModel3.get(i).pb,
                                                                        pw: tableModel3.get(i).pw,
                                                                        tmax: tableModel3.get(i).tmax,
                                                                        tmin: tableModel3.get(i).tmin,
                                                                        tp: tableModel3.get(i).tp})
                                                }
                                                for(var i = tableModel3.count;i< text;i++){
                                                    tableModel3.insert(i,{ nFunction:i+1,
                                                                           amax: "0.0005",
                                                                           amin: "-0.0005",
                                                                           bmax: "0.1",
                                                                           bmin: "0.003",
                                                                           wmax: "2",
                                                                           wmin: "0.2",
                                                                           pa: "0.03",
                                                                           pb: "0.03",
                                                                           pw: "0.03",
                                                                           tmax: "2",
                                                                           tmin: "0",
                                                                           tp: "0.01"})
                                                }
                                            }
                                            else
                                                if(text < tableModel3.count){
                                                    for(var i = 0;i< text;i++){
                                                        tableModel3.set(i,{ nFunction:i+1,
                                                                            amax: tableModel3.get(i).amax,
                                                                            amin: tableModel3.get(i).amin,
                                                                            bmax: tableModel3.get(i).bmax,
                                                                            bmin: tableModel3.get(i).bmin,
                                                                            wmax: tableModel3.get(i).wmax,
                                                                            wmin: tableModel3.get(i).wmin,
                                                                            pa: tableModel3.get(i).pa,
                                                                            pb: tableModel3.get(i).pb,
                                                                            pw: tableModel3.get(i).pw,
                                                                            tmax: tableModel3.get(i).tmax,
                                                                            tmin: tableModel3.get(i).tmin,
                                                                            tp: tableModel3.get(i).tp})
                                                    }
                                                    var tmp = tableModel3.count;
                                                    for(var i = text;i < tmp;i++){
                                                        tableModel3.remove(text);
                                                    }

                                                }
                                        }

                                    }

                                    function showLabelFirstTime(){
                                        if(typeProject === 0){
                                        textFieldLinearFunction.text="1"
                                        tableModel3.clear()
                                        tableModel3.append({ nFunction:1,
                                                               amax: "0.0005",
                                                               amin: "-0.0005",
                                                               bmax: "0.1",
                                                               bmin: "0.003",
                                                               wmax: "2",
                                                               wmin: "0.2",
                                                               pa: "0.03",
                                                               pb: "0.03",
                                                               pw: "0.03",
                                                               tmax: "0",
                                                               tmin: "0",
                                                               tp: "0"})
                                        }
                                    }
                                    width: 63
                                    placeholderText: "Number of gamma functions"
                                    validator: RegExpValidator {
                                        regExp: /^[0-9]\d+/
                                    }
                                    //text: showLabelFirstTime()
                                    onTextChanged: showLabel(text)


                                }


                            }

                            ListModel {
                                id: tableModel3
                                dynamicRoles: true
                            }

                            TableView {
                                id: tableView3
                                width: 672
                                height: 50
                                Layout.columnSpan: 2
                                Layout.rowSpan: 0
                                visible: true
                                Layout.fillWidth: false
                                Layout.minimumWidth:  width
                                Layout.fillHeight: false

                                TableViewColumn {
                                    width: 20
                                    movable: false
                                    title: "N."
                                    role: "nFunction"
                                    delegate: Text {
                                        text: model.nFunction
                                    }
                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "α max"
                                    role: "amax"
                                    delegate: TextField {
                                        text: model.amax
                                        onTextChanged: {
                                             if (tableModel3.get(styleData.row).amax !== text)
                                            tableModel3.get(styleData.row).amax = text
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "α min"
                                    role: "amin"
                                    delegate: TextField {
                                        text: model.amin
                                        onTextChanged: {
                                         if (tableModel3.get(styleData.row).amin !== text)
                                            tableModel3.get(styleData.row).amin = text
                                        }
                                    }
                                    resizable: false

                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "β max"
                                    role: "bmax"
                                    delegate: TextField {
                                        text: model.bmax
                                        onTextChanged: {
                                            if (tableModel3.get(styleData.row).bmax !== text)
                                            tableModel3.get(styleData.row).bmax = text
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 50
                                    movable: false
                                    title: "β min"
                                    role: "bmin"
                                    delegate: TextField {
                                        text: model.bmin
                                        onTextChanged: {
                                             if (tableModel3.get(styleData.row).bmin !== text)
                                            tableModel3.get(styleData.row).bmin = text
                                        }
                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 70
                                    movable: false
                                    title: "Weight max"
                                    role: "wmax"
                                    delegate: TextField {
                                        text: model.wmax
                                        onTextChanged: {
                                             if (tableModel3.get(styleData.row).wmax !== text)
                                            tableModel3.get(styleData.row).wmax = text
                                        }
                                    }
                                }

                                TableViewColumn {
                                    width: 70
                                    movable: false
                                    title: "Weight min"
                                    role: "wmin"
                                    delegate: TextField {
                                        text: model.wmin

                                        onTextChanged: {
                                             if (tableModel3.get(styleData.row).wmin !== text)
                                            tableModel3.get(styleData.row).wmin = text
                                        }

                                    }
                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Percentage α"
                                    role: "pa"
                                    delegate: TextField {
                                        text: model.pa
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                           if (tableModel3.get(styleData.row).pa !== text)
                                            tableModel3.get(styleData.row).pa = text
                                        }
                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Percentage β"
                                    role: "pb"
                                    delegate: TextField {
                                        text: model.pb
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                           if (tableModel3.get(styleData.row).pb !== text)
                                            tableModel3.get(styleData.row).pb = text
                                        }
                                    }
                                    resizable: false
                                }
                                TableViewColumn {
                                    width: 100
                                    movable: false
                                    title: "Percentage Weight "
                                    role: "pw"
                                    delegate: TextField {
                                        text: model.pw
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                           if (tableModel3.get(styleData.row).pw !== text)
                                            tableModel3.get(styleData.row).pw = text
                                        }
                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Translation max"
                                    role: "tmax"
                                    delegate: TextField {
                                        text: model.tmax
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                             if (tableModel3.get(styleData.row).tmax !== text)
                                              tableModel3.get(styleData.row).tmax = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 90
                                    movable: false
                                    title: "Translation min"
                                    role: "tmin"
                                    delegate: TextField {
                                        text: model.tmin
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                           if (tableModel3.get(styleData.row).tmin !== text)
                                            tableModel3.get(styleData.row).tmin = text
                                        }

                                    }

                                    resizable: false
                                }

                                TableViewColumn {
                                    width: 100
                                    movable: false
                                    title: "Translation percentage"
                                    role: "tp"
                                    delegate: TextField {
                                        text: model.tp
                                        validator:  RegExpValidator { regExp:  /(^0[.]\d{1,3})|1/}
                                        onTextChanged: {
                                          if (tableModel3.get(styleData.row).tp !== text)
                                            tableModel3.get(styleData.row).tp = text
                                        }

                                    }

                                    resizable: false
                                }

                                objectName: "tableView1"
                                model: tableModel3
                                backgroundVisible: true
                                alternatingRowColors: false
                            }


                        }

                        GridLayout {
                            id: gridLayout3
                            x: 0
                            y: 356
                            width: 309
                            height: 35
                            columnSpacing: 2
                            rowSpacing: 1
                            columns: 2
                            rows: 1

                            Layout.preferredWidth: 309
                            Layout.preferredHeight: 50



                            FileDialog {
                                id: fileDialogRain
                                title: "Please choose a file"
                                folder: shortcuts.home
                                property string  tmp
                                property variant split
                                onAccepted: {
                                    pathrain=fileDialogRain.fileUrl
                                    tmp = fileDialogRain.fileUrl
                                    split = tmp.split("/")
                                    textfileRain.text = "../"+split[split.length-1]
                                    customPlotKernelRegression1.initCustomPlotRegressionPreviewKernel(fileDialogRain.fileUrl)
                                    customPlotKernelRegression1.initCustomPlotKernelComtrolPoints(textPercentageN.text)
                                    //handlerCSV.loadCSV(fileDialogRain.fileUrl)
                                    //Qt.quit()








                                }
                                onRejected: {
                                    console.log("Canceled")
                                    //Qt.quit()
                                }
                                nameFilters: [ "files (*.csv)" ]
                                Component.onCompleted: visible = false
                            }


                            Button {
                                id: button1
                                text: qsTr("Load Kernel")
                                onClicked: {
                                    fileDialogRain.open()

                                }
                            }

                            Text {
                                id: textfileRain
                                width: 147
                                height: 31
                                text: qsTr("Empty")
                                font.pixelSize: 12
                            }
                        }

                        GridLayout{
                            x: 0
                            y: 396
                            columnSpacing: 100
                            columns: 3
                            rows: 1

                            CheckBox {
                                id: checkControlPoints
                                text: qsTr("Use Control Points(Default) ")
                                checked: true
                                onCheckedChanged: {
                                    if(checkControlPoints.checked)
                                    {
                                        checkKernel.checked = false;
                                        checkN.checked = false;
                                    }else
                                        if(checkN.checked === false && checkKernel.checked === false){
                                            checkControlPoints.checked=true;
                                        }
                                }

                            }
                            CheckBox {
                                id: checkKernel
                                text: qsTr("Use Kernel")
                                onCheckedChanged: {
                                    if(checkKernel.checked)
                                    {
                                        checkControlPoints.checked = false;
                                        checkN.checked = false;
                                    }else
                                        if(checkN.checked === false && checkKernel.checked === false){
                                            checkControlPoints.checked=true;
                                        }
                                }

                            }
                            CheckBox {
                                id: checkN
                                text: qsTr("Use N")
                                onCheckedChanged: {
                                    if(checkN.checked)
                                    {
                                        checkControlPoints.checked = false;
                                        checkKernel.checked = false;
                                    }else
                                        if(checkKernel.checked === false && checkN.checked === false){
                                            checkControlPoints.checked=true;
                                        }
                                }

                            }

                        }






                    }

                    GridLayout {
                        id: gridLayout4
                        width: 100
                        height: 100
                        rowSpacing: 0
                        columnSpacing: 0
                        columns: 1
                        rows: 1


                        CustomPlotRegressionPreviewKernel {
                            id: customPlotKernelRegression1
                            width: 798
                            height: 886
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            Layout.preferredWidth: 700
                            Layout.preferredHeight: 200
                            Layout.maximumWidth:  1000000
                            Layout.maximumHeight: 1000000
                            //objectName:  'customPlotKernelRegression'
                            //anchors.top: customPlot1.bottom
                            Component.onCompleted: initCustomPlotRegressionPreviewKernel()

                        }
                        //                    CustomPlotRegressionPreviewKernel {
                        //                        id: customPlotKernelRegression2
                        //                        Layout.fillWidth: true
                        //                        Layout.fillHeight: true

                        //                        Layout.preferredWidth: 700
                        //                        Layout.preferredHeight: 200
                        //                        Layout.maximumWidth:  1000000
                        //                        Layout.maximumHeight: 1000000
                        //                        //objectName:  'customPlotKernelRegression'
                        //                        //anchors.top: customPlot1.bottom
                        //                        Component.onCompleted: initCustomPlotRegressionPreviewKernel()

                        //                    }

                    }
                }

                RowLayout {
                    id: columnLayout1
                    width: 328
                    height: 96
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    spacing: 2

                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 30

                    Button {
                        id: start
                        objectName: "namestart"



                        signal qmlSignal(var var1,var var1,var var2,var var3,var var4,var var5,
                                         var var6,var var7,var var8,var var9,var var10,var var11,
                                         var var12,var var13,var var14)
                        text: qsTr("Start")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        checkable: false
                        property  string selection;
                        property  string elitist;
                        property  string populationSize;
                        property  string percentageCrossover;
                        property  string percentageMutation;
                        property  string percentageWeight;
                        property  string numberProcessor;
                        property  string numberGamma;
                        property  string percentageGammaA;
                        property  string percentageGammaB;
                        property  string numberLinear;
                        property  string percentageLinearA;
                        property  string percentageLinearB;
                        property  string maxGeneration;
                        property  string fileUrl;

                        property  int typeReplacement;
                        property  string para1;
                        property  string para2;

                        onClicked: {

                            if(typeProject===0)
                            {
                                projectName = textProjectName.text;
                            }
                            console.log("projectName = "+projectName)
                            console.log("projectName = "+projectName)
                            populationSize = textFieldPopulationSize.text;
                            percentageCrossover = textFieldProbabiltyCrossOver.text;
                            percentageMutation = textFieldProbabiltyMutation.text;
                            numberProcessor = textFieldNumberProcessor.text;
                            numberGamma = textFieldGammaFunctions.text;
                            numberLinear = textFieldLinearFunction.text;
                            maxGeneration = textFieldMaxGeneration.text;
                            selection =  comboSelection.currentText;
                            console.log("selection = "+selection)
                            elitist =  replacementParameter.text;
                            typeReplacement = 4;
                            fileUrl = pathrain;

                            if(comboSelection.currentText == "StochTour(t)"
                                    || comboSelection.currentText == "DetTour(T)"){
                                para1=parameter1.text;
                                para2=-1;
                            }else
                                if(comboSelection.currentText == "Ranking(p,e)"){
                                    para1=parameter1.text;
                                    para2=parameter2.text;
                                }else
                                    if(comboSelection.currentText == "Roulette"){
                                        para1=-1;
                                        para2=-1;
                                    }

                            if(comboReplacament.currentText == "generational"){
                                typeReplacement=0;

                            }else
                                if(comboReplacament.currentText == "elitist/steady state"){
                                    typeReplacement=1;
                                }
                            //                        console.log("populationSize : "+populationSize +
                            //                                    "\n percentageCrossover : "+percentageCrossover+
                            //                                    "\n percentageMutation : "+percentageMutation+
                            //                                    "\n numberProcessor : "+numberProcessor+
                            //                                    "\n numberGamma : "+numberGamma+
                            //                                    "\n numberLinear : "+numberLinear+
                            //                                    "\n maxGeneration : "+maxGeneration+
                            //                                    "\n selection : "+selection+
                            //                                    "\n elitist : "+selectionElitist+
                            //                                    "\n fileUrl : "+fileUrl
                            //                                    )

                            var numberArguments = 9;
                            var matrixGamma1 = new Array(tableModel.count+1);
                            for (var i = 0; i < tableModel.count+1; i++) {
                                matrixGamma1[i] = new Array(numberArguments);
                            }
                            matrixGamma1[0][0]=tableModel.count;
                            for(var i = 0; i < tableModel.count; i++){
                                var tmp = tableModel.get(i);
                                matrixGamma1[i+1][0]=tmp.amax
                                matrixGamma1[i+1][1]=tmp.amin
                                matrixGamma1[i+1][2]=tmp.bmax
                                matrixGamma1[i+1][3]=tmp.bmin
                                matrixGamma1[i+1][4]=tmp.wmax
                                matrixGamma1[i+1][5]=tmp.wmin
                                matrixGamma1[i+1][6]=tmp.pa
                                matrixGamma1[i+1][7]=tmp.pb
                                matrixGamma1[i+1][8]=tmp.pw
                                matrixGamma1[i+1][9]=tmp.tmax
                                matrixGamma1[i+1][10]=tmp.tmin
                                matrixGamma1[i+1][11]=tmp.tp
                                //                            console.log(tmp.amax +" "+ tmp.amin +" "+ tmp.bmax+ " "+ tmp.bmin+" "+tmp.wmax+
                                //                                        " "+ tmp.wmin + " " + tmp.pa + " "+ tmp.pb+ " "+ tmp.pw);
                            }

                            var matrixGamma2 = new Array(tableModel2.count+1);
                            for (var i = 0; i < tableModel2.count+1; i++) {
                                matrixGamma2[i] = new Array(numberArguments);
                            }
                            matrixGamma2[0][0]=tableModel2.count;
                            for(var i = 0; i < tableModel2.count; i++){
                                var tmp = tableModel2.get(i);
                                matrixGamma2[i+1][0]=tmp.amax
                                matrixGamma2[i+1][1]=tmp.amin
                                matrixGamma2[i+1][2]=tmp.bmax
                                matrixGamma2[i+1][3]=tmp.bmin
                                matrixGamma2[i+1][4]=tmp.wmax
                                matrixGamma2[i+1][5]=tmp.wmin
                                matrixGamma2[i+1][6]=tmp.pa
                                matrixGamma2[i+1][7]=tmp.pb
                                matrixGamma2[i+1][8]=tmp.pw
                                matrixGamma2[i+1][9]=tmp.tmax
                                matrixGamma2[i+1][10]=tmp.tmin
                                matrixGamma2[i+1][11]=tmp.tp
                                //                            console.log(tmp.amax +" "+ tmp.amin +" "+ tmp.bmax+ " "+ tmp.bmin+" "+tmp.wmax+
                                //                                        " "+ tmp.wmin + " " + tmp.pa + " "+ tmp.pb+ " "+ tmp.pw);
                            }

                            var matrixGamma3 = new Array(tableModel3.count+1);
                            for (var i = 0; i < tableModel3.count+1; i++) {
                                matrixGamma3[i] = new Array(numberArguments);
                            }
                            matrixGamma3[0][0]=tableModel3.count;
                            for(var i = 0; i < tableModel3.count; i++){
                                var tmp = tableModel3.get(i);
                                matrixGamma3[i+1][0]=tmp.amax
                                matrixGamma3[i+1][1]=tmp.amin
                                matrixGamma3[i+1][2]=tmp.bmax
                                matrixGamma3[i+1][3]=tmp.bmin
                                matrixGamma3[i+1][4]=tmp.wmax
                                matrixGamma3[i+1][5]=tmp.wmin
                                matrixGamma3[i+1][6]=tmp.pa
                                matrixGamma3[i+1][7]=tmp.pb
                                matrixGamma3[i+1][8]=tmp.pw
                                matrixGamma3[i+1][9]=tmp.tmax
                                matrixGamma3[i+1][10]=tmp.tmin
                                matrixGamma3[i+1][11]=tmp.tp
                                //                            console.log(tmp.amax +" "+ tmp.amin +" "+ tmp.bmax+ " "+ tmp.bmin+" "+tmp.wmax+
                                //                                        " "+ tmp.wmin + " " + tmp.pa + " "+ tmp.pb+ " "+ tmp.pw);
                            }
                            if(textProjectName.length ===0 && typeProject===0){
                                messageDialogProjectNameEmpty.open()
                            }else
                                if(textfileRain.text === "Empty"){

                                     messageDialogFileKernel.open()
                                }
                                else
                                     {
                            sakeStart.startRegression(
                                        projectName,
                                        selection  ,
                                        elitist  ,
                                        populationSize  ,
                                        percentageCrossover  ,
                                        percentageMutation  ,
                                        numberProcessor  ,
                                        maxGeneration,
                                        fileUrl,
                                        typeProject,
                                        matrixGamma1,
                                        matrixGamma2,
                                        matrixGamma3,
                                        checkControlPoints.checked,
                                        checkKernel.checked,
                                        checkN.checked,
                                        checkUseControlPointsWithN.checked,
                                        textPercentageN.text,
                                        para1,
                                        para2,
                                        typeReplacement,
                                        typeProject
                                        )
                            applicationWindow1.destroy()
                            }
                            //                        if(comboSelection.currentText == "StochTour(t)"
                            //                                || comboSelection.currentText == "DetTour(T)"){
                            //                            para1=selectionParameter.text;
                            //                            para2=-1;
                            //                        }else
                            //                            if(comboSelection.currentText == "Ranking(p,e)"){
                            //                                para1=selectParameterRanking1.text;
                            //                                para2=selectParameterRanking2.text;
                            //                            }else
                            //                                if(comboSelection.currentText == "Roulette"){
                            //                                    para1=-1;
                            //                                    para2=-1;
                            //                                }else
                            //                                    if(comboSelection.currentText == "Sequential(ordered/unordered)")
                            //                                    {
                            //                                        para1=comboSelectinParameterSequentialList.get(comboSelectinParameterSequential.currentIndex).text;
                            //                                        para2=-1;
                            //                                    }else
                            //                                        if(comboSelection.currentText == "Generational"){
                            //                                            para1=selectionParameterTournamentWithoutReplacement.text;
                            //                                            para2=-1;
                            //                                            typeAlgorithm=2;
                            //                                        }else
                            //                                            if(comboSelection.currentText == "MultiObjects Generational"){
                            //                                                para1=selectionParameterTournamentWithoutReplacement.text;
                            //                                                para2=-1;
                            //                                                typeAlgorithm=3;
                            //                                                order1=selectionsOrder.get(selectionsOrder.currentIndex).text
                            //                                                order2=selectionsOrder1.get(selectionsOrder1.currentIndex).text
                            //                                                order3=selectionsOrder2.get(selectionsOrder2.currentIndex).text
                            //                                                order4=selectionsOrder3.get(selectionsOrder3.currentIndex).text
                            //                                            }else
                            //                                                if(comboSelection.currentText == "Steady-State"){
                            //                                                    para1=selectionParameterTournamentWithoutReplacement.text;
                            //                                                    para2=-1;
                            //                                                    typeAlgorithm=0;
                            //                                                }else
                            //                                                    if(comboSelection.currentText == "MultiObjects Steady-State"){
                            //                                                        para1=selectionParameterTournamentWithoutReplacement.text;
                            //                                                        para2=-1;
                            //                                                        typeAlgorithm=1;
                            //                                                        order1=selectionsOrder.get(selectionsOrder.currentIndex).text
                            //                                                        order2=selectionsOrder1.get(selectionsOrder1.currentIndex).text
                            //                                                        order3=selectionsOrder2.get(selectionsOrder2.currentIndex).text
                            //                                                        order4=selectionsOrder3.get(selectionsOrder3.currentIndex).text
                            //                                                    }



                        }

                    }

                    Button {
                        id: cancel
                        objectName: "namecancel"
                        text: qsTr("Cancel")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        checkable: false
                        onClicked: applicationWindow1.destroy()

                    }
                }

            }


        }
    }

//    MessageDialog {
//        id: messageDialogRain
//        title: "Input error"
//        text: "Please enter rain csv path."
//        onAccepted: close()
//        Component.onCompleted: visible = false
//        modality: "ApplicationModal"
//    }

//    MessageDialog {
//        id: messageDialogActivation
//        title: "Input error"
//        text: "Please enter Activation csv path."
//        onAccepted: close()
//        Component.onCompleted: visible = false
//        modality: "ApplicationModal"
//    }


//    MessageDialog {
//        id: messageDialogProjectName
//        title: "Input error"
//        text: "The project name already exists."
//        onAccepted: close()
//        Component.onCompleted: visible = false
//        modality: "ApplicationModal"
//    }
//    MessageDialog {
//        id: messageDialogFileKernel
//        title: "Input error"
//        text: "Please enter Kernel csv path."
//        onAccepted: close()
//        Component.onCompleted: visible = false
//        modality: "ApplicationModal"
//    }

//    MessageDialog {
//        id: messageDialogProjectNameEmpty
//        title: "Input error"
//        text: "The project name is empty."
//        onAccepted: close()
//        Component.onCompleted: visible = false
//        modality: "ApplicationModal"
//    }

}
