//  Created by Arthur Neves on 08/03/22.

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension SignUpViewController: LoadingView {
  func display(viewModel: LoadingViewModel) {
    if viewModel.isLoading {
      loadingIndicator?.startAnimating()
    } else {
      loadingIndicator?.stopAnimating()
    }
  }
}
