import SwiftUI
import Models
import ManagedObjects

public struct TrafficSignsGrid: View {
    
    // filtered traffic signs which can be shown
    private var filteredTrafficSigns: [TrafficSign]
    
    // images from filtered traffic signs
    private var images: [UIImage]
    
    // learning signs helper
    @ObservedObject private var learningSignsHelper: LearningSignsHelper
    
    // init
    public init(for ids: [Int], learningSignsHelper: LearningSignsHelper) {
        
        // filter traffic signs if the id is in ids passed over init
        filteredTrafficSigns = trafficSigns.filter { trafficSign in
            ids.contains { $0 == trafficSign.id }
        }
        
        // get all images for all filtered traffic signs
        images = filteredTrafficSigns.map {
            UIImage(named: $0.imageName) ?? UIImage()
        }
        
        self.learningSignsHelper = learningSignsHelper
    }
    
    public var body: some View {
        LazyVGrid(columns: .init(repeating: GridItem(.flexible(), spacing: 32), count: 3)) {
            ForEach(filteredTrafficSigns.indices, id: \.self) { index in
                VStack(spacing: 16) {
                    
                    // add image
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .shadow(color: Color.black.opacity(0.06), radius: 32, x: 0, y: 16)
                    
                    // add the name
                    Text(filteredTrafficSigns[index].name)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                        
                    Spacer()
                }
                .padding(.bottom, 8)
                .onTapGesture {
                    learningSignsHelper.currentTrafficSign = filteredTrafficSigns[index]
                }
            }
        }
    }
    
}
