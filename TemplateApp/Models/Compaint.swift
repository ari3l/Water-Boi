//
//  Compaint.swift
//  Water Boi
//
//  Created by Ariel Steinlauf on 4/11/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import Foundation
import CoreLocation
struct Complaint {

    /*
     "Created Date": "03/31/2018 02:12:00 PM",
     "Latitude": 40.7691606266,
     "Complaint": "Taste/Odor, Chlorine (QA1)",
     "Borough": "MANHATTAN",
     "Incident Address": "446 WEST   58 STREET",
     "Closed Date": "04/02/2018 07:16:00 AM",
     "Incident Zip": 10019.0,
     "Unique ID": "38829867",
     "Complaint Type": "Water Quality",
     "Longitude": -73.9865845071
     */
    var uniqueId: String
    var createdDate: Date
    var closedDate: Date
    var complaintType: String
    var complaint: String
    var coordinate: CLLocationCoordinate2D
//    var descriptor: String
//    var zip: String
    var address: String

    init?(json: [String: Any]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM/dd/yyyy h:mm:ss a"

        guard let uniqueId = json["Unique ID"] as? String,
            let complaintType = json["Complaint Type"] as? String,
            let complaint = json["Complaint"] as? String,
            let address = json["Incident Address"] as? String,
            let createdDateString = json["Created Date"] as? String,
            let closedDateString = json["Closed Date"] as? String,
            let closedDate = dateFormatter.date(from: closedDateString),
            let createdDate = dateFormatter.date(from: createdDateString),
            let long = json["Longitude"] as? Double,
            let lat = json["Latitude"] as? Double
        else {
            return nil
        }

        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.uniqueId = uniqueId
        self.complaintType = complaintType
        self.complaint = complaint
        self.address = address
        self.closedDate = closedDate
        self.createdDate = createdDate

    }
}
