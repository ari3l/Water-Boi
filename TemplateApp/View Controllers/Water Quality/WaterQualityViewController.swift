//
//  WaterQualityViewController.swift
//  Water Boi
//
//  Created by Ariel Steinlauf on 4/11/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import UIKit

class WaterQualityViewController: UIViewController {

    @IBOutlet weak var waterTableView: UITableView!

    private let reUse: String = "reUse"
    private let reUsecell: String = "reUsecell"

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLocationAndData()
    }

    func fetchLocationAndData() {
        LocationHelper.sharedInstance.getCurrentLocation { [weak self] (response) in
            switch response {
            case .dennied:
                self?.showError(message: "Could not determine location")
            case .error:
                self?.showError(message: "Could not determine location")
            case .success(let currentLocation):

                self?.fetchData(currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude)
            }
        }
    }

    func fetchData(_ lat: Double, long: Double) {
        
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
            return tableView.dequeueReusableCell(withIdentifier: reUse, for: indexPath)
        } else {
            return tableView.dequeueReusableCell(withIdentifier: reUsecell, for: indexPath)
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
