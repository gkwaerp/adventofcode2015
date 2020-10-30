//
//  Grid.swift
//  AdventOfCode2015
//
//  Created by Geir-Kåre S. Wærp on 30/10/2020.
//  Copyright © 2020 Geir-Kåre S. Wærp. All rights reserved.
//

import Foundation

class Grid {
    typealias GridValue = String
    var size: IntPoint
    var values: [GridValue]
    
    var width: Int {
        return self.size.x
    }
    var height: Int {
        return self.size.y
    }
    
    init(size: IntPoint, values: [GridValue]) {
        guard size.x > 0, size.y > 0 else { fatalError("Invalid grid, size must be non-negative in both axes.") }
        guard size.x * size.y == values.count else { fatalError("Invalid grid, values doesn't match size." )}
        self.size = size
        self.values = values
    }
    
    private func getIndex(for position: IntPoint) -> Int? {
        guard position.x < self.width, position.x >= 0 else { return nil }
        guard position.y < self.height, position.y >= 0 else { return nil }
        return position.y * self.width + position.x
    }
    
    func getValue(at position: IntPoint) -> GridValue? {
        guard let index = self.getIndex(for: position) else { return nil }
        return self.values[index]
    }
    
    func setValue(at position: IntPoint, to value: String) {
        guard let index = self.getIndex(for: position) else { return }
        self.values[index] = value
    }
    
    func getValues(offset from: IntPoint, offsets: [IntPoint]) -> [GridValue] {
        return offsets.compactMap({return self.getValue(at: from + $0)})
    }
    
    func asText() -> String {
        var finalText = ""
        for y in 0..<self.height {
            for x in 0..<self.width {
                if let value = self.getValue(at: IntPoint(x: x, y: y)) {
                    finalText.append(value)
                }
            }
            finalText.append("\n")
        }
        return finalText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
