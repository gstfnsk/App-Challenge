//
//  ViewController.swift
//  MapKitTest
//
//  Created by Gustavo Ferreira bassani on 11/06/25.
//

import UIKit
import MapKit
import CoreLocation

class MapKitSpike: UIViewController, CLLocationManagerDelegate {
    
    // Optional region where the map should start centered
    var region: MKCoordinateRegion? = nil
    
    // Converts address strings into geographic coordinates
    let geocoder = CLGeocoder()
    
    // Suggests possible addresses or places as the user types
    var searchCompleter = MKLocalSearchCompleter()
    
    // List of search suggestions based on user input (contains title and subtitle, not just plain strings)
    var searchResults = [MKLocalSearchCompletion]()
    
    // Utility method to generate CLLocationCoordinate2D from latitude and longitude values
    func fetchLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocationCoordinate2D {
        let latitude: CLLocationDegrees = latitude
        let longitude: CLLocationDegrees = longitude
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        return location
    }
    
    // Centers the map on a specific coordinate with a defined zoom level
    func centerMap(regionToCenter: CLLocationCoordinate2D) {
        let visibleArea = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        let searchedRegionToCenter: MKCoordinateRegion = MKCoordinateRegion(center: regionToCenter, span: visibleArea)
        mapView.setRegion(searchedRegionToCenter, animated: true)
    }
    
    // TextField where the user types the address
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        let attributedString = NSAttributedString(string: "endereço aqui", attributes: [.foregroundColor : UIColor.black])
        textField.attributedPlaceholder = attributedString
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    
    // Button that triggers the address lookup and map update
    lazy var button:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.setTitle("Enter with adress", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        return button
    }()
    
    // Button action to geocode the address, add a map pin, and center the map
    @objc func buttonAction() {
        guard let adress = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !adress.isEmpty else {
            print("Error: Address not provided")
            return
        }
        // Convert address string to coordinates
        geocoder.geocodeAddressString(adress) { [self] placeMark, error in
            if error != nil {
                print("Error converting address to coordinates")
                return
            }
            // Use first result if available
            if let placeMarkToLocation = placeMark?.first, let locationCLLocationCordinate = placeMarkToLocation.location {
                // Set annotation coordinates and title based on the typed address
                pointNotation.coordinate = locationCLLocationCordinate.coordinate
                pointNotation.title = adress
                mapView.addAnnotation(pointNotation)
                centerMap(regionToCenter: locationCLLocationCordinate.coordinate)
            }
        }
    }
    
    // Table view that displays suggestions as the user types
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = 16
        table.backgroundColor = .white
        return table
    }()
    
    // Main map view setup
    lazy var  mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        // Set initial region if available
        if let region {
            print(region)
            map.setRegion(region , animated: true)
        }
        return map
    }()
    
    // Reusable map annotation (pin) object
    lazy var pointNotation: MKPointAnnotation = {
        let note = MKPointAnnotation()
        note.title = textField.text
        return note
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        // Configure MKLocalSearchCompleter
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        
        // Setup all subviews and constraints
        setup()
    }
}

extension MapKitSpike {
    
    // Layout setup for all UI elements
    func setup() {
        view.addSubview(mapView)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 100),
        ])
    }
}

extension MapKitSpike: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows based on the number of search results
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    // Configure each cell with the address suggestion (title and subtitle)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        let selectedResults = searchResults[indexPath.row]
        let fullAdress = "\(selectedResults.title), \(selectedResults.subtitle)"
        cell.textLabel?.text = "\(fullAdress)"
        return cell
    }
    
    // When a suggestion is selected, fill the text field with the full address
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResults = searchResults[indexPath.row]
        let fullAdress = "\(selectedResults.title), \(selectedResults.subtitle)"
        textField.text = fullAdress
    }
}

extension MapKitSpike: UITextFieldDelegate {
    
    // Update the searchCompleter's query fragment as the user types
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return true }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        searchCompleter.queryFragment = updateText
        return true
    }
}

extension MapKitSpike: MKLocalSearchCompleterDelegate {
    
    // When new suggestions are received, update the results and reload the table
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    // Handle possible error from the search completer
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error in search completer:", error.localizedDescription)
    }
}
