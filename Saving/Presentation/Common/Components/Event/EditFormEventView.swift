import SwiftUI
import PhotosUI
import SwiftData

struct EditFormEventView: View {
    @Environment(\.dismiss) var dismiss
    var modelContext: ModelContext
    var info: PromoModel?
    @State var promoTitle:String = ""
    @State var promoDetail: String = ""
    @State var selectedDays: [Day] = []
    @State var type: promoType = .others
    @State var amount: String = ""
    @State var days: [Day] = []
    @State private var promoTypeIndex = 0
    var promoType: [promoType] = [
        .food,
        .medicine,
        .others,
        .pets,
        .product
    ]
    
    init(info: PromoModel, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.info = info
        _promoTitle = State(initialValue: info.title)
        _promoDetail = State(initialValue: info.detail)
        _type = State(initialValue: info.kind)
        _amount = State(initialValue: info.amount)
        _days = State(initialValue: info.days)
    }
    
    
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
                            withAnimation {
                                    save()
                                    dismiss()
                            }
                        }
                        .disabled(disableForm)
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Button("Cancelar") {
                            withAnimation {
                                dismiss()
                            }
                        }
                        Spacer()
                    }
                }
                
            }
        }
    }
    
    private func save() {
        if let info {
            info.title = promoTitle
            info.detail = promoDetail
            info.kind = promoType[promoTypeIndex]
            info.amount = amount
            info.days = days
        }
    }
}
