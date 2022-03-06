//  Created by Arthur Neves on 05/03/22.

import Foundation
import Domain

public class SignUpPresenter {
  private let alertView: AlertView
  private let emailValidator: EmailValidator
  private let addAccount: AddAccount
  
  public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount) {
    self.alertView = alertView
    self.emailValidator = emailValidator
    self.addAccount = addAccount
  }
  
  // Presenter sends to AlertView the message (after logics)
  public func signUp(viewModel: SignUpViewModel) {
    if let message = validate(viewModel: viewModel) {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: message))
    } else {
      let addAccountModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
      addAccount.add(addAccountModel: addAccountModel) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Something went wrong, try again later."))
        case .success: break
        }
      }
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
    } else if viewModel.password != viewModel.passwordConfirmation {
      return "Password is not valid"
    } else if !emailValidator.isValid(email: viewModel.email!) {
      return "Email is not valid"
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
