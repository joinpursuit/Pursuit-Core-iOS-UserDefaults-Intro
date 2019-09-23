import Foundation

class UserDefaultsWrapper {
    
    // MARK: - Static Properties
    
    static let manager = UserDefaultsWrapper()
    
    // MARK: - Internal Methods
    
    func store(fontSize: Double) {
        UserDefaults.standard.set(fontSize, forKey: fontSizeKey)
    }
    
    func store(username: String) {
        UserDefaults.standard.set(username, forKey: usernameKey)
    }
    
    func store(shouldUppercaseText: Bool) {
        UserDefaults.standard.set(shouldUppercaseText, forKey: shouldUppercaseTextKey)
    }
    
    func getFontSize() -> Double? {
        return UserDefaults.standard.value(forKey: fontSizeKey) as? Double
    }
    
    func getUsername() -> String? {
        return UserDefaults.standard.value(forKey: usernameKey) as? String
    }
    
    func getShouldUppercaseText() -> Bool? {
        return UserDefaults.standard.value(forKey: shouldUppercaseTextKey) as? Bool
    }
    
    // MARK: - Private inits and properties
    
    private init() {}
    
    private let usernameKey = "username"
    private let shouldUppercaseTextKey = "uppercaseText"
    private let fontSizeKey = "fontSize"
}
