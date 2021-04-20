import SwiftUI

public struct ChartView: View {
    
    // init
    public init() {}
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 48) {
                
                // add large title
                Text("The problem")
                    .font(.system(size: 48, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // add category views
                VStack(spacing: 96) {
                    ChartImageView(number: "1", title: "Driver misconduct in road traffic accidents", subtitle: "Personal injury - 2019", imageName: "chart-1")
                    ChartImageView(number: "2", title: "Fatalities in road traffic", subtitle: "By selected traffic association type and localities - 2019", imageName: "chart-2")
                    ChartImageView(number: "3", title: "Development of the number of road traffic fatalities", subtitle: "With legal changes in Germany - in thousand", imageName: "chart-3")
                }
            }
            .padding(40)
            .padding(.top, 64)
            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            // add background image
            Image(uiImage: UIImage(named: "gradientBackground")!)
                .resizable()
                .edgesIgnoringSafeArea(.all)
        )
    }
    
}
