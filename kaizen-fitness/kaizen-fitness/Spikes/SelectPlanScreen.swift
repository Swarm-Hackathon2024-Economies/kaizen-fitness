//
//  SelectPlanScreen.swift
//  kaizen-fitness
//
//  Created by takuya on 9/12/24.
//

import SwiftUI

struct SelectPlanScreen: View {
    @State var distance: String = "0km"
    var body: some View {
        VStack {
            Spacer()
            Text("\(distance)")
            Spacer()
            Button {
                distance = "100km"
            } label: {
                Text("プラン100km")
                    .primaryButtonStyle()
            }
            Spacer()
            Button {
                distance = "50km"
            } label: {
                Text("プラン50km")
                    .primaryButtonStyle()
            }
            Spacer()
            Button {
                distance = "10km"
            } label: {
                Text("プラン10km")
                    .primaryButtonStyle()
            }
            Spacer()
        }
    }
}

#Preview {
    SelectPlanScreen()
}
