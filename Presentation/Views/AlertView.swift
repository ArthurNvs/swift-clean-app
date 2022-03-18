//  Created by Arthur Neves on 05/03/22.

import Foundation

public protocol AlertView {
  func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
  public var title: String
  public var message: String
  
  public init(title: String, message: String) {
    self.title = title
    self.message = message
  }
}
