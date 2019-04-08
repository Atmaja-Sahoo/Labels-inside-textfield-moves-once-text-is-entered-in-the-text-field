//
//  ViewController.swift
//  FloatingLabelTextField
//
//  Created by Atmaja on 08/04/19.
//  Copyright © 2019 Atmaja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var floatTextfield: FloatLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}
extension ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

