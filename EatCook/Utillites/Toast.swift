//
//  Toast.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation
import SwiftUI
import Combine


struct Toast: View {
    var message: String
    var duration: Double
    var backgroundColor: Color = Color.black.opacity(0.8)
    var textColor: Color = .white
    var cornerRadius: CGFloat = 10.0
    @Binding var isShowing: Bool

    var body: some View {
        if isShowing {
            Text(message)
                .padding()
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(cornerRadius)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
                .transition(AnyTransition.opacity.combined(with: .slide))
        }
    }
}


class ToastManager: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var currentMessage: String = ""
    
    func showToast() -> some View {
           Toast(
               message: currentMessage,
               duration: 2.0,
               isShowing: Binding(get: { self.isShowing }, set: { self.isShowing = $0 })
           )
       }
   
    func displayToast(message: String, duration: Double = 2.0) {
        isShowing = true
        currentMessage = message
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                self.isShowing = false
               
            }
        }
    }
}

