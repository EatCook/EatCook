//
//  HomeView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {

        NavigationStack {
            NavigationLink(destination: SearchView().toolbarRole(.editor)) {
                Text("검색")
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.bdActive)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 46)
            }
        }

    }
}

#Preview {
    HomeView()
}
