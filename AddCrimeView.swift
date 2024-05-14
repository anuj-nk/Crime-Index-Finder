//
//  AddCrimeView.swift
//  ClassProject
//
//  Created by Anuj Kamasamudram on 4/22/24.
//

import SwiftUI
import CoreData

struct AddCrimeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Crime.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Crime.date, ascending: false)],
        animation: .default)
    private var crimes: FetchedResults<Crime>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(crimes, id: \.self) { crime in
                    VStack(alignment: .leading) {
                        Text("Zip Code: \(crime.zipcode ?? "Unknown")").font(.headline)
                        Text("Overall Crime Grade: \(crime.overallCrimeGrade ?? "N/A")")
                        Text("Violent Crime Grade: \(crime.violentCrimeGrade ?? "N/A")")
                        Text("Property Crime Grade: \(crime.propertyCrimeGrade ?? "N/A")")
                        Text("Fact: \(crime.fact ?? "N/A")")
                        Text("Risk: \(crime.risk ?? "N/A")")
                        Text("Risk Detail: \(crime.riskDetail ?? "N/A")")
                    }
                }
            }
            .navigationTitle("Crime Data")
        }
    }
}
