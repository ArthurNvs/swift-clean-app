//  Created by Arthur Neves on 08/03/22.

import Foundation
import Presentation

class AlertViewSpy: AlertView {
  var emit: ((AlertViewModel) -> Void)?
  
  func observe(completion: @escaping (AlertViewModel) -> Void) {
    self.emit = completion
  }
  
  func showMessage(viewModel: AlertViewModel) {
    self.emit?(viewModel)
  }
}
