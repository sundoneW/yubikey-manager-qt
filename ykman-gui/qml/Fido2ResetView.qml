import QtQuick 2.5
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.2

ColumnLayout {

    readonly property bool hasDevice: yubiKey.hasDevice
    property bool loadedReset
    onHasDeviceChanged: resetOnReInsert()

    function resetOnReInsert() {
        if (!hasDevice && reInsertYubiKey.visible) {
            loadedReset = true
        } else {
            if (loadedReset) {
                loadedReset = false
                touchYubiKey.open()
                yubiKey.fido_reset(function (resp) {
                    touchYubiKey.close()
                    if (resp.success) {
                        fido2ResetSucces.open()
                    } else {
                        if (resp.error === 'touch timeout') {
                            fido2ResetTouchError.open()
                        } else {
                            fido2GeneralError.error = resp.error
                            fido2GeneralError.open()
                        }
                    }
                })
            }
        }
    }

    TouchYubiKeyPopup {
        id: touchYubiKey
    }

    Fido2ResetConfirmPopup {
        id: fido2ResetConfirmationPopup
        onAccepted: reInsertYubiKey.open()
    }

    Fido2SuccessPopup {
        id: fido2ResetSucces
        message: qsTr("Success! The FIDO application was reset.")
    }

    Fido2GeneralErrorPopup {
        id: fido2ResetTouchError
        error: qsTr("A reset requires a touch on the YubiKey to be confirmed.")
    }

    Fido2GeneralErrorPopup {
        id: fido2GeneralError
    }

    ColumnLayout {
        Layout.fillWidth: true
        Layout.margins: 20
        Layout.preferredHeight: app.height

        Label {
            Layout.fillWidth: true
            color: yubicoBlue
            text: qsTr("Reset FIDO")
            font.pointSize: constants.h1
        }

        RowLayout {
            Label {
                text: qsTr("Home")
                color: yubicoGreen
            }

            Label {
                text: '/ '
                color: yubicoGrey
            }
            Label {
                text: qsTr("FIDO2")
                color: yubicoGreen
            }

            Label {
                text: '/ '
                color: yubicoGrey
            }
            Label {
                text: qsTr("Reset FIDO")
                color: yubicoGrey
            }
        }

        Label {
            color: yubicoBlue
            text: qsTr("This action permanently deletes all FIDO credentials on the device (U2F & FIDO2), and removes the FIDO2 PIN.

A reset requires a re-insertion and a touch on the YubiKey.")
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width
            wrapMode: Text.WordWrap
            font.pointSize: constants.h3
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            Layout.fillWidth: true
            Button {
                text: qsTr("Cancel")
                onClicked: views.pop()
            }
            Button {
                text: qsTr("Reset")
                highlighted: true
                onClicked: fido2ResetConfirmationPopup.open()
            }
        }
    }
}