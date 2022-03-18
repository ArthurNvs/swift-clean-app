//  Created by Arthur Neves on 17/03/22.

import Foundation
import Presentation

public final class WeakVarProxy<T: AnyObject> {
  private weak var instance: T?
  
  init(_ instance: T) {
    self.instance = instance
  }
}

extension WeakVarProxy: AlertView where T: AlertView {
  public func showMessage(viewModel: AlertViewModel) {
    instance?.showMessage(viewModel: viewModel)
  }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
  public func display(viewModel: LoadingViewModel) {
    instance?.display(viewModel: viewModel)
  }
}
