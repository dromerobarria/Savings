import OSLog
import SwiftData
import WidgetKit

extension SavingWidget {
    struct Provider: TimelineProvider {
        private let modelContext = ModelContext(Self.container)

        func placeholder(in context: Context) -> Entry {
            .placeholder
        }

        func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
            completion(.placeholder)
        }

        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
            guard let products = fetchProducts() else {
                completion(.init(entries: [.empty], policy: .after(.now.advanced(by: 60*60))))
                return
            }
            let entry = Entry(date: .now, productInfo: products)
            completion(.init(entries: [entry], policy: .after(.now.advanced(by: 60*60))))
        }
    }
}

// MARK: - ModelContainer

extension SavingWidget.Provider {
    private static let container: ModelContainer = {
        do {
            return try ModelContainer(for: PromoModel.self)
        } catch {
            fatalError("\(error)")
        }
    }()
}

// MARK: - Helpers

extension SavingWidget.Provider {
    private func fetchProducts() -> [PromoModel]? {
        let date = Date.now.formatted(.dateTime.weekday())
        let day: Day = switch date {
        case "Sat": .Sábado
        case "Tue": .Martes
        case "Wed": .Miércoles
        case "Mon": .Lunes
        case "Thurs": .Jueves
        case "Sun": .Domingo
        default: .Viernes
        }
        
        do {
            let products = try modelContext.fetch(FetchDescriptor<PromoModel>())
            var result:[PromoModel] = []
            for promo in products {
                if promo.days.contains(day) && promo.kind == .food  {
                    result.append(promo)
                }
            }
            
            guard let firstPromo = result.first else {
                return []
            }
            return [firstPromo]
        } catch {
            Logger.widgets.error("Error fetching products: \(error)")
            return nil
        }
    }
}
