import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.scenePhase) private var scenePhase
    var modelContext: ModelContext
    @StateObject private var viewModel: HomeViewModel
    @State private var showingOptions = false
    @State private var selectedInfo: PromoModel?
    @State private var favoriteDay: Day = .Lunes
    @State private var selectedDay = ""
    @State private var choice = 0
    @State private var selectedType: promoType = .food
    var days = ["Lun","Mar","Mier","Jue","Vie","Sab","Dom"]
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: HomeViewModel(fetchInfoListUseCase: FetchInfoListUseCase(infoRepository: InfoRepositoryImplementation(modelContext: modelContext))))
    }
    
    @State private var title = "Promociones 🤤"
    @State private var isShowingSettings = false
    @State private var isShowingLogs = false
    var body: some View {
        contentView
            .redacted(if: viewModel.state == .loading)
            .backgroundColor()
            .onAppear {
                viewModel.handle(.onAppear)
            }
    }
    
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()

        case .loading:
            EmptyView()

        case .loaded(let viewData):
            listView(infoItems: viewData.infoItems)
        case .error(let message):
            ContentUnavailableView {
                Label("Error for \"\(message)\"", systemImage: "doc.richtext.fill")
            } description: {
                Text("Try again.")
            }
        }
    }
}

private extension HomeView {

