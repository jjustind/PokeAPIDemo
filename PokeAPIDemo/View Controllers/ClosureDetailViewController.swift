//
//  ClosureDetailViewController.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/29/20.
//

import UIKit

class ClosureDetailViewController: UIViewController {

    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var name = String()
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlLabel.text = url
        nameLabel.text = name
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
