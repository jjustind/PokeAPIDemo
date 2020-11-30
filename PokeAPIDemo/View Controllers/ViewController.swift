//
//  ViewController.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var _closureTableView: UITableView!
    
    let url = "https://pokeapi.co/api/v2/pokemon?limit=151"
    
    var pokemon = [SinglePokemon]()
    var alert = UIAlertController()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _closureTableView.delegate = self
        _closureTableView.dataSource = self
        
        getNetworkData()
        showAlert(Message: "Stand by, Please.", Title: "This Snorlax isn't going to wake itself.")
    }
    
    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = _closureTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ClosureTableViewCell else { fatalError("Unable to initialize table view cell") } // Do not return this in a production build. There are plenty of ways to handle this failure gracefully, but this isn't one of them.
        
        cell.nameLabel.text = pokemon[indexPath.row].name
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "closure", sender: self)
        _closureTableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func getNetworkData() {
        NetworkManager.shared.getNetworkData(from: url) { (result) in
            switch result {
            case .success(let returns):
                
                if let poke = returns.results {
                    self.pokemon = poke
                    
                    DispatchQueue.main.async {
                        self._closureTableView.reloadData()
                        self.alert.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    fileprivate func showAlert(Message: String, Title: String) {
        alert = UIAlertController(title: Message, message: Title, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -10).isActive = true
        
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = _closureTableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            if let detailVC = segue.destination as? ClosureDetailViewController {
                guard let name = pokemon[selectedRow].name else { return }
                guard let url = pokemon[selectedRow].url else { return }
                print(name)
                print(url)
                detailVC.name = name
                detailVC.url = url
            }
            
        }
    }



}

