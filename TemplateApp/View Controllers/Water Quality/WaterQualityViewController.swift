//
//  WaterQualityViewController.swift
//  Water Boi
//
//  Created by Ariel Steinlauf on 4/11/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import UIKit
import CoreLocation

class WaterQualityViewController: UIViewController {

    @IBOutlet weak var waterTableView: UITableView!

    private let reUse: String = "reUse"
    private let reUsecell: String = "reUsecell"
    private var location: CLLocationCoordinate2D?
    private var placeName: NSString?
    private var cityName: NSString?
//    private var refreshControl: UIRefreshControl

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.fetchLocationAndData), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Around Me"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let nib = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        waterTableView.register(nib, forCellReuseIdentifier: reUse)

        let nib2 = UINib(nibName: "ComplaintTableViewCell", bundle: nil)
        waterTableView.register(nib2, forCellReuseIdentifier: reUsecell)

        waterTableView.dataSource = self
        waterTableView.addSubview(refreshControl)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLocationAndData()
    }

    @objc func fetchLocationAndData() {
        LocationHelper.sharedInstance.getCurrentLocation { [weak self] (response) in
            switch response {
            case .dennied:
                self?.showError(message: "Could not determine location")
            case .error:
                self?.showError(message: "Could not determine location")
            case .success(let currentLocation):
//                self?.location = currentLocation.coordinate
                guard let sself = self else { return }
                let location = CLLocationCoordinate2D(latitude: 40.7690234883499, longitude: -73.9822995943481)

                sself.fetchData(location.latitude, long: location.longitude)
                sself.location = location

                sself.fetchCityName()
            }
        }
    }

    func fetchData(_ lat: Double, long: Double) {
        APIClient.shared.fetchComplaints(lat: lat, long: long, completionBlock: { (complaints) in
            //
        }) { [weak self] (error) in
            self?.showError(message: error)
        }
    }

    func fetchCityName() {
        guard let mylocation = self.location else {
            return
        }

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mylocation.latitude, longitude: mylocation.longitude)
        geoCoder.reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in

            let placeArray = placemarks as [CLPlacemark]!

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]

            // Address dictionary
            print(placeMark.addressDictionary)

            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
            {
                print(locationName)
            }

            // Street address // THIS
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
            {
                print(street)
                self.placeName = street

            }

            // City // THIS
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
                self.cityName = city
            }

            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
            {
                print(zip)
            }

            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
                print(country)
            }

            self.waterTableView.reloadSections([0], with: .automatic)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: false, completion: nil)
    }

}

extension WaterQualityViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reUse, for: indexPath)
            if let cell = cell as? HeaderTableViewCell {
                if let placeName = self.placeName, let cityName = self.cityName {
                    cell.placeLabel.text = "\(placeName), \(cityName)"
                }
            }
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: reUsecell, for: indexPath)
            if let cell = cell as? ComplaintTableViewCell {
                cell.complaintTitleLabel.text = "Title Goes here"
                cell.createdLabel.text = "A long time age"
                cell.addressLabel.text = "201 Street strre"
                cell.distanceLabel.text = "10 miles away"
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }

        return 22
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
