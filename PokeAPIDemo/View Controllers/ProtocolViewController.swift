//
//  ProtocolViewController.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import UIKit

class ProtocolViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var _protocolTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        _protocolTableView.delegate = self
        _protocolTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell() 
    }

}
