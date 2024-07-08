//
//  SwiftDataWidget+EntryView.swift
//  Saving
//
//  Created by Daniel Romero on 07-07-24.
//

import Foundation
import SwiftUI

struct SavingWidgetEntryView : View {
    let entry: SavingWidget.Entry
   
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(Date().formatted(Date.FormatStyle().weekday(.wide)))
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Text(String(UnicodeScalar(Array(0x1F600...0x1F64F).randomElement()!)!))
            }
            
            ForEach(entry.productInfo) { promo in
                VStack(alignment: .leading) {
                    Text(promo.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Text(promo.detail)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                    Text(promo.amount)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .background(.appAccent)
    }
}
