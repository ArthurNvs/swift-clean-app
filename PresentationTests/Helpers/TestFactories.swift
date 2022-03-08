//  Created by Arthur Neves on 08/03/22.

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email@mail.com", password: String? = "any_pswd", passwordConfirmation: String? = "any_pswd") -> SignUpViewModel {
  return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
  return AlertViewModel(title: "Validation failed", message: "\(fieldName) is required")
}

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
  return AlertViewModel(title: "Validation failed", message: "\(fieldName) is not valid")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
  return AlertViewModel(title: "Error", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
  return AlertViewModel(title: "Success", message: message)
}
