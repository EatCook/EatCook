//
//  RecipeTagView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

struct RecipeTagView: View {
    @State private var tags: [Tag] = []
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("재료 태그")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            TagField(tags: $tags)
                .modifier(CustomBorderModifier())
                .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 15) {
                Button {
                    naviPathFinder.pop()
                } label: {
                    Text("이전")
                        .padding()
                        .foregroundStyle(.gray5)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .modifier(CustomBorderModifier())
                }
                
                Button {
                    naviPathFinder.addPath(.recipeStep(""))
                } label: {
                    Text("다음")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .modifier(CustomBorderModifier(lineWidth: 0, background: .primary7))
                }
            }
            
        }
        .padding()
        .background(.gray1)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    naviPathFinder.popToRoot()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
        }
//        .navigationDestination(for: ViewOptions.self) { viewCase in
//            viewCase.view()
//        }
        
    }
}

#Preview {
    NavigationStack {
        RecipeTagView()
            .environmentObject(NavigationPathFinder.shared)        
    }
}
