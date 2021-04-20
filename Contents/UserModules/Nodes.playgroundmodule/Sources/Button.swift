import SpriteKit

public class Button: SKNode {
    
    // custom action
    public var action: () -> Void
    
    // init
    public required init(title: String, action: @escaping () -> Void) {
        self.action = action
        super.init()
        
        isUserInteractionEnabled = true
        
        // add title label
        let titleLabel = Label(text: title, font: .systemFont(ofSize: 20, weight: .bold), textColor: .white)
        titleLabel.zPosition = 1
        addChild(titleLabel)
        
        // add background
        let background = SKShapeNode()
        let buttonRect = CGRect(x: -(titleLabel.frame.width + 64) / 2, y: -28, width: titleLabel.frame.width + 64, height: 56)
        let purple = UIColor(red: 83/255, green: 34/255, blue: 248/255, alpha: 1)
        background.path = UIBezierPath(roundedRect: buttonRect, cornerRadius: 16).cgPath
        background.fillColor = purple
        background.strokeColor = purple
        background.zPosition = 0
        addChild(background)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // trigger custom action passed in init
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
    
}
