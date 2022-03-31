//  Created by Arthur Neves on 17/03/22.

import Foundation
import UI
import Validation
import Domain
import Presentation
import Infra

public func makeSignUpController() -> SignUpViewController {
  return makeSignUpControllerWith(addAccount: makeRemoteAddAccount())
}

public func makeSignUpControllerWith(addAccount: AddAccount) -> SignUpViewController {
  let controller = SignUpViewController.instantiate()
  let validationComposite = ValidationComposite(validations: makeSignUpValidations())
  let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller), validation: validationComposite)
  controller.signUp = presenter.signUp
  return controller
}

public func makeSignUpValidations() -> [Validation] {
  return ValidationBuilder
            .field("name")
            .label("Name")
            .required()
            .build() +
          ValidationBuilder
            .field("email")
            .label("Email")
            .required()
            .email()
            .build() +
          ValidationBuilder
            .field("password")
            .label("Password")
            .required()
            .build() +
          ValidationBuilder
            .field("passwordConfirmation")
            .label("Password Confirmation")
            .sameAs("password")
            .build()
}
