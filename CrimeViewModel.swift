//
//  CrimeViewModel.swift
//  ClassProject
//
//  Created by Anuj Kamasamudram on 4/16/24.
//

import Foundation
import CoreData

class CrimeViewModel: ObservableObject {
    @Published var crimeData: [CrimeData] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
    }
    
    func fetchCrimeData(zipcode: String) {
        isLoading = true
        let headers = [
            "X-RapidAPI-Key": "b97bcc9ff3msh3b646f9036c96cep1a1ec4jsn155e8efb86f5",
            "X-RapidAPI-Host": "crime-data-by-zipcode-api.p.rapidapi.com"
        ]

        guard let url = URL(string: "https://crime-data-by-zipcode-api.p.rapidapi.com/crime_data?zip=\(zipcode)") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let self = self else { return }
                        
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                        
                guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Error with the response, unexpected status code: \(String(describing: (response as? HTTPURLResponse)?.statusCode))"
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(CrimeData.self, from: data)
                    DispatchQueue.main.async {
                        self.saveCrimes(crimeData: responseData)
                    }
                } catch {
                    self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    private func saveCrimes(crimeData: CrimeData) {
        viewContext.perform {
            let newCrime = Crime(context: self.viewContext)
            newCrime.date = Date()
            // Assuming you have attributes like zipcode in your Crime entity
            newCrime.zipcode = crimeData.overall.zipcode ?? "Unknown"
            newCrime.overallCrimeGrade = crimeData.overall.overallCrimeGrade 
            newCrime.propertyCrimeGrade = crimeData.overall.propertyCrimeGrade
            newCrime.violentCrimeGrade = crimeData.overall.violentCrimeGrade
            newCrime.riskDetail = crimeData.overall.riskDetail
            
            do {
                try self.viewContext.save()
                print("Crime data saved successfully")
            } catch {
                self.errorMessage = "Failed to save context: \(error.localizedDescription)"
            }
        }
    }
    
    func resetData(){
        self.viewContext.reset()
    }
}
