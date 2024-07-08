//
//  SavingWidgetBundle.swift
//  SavingWidget
//
//  Created by Daniel Romero on 06-07-24.
//

import WidgetKit
import SwiftUI

@main
struct SavingWidgetBundle: WidgetBundle {
    var body: some Widget {
        SavingWidget()
        SavingWidgetLiveActivity()
    }
}
