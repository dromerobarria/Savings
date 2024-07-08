import SwiftUI
import PhotosUI
import SwiftData

struct TextFormView: View {
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    @Environment(\.dismiss) var dismiss
    
    @State var promoTitle:String = ""
    @State var promoDetail: String = ""
    @State var selectedDays: [Day] = []
    @State var type: promoType = .others
    @State var amount: String = ""
    @State var days: [Day] = []
    @State private var promoTypeIndex = 0
    @State private var counter: Int = 0
    var promoType: [promoType] = [
        .food,
        .medicine,
        .others,
        .pets,
        .product
    ]
    
    var disableForm: Bool {
        promoTitle.isEmpty || promoDetail.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Titulo")) {
                    TextField("", text: $promoTitle)
                }
                Section(header: Text("Detalle"),
                        footer: Text("Agrega un texto detalle")) {
                    TextField("", text: $promoDetail)
                }
                Section(header: Text("Descuento")) {
                    TextField("", text: $amount)
                }
                Section(header: Text("Tipo de descuento"),
                        footer: Text("Selecciona el tipo de descuento"))
                {
                    Picker(selection: $promoTypeIndex,
                           label: pickerLabelView(
                            title: "Tipo"))
                    {
                        ForEach(0 ..< promoType.count, id: \.self) {
                            Text(self.promoType[$0].description)
                        }
                    }
                }
                
                Section(header: Text("Días")) {
                    HStack {
                        ForEach(Day.allCases, id: \.self) { day in
                            Text(String(day.rawValue.first!))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(days.contains(day) ? Color.cyan.cornerRadius(10) : Color.gray.cornerRadius(10))
                                .onTapGesture {
                                    if selectedDays.contains(day) {
                                        selectedDays.removeAll(where: {$0 == day})
                                        days.removeAll(where: {$0 == day})
                                    } else {
                                        selectedDays.append(day)
                                        days.append(day)
                                    }
                                }
                        }
                    }
                }
                Section(header: Text("¿Todo listo?")) {
                    HStack{
                        Spacer()
                        Button("Guardar") {
                            type = promoType[promoTypeIndex]
                            let promo = PromoModel(title: promoTitle, detail: promoDetail, kind: type, amount: amount, days: days)
                            modelContext.insert(promo)
                            counter = 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                dismiss()
                            }
                        }
                        .disabled(disableForm)
                        Spacer()
                    }
                }
            }
        }
        .confettiCannon(counter: $counter, num: 100)
    }
}
