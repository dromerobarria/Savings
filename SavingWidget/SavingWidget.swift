//
//  SavingWidget.swift
//  SavingWidget
//
//  Created by Daniel Romero on 06-07-24.
//

import WidgetKit
import SwiftUI
import SwiftData
import OSLog

struct SavingWidget: Widget {
    let kind: String = "SavingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            SavingWidgetEntryView(entry: entry)
                .containerBackground(.appAccent, for: .widget)
        }
    }
}


extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let widgets = Logger(subsystem: subsystem, category: "Widgets")
}

#Preview(as: .systemSmall) {
    SavingWidget()
} timeline: {
    SavingWidget.Entry.empty
    SavingWidget.Entry.placeholder
}
