//
//  SearchBarSpike.swift
//  filtersTest
//
//  Created by Gustavo Ferreira bassani on 12/06/25.
//

import UIKit

class SearchBarSpike: UIViewController {
    // Array holding all job titles
    var works: [String] = ["garçom 1", "recepcionista 1", "cozinheiro 1", "garçom 2", "garçom 3", "cozinheiro 2", "recepcionista 2", "garçom 4", "copa 1", "copa 2", "serviços auxiliares 1"]
    
    // Array holding filtered job titles based on search input
    var filteredWorks: [String] = []
    
    // Lazy initialization of UITableView to display the list of jobs
    lazy var tableview: UITableView = {
       let table = UITableView()
       table.translatesAutoresizingMaskIntoConstraints = false
       
       // Setting the data source and delegate for the table view
       table.dataSource = self
       table.delegate = self
       
       // Set background color of the table view
       table.backgroundColor = UIColor.white
       
       // Register default UITableViewCell for reuse
        table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)

       return table
    }()
    
    // Lazy initialization of UISearchController to enable search functionality
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        
        // Assign self as updater to handle search text changes
        sc.searchResultsUpdater = self
        
        // Do not obscure background when search bar is active
        sc.obscuresBackgroundDuringPresentation = false
        
        // Placeholder text shown in the search bar
        sc.searchBar.placeholder = "Buscar..."
        
        // Customize the placeholder text color inside the search bar's text field
        if let textField = sc.searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(
                string: "Buscar...",
                attributes: [.foregroundColor: UIColor.blue]
            )
            // Set the text color inside the search bar to black
            textField.textColor = .black
        }
        return sc
    }()
    
    // Helper function to check if filtering (search) is active and search text is not empty
    func isFiltering() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Activate the search controller immediately when view loads
        searchController.isActive = true
        
        // Call setup function to configure the UI elements and constraints
        setup()
    }
}

// MARK: - Setup UI and Layout
extension SearchBarSpike {
    func setup() {
        // Set navigation bar title
        title = "busca de trabalhos"
        
        // Print to console if the view controller is inside a UINavigationController
        print("Estou dentro de UINavigationController?", navigationController != nil)
        
        // Assign the search controller to the navigation item's search controller property
        navigationItem.searchController = searchController
        
        // Set background color of the search bar to white
        searchController.searchBar.backgroundColor = .white
        
        // Globally set the text color of UITextField contained inside UISearchBar to black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .black

        // Keep search bar visible when scrolling the table view
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Set the main view's background color to red (likely for debugging or design)
        view.backgroundColor = .red
        
        // Add the table view as a subview
        view.addSubview(tableview)
        
        // Ensure that the search controller does not remain on screen if another view controller is pushed
        definesPresentationContext = true

        // Setup Auto Layout constraints for the table view to fill the entire view safely
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}

// MARK: - UITableView Delegate & Data Source Methods
extension SearchBarSpike: UITableViewDelegate, UITableViewDataSource {
    // Return number of rows depending on whether filtering is active or not
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredWorks.count : works.count
    }
    
    // Configure each table view cell to show either filtered or full list item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        
        let item = isFiltering() ? filteredWorks[indexPath.row] : works[indexPath.row]
        
        // Set cell text to filtered or full array element
        cell?.config(title: item)
        

        return cell ?? UITableViewCell()
    }
    
    private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> Double {
        return 120 // ou outro valor fixo
    }
}
// MARK: - UISearchResultsUpdating Protocol Implementation
extension SearchBarSpike: UISearchResultsUpdating {
    // Called whenever the search bar text changes
    func updateSearchResults(for searchController: UISearchController) {
        // Get the current text from the search bar
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            // If search bar is empty, show full list and reload table view
            filteredWorks = works
            tableview.reloadData()
            return
        }
        
        // Filter the works array based on case-insensitive containment of the search text
        filteredWorks = works.filter { $0.localizedCaseInsensitiveContains(text) }
        
        // Reload table view to update the displayed data
        tableview.reloadData()
    }
}
