import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

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
