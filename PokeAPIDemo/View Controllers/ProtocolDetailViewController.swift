//
//  ProtocolDetailViewController.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/29/20.
//

import UIKit

class ProtocolDetailViewController: UIViewController {
    
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var name = String()
    var url = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        urlLabel.text = url
        nameLabel.text = name
        
    }
    

}
