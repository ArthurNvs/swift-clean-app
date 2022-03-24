//  Created by Arthur Neves on 23/03/22.

import Foundation
import Domain

public class LoginPresenter {
  private let validation: Validation
  private let alertView: AlertView
  private let authentication: Authentication
  private let loadingView: LoadingView
  
  public init(validation: Validation, alertView: AlertView, authentication: Authentication, loadingView: LoadingView) {
    self.validation = validation
    self.alertView = alertView
    self.authentication = authentication
    self.loadingView = loadingView
  }
  
  public func login(viewModel: LoginViewModel) {
    if let message = validation.validate(data: viewModel.toJson()) {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: message))
    } else {
      loadingView.display(viewModel: LoadingViewModel(isLoading: true))
      authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .failure(let error):
          var errorMessage: String!
          switch error {
          case .expiredSession:
            errorMessage = "Invalid email or password."
          default:
            errorMessage =  "Something went wrong, try again later."
          }
          self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: errorMessage))
        case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Welcome!"))
        }
        self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
      }
    }
  }
}
