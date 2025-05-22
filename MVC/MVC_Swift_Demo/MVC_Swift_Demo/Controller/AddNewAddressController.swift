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
        print("Street: \(streetTextField.text ?? "")")
        print("City: \(cityTextField.text ?? "")")
        print("State: \(stateTextField.text ?? "")")
        print("Zipcode: \(zipcodeTextField.text ?? "")")
        
        let streetName = streetTextField.text ?? ""
        let city = self.cityTextField.text ?? ""
        let state = self.stateTextField.text ?? ""
        let zipcode = self.zipcodeTextField.text ?? ""
        
        let newAddress : Address = Address(street: streetName, city: city, zipcode: zipcode, state: state)
        
        print(newAddress)
        delegate?.didAddAddress(newAddress)
        
        navigationController?.popViewController(animated: true)
    }
    
}
