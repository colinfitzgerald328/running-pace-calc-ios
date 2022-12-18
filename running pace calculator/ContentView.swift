import UIKit

class ViewController: UIViewController {
    
    // Declare three UITextFields for the inputs
    let input1TextField = UITextField()
    let input2TextField = UITextField()
    let input3TextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the input text fields
        input1TextField.placeholder = "Input 1"
        input1TextField.borderStyle = .roundedRect
        input2TextField.placeholder = "Input 2"
        input2TextField.borderStyle = .roundedRect
        input3TextField.placeholder = "Input 3"
        input3TextField.borderStyle = .roundedRect
        
        // Add the input text fields to the view
        view.addSubview(input1TextField)
        view.addSubview(input2TextField)
        view.addSubview(input3TextField)
        
        // Set up the layout constraints for the input text fields
        input1TextField.translatesAutoresizingMaskIntoConstraints = false
        input1TextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        input1TextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        input1TextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        input2TextField.translatesAutoresizingMaskIntoConstraints = false
        input2TextField.topAnchor.constraint(equalTo: input1TextField.bottomAnchor, constant: 20).isActive = true
        input2TextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        input2TextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        input3TextField.translatesAutoresizingMaskIntoConstraints = false
        input3TextField.topAnchor.constraint(equalTo: input2TextField.bottomAnchor, constant: 20).isActive = true
        input3TextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        input3TextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}

