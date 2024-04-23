//
//  SettingView.swift
//  EatCook
//
//  Created by 이명진 on 4/23/24.
//

import SwiftUI

struct SettingView: View {
    @State private var serviceAlarmIsOn = true
    @State private var eventAlarmIsOn = true
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("프로필 및 계정")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.vertical, 12)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.gray5)
                    }
                }
                
                Divider()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("알림")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 12)
                
                Toggle(isOn: $serviceAlarmIsOn) {
                    Text("서비스 이용 알림")
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                        .foregroundStyle(Color.gray5)
                }
                .tint(Color.primary5)
                
                Divider()
                
                Toggle(isOn: $eventAlarmIsOn) {
                    Text("이벤트 알림")
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                        .foregroundStyle(Color.gray5)
                }
                .tint(Color.primary5)
                
                Divider()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("고객지원")
                    .font(.system(size: 16, weight: .semibold))
                
                HStack {
                    Text("1:1 문의")
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .foregroundStyle(Color.gray5)
                
                Divider()
                
                HStack {
                    Text("서비스 이용 약관")
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .foregroundStyle(Color.gray5)
                
                Divider()
                
                HStack {
                    Text("앱 버전")
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                    
                    Spacer()
                    
                    Text("1.0")
                        .font(.system(size: 16))
                }
                .foregroundStyle(Color.gray5)
                
                Divider()
            }
            .padding(.horizontal, 24)
        }
        
    }
}

#Preview {
    SettingView()
}
