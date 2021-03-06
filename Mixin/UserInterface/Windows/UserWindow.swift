import Foundation
import SDWebImage

class UserWindow: BottomSheetView {

    @IBOutlet weak var containerView: UIView!

    private let userView = UserView.instance()

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addSubview(userView)
        userView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }

    override func dismissPopupControllerAnimated() {
        if popupView is UIImageView {
            isShowing = false
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
                self.popupView.bounds.size = .zero
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        } else {
            CATransaction.perform(blockWithTransaction: dismissView, completion: {
                self.removeFromSuperview()
            })
        }
    }

    @discardableResult
    func updateUser(user: UserItem, animated: Bool = false, refreshUser: Bool = true) -> UserWindow {
        userView.updateUser(user: user, animated: animated, refreshUser: refreshUser, superView: self)
        return self
    }

    class func instance() -> UserWindow {
        return Bundle.main.loadNibNamed("UserWindow", owner: nil, options: nil)?.first as! UserWindow
    }
}
