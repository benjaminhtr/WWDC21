import SwiftUI

// circle button
public struct CircleButton: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .background(Color.black.opacity(0.1))
            .foregroundColor(Color.black.opacity(0.8))
            .clipShape(Circle())
            .font(.system(size: 16, weight: .bold, design: .default))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
