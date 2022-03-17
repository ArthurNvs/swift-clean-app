//  Created by Arthur Neves on 16/03/22.

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignUpFactory {
  static func makeController() -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let emailValidatorAdapter = EmailValidatorAdapter()
    let alamofireAdapter = AlamofireAdapter()
    let url = URL(string: "http://localhost:5050/api/signup")!
    let remoteAddAccount = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    let presenter = SignUpPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addAccount: remoteAddAccount, loadingView: controller)
    controller.signUp = presenter.signUp
    return controller
  }
}
