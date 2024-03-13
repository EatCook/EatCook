//
//  TimerPickerView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

struct TimerPickerView: View {
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("조리 시간")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(24)
            
            Spacer()
            
            HStack {
                VStack {
                    Text("시간")
                        .fontWeight(.semibold)
                    
                    Picker("Hours", selection: $selectedHours) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80, height: 100)
                }
                
                VStack {
                    Text("분")
                        .fontWeight(.semibold)
                    
                    Picker("Minutes", selection: $selectedMinutes) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80, height: 100)
                }
                
            }
            .padding()
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Text("취소")
                        .foregroundStyle(.gray5)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .modifier(CustomBorderModifier())
                
                Button {
                    
                } label: {
                    Text("선택")
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .modifier(CustomBorderModifier(background: .primary7))
            }
            .padding()
        }
        .background(.gray1)
        .frame(maxHeight: 250)
    }
}

#Preview {
    TimerPickerView()
}

