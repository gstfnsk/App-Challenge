//
//  SelectedPositions.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 17/06/25.
//

import Foundation

struct SelectedPositions {
    private static var selectedPositions: Set<JobPosition> = []

    static func setSelectedPositions(_ positions: Set<JobPosition>) {
        selectedPositions = positions
    }

    static func applyFilter(to offers: [JobOffer]) -> [JobOffer] {
        guard !selectedPositions.isEmpty else {
            return offers }
        return offers.filter { selectedPositions.contains($0.position) }
    }

    static func getSelectedPositions() -> Set<JobPosition> {
        return selectedPositions
    }

    static func add(position: JobPosition) {
        selectedPositions.insert(position)
    }

    static func remove(position: JobPosition) {
        selectedPositions.remove(position)
    }

    static func clearAll() {
        selectedPositions.removeAll()
    }

    static func isSelected(_ position: JobPosition) -> Bool {
        return selectedPositions.contains(position)
    }
}
