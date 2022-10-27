/*
* This file is part of meego-pinquery
* Copyright (C) 2018 Chupligin Sergey <neochapay@gmail.com>
* Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
*
* Contact: Sirpa Kemppainen <sirpa.h.kemppainen@nokia.com>
*
* Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
*
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of Nokia Corporation nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
* AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
* THE POSSIBILITY OF SUCH DAMAGE.
*
*/

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Item{
    id: pinNumPad

    property PinEntry entry

    width: parent.width;
    height: 5 * Theme.itemHeightMedium + 4 * Theme.itemSpacingExtraSmall

    function insertText(text) {
        entry.appendChar(text)
    }

    function removeChar() {
        entry.removeChar()
    }

    function setEntry(pinType) {
        pinPage.pinType = pinType;

        switch(pinType) {
        case 'puk':
            entry = pukEntry;
            entry.placeHolderText = pukEntry.stepOneText
            changeTimer.start();
            break;
        case 'newpin':
            entry = pukEntry;
            entry.placeHolderText = pukEntry.stepTwoText;
            entry.clear();
            break;
        case 'confirm':
            entry = pukEntry;
            entry.placeHolderText = pukEntry.stepThreeText;
            entry.clear();
            break;
        default:
            entry = pinEntry;
            pinEntry.visible = true;
            pukEntry.visible = false;
            break;
        }

    }

    Timer {
        id : quitTimer;
        interval: 1000;
        running: false;
        repeat: false;
        onTriggered: Qt.quit();
    }

    Timer {
        id : changeTimer;
        interval: 1500;
        running: false;
        repeat: false;
        onTriggered: {
            pukEntry.visible = true;
            pinEntry.visible = false;
        }
    }

    Connections {
        target: ofonoSimIf

        onPinOk : {
            entry.placeHolderText = '';
            entry.succeeded();
            quitTimer.start();
        }
        onPinFailed : {
            entry.failed(attemptsLeft);
        }
        onPinNotRequired : {
            entry.notRequired();
        }
        onPinTypeChanged : {
            setEntry(pinType);
        }
    }

    Behavior on opacity {PropertyAnimation {duration: 500}}


    ListModel {
        id: buttonsModel
        ListElement { number: "1"; letters: ""; }
        ListElement { number: "2"; letters: "ABC"; }
        ListElement { number: "3"; letters: "DEF"; }
        ListElement { number: "4"; letters: "GHI"; }
        ListElement { number: "5"; letters: "JKL"; }
        ListElement { number: "6"; letters: "MNO"; }
        ListElement { number: "7"; letters: "PQRS"; }
        ListElement { number: "8"; letters: "TUV"; }
        ListElement { number: "9"; letters: "WXYZ"; }
        ListElement { number: "*"; letters: ""; }
        ListElement { number: "0"; letters: "+"; }
    }

    Grid {
        id: dialerButtons
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: actionButtons.top
        anchors.margins: Theme.itemSpacingExtraSmall
        spacing: Theme.itemSpacingExtraSmall
        columns: 3

        Repeater {
            model: buttonsModel
            delegate: NumButton {
                width: (dialerButtons.width - Theme.itemSpacingLarge*3) /3
                text: model.number
                subText: model.letters
                onPressed: pinNumPad.insertText(model.number)
            }
        }

        BackButton {
            isActive: (entry.textInput.state == "Input")
            onPressed: {
                pinNumPad.removeChar();
            }
        }

    }

    Row {
        id: actionButtons
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        PinActionButton {
            width: parent.width/2 - 3* anchors.margins
            text: qsTr("Emergency")
            onPressed: {
                console.log("Emergency calls are not supported")
            }
        }

        PinActionButton {
            width: parent.width/2 - 3* anchors.margins
            property bool btnIsOk: (entry.textInput.state == "Input")
            text: (btnIsOk)  ? qsTr("OK") : qsTr("SKIP")
            onPressed: {
                if (btnIsOk) {
                    ofonoSimIf.enterPin(entry.textInput.text.toString());
                } else {
                    Qt.quit();
                }
            }
        }

    }

}
