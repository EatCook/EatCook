//
//  CreateView.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import SwiftUI

struct CreateView: View {
    @State private var recipeTitleInput: String = ""
    @State private var titleTextInput: String = ""
    @State private var descriptionTextInput: String = ""
    @State private var progressValue: Float = 0.2
    
    let characterLimit = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProgressView(value: progressValue)
                .progressViewStyle(CustomProgressBarStyle())
            
            Text("레시피 내용")
                .font(.title2.bold())
            
            HStack {
                TextField("레시피 제목을 적어주세요.", text: $recipeTitleInput)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                
                Button {
                    
                } label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 20)
                        .padding()
                        .foregroundStyle(.gray)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                }
            }
            
            VStack {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $descriptionTextInput)
                        .frame(height: 270)
                        .onChange(of: descriptionTextInput) { newValue in
                            if newValue.count > characterLimit {
                                descriptionTextInput = String(newValue.prefix(characterLimit))
                            }
                        }
                    
                    if descriptionTextInput.isEmpty {
                        Text("내 레시피 소개글을 입력해주세요.")
                            .font(.body)
                            .foregroundStyle(.gray)
                            .padding(.leading, 4)
                            .padding(.top, 4)
                            .allowsHitTesting(false)
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Text("\(descriptionTextInput.count) / \(characterLimit)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            }
            
            Spacer()
            
            Text("요리 정보")
                .font(.title2.bold())
            
            HStack(alignment: .center, spacing: 36) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "timer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        
                        Text("조리 시간")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.gray)
                }
                
                Divider()
                    .frame(width: 1, height: 30)
                    .background(Color.gray)
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        
                        Text("테마 선택")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            }
            
            Button {
                
            } label: {
                Text("다음")
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.orange)
                    .frame(height: 56)
            }
            .padding(.vertical, 20)
        }
        .padding(24)
        .navigationTitle("글쓰기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CreateView()
    }
}

struct CustomProgressBarStyle: ProgressViewStyle {
    var progressBarThickness: CGFloat = 10.0
    
    func makeBody(configuration: Configuration) -> some View {
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: progressBarThickness)
                .foregroundColor(.gray)
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0.0) * UIScreen.main.bounds.width,
                       height: progressBarThickness)
                .foregroundColor(.blue)
        }
        //        .animation(.linear)
    }
}
