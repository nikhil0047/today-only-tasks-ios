//
//  EmptyStateView.swift
//  Todo_hackathon
//
//  Created by Nikhil Shinde on 19/02/26.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            Text("Nothing for today")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Add a task and stay focused.")
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding(.top, 60)
    }
}

