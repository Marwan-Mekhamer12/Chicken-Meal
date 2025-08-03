//
//  FetchData.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import Foundation

protocol APIData {
    
    func fetchData(_ Completion: @escaping ([AllMeals]) -> Void)
    func parameJson(_ data: Data,_ Completion: @escaping ([AllMeals]) -> Void)
}

class FetchDataLogic: APIData {
    
    func fetchData(_ Completion: @escaping ([AllMeals]) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            // First check for errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
                return
            }
            
            // Check HTTP status
            if let httpResponse = response as? HTTPURLResponse {
                print("🔍 HTTP Status: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    print("⚠️ Unexpected status code")
                }
            }
            
            // Check if data exists
            guard let data = data else {
                print("❌ No data received")
                return
            }
            
            // Print raw response (first 200 characters)
            let rawResponse = String(data: data, encoding: .utf8) ?? "Unable to decode data"
            print("📦 Raw response (first 200 chars): \(rawResponse.prefix(200))")
            
            // Continue with parsing
            self.parameJson(data, Completion)
        }
        task.resume()
    }
    
    func parameJson(_ data: Data, _ Completion: @escaping ([AllMeals]) -> Void) {
        do {
            // Print raw JSON for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 Raw JSON response:", jsonString.prefix(500), "...")
            }
            
            let decoded = try JSONDecoder().decode(ManagerBrain.self, from: data)
            
            if !decoded.meals.isEmpty {
                print("First meal:", decoded.meals[0].strMeal)
            }
            Completion(decoded.meals)
        } catch {
            Completion([]) // Always call completion
        }
    }
}
