//  Created by Arthur Neves on 16/03/22.

import Foundation
import UI
import Validation
import Domain
import Presentation

class ControllerFactory {
  static func makeSignUpViewController(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let emailValidatorAdapter = EmailValidatorAdapter()
    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
    controller.signUp = presenter.signUp
    return controller
  }
}
