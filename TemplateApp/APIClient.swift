//
//  APIClient.swift
//  Water Boi
//
//  Created by Ariel Steinlauf on 4/11/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import Foundation

class APIClient {
    static let shared: APIClient = APIClient()

    private let apiURL = "http://9a63fe00.ngrok.io/waterdata"

    func fetchComplaints(lat: Double, long: Double, completionBlock: @escaping ([Complaint])-> Void, errorBlock: @escaping (String) -> Void) {
        print("Startig req")
        guard let url = URL(string: apiURL + "?lat=\(lat)&long=\(long)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String, Any>> {

                    var arrComplains: [Complaint] = []
                    for dict in json {
                        if let comp = Complaint(json: dict) {
                            arrComplains.append(comp)
                        }
                    }

                    completionBlock(arrComplains)

                } else {
                    // Error
                    errorBlock("There was an error getting the data")
                }

            } catch let error {
                errorBlock(error.localizedDescription)
            }

        }.resume()

    }
}
