//
//  UserProfileEditView.swift
//  EatCook
//
//  Created by 이명진 on 4/23/24.
//

import SwiftUI

struct UserProfileEditView: View {
    @State private var showAlert: Bool = false
    
    @StateObject private var viewModel = UserProfileEditViewModel(
        myPageUseCase: MyPageUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()
                )
            )
        ),
        loginUserInfo: LoginUserInfoManager.shared
    )
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        if let imageUrlString = viewModel.userProfileImagePath {
                            let imageUrl = URL(string: imageUrlString)
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .frame(width: 130, height: 130)
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .padding(.top, 24)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 130, height: 130)
                                .scaledToFit()
                                .clipShape(Circle())
                                .padding(.top, 24)
                                .foregroundStyle(.gray3)
                        }
                        
                        Button {
                            viewModel.requestUserProfileImageEdit("jpg")
                        } label: {
                            CameraImageView()
                        }
                        .frame(width: 42, height: 42)
                        .offset(x: 5, y: 6)
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("닉네임")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray6)
                            .padding(.bottom, 8)
                        
                        TextField("닉네임", text: $viewModel.userNickName)
                            .padding()
                            .modifier(CustomBorderModifier(cornerRadius: 10,
                                                           lineWidth: 1,
                                                           background: .white))
                            .padding(.bottom, 24)
                        
                        Text("이메일")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray6)
                            .padding(.bottom, 8)
                        
                        TextField("이메일", text: $viewModel.userEmail)
                            .padding()
                            .foregroundStyle(.gray5)
                            .modifier(CustomBorderModifier(cornerRadius: 10,
                                                           lineWidth: 1,
                                                           background: .gray3))
                            .disabled(true)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.top, 41)
                    
                    Rectangle()
                        .fill(.gray1)
                        .padding(.top, 48)
                    
                    Button {
//                        naviPathFinder.addPath(<#T##option: ViewOptions##ViewOptions#>)
                    } label: {
                        HStack {
                            Text("비밀번호 변경")
                                .font(.system(size: 16))
                                .foregroundStyle(.gray6)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 9, height: 16)
                                .foregroundStyle(.gray4)
                        }
                        .padding(.vertical, 19)
                        .padding(.horizontal, 16)
                    }
                    
                    Button {
                        naviPathFinder.addPath(.userWithDraw)
                    } label: {
                        HStack {
                            Text("회원탈퇴")
                                .font(.system(size: 16))
                                .foregroundStyle(.gray6)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 9, height: 16)
                                .foregroundStyle(.gray4)
                        }
                        .padding(.vertical, 19)
                        .padding(.horizontal, 16)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("로그아웃")
                                .font(.system(size: 16))
                                .foregroundStyle(.gray6)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 9, height: 16)
                                .foregroundStyle(.gray4)
                        }
                        .padding(.vertical, 19)
                        .padding(.horizontal, 16)
                    }
                    
                    
                }
            }
            .navigationTitle("프로필 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        Task {
                            await viewModel.requestUserProfileEdit(viewModel.userNickName)
                            
                            if !viewModel.isLoading && viewModel.error == nil {
                                showAlert.toggle()
                            } else if let error = viewModel.error {
                                print("프로필 편집 실패!!!")
                            }
                        }
                    } label: {
                        Text("저장")
                    }
                }
            }
            .alert("프로필 편집 성공", isPresented: $showAlert) {
                Button("확인", role: .cancel) {
                    showAlert.toggle()
                }
            } message: {
                Text("프로필 편집이 완료되었습니다.")
            }
            .onAppear {
                
            }

            
    }
}

#Preview {
    UserProfileEditView()
        .environmentObject(NavigationPathFinder.shared)
}
