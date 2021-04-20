import SwiftUI

public struct BlurTitleView<Content: View>: View {
    
    // init with content
    private let content: Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .frame(maxWidth: .infinity)
            .padding(32)
            .background(
                Blur(effect: UIBlurEffect(style: .light))
            )
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.5),
                            Color.white.opacity(0.3)
                        ]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing
                    ), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.06), radius: 32, x: 0, y: 16)
    }
    
}
