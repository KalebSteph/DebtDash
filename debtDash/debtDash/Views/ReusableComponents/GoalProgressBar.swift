//
//  GoalProgressBar.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/16/26.
//

import SwiftUI

struct GoalProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(AppColors.track)

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [AppColors.cyan, AppColors.pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * max(0, min(progress, 1)))
            }
        }
        .frame(height: 14)
    }
}
