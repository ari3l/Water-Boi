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

    private let apiURL = "http://6a4b3a09.ngrok.io/waterdata"

    func fetchComplaints(lat: Double, long: Double) {
        guard let url = URL(string: apiURL + "?lat=\(lat)&long=\(long)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {

                } else {
                    // Error
                }

            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }

        }.resume()

    }
}
