//
//  UserProfileView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                UserProfileTopView()
                
                ZStack(alignment: .top) {
                    HStack(alignment: .center) {
                        Spacer()
                            .frame(width: 16)
                        
                        VStack(spacing: 12) {
                            Text("416")
                                .fontWeight(.semibold)
                            
                            Text("팔로워")
                        }
                        .frame(width: 110)
    //                    .background(.red)
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Text("321")
                                .fontWeight(.semibold)
                            
                            Text("팔로잉")
                        }
                        .frame(width: 110)
                        
                        Spacer()
                            .frame(width: 16)
                    }
                    .padding(.vertical, 20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .offset(y: -12)
    //                .background(.gray)
                    
                    VStack(spacing: 12) {
                        Rectangle()
                            .frame(width: 96, height: 96)
                            .foregroundStyle(.gray5)
            //                .resizable()
            //                .scaledToFill()
            //                .frame(width: 96, height: 96)
                            .clipShape(Circle())
                        
                        Text("집밥백선생")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("집밥 요리 전문가")
                            .font(.footnote)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.gray3)
                            }
                    }
                    .offset(y: -50)
                }
//                .overlay {
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill()
//                }
            
                VStack {
                    HStack {
                        Text("마이페이지")
                        
                        Text("보관함")
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ForEach(1..<10) { index in
                        UserProfileRowView()
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    UserProfileView()
}
