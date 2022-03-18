//  Created by Arthur Neves on 17/03/22.

import Foundation
import UI
import Validation
import Domain
import Presentation

public final class SignUpComposer {
  public static func composeControllerWith(_ addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let emailValidatorAdapter = EmailValidatorAdapter()
    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
    controller.signUp = presenter.signUp
    return controller
  }
}
