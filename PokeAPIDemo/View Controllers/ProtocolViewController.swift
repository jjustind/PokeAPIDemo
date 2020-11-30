//
//  ProtocolViewController.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import UIKit

class ProtocolViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProtocolNetworkManagerDelegate {
 
    let url = "https://pokeapi.co/api/v2/pokemon?limit=151" // Endpoint
    var pokemon = [SinglePokemon]() // This is populated via the delegate method called from the Protocol Network Manager
    var protocolAlert = UIAlertController() // This will show while the app is calling out for data

    @IBOutlet var _protocolTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _protocolTableView.delegate = self // TableView required statement, it needs to know where its delegate methods are being called from
        _protocolTableView.dataSource = self // The TableView needs to know where its data is coming from

        let protocolNetworkManager = ProtocolNetworkManager() // This is an instance of our network data protocol
        protocolNetworkManager.delegate = self // This populates the delegate variable, all objects that populate this variable will get their local instances of the protocol method called when the hosting class calls it.
        protocolNetworkManager.getNetworkData(from: url) // We ask for our data here.
        showAlert(Message: "Stand by, please.", Title: "We lost the Poké flute, so we're trying dynamite.") // This is to interrupt the users ability to interact with the screen whilst the network call is being made. Apple recommends against doing this. I do it anyway.
            
            // Dear Apple: (•_•) ( •_•)>⌐■-■ (⌐■_■) Deal with it.
    }
    
    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count // The UITableView will ascertain its total number of rows from this delegate method.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // our repeated cells are created here. I use guard to ensure that IF something goes wrong and I can't instantiate a cell, (this is an exceptionally rare event) I have a way to deal with it in the closure of the guard statement.
        guard let cell = _protocolTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProtocolTableViewCell else { fatalError("Unable to create protocol table view cell")}
        cell.textLabel?.text = pokemon[indexPath.row].name // The textLabel view is provided with ALL UITableViewCells by default. You don't have to use it, you can completely override the cell and its view. I did that in the first view controller, however, with this one I went with the default view. I did this to show how they are visually different.
        return cell
    }
    
    //MARK: Required protocol delegate function
    func getNetworkData(data: Pokemon) { // The protocol's hosting class callst his method and returns the Pokemon data we pulled in from that hosting class. We can do whatever we want here.
        
        if let poke = data.results {
            pokemon = poke
            
            // Grand Central Dispatch is your best friend. DispatchQueue.main.async is but one of many things GCD can do.
            DispatchQueue.main.async {
                
                // ALL UI CHANGES MUST BE DONE ON THE MAIN THREAD - XCODE HAS A THREAD SANITIZER. USE IT AND LOVE IT. IT IS YOUR BEST FRIEND. UI OBJECTS CALLED IN CLOSURES ARE >NOT< ON THE MAIN THREAD BY DEFAULT. THIS IS WHY THEY USE THE 'SELF' PREFEX. IF XCODE DEMANDS FOR YOU TO ADD 'SELF.' TO AN OBJECT, YOU ARE IN A CLOSURE AND NOT ON THE MAIN THREAD.
                
                // UI👏OBJECTS👏STAY👏ON👏THE👏MAIN👏THREAD👏NO👏EXCEPTIONS👏.
                
                self._protocolTableView.reloadData() // Once we've got our data, the tableView needs to be reloaded because its already rendered with an empty Pokemon array. But at this point, we know are data is present and populating our local array, so we can safely reload the tableView here.
                self.protocolAlert.dismiss(animated: true, completion: nil) // No need in keeping that alert controller around if we know we have our data.
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "protocol", sender: self)
        _protocolTableView.deselectRow(at: indexPath, animated: true) // This seems cointerintuitive, but if you don't call this, the tableView row you have selected (even upon returning to the parent view after viewing the detail view) will remain selected until you select something else. This just auto-deselects after you tap the row for you.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // This method is called when the users asks the app to performa segue. Using the segue parameter.
        if let indexPath = _protocolTableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            if let detailVC = segue.destination as? ProtocolDetailViewController { // by checking that the segue's destination view controller is of a particular class, you can gain access to the variables and methods of that particular class.
                guard let name = pokemon[selectedRow].name else { return } // Sanity check
                guard let url = pokemon[selectedRow].url else { return } // Sanity Check
                print(name) // Unlike Unity, the Swift compiler will ignore print statements.
                print(url)
                detailVC.name = name // these two variables are members of the ProtocolDetailViewController class. We're able to access them because we gained access to the destination views' class type via nil coalescence.
                detailVC.url = url
            }
        }
    }
    
    fileprivate func showAlert(Message: String, Title: String) { // This is just a conveinence method. You can really call this anywhere, but Alert Controllers are annoying with how much boilter plate code they require, so I often build functions like this just so I don't go insane.
        
        protocolAlert = UIAlertController(title: Message, message: Title, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        protocolAlert.view.addSubview(activityIndicator)
        protocolAlert.view.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: protocolAlert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: protocolAlert.view.bottomAnchor, constant: -10).isActive = true // I can't access the view via the Storyboard, so I have no choice but to use programmatic layout with the activityindicator. 
        
        present(protocolAlert, animated: true)
    }
    
    

}
