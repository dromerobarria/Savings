import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.scenePhase) private var scenePhase
    var modelContext: ModelContext
    @StateObject private var viewModel: FavoriteViewModel
    @State private var showingOptions = false
    @State private var selectedInfo: PromoModel?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: FavoriteViewModel(fetchInfoListUseCase: FetchInfoListUseCase(infoRepository: InfoRepositoryImplementation(modelContext: modelContext))))
        
        
    }
    
    @State private var title = "Favoritos"
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

private extension FavoritesView {

    func listView(infoItems: [PromoModel]) -> some View {
            List {
                Section {
                    ForEach(infoItems) { info in
                        Button(action: {
                            selectedInfo = info
                        }, label: {
                            InfoView(info: info)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .overlay {
                if infoItems.isEmpty{
                    ContentUnavailableView {
                        Label("No Promos", systemImage: "wineglass.fill")
                    } description: {
                        Text("Try to add a new Promos.")
                    }
                }
            }
            .refreshable {
                viewModel.handle(.onAppear)
            }
            .sheet(isPresented: $isShowingSettings, onDismiss: {
                viewModel.handle(.onAppear)

            }) {
                TextFormView(modelContext: modelContext)
            }
            .sheet(item: $selectedInfo, onDismiss: {
                viewModel.handle(.onAppear)

            }) { info in
                OptionEventView(info: info, modelContext: modelContext).presentationDetents([.fraction(0.18)])
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
}
