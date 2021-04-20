import SwiftUI
import Models
import ManagedObjects

public struct LearningSignsView: View {
    
    // create instance of learning signs helper
    @ObservedObject private var learningSignsHelper = LearningSignsHelper()
    
    // init
    public init() {}
    
    public var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 48) {
                    
                    // add large title
                    Text("Learning Traffic Signs")
                        .font(.system(size: 48, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // add category views
                    VStack(spacing: 96) {
                        CategoryView(with: .danger, learningSignsHelper: learningSignsHelper)
                        CategoryView(with: .prescription, learningSignsHelper: learningSignsHelper)
                        CategoryView(with: .indicator, learningSignsHelper: learningSignsHelper)
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
            .zIndex(1)
            
            // add traffic sign detail view
            if learningSignsHelper.showDetail {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(AnyTransition.opacity.animation(.spring()))
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
                
                TrafficSignDetailView(learningSignsHelper: learningSignsHelper)
                    .animation(.spring())
                    .transition(.move(edge: .trailing))
                    .zIndex(3)
            }
            
        }
    }
    
}
