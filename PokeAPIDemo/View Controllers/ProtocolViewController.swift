//
//  ProtocolViewController.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import UIKit

class ProtocolViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProtocolNetworkManagerDelegate {
 
    
    
    let url = "https://pokeapi.co/api/v2/pokemon?limit=151"
    var pokemon = [SinglePokemon]()
    var protocolAlert = UIAlertController()

    
    @IBOutlet var _protocolTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        _protocolTableView.delegate = self
        _protocolTableView.dataSource = self

        let protocolNetworkManager = ProtocolNetworkManager()
        protocolNetworkManager.delegate = self
        protocolNetworkManager.getNetworkData(from: url)
        showAlert(Message: "Stand by, please.", Title: "We lost the Poké flute, so we're trying dynamite.")
    }
    

    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = _protocolTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProtocolTableViewCell else { fatalError("Unable to create protocol table view cell")}
        cell.textLabel?.text = pokemon[indexPath.row].name
        return cell
    }
    //MARK: Required protocol delegate function
    func getNetworkData(data: Pokemon) {
        if let poke = data.results {
            pokemon = poke
            
            DispatchQueue.main.async {
                self._protocolTableView.reloadData()
                self.protocolAlert.dismiss(animated: true, completion: nil)
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "protocol", sender: self)
        _protocolTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = _protocolTableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            if let detailVC = segue.destination as? ProtocolDetailViewController {
                guard let name = pokemon[selectedRow].name else { return }
                guard let url = pokemon[selectedRow].url else { return }
                print(name)
                print(url)
                detailVC.name = name
                detailVC.url = url
            }
            
        }
    }
    
    fileprivate func showAlert(Message: String, Title: String) {
        protocolAlert = UIAlertController(title: Message, message: Title, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        protocolAlert.view.addSubview(activityIndicator)
        protocolAlert.view.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: protocolAlert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: protocolAlert.view.bottomAnchor, constant: -10).isActive = true
        
        present(protocolAlert, animated: true)
    }
    
    

}
