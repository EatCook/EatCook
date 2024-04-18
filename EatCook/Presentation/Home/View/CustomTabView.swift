//
//  CustomTabView.swift
//  EatCook
//
//  Created by 강신규 on 4/17/24.
//

import SwiftUI

struct CustomTabView: View {
    
    @State private var selection : String = "home"
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("aa")
            }
            TabView(selection: $selection,
                    content:  {
                Text("Tab Content 1").tabItem { Text("Tab Label 1") }
                Text("Tab Content 2").tabItem { Text("Tab Label 2") }
            })
            VStack{
                Text("aaaa")
            }
        }

       
    }
}

#Preview {
    CustomTabView()
}
