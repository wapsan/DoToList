import UIKit
import SnapKit

class MainStyleViewController: UIViewController {
    
    //MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    //MARK: - GUI Properties
    lazy var backgroumdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewController()
    }
    
    //MARK: - Private methods
    private func setUpViewController() {
        self.backgroumdImageView.image = UIImage(named: "backgroundImage")
        self.view.addSubview(self.backgroumdImageView)
        self.setUpConstraints()
    }
    
    //MARK: - Constraints
    private func setUpConstraints() {
        self.backgroumdImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeArea.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
