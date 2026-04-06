//
//  AddNewAddressControllerTableViewController.swift
//  MVC_Swift_Demo
//
//  Created by Sakir Saiyed on 21/05/25.
//

import UIKit

protocol AddAddressDelegate: AnyObject {
    func didAddAddress(_ address: Address)
}

class AddNewAddressController: UITableViewController {
    
    
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    weak var delegate: AddAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cancelTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAddressTapped(_ sender: UIBarButtonItem) {
        let streetName = streetTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let city = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let state = stateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let zipcode = zipcodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !streetName.isEmpty, !city.isEmpty, !state.isEmpty, !zipcode.isEmpty else {
            let alert = UIAlertController(title: "Missing Fields", message: "All fields are required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let newAddress = Address(street: streetName, city: city, zipcode: zipcode, state: state)
        delegate?.didAddAddress(newAddress)

        navigationController?.popViewController(animated: true)
    }
    
}
