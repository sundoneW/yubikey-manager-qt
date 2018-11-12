import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import QtQuick.Controls.Material 2.2

ColumnLayout {
    id: pivView

    StackView.onActivating: load()

    objectName: "pivView"
    property bool isBusy

    function load() {// TODO: load
    }

    BusyIndicator {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        running: isBusy
        visible: running
    }

    CustomContentColumn {
        visible: !isBusy

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Heading1 {
                text: qsTr("PIV")
            }

            BreadCrumbRow {
                items: [{
                        text: qsTr("PIV")
                    }]
            }
            RowLayout {
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                CustomButton {
                    text: qsTr("Reset PIV")
                    highlighted: true
                    toolTipText: qsTr("Reset the PIV application")
                    flat: true
                    iconSource: "../images/reset.svg"
                    onClicked: views.pivReset()
                }
                CustomButton {
                    text: qsTr("Setup for macOS")
                    highlighted: true
                    toolTipText: qsTr("Setup PIV for pairing with macOS")
                    flat: true
                    iconSource: "../images/mac.svg"
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 60
            id: mainRow

            ColumnLayout {
                Heading2 {
                    text: qsTr("PIN Management")
                    font.pixelSize: constants.h2
                }
                Label {
                    text: qsTr("Configure PIN, PUK and Management Key")
                    font.pixelSize: constants.h3
                    color: yubicoBlue
                }
                CustomButton {
                    text: qsTr("Configure PINs")
                    highlighted: true
                    toolTipText: qsTr("Configure PIN, PUK and Management Key")
                    iconSource: "../images/lock.svg"
                    onClicked: views.pivPinManagement()
                }
            }

            Rectangle {
                id: separator
                Layout.minimumWidth: 1
                Layout.maximumWidth: 1
                Layout.maximumHeight: mainRow.height * 0.7
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: yubicoGrey
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            ColumnLayout {
                Heading2 {
                    text: qsTr("Certificates")
                }
                Label {
                    text: qsTr("No certificates loaded")
                    font.pixelSize: constants.h3
                    color: yubicoBlue
                }
                CustomButton {
                    text: qsTr("Handle Certificates")
                    highlighted: true
                    toolTipText: qsTr("Hande PIV Certificates")
                    onClicked: views.pivCertificates()
                }
            }
        }
    }
}