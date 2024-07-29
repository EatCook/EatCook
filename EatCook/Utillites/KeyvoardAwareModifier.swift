//
//  KeyvoardAwareModifier.swift
//  EatCook
//
//  Created by 강신규 on 7/26/24.
//

import Foundation
import SwiftUI
import UIKit
import Combine

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { notification -> CGFloat? in
                    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                        return nil
                    }
                    let keyboardHeight = keyboardFrame.height
                    let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
                    return keyboardHeight - bottomSafeArea
                },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        ).eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .animation(.easeOut(duration: 0.16), value: keyboardHeight)
            .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAware() -> some View {
        modifier(KeyboardAwareModifier())
    }
}



struct KeyboardAvoidingScrollView<Content: View>: UIViewRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .interactive
        
        context.coordinator.scrollView = scrollView
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(Coordinator.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(Coordinator.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: KeyboardAvoidingScrollView
        weak var scrollView: UIScrollView?
        
        init(_ parent: KeyboardAvoidingScrollView) {
            self.parent = parent
        }
        
        @objc func keyboardWillShow(_ notification: Notification) {
            guard let scrollView = scrollView,
                  let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
        
        @objc func keyboardWillHide(_ notification: Notification) {
            guard let scrollView = scrollView else { return }
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
    }
}
