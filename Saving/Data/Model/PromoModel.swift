import Foundation
import SwiftData

enum promoType: Codable {
    case food
    case product
    case pets
    case medicine
    case others
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .food: return "Comida"
        case .product: return "Productos"
        case .pets: return "Mascotas"
        case .medicine: return "Medicina"
        case .others: return "Otros"
        }
      }
}

enum Day: String, CaseIterable, Codable {
    case Lunes, Martes, Miércoles, Jueves, Viernes, Sábado, Domingo
}


@Model
final class PromoModel {
    
    var id: UUID = UUID()
    var title : String = ""
    var detail : String = ""
    var kind : promoType = promoType.others
    var amount : String = ""
    var days: [Day] = []
    var favorite: Bool = false
    
    init(id: UUID = UUID(),title: String,detail: String, kind: promoType, amount: String, days: [Day], favorite: Bool = false) {
        self.id = id
        self.title = title
        self.detail = detail
        self.kind = kind
        self.amount = amount
        self.days = days
        self.favorite = favorite
    }
    
    static func example() -> PromoModel {
        let promo = PromoModel(title: "Comida", detail: "2 x 1", kind: .food, amount: "%40", days: [.Lunes])
        return promo
    }
}

