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

Item {
    id: pinEntry

    property string placeHolderText: ''
    property string errorText: ''
    property string okText: ''
    property string notRequiredText: qsTr('PIN not required')
    property TextInput textInput: input

    function clear() {
        input.text = placeHolderText;
        input.state = "Prompt";
    }

    function failed(attemptsLeft) {
        input.text = errorText;
        if (attemptsLeft > 0)
            input.text += qsTr(" (%n  attempts left)", "PinEntry", attemptsLeft);

        input.state = "ErrorMsg";
        timer.start();
    }

    function notRequired() {
        input.text = notRequiredText;
        input.state = "ErrorMsg";
        timer.start();
    }

    function succeeded() {
        input.text = okText;
        input.state = "InfoMsg";
    }

    function appendChar(character) {
        if (timer.running)
            return ;

        if (input.state != "Input")
            input.text = character;
        else if (input.text.length < 8)
            input.text += character;
        input.state = "Input";
    }

    function removeChar() {
        if (input.state == "Input")
            input.text = input.text.substring(0, input.text.length - 1);

    }

    Timer {
        id: timer

        interval: 1500
        running: false
        repeat: false
        onTriggered: clear()
    }

    TextInput {
        id: input

        anchors.margins: Theme.itemSpacingSmall
        anchors.fill: parent
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        wrapMode: TextInput.Wrap
        color: Theme.accentColor
        cursorVisible: true
        readOnly: true
        font.pixelSize: Theme.fontSizeExtraLarge
        text: placeHolderText
        state: "Prompt"
        onTextChanged: {
            if (text.length == 0)
                pinEntry.clear();

        }
        states: [
            State {
                name: "Prompt"

                PropertyChanges {
                    target: input
                    color: Theme.accentColor
                    echoMode: TextInput.Normal
                }

            },
            State {
                name: "Input"

                PropertyChanges {
                    target: input
                    color: Theme.textColor
                    echoMode: TextInput.PasswordEchoOnEdit
                }

            },
            State {
                name: "InfoMsg"

                PropertyChanges {
                    target: input
                    color: Theme.accentColor
                    echoMode: TextInput.Normal
                }

            },
            State {
                name: "ErrorMsg"

                PropertyChanges {
                    target: input
                    color: "red"
                    echoMode: TextInput.Normal
                }

            }
        ]
    }

    BackButton {
        anchors.verticalCenter: input.verticalCenter
        anchors.right: parent.right
        anchors.margins: Theme.itemSpacingMedium
        visible: input.state == "Input"
        onPressed: {
            pinEntry.removeChar();
        }
    }

}
