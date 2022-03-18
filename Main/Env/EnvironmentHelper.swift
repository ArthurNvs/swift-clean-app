//  Created by Arthur Neves on 17/03/22.

import Foundation

public final class EnvironmentHelper {
  // Should contain all environment variables
  public enum EnvironmentVariables: String {
    case apiBaseUrl = "API_BASE_URL"
  }
  public static func variable(_ key: EnvironmentVariables) -> String {
    // Reads key inside Info.plist
    return Bundle.main.infoDictionary![key.rawValue] as! String
  }
}
