//
//  CrimeData.swift
//  ClassProject
//
//  Created by Anuj Kamasamudram on 4/16/24.
//

import Foundation
import SwiftUI


struct CrimeData: Codable {
    let overall: Overall
    let crimeBreakdown: [Breakdown]
    let crimeRatesNearby: [NearbyRate]
    let similarPopulationCrimeRates: [SimilarRate]
    let success: Bool
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case overall = "Overall"
        case crimeBreakdown = "Crime BreakDown"
        case crimeRatesNearby = "Crime Rates Nearby"
        case similarPopulationCrimeRates = "Similar Population Crime Rates"
        case success
        case statusCode = "status code"
    }
}

struct Overall: Codable {
    let zipcode: String?
    let overallCrimeGrade: String
    let violentCrimeGrade: String
    let propertyCrimeGrade: String
    let otherCrimeGrade: String
    let fact: String
    let risk: String
    let riskDetail: String

    enum CodingKeys: String, CodingKey {
        case zipcode = "Zipcode"
        case overallCrimeGrade = "Overall Crime Grade"
        case violentCrimeGrade = "Violent Crime Grade"
        case propertyCrimeGrade = "Property Crime Grade"
        case otherCrimeGrade = "Other Crime Grade"
        case fact = "Fact"
        case risk = "Risk"
        case riskDetail = "Risk Detail"
    }
}

struct Breakdown: Codable {
    let violentCrimeRates: [String: String]?
    let propertyCrimeRates: [String: String]?
    let otherCrimeRates: [String: String]?
    let totalViolentCrime: String?
    let totalViolentCrimeScore: String?
    let totalPropertyCrime: String?
    let totalPropertyCrimeScore: String?
    let totalOtherRate: String?
    let totalOtherScore: String?

    enum CodingKeys: String, CodingKey {
        case violentCrimeRates = "Violent Crime Rates"
        case propertyCrimeRates = "Property Crime Rates"
        case otherCrimeRates = "Other Crime Rates"
        case totalViolentCrime = "Total Violent Crime"
        case totalViolentCrimeScore = "Total Violent Crime Score"
        case totalPropertyCrime = "Total Property Crime"
        case totalPropertyCrimeScore = "Total Property Crime Score"
        case totalOtherRate = "Total Other Rate"
        case totalOtherScore = "Total Other Score"
    }
}

struct NearbyRate: Codable {
    let nearbyZip: String
    let overallCrimeGrade: String
    let violentCrimeGrade: String
    let propertyCrimeGrade: String

    enum CodingKeys: String, CodingKey {
        case nearbyZip = "Nearby Zip"
        case overallCrimeGrade = "Overall Crime Grade"
        case violentCrimeGrade = "Violent Crime Grade"
        case propertyCrimeGrade = "Property Crime Grade"
    }
}

struct SimilarRate: Codable {
    let similarZip: String
    let overallCrimeGrade: String
    let violentCrimeGrade: String
    let propertyCrimeGrade: String

    enum CodingKeys: String, CodingKey {
        case similarZip = "Similar Zip"
        case overallCrimeGrade = "Overall Crime Grade"
        case violentCrimeGrade = "Violent Crime Grade"
        case propertyCrimeGrade = "Property Crime Grade"
    }
}
