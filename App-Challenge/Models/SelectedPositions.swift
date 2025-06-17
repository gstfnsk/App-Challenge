//
//  SelectedPositions.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 17/06/25.
//

import Foundation

struct SelectedPositions {
    var selectedPositions: Set<JobPosition> = []
    
    func applyFilter(to offers: [JobOffer]) -> [JobOffer] {
        if !selectedPositions.isEmpty {
            return offers.filter { selectedPositions.contains($0.position) }
        }
        return offers
    }
}
