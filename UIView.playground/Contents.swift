//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class ScoreListHeaderLabel: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 240.0, height: 80.0)
    }
    
    override func draw(_ rect: CGRect) {
        let bannerHeight: CGFloat = round(2.0 * rect.size.height / 3.0)
        let bannerIndent: CGFloat = bannerHeight * 0.25
        let bannerYStart: CGFloat = round(rect.size.height / 3.0)
        
        let bannerBottomWidth = rect.size.width * 0.16
        let bannerFoldWidth = bannerBottomWidth * 0.33
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0.0, y: bannerYStart))
        
    }

}

class MyViewController : UIViewController {
    override func loadView() {
        print("Loading view")
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(origin: .zero, size: CGSize(width: 320.0, height: 480.0))

        let header = ScoreListHeaderLabel(frame: .zero)
        let size = header.intrinsicContentSize
        header.frame = CGRect(origin: .zero, size: size)

        view.addSubview(header)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

