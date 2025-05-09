/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
*/

import QtQuick
import Nemo
import Nemo.Controls

Rectangle {
    id: btn

    property alias text: numberText.text
    property alias subText: letterText.text

    signal pressed()
    signal pressAndHold()

    width: height
    height: Theme.itemHeightExtraLarge
    color: dialerButtonMouse.pressed ? Theme.fillColor : "transparent"
    //    color: "transparent";
    radius: height / 2

    Text {
        //            text: btn.text

        id: numberText

        color: dialerButtonMouse.pressed ? Theme.accentColor : Theme.textColor
        font.pixelSize: btn.height * 0.8
        font.weight: Theme.fontWeightMedium
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -btn.width * 0.15
    }

    Text {
        id: letterText

        color: Theme.fillColor
        font.pixelSize: numberText.font.pixelSize * 0.4
        font.weight: Theme.fontWeightMedium
        anchors.left: numberText.right
        anchors.leftMargin: Theme.itemSpacingSmall
        anchors.baseline: numberText.baseline
    }

    Shortcut {
        sequence: numberText.text
        onActivated: btn.pressed()
    }

    MouseArea {
        id: dialerButtonMouse

        anchors.fill: parent
        onPressed: {
            btn.pressed();
        }
        onPressAndHold: {
            btn.pressAndHold();
        }
    }

}
