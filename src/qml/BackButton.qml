import QtQuick
import Nemo
import Nemo.Controls

NemoIcon {
    id: backButton

    property bool isActive: true

    signal pressed()

    width: height
    height: Theme.itemHeightExtraLarge
    source: isActive ? "image://theme/angle-left" : ""
    color: mouse.pressed ? Theme.accentColor : Theme.textColor

    MouseArea {
        id: mouse

        anchors.fill: parent
        onClicked: {
            backButton.pressed();
        }
    }

}
