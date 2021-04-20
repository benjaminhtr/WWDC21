import SpriteKit
import Models
import Protocols


public class Label: SKLabelNode {
    
    // font dependencies
    public var font: UIFont
    public var paragraphAlignment: NSTextAlignment
    public var textColor: UIColor
    
    // init
    public required init(text: String = "", font: UIFont = .systemFont(ofSize: 16), paragraphAlignment: NSTextAlignment = .center, textColor: UIColor = .black) {
        self.font = font
        self.paragraphAlignment = paragraphAlignment
        self.textColor = textColor
        super.init()
        
        setText(text)
        
        verticalAlignmentMode = .center
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set the current attributed text
    public func setText(_ text: String) {
        if text.count != 0 {
            let attrString = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = paragraphAlignment
            let range = NSRange(location: 0, length: (text as NSString).length)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            attrString.addAttributes([
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.font: font
            ], range: range)
            attributedText = attrString
        } else {
            attributedText = NSAttributedString(string: text)
        }
    }
    
}
