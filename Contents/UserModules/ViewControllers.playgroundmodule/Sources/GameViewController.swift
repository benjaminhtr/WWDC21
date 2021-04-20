import SpriteKit
import Scenes

public class GameViewController: UIViewController {
    
    // the original scene size
    private let sceneSize = CGSize(width: 484, height: 968)
    
    // user interface views
    private var containerView: UIView!
    private var backgroundImageView: UIImageView!
    private let gameView = SKView()
    
    // view did load
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // add background image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "gradientBackground")
        view.addSubview(backgroundImageView)
    }
    
    // view did layout subviews - frame changed
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // set background image view frame
        backgroundImageView.frame = view.bounds
        
        // calculate game view frame
        let originalAspect: CGFloat = sceneSize.width / sceneSize.height
        let width = originalAspect * view.bounds.height
        gameView.frame = CGRect(x: (view.bounds.width - width) / 2, y: 0, width: width, height: view.bounds.height)
    }
    
    // start game
    public func startGame(rounds: Int = 8) {
        let gameScene = GameScene(totalRounds: rounds)
        gameScene.scaleMode = .aspectFit
        gameScene.backgroundColor = .clear
        gameScene.size = sceneSize
        
        gameView.presentScene(gameScene)
        gameView.allowsTransparency = true
        gameView.backgroundColor = .clear
        gameView.tintColor = .clear
        
        view.addSubview(gameView)
    }
    
}