    func listView(infoItems: [PromoModel]) -> some View {
        VStack(spacing: 0) {
            List {
                HStack {
                    Picker(selection: self.$choice, label: Text("Pick One")) {
                        ForEach(0 ..< self.days.count) {
                            Text(self.days[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Picker("Tipo", selection: $selectedType) {
                    Text("Comida").tag(promoType.food)
                    Text("Medicina").tag(promoType.medicine)
                    Text("Mascotas").tag(promoType.pets)
                    Text("Productos").tag(promoType.product)
                    Text("Otros").tag(promoType.others)
                }
                
                Section {
                    ForEach(infoItems.filter{$0.days.contains(favoriteDay)}.filter{ $0.kind == selectedType } ) { info in
                        Button(action: {
                            selectedInfo = info
                        }, label: {
                            InfoView(info: info)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .onChange(of: choice) { value in
            let resultDay: Day = switch value {
            case 0: .Lunes
            case 1: .Martes
            case 2: .Miércoles
            case 3: .Jueves
            case 4: .Viernes
            case 5: .Sábado
            default: .Domingo
            }
            favoriteDay = resultDay
        }
        .overlay {
            if infoItems.isEmpty{
                ContentUnavailableView {
                    Label("No Promos", systemImage: "wineglass")
                } description: {
                    Text("Agrega una nueva Promo.")
                }
            }
        }
        .refreshable {
            viewModel.handle(.onAppear)
        }
        
        .navigationBarItems(
            leading:
                HStack {
                    Button(action: addDemo) {
                        Label("Add Data Promo", systemImage: "swiftdata")
                    }
                },
            trailing:  
                HStack {
                    Button(action: addItem) {
                        Label("Add Promo", systemImage: "plus")
                    }
                    Button(action: deleteDemo) {
                        Label("Delete Data Promo", systemImage: "delete.left")
                    }
                }
        )
        .sheet(isPresented: $isShowingSettings, onDismiss: {
            viewModel.handle(.onAppear)
            
        }) {
            TextFormView(modelContext: modelContext)
        }
        .sheet(item: $selectedInfo, onDismiss: {
            viewModel.handle(.onAppear)
            
        }) { info in
            OptionView(info: info, modelContext: modelContext).presentationDetents([.fraction(0.18)])
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(15)
        .navigationTitle("\(title)")
    }
    
    private func addItem() {
        withAnimation(.spring()) {
            isShowingSettings.toggle()
        }
    }
    
    private func deleteDemo() {
        do {
            try modelContext.delete(model: PromoModel.self)
            viewModel.handle(.onAppear)
        } catch {
            print("Failed to clear all Promo data.")
        }
    }
    
    private func addDemo() {
        let info = [PromoModel(title: "Buffet Express",
                                            detail: "Con Banco de Chile",
                                            kind: .food,
                                            amount: "20%",
                                            days: [.Lunes,.Martes,.Miércoles]),
                    PromoModel(title: "Indian box - open kenedy",
                                           detail: "Con CMR",
                                           kind: .food,
                                           amount: "40%",
                                           days: [.Jueves]),
                    PromoModel(title: "Vapiano",
                                           detail: "Con CMR",
                                           kind: .food,
                                           amount: "40%",
                                           days: [.Miércoles]),
                    PromoModel(title: "Castaño",
                                           detail: "Con banco ripley",
                                           kind: .product,
                                           amount: "25%",
                                           days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Farmacia ahumada",
                                           detail: "Con CMR en anticonceptivos",
                                           kind: .medicine,
                                           amount: "hasta 50%",
                                           days: [.Lunes]),
                    PromoModel(title: "Burger King",
                                           detail: "Con banco ripley",
                                           kind: .food,
                                           amount: "40%",
                                           days: [.Martes],
                                           favorite: true),
                    PromoModel(title: "Papa Jhons",
                                           detail: "Con banco ripley, primeros 6 digitos tarjeta",
                                           kind: .food,
                                           amount: "40%",
                               days: [.Jueves,.Domingo]),
                    PromoModel(title: "Galpon italia",
                                           detail: "Con Banco de Chile",
                                           kind: .food,
                                           amount: "20%",
                                           days: [.Lunes,.Martes,.Miércoles]),
                    PromoModel(title: "Verde Sazón",
                                           detail: "Con Banco de Chile",
                                           kind: .food,
                                           amount: "25%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Huargos",
                                           detail: "Con Banco de Scotiabank, en primera compra (codigo online)",
                               kind: .pets,
                                           amount: "25%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Transvip",
                                           detail: "Con Banco de Scotiabank, primero 6 digitos tarjeta",
                                           kind: .others,
                                           amount: "25%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Casa ideas",
                                           detail: "Con Banco de Scotiabank",
                                           kind: .product,
                                           amount: "Hasta 35%",
                               days: [.Martes]),
                    PromoModel(title: "Cine Hoyts",
                                           detail: "Con Banco de Scotiabank, ver página",
                                           kind: .others,
                                           amount: "50%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Copec",
                                           detail: "Con Banco de Scotiabank",
                                           kind: .others,
                                           amount: "$100 por litro",
                               days: [.Miércoles]),
                    PromoModel(title: "Melt",
                                           detail: "Con Movistar",
                                           kind: .food,
                                           amount: "40%",
                               days: [.Jueves]),
                    PromoModel(title: "Burger King",
                                           detail: "Con Banco de Santader,",
                                           kind: .food,
                                           amount: "40%",
                               days: [.Jueves]),
                    PromoModel(title: "Melt",
                                           detail: "Con Banco de Santander, primero 6 digitos tarjeta",
                                           kind: .food,
                                           amount: "40%",
                               days: [.Martes]),
                    PromoModel(title: "Melt",
                                           detail: "Con Banco de Santander, primero 6 digitos tarjeta",
                                           kind: .food,
                                           amount: "40%",
                               days: [.Martes]),
                    PromoModel(title: "Melt",
                                           detail: "Con Banco de Santander, primero 6 digitos tarjeta",
                                           kind: .food,
                                           amount: "40%",
                               days: [.Martes]),
                    PromoModel(title: "Dominó",
                                           detail: "Con Banco de Santander, primero 6 digitos tarjeta y cupón BANCO SANTANDER",
                                           kind: .food,
                                           amount: "40% app dominó y 20% local",
                               days: [.Martes]),
                    PromoModel(title: "Ash",
                                           detail: "Con Banco de Santander, nueva colección",
                                           kind: .others,
                                           amount: "20%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Club perros y gatos",
                                           detail: "Con Banco de Santander, con los primeros 6 digitos",
                                           kind: .pets,
                                           amount: "15%",
                               days: [.Miércoles]),
                    PromoModel(title: "CineHoyts",
                                           detail: "Con Movistar, entradas 2D descuento en la App",
                                           kind: .others,
                                           amount: "60%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "StarBucks",
                                           detail: "Con Banco de Chile",
                                           kind: .food,
                                           amount: "30%",
                               days: [.Viernes]),
                    PromoModel(title: "Ash",
                                           detail: "Con Banco de Santander, nueva colección",
                                           kind: .others,
                                           amount: "20%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Freemet",
                                           detail: "Con Banco de Santander, primero 6 digitos tarjeta",
                                           kind: .product,
                                           amount: "20%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo]),
                    PromoModel(title: "Bigos",
                                           detail: "Con Banco de Chile, primero 6 digitos tarjeta, excluye alimentos",
                                           kind: .pets,
                                           amount: "20%",
                               days: [.Viernes]),
                    PromoModel(title: "Freemet",
                                           detail: "Con Banco de Santander, primero 6 digitos tarjeta",
                                           kind: .product,
                                           amount: "20%",
                               days: [.Lunes,.Martes,.Miércoles,.Jueves,.Viernes,.Sábado,.Domingo])
        ]
        
        for value in info {
            modelContext.insert(value)
        }
        
        viewModel.handle(.onAppear)
    }
}


