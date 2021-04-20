import SwiftUI

public struct ChartImageView: View {
    
    private let number: String
    private let title: String
    private let subtitle: String
    private let imageName: String
    
    public init(number: String, title: String, subtitle: String, imageName: String) {
        self.number = number
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
    
    public var body: some View {
        VStack(spacing: 32) {
            BlurTitleView {
                HStack(alignment: .top, spacing: 16) {
                    Text(number)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(Color.black.opacity(0.8))
                        .padding(.top, 6)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title)
                            .font(.system(size: 24, weight: .semibold, design: .default))
                        
                        Text(subtitle)
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(Color.black.opacity(0.8))
                    }
                    
                    Spacer()
                }
                .padding(.leading, 8)
                
            }
            
            Image(uiImage: UIImage(named: imageName)!)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
    }
    
}
