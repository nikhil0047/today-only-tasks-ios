//
//  Date+Helpers.swift
//  Todo_hackathon
//
//  Created by Nikhil Shinde on 19/02/26.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

