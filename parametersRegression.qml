import QtQuick 2.3
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
    width: 1500
    height: 1000
    Layout.minimumHeight: height
    Layout.minimumWidth: width
    Component.onCompleted: {
        setX(Screen.width / 2 - width / 2);
        setY(Screen.height / 2 - height / 2);
    }

    function f(list){
        labelProjectNameFromFile.text=list[0]
        if(list[1]==="TournamentWithoutReplacement" || list[1]==="Generational"){
            comboSelection.currentIndex=0
            selectionParameterTournamentWithoutReplacement.text=list[2]
        }


        textFieldPopulationSize.text=list[4]
        textFieldProbabiltyCrossOver.text=list[5]
        textFieldProbabiltyMutation.text=list[6]
        textPercentageWeight.text=list[7]
        textFieldNumberProcessor.text=list[8]
        textFieldGammaFunctions.text=list[9]
        textFieldGammaA.text=list[10]
        textFieldGammaB.text=list[11]
        textFieldLinearFunction.text=list[12]
        textFieldLinearA.text=list[13]
        textFieldLinearB.text=list[14]
        textFieldMaxGeneration.text=list[15]

        var split = list[16].split("/")
        textfileRain.text = "../"+split[split.length-1]
        pathrain=list[16]


    }


    Rectangle{
        id: parameter
        color:"#f2f2f2"
        width: parent.width
        height: parent.height

        ColumnLayout {
            id: columnLayout5
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
                anchors.left: parent.left
                anchors.leftMargin: 7
                columns: 2

                ColumnLayout {
                    id: columnLayout2
                    spacing: 2


                    ColumnLayout{
                        spacing: 20
                        RowLayout {
                            id: rowLayout
                            spacing: 20

                            Label {
                                id: projectName
                                text: qsTr("Project Name")
                                Layout.alignment: Qt.AlignHCenter
                            }

                            TextField {
                                id: textFiledProjectName
                                placeholderText: qsTr("Text Field")
                            }
                        }

                    }
                    RowLayout {
                        id: rowLayout1
                        width: 630
                        height: 300
                        spacing: 1

                        GridLayout {
                            id: gridLayout1
                            width: 63
                            height: 350
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            rowSpacing: 19
                            columnSpacing: 2
                            scale: 1
                            transformOrigin: Item.Center
                            rows: 2
                            columns: 1

                            Layout.preferredWidth: 309
                            Layout.preferredHeight: 250

                            ColumnLayout {
                                id: columnLayout4
                                width: 100
                                height: 100

                                GridLayout {
                                    id: gridLayout5
                                    Label {
                                        id: labelSelection
                                        text: qsTr("Selection")
                                        scale: 1
                                        transformOrigin: Item.Center
                                    }

                                    ComboBox {
                                        id: comboSelection
                                        currentIndex: 0
                                        function show( currentIndex){
                                            //                                    if(currentIndex === 0 ||
                                            //                                       currentIndex === 1  ){
                                            //                                        selectionParameter.visible=true;
                                            //                                    }else
                                            //                                        selectionParameter.visible=false;

                                            //                                    if(currentIndex ===2){
                                            //                                        selectParameterRanking1.visible=true;
                                            //                                        selectParameterRanking2.visible=true;
                                            //                                    }else
                                            //                                    {
                                            //                                        selectParameterRanking1.visible=false;
                                            //                                        selectParameterRanking2.visible=false;

                                            //                                    }
                                            //                                    if(currentIndex ===4){
                                            //                                        comboSelectinParameterSequential.visible=true;
                                            //                                    }else{
                                            //                                        comboSelectinParameterSequential.visible=false;
                                            //                                    }

                                            if(currentIndex ===0 || currentIndex ===7 || currentIndex ===6 || currentIndex ===8){
                                                selectionParameterTournamentWithoutReplacement.visible=true;
                                            }else{
                                                selectionParameterTournamentWithoutReplacement.visible=false;
                                            }
                                            //                                    if(currentIndex ===6 || currentIndex ===8){
                                            //                                        gridLayout5.visible=true;
                                            //                                    }else{
                                            //                                        gridLayout5.visible=false;
                                            //                                    }
                                        }
                                        model: ListModel {
                                            id: selections
                                            ListElement {
                                                text: "Generational"
                                            }
                                        }
                                        onCurrentIndexChanged: show(currentIndex)
                                    }

                                    TextField {
                                        id: selectionParameterTournamentWithoutReplacement
                                        text: "8"
                                        validator: RegExpValidator {
                                            regExp: /^[1-9]\d+/
                                        }
                                        visible: true
                                    }

                                    TextField {
                                        id: selectionParameter
                                        width: 39
                                        height: 31
                                        text: "0"
                                        visible: false
                                    }

                                    TextField {
                                        id: selectParameterRanking2
                                        width: 45
                                        height: 31
                                        text: "0"
                                        visible: false
                                    }

                                    TextField {
                                        id: selectParameterRanking1
                                        width: 45
                                        height: 31
                                        text: "0"
                                        visible: false
                                    }

                                    ComboBox {
                                        id: comboSelectinParameterSequential
                                        model: ListModel {
                                            id: comboSelectinParameterSequentialList
                                            ListElement {
                                                text: "ordered"
                                            }

                                            ListElement {
                                                text: "unorder"
                                            }
                                        }
                                        visible: false
                                        currentIndex: 1
                                    }
                                    columns: 4
                                    rows: 1
                                    columnSpacing: 20
                                }
                            }

                            GridLayout{
                                rows: 4
                                columns: 2
                                rowSpacing: 8
                                columnSpacing: 3
                                Layout.preferredWidth: 309
                                Layout.preferredHeight: 50
                                width: 630
                                height: 150







                                Label {
                                    id: labelPopulationSize
                                    text: qsTr("Population Size")
                                }

                                TextField {
                                    id: textFieldPopulationSize
                                    width: 63
                                    text: "20"
                                    placeholderText: qsTr("Population Size")
                                    validator: RegExpValidator {
                                        regExp: /^[1-9]\d+/
                                    }
                                }

                                Label {
                                    id: labelProbabiltyCrossOver
                                    text: qsTr("Probabilty CrossOver")
                                }

                                TextField {
                                    id: textFieldProbabiltyCrossOver
                                    width: 63
                                    text: "0.65"
                                    placeholderText: qsTr("Probabilty CrossOver")
                                    validator:  RegExpValidator { regExp: /0[.]\d{1,3}/ }
                                }

                                Label {
                                    id: labelProbabiltyMutation
                                    text: qsTr("Probabilty Mutation")
                                }

                                TextField {
                                    id: textFieldProbabiltyMutation
                                    width: 63
                                    text: "0.35"
                                    placeholderText: qsTr("Probabilty Mutation")
                                    validator:  RegExpValidator { regExp: /0[.]\d{1,3}/ }
                                }




                                Label {
                                    id: labelNumberProcessor
                                    text: qsTr("Number of processor")
                                }
                                TextField {
                                    id: textFieldNumberProcessor
                                    width: 63
                                    text: "4"
                                    validator: RegExpValidator { regExp: /^[1-9]\d+/ }
                                    placeholderText: qsTr("")
                                }

                                Label {
                                    id: labelMaxGeneration
                                    text: qsTr("Max Number of Generation")
                                    transformOrigin: Item.Center
                                }

                                TextField {
                                    id: textFieldMaxGeneration
                                    width: 63
                                    text: "50000"
                                    placeholderText: "Max Number of Generation"
                                    validator: RegExpValidator {
                                        regExp: /^[1-9]\d+/
                                    }
                                }

                                Label {
                                    id: labelPercentageWeight
                                    text: qsTr("N")
                                    transformOrigin: Item.Center
                                }
                                TextField {
                                    id: textPercentageWeight
                                    width: 63
                                    text: "0.03"
                                    //text: "30"
                                    //inputMethodHints: Qt.ImhDigitsOnly
                                    validator:  RegExpValidator { regExp: /0[.]\d{1,3}|^[1-9]\d+/ }
                                    placeholderText: "Population Size"
                                }

                                CheckBox {id:lastGeneration; text: qsTr("Use Control Points")   }




                            }


                        }



                    }
                    ColumnLayout {
                        id: columnLayout3
                        width: 500
                        height: 100
                        Layout.minimumHeight: height
                        Layout.minimumWidth: width
                        Layout.fillHeight: true
                        visible: true

                        RowLayout {
                            id: rowLayout2
                            width: 100
                            height: 50
                            visible: true
                            spacing: 15

                            Label {
                                id: labelGammaFunctions
                                width: 211
                                text: qsTr("Number of gamma functions with alfa < 1")
                                transformOrigin: Item.Center




                            }

                            TextField {
                                id: textFieldGammaFunctions

                                function showLabel(text){
                                    if(text > 0){
                                        //console.log(tableModel.count)
                                        //tableModel.get(0).amax = "1"
                                        //tableModel.get(0).amin = "2"
                                        //tableModel.get(0).bmax = "3"
                                        //tableModel.get(0).bmin = "4"
                                        //tableModel.get(0).wmax = "5"
                                        //tableModel.get(0).wmin = "6"
                                        //tableModel.get(0).pa = "7"
                                        //tableModel.get(0).pb = "8"
                                        //tableModel.get(0).pw = "9"
                                        //console.log(tableModel.get(0).amin)
                                        tableModel.clear()
                                        for(var i = 0;i< text;i++){
                                            tableModel.append({nFunction: i+1})
                                        }


                                    }else
                                    {
                                        tableModel.clear()
                                    }
                                }

                                width: 63
                                text: "0"
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
                            height: 50
                            Layout.minimumWidth:  width
                            Layout.fillHeight: false

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "N."
                                role: "nFunction"
                                delegate: Text {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "α max"
                                role: "amax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "α min"
                                role: "amin"
                                delegate: TextField {
                                }
                                resizable: false

                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "β max"
                                role: "bmax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "β min"
                                role: "bmin"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 70
                                movable: false
                                title: "Weight max"
                                role: "wmax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 70
                                movable: false
                                title: "Weight min"
                                role: "wmin"
                                delegate: TextField {
                                }
                                resizable: false
                            }

                            TableViewColumn {
                                width: 90
                                movable: false
                                title: "Percentage α"
                                role: "pa"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 90
                                movable: false
                                title: "Percentage β"
                                role: "pb"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 100
                                movable: false
                                title: "Percentage Weight "
                                role: "Percentage Weight "
                                delegate: TextField {

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
                                    if(text > 0){


                                        //console.log(tableModel.count)
                                        //tableModel.get(0).amax = "1"
                                        //tableModel.get(0).amin = "2"
                                        //tableModel.get(0).bmax = "3"
                                        //tableModel.get(0).bmin = "4"
                                        //tableModel.get(0).wmax = "5"
                                        //tableModel.get(0).wmin = "6"
                                        //tableModel.get(0).pa = "7"
                                        //tableModel.get(0).pb = "8"
                                        //tableModel.get(0).pw = "9"
                                        //console.log(tableModel.get(0).amin)
                                        tableModel2.clear()
                                        for(var i = 0;i< text;i++){
                                            tableModel2.append({nFunction:i+1})
                                        }


                                    }else
                                    {
                                        tableModel2.clear()
                                    }
                                }

                                width: 63
                                text: "0"
                                placeholderText: "Number of gamma functions"
                                validator: RegExpValidator {
                                    regExp: /^[0-9]\d+/
                                }
                                //                                editingFinished: console.log("CIAO")
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
                                width: 50
                                movable: false
                                title: "N."
                                role: "nFunction"
                                delegate: Text {
                                }
                            }


                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "α max"
                                role: "amax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "α min"
                                role: "amin"
                                delegate: TextField {
                                }
                                resizable: false

                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "β max"
                                role: "bmax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "β min"
                                role: "bmin"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 70
                                movable: false
                                title: "Weight max"
                                role: "wmax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 70
                                movable: false
                                title: "Weight min"
                                role: "wmin"
                                delegate: TextField {
                                }
                                resizable: false
                            }

                            TableViewColumn {
                                width: 90
                                movable: false
                                title: "Percentage α"
                                role: "pa"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 90
                                movable: false
                                title: "Percentage β"
                                role: "pb"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 100
                                movable: false
                                title: "Percentage Weight "
                                role: "Percentage Weight "
                                delegate: TextField {

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
                                id: textFieldGammaFunctionsLinear

                                function showLabel(text){
                                    if(text > 0){

                                        //console.log(tableModel.count)
                                        //tableModel.get(0).amax = "1"
                                        //tableModel.get(0).amin = "2"
                                        //tableModel.get(0).bmax = "3"
                                        //tableModel.get(0).bmin = "4"
                                        //tableModel.get(0).wmax = "5"
                                        //tableModel.get(0).wmin = "6"
                                        //tableModel.get(0).pa = "7"
                                        //tableModel.get(0).pb = "8"
                                        //tableModel.get(0).pw = "9"
                                        //console.log(tableModel.get(0).amin)
                                        tableModel3.clear()
                                        for(var i = 0;i< text;i++){
                                            tableModel3.append({nFunction:i+1})
                                        }


                                    }else
                                    {
                                        tableModel3.clear()

                                    }
                                }

                                width: 63
                                text: "0"
                                placeholderText: "Number of gamma functions"
                                validator: RegExpValidator {
                                    regExp: /^[0-9]\d+/
                                }
                                //                                editingFinished: console.log("CIAO")
                                onTextChanged: showLabel(text)


                            }


                        }

                        ListModel {
                            id: tableModel3
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
                            id: tableView3
                            width: 672
                            height: 50
                            Layout.minimumWidth:  width
                            Layout.fillHeight: false

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "N."
                                role: "nFunction"
                                delegate: Text {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "α max"
                                role: "amax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "α min"
                                role: "amin"
                                delegate: TextField {
                                }
                                resizable: false

                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "β max"
                                role: "bmax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 50
                                movable: false
                                title: "β min"
                                role: "bmin"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 70
                                movable: false
                                title: "Weight max"
                                role: "wmax"
                                delegate: TextField {
                                }
                            }

                            TableViewColumn {
                                width: 70
                                movable: false
                                title: "Weight min"
                                role: "wmin"
                                delegate: TextField {
                                }
                                resizable: false
                            }

                            TableViewColumn {
                                width: 90
                                movable: false
                                title: "Percentage α"
                                role: "pa"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 90
                                movable: false
                                title: "Percentage β"
                                role: "pb"
                                delegate: TextField {
                                }
                                resizable: false
                            }
                            TableViewColumn {
                                width: 100
                                movable: false
                                title: "Percentage Weight "
                                role: "Percentage Weight "
                                delegate: TextField {

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
                        width: 309
                        height: 50
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
                                console.log("You chose: " + split[0])
                                console.log("You chose: " + split.length)
                                textfileRain.text = "../"+split[split.length-1]
                                customPlotKernelRegression1.initCustomPlotRegressionPreviewKernel(fileDialogRain.fileUrl)
//                                customPlotKernelRegression1.initCustomPlotKernelComtrolPoints(fileDialogRain.fileUrl)
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






                }

                GridLayout {
                    id: gridLayout4
                    width: 100
                    height: 100
                    columns: 1
                    rows: 2


                    CustomPlotRegressionPreviewKernel {
                        id: customPlotKernelRegression1
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
                    CustomPlotRegressionPreviewKernel {
                        id: customPlotKernelRegression2
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

                }
            }

            RowLayout {
                id: columnLayout1
                width: 328
                height: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 2

                Layout.preferredWidth: 328
                Layout.preferredHeight: 100

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
                    property  string selectionElitist;
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

                    property  int typeAlgorithm;

                    onClicked: {
                        populationSize = textFieldPopulationSize.text;
                        percentageCrossover = textFieldProbabiltyCrossOver.text;
                        percentageMutation = textFieldProbabiltyMutation.text;
                        percentageWeight = textPercentageWeight.text;
                        numberProcessor = textFieldNumberProcessor.text;
                        numberGamma = textFieldGammaFunctions.text;
                        percentageGammaA = textFieldGammaA.text;
                        percentageGammaB = textFieldGammaB.text;
                        numberLinear = textFieldLinearFunction.text;
                        percentageLinearA = textFieldLinearA.text;
                        percentageLinearB = textFieldLinearB.text;
                        maxGeneration = textFieldMaxGeneration.text;
                        selection =  selections.get(selections.currentIndex).text;
                        selectionElitist =  selectionParameterTournamentWithoutReplacement.text;
                        typeAlgorithm = 4;
                        fileUrl = pathrain;

                        console.log("populationSize : "+populationSize +
                                    "\n percentageCrossover : "+percentageCrossover+
                                    "\n percentageMutation : "+percentageMutation+
                                    "\n percentageWeight : "+percentageWeight+
                                    "\n numberProcessor : "+numberProcessor+
                                    "\n numberGamma : "+numberGamma+
                                    "\n percentageGammaA : "+percentageGammaA+
                                    "\n percentageGammaB : "+percentageGammaB+
                                    "\n numberLinear : "+numberLinear+
                                    "\n percentageLinearA : "+percentageLinearA+
                                    "\n percentageLinearB : "+percentageLinearB+
                                    "\n maxGeneration : "+maxGeneration+
                                    "\n selection : "+selection+
                                    "\n selectionElitist : "+selectionElitist+
                                    "\n fileUrl : "+fileUrl
                                    )


                        sakeStart.startRegression(
                                    textFiledProjectName.text,
                                    selection  ,
                                    selectionElitist  ,
                                    populationSize  ,
                                    percentageCrossover  ,
                                    percentageMutation  ,
                                    percentageWeight  ,
                                    numberProcessor  ,
                                    numberGamma  ,
                                    percentageGammaA  ,
                                    percentageGammaB  ,
                                    numberLinear  ,
                                    percentageLinearA  ,
                                    percentageLinearB  ,
                                    maxGeneration,
                                    fileUrl,
                                    0
                                    )
                        //                                                            sakeStart.startRegression()
                        close();
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
                    onClicked: close()

                }
            }

        }


    }

    //        MessageDialog {
    //            id: messageDialogRain
    //            title: "Input error"
    //            text: "Please enter rain csv path."
    //            onAccepted: close()
    //            Component.onCompleted: visible = false
    //            modality: "ApplicationModal"
    //        }

    //        MessageDialog {
    //            id: messageDialogActivation
    //            title: "Input error"
    //            text: "Please enter Activation csv path."
    //            onAccepted: close()
    //            Component.onCompleted: visible = false
    //            modality: "ApplicationModal"
    //        }

    //        MessageDialog {
    //            id: messageDialogProjectName
    //            title: "Input error"
    //            text: "The project name already exists."
    //            onAccepted: close()
    //            Component.onCompleted: visible = false
    //            modality: "ApplicationModal"
    //        }
    //        MessageDialog {
    //            id: messageDialogProjectNameEmpty
    //            title: "Input error"
    //            text: "The project name is empty."
    //            onAccepted: close()
    //            Component.onCompleted: visible = false
    //            modality: "ApplicationModal"
    //        }

}
