//  Created by Arthur Neves on 16/03/22.

import Foundation
import UI
import Presentation
import Validation
import Domain

class ControllerFactory {
  static func makeSignUp(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let emailValidatorAdapter = EmailValidatorAdapter()
    let presenter = SignUpPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: controller)
    controller.signUp = presenter.signUp
    return controller
  }
}
