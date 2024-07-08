import SwiftUI
import SwiftData

struct OptionEventView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var info: PromoModel
    var modelContext: ModelContext
    @State private var isShowingSettings = false
   
    
    init(info: PromoModel, modelContext: ModelContext) {
        self.info = info
        self.modelContext = modelContext
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10){
                Text(info.title)
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.leading)
                Text("-")
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.leading)
                
                Text(info.detail)
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            
            Text("Descuento de \(info.amount)")
            .bold()
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            
          
            HStack {
                Button {
                    isShowingSettings.toggle()
                } label: {
                    Text("Editar")
                        .frame(width: 150, height: 20)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                
                Button {
                    info.favorite = false
                    dismiss()
                } label: {
                    Image(systemName: "star.slash")
                        .frame(height: 20)
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                
                Button {
                    modelContext.delete(info)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                        .frame(height: 20)
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .frame(height: 20)
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $isShowingSettings, onDismiss: didDismiss) {
            EditFormView(info: info, modelContext: modelContext)
        }
    }
    
    func didDismiss() {
        dismiss()
    }
}
