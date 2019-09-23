import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var welcomeMessageLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var fontSizeSlider: UISlider!
    @IBOutlet var uppercaseTextSwitch: UISwitch!
    
    @IBOutlet var allLabels: [UILabel]!

    // MARK: - Private Properties
    
    var fontSize: Double = 10 {
        didSet {
            allLabels.forEach { $0.font = $0.font.withSize(CGFloat(fontSize)) }
            UserDefaultsWrapper.manager.store(fontSize: fontSize)
        }
    }
    
    var uppercaseText = false {
        didSet {
            switch uppercaseText {
            case true:
                allLabels.forEach { $0.text = $0.text?.uppercased() }
            case false:
                allLabels.forEach { $0.text = $0.text?.lowercased() }
            }
            UserDefaultsWrapper.manager.store(shouldUppercaseText: uppercaseText)
        }
    }
    
    var username = "" {
        didSet {
            welcomeMessageLabel.text = "Welcome " + username + "!"
            UserDefaultsWrapper.manager.store(username: username)
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        setInitialValuesFromUserDefaults()
    }
    
    // MARK: - Private Methods
    
    private func setInitialValuesFromUserDefaults() {
        if let storedUsername = UserDefaultsWrapper.manager.getUsername() {
            usernameTextField.text = storedUsername
            username = storedUsername
        }
        if let storedFontSize = UserDefaultsWrapper.manager.getFontSize() {
            fontSizeSlider.value = Float(storedFontSize)
            fontSize = storedFontSize
        }
        if let storedUppercaseText = UserDefaultsWrapper.manager.getShouldUppercaseText() {
            uppercaseTextSwitch.isOn = storedUppercaseText
            uppercaseText = storedUppercaseText
        }
    }

    // MARK: - IBActions
    
    @IBAction func updateFontSize(_ sender: UISlider) {
        fontSize = Double(sender.value)
    }

    @IBAction func updateUppercaseText(_ sender: UISwitch) {
        uppercaseText = sender.isOn
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // https://stackoverflow.com/questions/25621496/how-shouldchangecharactersinrange-works-in-swift
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            username = updatedText
        }
        return true
    }
}


