// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import Jammer
import BackendSingleton 1.0

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "Jammer"

    BaseScreen {
        id: mainScreen
        myProgressBarPBarValue: BackendSingleton.battery
        mySignalBarValue: BackendSingleton.signalStrength


        VideoComponent {

            playVideo: true

        }

    }

}

