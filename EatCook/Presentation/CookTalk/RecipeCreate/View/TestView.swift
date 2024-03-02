//
//  TestView.swift
//  EatCook
//
//  Created by 이명진 on 3/3/24.
//

import SwiftUI

struct Memo: Identifiable {
    let id = UUID()
    var text: String
    var isEditing = false
}

struct MemoListView: View {
    @State private var memos = [
        Memo(text: "첫 번째 메모"),
        Memo(text: "두 번째 메모"),
        Memo(text: "3 번째 메모"),
        Memo(text: "4 번째 메모"),
        Memo(text: "5 번째 메모"),
        Memo(text: "6 번째 메모"),
        Memo(text: "7 번째 메모"),
        Memo(text: "8 번째 메모"),
        // ... 기타 메모들
    ]

    var body: some View {
        List {
            ForEach(memos.indices, id: \.self) { index in
                if !memos[index].isEditing {
                    MemoRowView(memo: $memos[index])
                        .onTapGesture {
                            withAnimation {
                                memos[index].isEditing.toggle()
                            }
                        }
                } else {
                    MemoEditorView(memo: $memos[index], onFinishEditing: {
                        withAnimation {
                            memos[index].isEditing.toggle()
                        }
                    })
                }
            }
        }
    }
}

struct MemoRowView: View {
    @Binding var memo: Memo

    var body: some View {
        Text(memo.text)
            .padding()
    }
}

struct MemoEditorView: View {
    @Binding var memo: Memo
    var onFinishEditing: () -> Void

    var body: some View {
        VStack {
            TextEditor(text: $memo.text)
                .padding()

            Button("저장") {
                onFinishEditing()
            }
            .padding()
        }
    }
}

#Preview {
    MemoListView()
}
