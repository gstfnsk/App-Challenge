//
//  ViewController.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 09/06/25.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SavingAndFetchOnCK.savePublicData(nameInput: "teste3", descriptionInput: "testeandoo")
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
}
