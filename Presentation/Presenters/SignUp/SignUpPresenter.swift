//  Created by Arthur Neves on 05/03/22.

import Foundation
import Domain

public class SignUpPresenter {
  private weak var alertView: AlertView?
  private let emailValidator: EmailValidator
  private let addAccount: AddAccount
  private weak var loadingView: LoadingView?
  
  public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView) {
    self.alertView = alertView
    self.emailValidator = emailValidator
    self.addAccount = addAccount
    self.loadingView = loadingView
  }
  
  // Presenter sends to AlertView the message (after logics)
  public func signUp(viewModel: SignUpViewModel) {
    if let message = validate(viewModel: viewModel) {
      alertView?.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: message))
    } else {
      loadingView?.display(viewModel: LoadingViewModel(isLoading: true))
      addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .failure: self.alertView?.showMessage(viewModel: AlertViewModel(title: "Error", message: "Something went wrong, try again later."))
        case .success: self.alertView?.showMessage(viewModel: AlertViewModel(title: "Success", message: "Account created."))
        }
        self.loadingView?.display(viewModel: LoadingViewModel(isLoading: false))
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
