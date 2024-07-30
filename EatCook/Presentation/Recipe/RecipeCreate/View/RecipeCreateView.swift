//
//  RecipeCreateView.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import SwiftUI

struct RecipeCreateView: View {
    @StateObject private var viewModel = RecipeCreateViewModel(
        cookTalkUseCase: RecipeUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()))))
    
    @State private var progressValue: Float = 0.2
    
    @FocusState private var titleTextFieldFocused: Bool
    @FocusState private var recipeTextEditorFocused: Bool
    
    @State private var showTimerPicker = false
    @State private var showDropdownTheme = false
    @State private var showImagePicker = false
//    @State private var selectedImage: UIImage?
//    @State private var imageExtension: String?
    
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
                    TextField("레시피 제목을 적어주세요.", text: $viewModel.recipeTitle)
                        .padding()
                        .modifier(CustomBorderModifier(isFocused: titleTextFieldFocused))
                        .focused($titleTextFieldFocused)
                    
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        if let image = viewModel.titleImage {
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
                        ImagePicker(image: $viewModel.titleImage,
                                    imageURL: $viewModel.titleImageURL,
                                    imageExtension: $viewModel.titleImageExtension,
                                    isPresented: $showImagePicker)
                    }
                }
                
                VStack {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $viewModel.recipeDescription)
                            .frame(height: 270)
                            .onChange(of: viewModel.recipeDescription) { newValue in
                                if newValue.count > characterLimit {
                                    viewModel.recipeDescription = String(newValue.prefix(characterLimit))
                                }
                            }
                        
                        if viewModel.recipeDescription.isEmpty {
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
                        
                        Text("\(viewModel.recipeDescription.count) / \(characterLimit)")
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
                                .foregroundStyle(viewModel.selectedTime == 0 ? .gray5 : .primary5)
                                .fontWeight(.bold)
                                .frame(width: 13.5)
                            
                            Text(viewModel.selectedTime == 0 ? "조리 시간" : "\(viewModel.selectedTime)분")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(viewModel.selectedTime == 0 ? .gray5 : .primary6)
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
                        DropdownView(showDropDown: $showDropdownTheme, selectedTheme: $viewModel.selectedTheme)
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
                    naviPathFinder.addPath(.recipeTag(viewModel))
                } label: {
                    Text("다음")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.primary7)
                                .frame(height: 56)
                        }
                }
                .padding(.vertical, 20)
            }
            .padding(24)
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
            TimerPickerView(selectedHours: $viewModel.selectHours,
                            selectedMinutes: $viewModel.selectMinutes) { selectTime in
                viewModel.selectedTime = selectTime
                showTimerPicker.toggle()
            } cancelButtonAction: {
                showTimerPicker.toggle()
            }
            .presentationDetents([.fraction(0.42)])
        }
//        .navigationDestination(for: ViewOptions.self) { viewCase in
//            viewCase.view()
//        }
    }
    
}

#Preview {
    NavigationStack {
        RecipeCreateView()
            .environmentObject(NavigationPathFinder.shared)        
    }
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
