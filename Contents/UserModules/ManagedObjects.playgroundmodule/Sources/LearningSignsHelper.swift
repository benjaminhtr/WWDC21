import SwiftUI
import Models

public class LearningSignsHelper: ObservableObject {
    
    // show traffic sign detail view
    @Published public var showDetail = false
    
    // set current traffic sign and enable show traffic sign detail view
    public var currentTrafficSign: TrafficSign? {
        didSet {
            showDetail = true
        }
    }
    
    // required in order to access the class in other files
    public init() {}
}
