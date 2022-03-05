//  Created by Arthur Neves on 05/03/22.

import Foundation

public class SignUpPresenter {
  private let alertView: AlertView
  
  public init(alertView: AlertView) {
    self.alertView = alertView
  }
  
  // Presenter sends to AlertView the message (after logic)
  public func signUp(viewModel: SignUpViewModel) {
    if let message = validate(viewModel: viewModel) {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: message))
    }
  }
  
  private func validate(viewModel: SignUpViewModel) -> String? {
    if viewModel.name == nil || viewModel.name!.isEmpty {
      return "Name is required"
    } else if viewModel.email == nil || viewModel.email!.isEmpty {
      return "Email is required"
    } else if viewModel.password == nil || viewModel.password!.isEmpty {
      return "Password is required"
    } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
      return "Password confirmation is required"
    }
    return nil
  }
}

public struct SignUpViewModel {
  public var name: String?
  public var email: String?
  public var password: String?
  public var passwordConfirmation: String?
  
  public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
    self.name = name
    self.email = email
    self.password = password
    self.passwordConfirmation = passwordConfirmation
  }
}
