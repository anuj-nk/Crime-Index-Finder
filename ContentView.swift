//
//  ContentView.swift
//  ClassProject
//
//  Created by Anuj Kamasamudram on 3/19/24.
//

import SwiftUI
import MapKit
import UIKit
import Combine
import CoreData
import Foundation
import CoreLocation
import CoreLocationUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Some zip codes don't work as I think the API hasn't been updated for newer zip codes like 85288 or 85280 in Tempe

struct ContentView: View {
    @State private var zip: String = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.234225, longitude: -122.0312186),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @StateObject private var viewModel = CrimeViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var locations: [Location] = []
    private let geocoder = CLGeocoder()
    @State private var popupContent: String? = nil

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            if popupContent != nil {
                                Text(popupContent!)
                                    .padding(5)
                                    .background(Color.white.opacity(0.85))
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .onTapGesture {
                                        popupContent = nil
                                    }
                                
                                Spacer().frame(height: 30)
                            }
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    if popupContent == nil {
                                        popupContent = "Check Values In Searches Up Top Right"
                                    } else {
                                        popupContent = nil
                                }
                            }
                            Text(location.name)
                                .fixedSize()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        TextField("Enter the zipcode", text: $zip)
                            .background()
                            .border(.black, width: 0.3)
                            .padding()
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button(action: {
                            geocodeAddressString(zip)
                            viewModel.fetchCrimeData(zipcode: zip)
                        }) {
                            Label("Search", systemImage: "location.magnifyingglass")
                                .padding()
                                .foregroundStyle(.blue)
                        }
                        .padding()

                        NavigationLink(destination: AddCrimeView()) {
                            Image(systemName: "tray.fill")
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                    Spacer()
                }
            }
        }
    }

    private func geocodeAddressString(_ zipCode: String) {
        geocoder.geocodeAddressString(zipCode) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first, let location = placemark.location {
                let newRegion = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                self.region = newRegion
                let newLocation = Location(name: zipCode, coordinate: location.coordinate)
                self.locations = [newLocation]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
