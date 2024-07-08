//
//  SwiftDataWidget+Entry.swift
//  Saving
//
//  Created by Daniel Romero on 07-07-24.
//

import WidgetKit

extension SavingWidget {
    struct Entry: TimelineEntry {
        let date: Date
        var productInfo: [PromoModel]
    }
}


// MARK: - Data

extension SavingWidget.Entry {
    static var empty: Self {
        .init(date: .now, productInfo: [PromoModel(title: "Promoción X", detail: "Banco Y", kind: .food, amount: "20%", days: [.Sábado])])
    }

    static var placeholder: Self {
        .init(date: .now, productInfo: [PromoModel(title: "Promoción X", detail: "Banco Y", kind: .food, amount: "20%", days: [.Sábado])])
    }
}

