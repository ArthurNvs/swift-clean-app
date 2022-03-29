//  Created by Arthur Neves on 08/03/22.

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email@mail.com", password: String? = "any_pswd", passwordConfirmation: String? = "any_pswd") -> SignUpRequest {
  return SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeLoginViewModel(email: String? = "any_email@mail.com", password: String? = "any_pswd") -> LoginRequest {
  return LoginRequest(email: email, password: password)
}
