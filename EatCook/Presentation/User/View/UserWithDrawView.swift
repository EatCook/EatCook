//
//  UserWithDrawView.swift
//  EatCook
//
//  Created by 이명진 on 4/27/24.
//

import SwiftUI
import Combine

struct UserWithDrawView: View {
    @StateObject private var viewModel: UserWithDrawViewModel
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    @State private var allCheckButton: Bool = false
    @State private var showRequestAlertView: Bool = false
    
    init() {
        _viewModel = StateObject(
            wrappedValue: UserWithDrawViewModel(
                myPageUseCase: MyPageUseCase(
                    eatCookRepository: EatCookRepository(
                        networkProvider: NetworkProviderImpl(
                            requestManager: NetworkManager())))))
    }
    
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
                    
                }
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "작성한 모든 피드 및 게시물",
                                      buttonImage: "checkmark") {
                    
                }
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "개인 소식, 알림 내역",
                                      buttonImage: "checkmark") {
                    
                }
                CheckImageTitleButton(isSelected: $allCheckButton,
                                      buttonTitle: "레시피 북마크 및 팔로우 내역",
                                      buttonImage: "checkmark") {
                    
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
                    naviPathFinder.pop()
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
                    withAnimation(.easeIn(duration: 0.1)) {
                        showRequestAlertView = true
                    }
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
        .overlay {
            if showRequestAlertView {
                CustomAlertView(
                    title: "정말 탈퇴하실건가요?",
                    message: "회원정보가 모두 삭제됩니다.",
                    layoutMode: .horizontal,
                    leftTitle: "네",
                    rightTitle: "아니요") {
                        withAnimation(.easeIn(duration: 0.1)) {
                            showRequestAlertView = false
                            viewModel.requestWithDraw()
                        }
                    } onConfirm: {
                        withAnimation(.easeIn(duration: 0.1)) {
                            showRequestAlertView = false
                        }
                    }
            }
            
            if viewModel.withDrawCompleted {
                CustomPopUpView(
                    title: "회원탈퇴 완료",
                    message: "다음에 또 만나요!",
                    confirmTitle: "확인"
                ) {
                    naviPathFinder.resetPathAndSetRoot(.login)
                }
            }
        }
        .navigationTitle("회원탈퇴")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    UserWithDrawView()
}
