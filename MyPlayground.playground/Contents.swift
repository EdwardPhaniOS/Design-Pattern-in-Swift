import UIKit

var str = "Hello, playground"

// MARK: - Singleton
let app = UIApplication.shared
// let app2 = UIApplication()

// MARK: - Singleton Plus
let defaultFileManager = FileManager.default
let customFileManager = FileManager()

public class MySingletonPlus {
    // 1
    static let shared = MySingletonPlus()
    // 2
    public init() { }
}
// 3
let singletonPlus = MySingletonPlus.shared
// 4
let singletonPlus2 = MySingletonPlus()
