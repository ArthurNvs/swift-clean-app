//  Created by Arthur Neves on 24/03/22.

import Foundation
import UI
import Validation
import Domain
import Presentation
import Infra

public func makeLoginController(authentication: Authentication) -> LoginViewController {
  let controller = LoginViewController.instantiate()
  let validationComposite = ValidationComposite(validations: makeSignUpValidations())
  let presenter = LoginPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), authentication: authentication, loadingView: WeakVarProxy(controller))
  controller.login = presenter.login
  return controller
}

public func makeLoginValidations() -> [Validation] {
  return [
    RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
    EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
    RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"),
  ]
}
