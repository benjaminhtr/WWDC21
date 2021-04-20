import SwiftUI
import ManagedObjects
import Models

public struct TrafficSignDetailView: View {
    
    // create instance of learning signs helper
    @ObservedObject private var learningSignsHelper: LearningSignsHelper
    
    // init
    public init(learningSignsHelper: LearningSignsHelper) {
        self.learningSignsHelper = learningSignsHelper
    }
    
    public var body: some View {
        if let trafficSign = learningSignsHelper.currentTrafficSign {
            VStack(spacing: 24) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        
                        // the category name
                        Text(trafficSign.category.uppercased())
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(Color.black.opacity(0.5))
                        
                        // the traffic sign name
                        Text(trafficSign.name)
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    // circle button - dismisses the view
                    Button {
                        learningSignsHelper.showDetail = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(CircleButton())
                }
                
                // add image if available
                if let image = UIImage(named: trafficSign.imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color(white: 0.92), lineWidth: 1)
                        )
                }
                
                Spacer()
                
                // add description
                VStack(spacing: 24) {
                    if let description = trafficSign.description {
                        Text(description)
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .frame(maxWidth: 640)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .lineLimit(nil)
                    }
                    
                    // purple button - dismisses the view
                    Button("Got it!") {
                        learningSignsHelper.showDetail = false
                    }
                    .buttonStyle(PurpleButton())
                    
                }
                .padding(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color(white: 0.92), lineWidth: 1)
                )
                
                Spacer()
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
            )
            .shadow(color: Color.black.opacity(0.12), radius: 64, x: 0, y: 16)
            .padding(20)
        }
    }
    
}
