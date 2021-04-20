import SwiftUI
import ManagedObjects

public struct CategoryView: View {
    
    // traffic sign types
    public enum TrafficSignType {
        case danger
        case prescription
        case indicator
    }
    
    // title of the category
    private var title: String
    
    // traffic sign id for the category
    private var trafficSignIds: [Int]
    
    // learning signs helper for changing current traffic sign
    @ObservedObject private var learningSignsHelper: LearningSignsHelper
    
    // init with type and learning signs helper
    public init(with type: TrafficSignType, learningSignsHelper: LearningSignsHelper) {
        switch type {
        case .danger:
            title = "Danger signs"
            trafficSignIds = [1001, 1009, 1013, 1014, 1016, 1019]
        case .prescription:
            title = "Regulation signs"
            trafficSignIds = [1022, 1023, 1024, 1025, 1029, 1031, 1032, 1033, 1035, 1040, 1041, 1042, 1044, 1045, 1046]
        case .indicator:
            title = "Indicator signs"
            trafficSignIds = [1047, 1048, 1050, 1051, 1052, 1053, 1054, 1055, 1056]
        }
        
        self.learningSignsHelper = learningSignsHelper
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            // add blur title view
            BlurTitleView {
                HStack() {
                    Text(title)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                    
                    Spacer()
                }
                .padding(.leading, 8)
            }
            
            // add traffic signs grid
            TrafficSignsGrid(for: trafficSignIds, learningSignsHelper: learningSignsHelper)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    
    
}
