/*
* This file is part of meego-pinquery
*
* Copyright (C) 2019-2025 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick
import Nemo
import Nemo.Controls

Page {
    id: pinPage

    property string pinType: ofonoSimIf.pinType()

    PinEntry {
        id: pinEntry

        visible: true
        placeHolderText: qsTr('Enter PIN code')
        errorText: qsTr('Incorrect PIN code')
        okText: qsTr('PIN code correct')

        anchors {
            top: parent.top
            bottom: numPad.top
            left: parent.left
            right: parent.right
            margins: Theme.itemSpacingSmall
        }

    }

    PinEntry {
        id: pukEntry

        property string stepOneText: qsTr('Enter PUK code')
        property string stepTwoText: qsTr('Enter new pin code')
        property string stepThreeText: qsTr('Re-enter new pin code')

        visible: false
        placeHolderText: qsTr('Enter PUK code')
        errorText: qsTr('Resetting PIN code failed')
        okText: qsTr('PIN code resetted successfully')

        anchors {
            //            margins: Theme.itemSpacingSmall

            top: parent.top
            bottom: numPad.top
            left: parent.left
            right: parent.right
        }

    }

    PinNumPad {
        id: numPad

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        //        anchors.margins: Theme.itemSpacingLarge
        Component.onCompleted: {
            setEntry(pinPage.pinType);
        }
    }

    headerTools: HeaderToolsLayout {
        title: qsTr("Unlock SIM card")
    }

}
