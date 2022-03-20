//  Created by Arthur Neves on 17/03/22.

import Foundation
import UI
import Validation
import Domain
import Presentation
import Infra

public final class SignUpComposer {
  public static func composeControllerWith(_ addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeValidations())
    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller), validation: validationComposite)
    controller.signUp = presenter.signUp
    return controller
  }
  
  public static func makeValidations() -> [Validation] {
    return [
      RequiredFieldValidation(fieldName: "name", fieldLabel: "Name"),
      RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
      EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
      RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"),
      RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Password Confirmation"),
      CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password Confirmation")
    ]
  }
}
