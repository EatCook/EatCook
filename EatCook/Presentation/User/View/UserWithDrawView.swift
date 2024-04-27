//
//  UserWithDrawView.swift
//  EatCook
//
//  Created by 이명진 on 4/27/24.
//

import SwiftUI

struct UserWithDrawView: View {
    @State private var button1: Bool = false
    @State private var button2: Bool = false
    @State private var button3: Bool = false
    @State private var button4: Bool = false
    
    @State private var allCheckButton: Bool = false
    
    var body: some View {
        VStack(spacing: 36) {
            Spacer()
            
            VStack(spacing: 8) {
                Text("정말 탈퇴하실건가요?")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("탈퇴시 정보는 영구적으로 삭제되며,\n 재가입 시에도 복구되지 않습니다.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray6)
            }
            
            VStack {
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "계정정보",
                                      buttonImage: "checkmark") {
//                    button1.toggle()
                }
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "작성한 모든 피드 및 게시물",
                                      buttonImage: "checkmark") {
//                    button2.toggle()
                }
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "개인 소식, 알림 내역",
                                      buttonImage: "checkmark") {
//                    button3.toggle()
                }
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "레시피 북마크 및 팔로우 내역",
                                      buttonImage: "checkmark") {
//                    button4.toggle()
                }
            }
            .padding(.vertical, 16)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray1)
            }
            .padding(.horizontal, 24)
            
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        allCheckButton.toggle()
                    }
                } label: {
                    Image(systemName: "checkmark.rectangle.portrait.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(allCheckButton ? .primary7 : .gray4)
                    
                }
                Text("위 주의사항을 모두 읽었으며, 탈퇴에 동의합니다.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray6)
            }
            
            Spacer()
            
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Text("더 써볼래요")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary6)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.primary1)
                        }
                }
                
                Button {
                    
                } label: {
                    Text("떠날래요")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(allCheckButton ? .white : .gray4)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(allCheckButton ? .primary7 : .gray2)
                        }
                }
                .disabled(!allCheckButton)
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .navigationTitle("회원탈퇴")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
}

#Preview {
//    NavigationStack {
        UserWithDrawView()
//    }
}
