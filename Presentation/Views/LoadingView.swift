//  Created by Arthur Neves on 06/03/22.

import Foundation

public protocol LoadingView: class {
  func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
  public var isLoading: Bool
  
  public init(isLoading: Bool) {
    self.isLoading = isLoading
  }
}
