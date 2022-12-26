import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Rectangle {
    id: actionButton

    property alias text: textContent.text

    signal pressed()

    width: Theme.itemWidthLarge
    height: Theme.itemHeightExtraLarge
    color: mouse.pressed ? Theme.fillDarkColor : "Transparent"
    radius: height / 2

    Text {
        id: textContent

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: mouse.pressed ? Theme.accentColor : Theme.textColor
        font.weight: Theme.fontWeightLarge
        font.pixelSize: Theme.fontSizeMedium
        font.family: Theme.fontFamily
    }

    MouseArea {
        id: mouse

        anchors.fill: parent
        onClicked: {
            actionButton.pressed();
        }
    }

}
