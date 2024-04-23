//
//  RecipeCreateView.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import SwiftUI

struct RecipeCreateView: View {
    @State private var recipeTitleInput: String = ""
    @State private var titleTextInput: String = ""
    @State private var descriptionTextInput: String = ""
    @State private var progressValue: Float = 0.2
    
    @FocusState private var titleTextFieldFocused: Bool
    @FocusState private var recipeTextEditorFocused: Bool
    
    @State private var showTimerPicker = false
    @State private var showDropdownTheme = false
    @State private var showImagePicker = false
    @State private var selectedTheme: String = "테마 선택"
    @State private var selectedImage: UIImage?
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    let characterLimit = 100
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                //            ProgressView(value: progressValue)
                //                .progressViewStyle(CustomProgressBarStyle())
                
                Text("레시피 내용")
                    .font(.title2.bold())
                
                HStack {
                    TextField("레시피 제목을 적어주세요.", text: $recipeTitleInput)
                        .padding()
                        .modifier(CustomBorderModifier(isFocused: titleTextFieldFocused))
                        .focused($titleTextFieldFocused)
                    
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 50)
                            //                                .padding()
                            //                                .foregroundStyle(.gray5)
                                .modifier(CustomBorderModifier())
                        } else {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 20)
                                .padding()
                                .foregroundStyle(.gray5)
                                .modifier(CustomBorderModifier(background: .gray3))
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $selectedImage, isPresented: $showImagePicker)
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
                                .foregroundStyle(.gray5)
                                .padding(.leading, 4)
                                .padding(.top, 8)
                                .allowsHitTesting(false)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("\(descriptionTextInput.count) / \(characterLimit)")
                            .font(.subheadline)
                            .foregroundStyle(.gray4)
                    }
                }
                .padding()
                .modifier(CustomBorderModifier(isFocused: recipeTextEditorFocused))
                .focused($recipeTextEditorFocused)
                
                Spacer()
                
                Text("요리 정보")
                    .font(.title2.bold())
                
                HStack(alignment: .top, spacing: 16) {
                    Button {
                        showTimerPicker.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "timer")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray4)
                                .fontWeight(.bold)
                                .frame(width: 13.5)
                            
                            Text("조리 시간")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray5)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .modifier(CustomBorderModifier())
                    
                    //                Divider()
                    //                    .frame(width: 1, height: 30)
                    //                    .background(.gray3)
                    
                    Button {
                        showDropdownTheme.toggle()
                    } label: {
                        DropdownView(showDropDown: $showDropdownTheme, selectedTheme: $selectedTheme)
                            .frame(height: showDropdownTheme ? 260 : 60)
                    }
                    //                    .padding()
                    //                    .frame(maxWidth: .infinity)
                    //                    .modifier(CustomBorderModifier())
                }
                .frame(height: showDropdownTheme ? 260 : 60)
                //                .frame(maxWidth: .infinity)
                //            .padding()
                //            .modifier(CustomBorderModifier())
                
                Button {
                    naviPathFinder.addPath(.recipeTag(""))
                } label: {
                    Text("다음")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.primary7)
                        .frame(height: 56)
                }
                .padding(.vertical, 20)
            }
            .padding(24)
//            .navigationDestination(for: ViewOptions.self) { viewCase in
//                viewCase.view()
//            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }
        .background(.gray1)
        .navigationTitle("글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    naviPathFinder.pop()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showTimerPicker) {
            TimerPickerView()
                .presentationDetents([.fraction(0.42)])
        }
    }
    
}

#Preview {
    RecipeCreateView()
        .environmentObject(NavigationPathFinder.shared)
}

//struct CustomProgressBarStyle: ProgressViewStyle {
//    var progressBarThickness: CGFloat = 10.0
//
//    func makeBody(configuration: Configuration) -> some View {
//
//        return ZStack(alignment: .leading) {
//            RoundedRectangle(cornerRadius: 8)
//                .frame(height: progressBarThickness)
//                .foregroundColor(Color("bgPrimary"))
//
//            RoundedRectangle(cornerRadius: 8)
//                .frame(width: CGFloat(configuration.fractionCompleted ?? 0.0) * UIScreen.main.bounds.width,
//                       height: progressBarThickness)
//                .foregroundColor(.orange)
//        }
//        //        .animation(.linear)
//    }
//}
