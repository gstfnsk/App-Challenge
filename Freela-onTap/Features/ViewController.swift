//
//  ViewController.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 09/06/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewwww: EmptyStateCompanyJobs = {
      let view = EmptyStateCompanyJobs()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(viewwww)
        NSLayoutConstraint.activate([
            viewwww.topAnchor.constraint(equalTo: view.topAnchor),
            viewwww.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewwww.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewwww.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
