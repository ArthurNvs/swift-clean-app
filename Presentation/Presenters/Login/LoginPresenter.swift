//  Created by Arthur Neves on 23/03/22.

import Foundation
import Domain

public class LoginPresenter {
  private let validation: Validation
  private let alertView: AlertView
  
  public init(validation: Validation, alertView: AlertView) {
    self.validation = validation
    self.alertView = alertView
  }
  
  public func login(viewModel: LoginViewModel) {
    if let message = validation.validate(data: viewModel.toJson()) {
      alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: message))
    }
  }
}
