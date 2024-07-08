import Foundation
import SwiftUI

struct EventView: View {
    @Bindable var info: PromoModel
    @State var kind = ""
    @State var selectedDays: [Day] = []
    
    var body: some View {
        HStack(alignment: .top, content: {
            VStack(alignment: .leading, spacing: 0) {
                Text(info.title)
                    .font(.system(size: 35, weight: .regular))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(info.amount)
                            .foregroundColor(.orange)
                        Text(info.detail)
                            .foregroundColor(.black)
                    }
                    HStack{
                        ForEach(info.days, id: \.self) { day in
                            Text(String(day.rawValue.first!))
                                .bold()
                                .textCase(.uppercase)
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.cyan.cornerRadius(10))
                        }
                    }
                }
            }
            Spacer()
        })
        
        .onAppear(perform: {})
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}
