//
//  AddressViewController.swift
//  MVC_Swift_Demo
//
//  Created by Sakir Saiyed on 21/05/25.
//

import Foundation
import UIKit


class AddressViewController: UITableViewController, AddAddressDelegate {
    
    var addressArray = [Address]()
    
    func didAddAddress(_ address: Address) {
        addressArray.append(address)
        tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(addressArray.count == 0 ){
            let addressObject = Address(street: "102 945th Steet NW", city: "Edmonton", zipcode: "T6K04", state: "Alberta")
            addressArray.append(addressObject)
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return addressArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AddressViewCell

        // Configure the cell...
        let address = addressArray[indexPath.section]
        cell.nameLabel?.text = address.street
        cell.cityLabel?.text = address.city
        cell.stateLabel?.text = address.state
        cell.zipcodeLabel?.text = address.zipcode
         
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Address #\(section + 1)"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddAddressSegue" {
            if let destinationVC = segue.destination as? AddNewAddressController {
                destinationVC.delegate = self
            }
        }
    }
     
}
