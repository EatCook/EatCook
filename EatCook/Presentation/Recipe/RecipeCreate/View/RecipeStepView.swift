//
//  RecipeStepView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

/*
 - 선택된 이미지를 하나의 변수에서 상태관리를 해서 글쓰기랑 편집이 같이 변경됨.
 - 디바이스에서 실행시 List 배경색 적용이 안됨.
 - 이미지 등록시 버튼에 맞게 레이아웃 다시 잡아야 됨.
 */

struct RecipeStep: Identifiable, Hashable {
    let id = UUID().uuidString
    var description: String
    var image: UIImage?
    var imageURL: URL?
    var imageExtension: String
    var isEditing: Bool = false
}

struct RecipeStepView: View {
    @ObservedObject var viewModel: RecipeCreateViewModel
    
    @State private var showImagePicker: Bool = false
    @State private var showUploadingAlert: Bool = false
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("조리 과정")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            List {
                ForEach(viewModel.recipeStepData.indices, id: \.self) { index in
                    if !viewModel.recipeStepData[index].isEditing {
                        StepRowView(viewModel: viewModel, index: index)
                            .listRowBackground(Color.gray1)
                            .listRowSeparator(.hidden)
                            .swipeActions {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .tint(.primary2)
                                }
                                
                                Button {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        viewModel.recipeStepData[index].isEditing = true
                                    }
                                } label: {
                                    Image(systemName: "pencil")
                                        .tint(.primary4)
                                }
                            }
                    } else {
                        StepEditorView(viewModel: viewModel,
                                       showImagePicker: $showImagePicker,
                                       selectedImage: $viewModel.recipeStepImage,
                                       index: index)
                            .listRowBackground(Color.gray1)
                            .listRowSeparator(.hidden)
//                        StepEditorView(viewModel: viewModel, index: index)
                            
                    }
                }
            }
            .listStyle(.plain)
//            .onTapGesture {
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//            }
            
            CreateChatView(viewModel: viewModel,
                           showImagePicker: $showImagePicker,
                           selectedImage: $viewModel.recipeStepImage)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $viewModel.recipeStepImage,
                                imageURL: $viewModel.recipeStepImageURL,
                                imageExtension: $viewModel.recipeStepImageExtension,
                                isPresented: $showImagePicker)
                }
        }
        .background(.gray1)
        .navigationTitle("글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    naviPathFinder.popToRoot()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await viewModel.requestRecipeCreate()
                        await viewModel.uploadImage()
                        
                        if !viewModel.isUpLoading && viewModel.isUpLoadingError == nil  {
                            naviPathFinder.popToRoot()
                        } else if let error = viewModel.isUpLoadingError {
                            print(error)
                            showUploadingAlert = true
                        }
                        
                    }
                } label: {
                    Text("저장")
                }
            }
        }
        .overlay {
            if viewModel.isUpLoading {
                VStack(spacing: 8) {
                    LoadingImageView()
                    
                    Text("레시피 굽는중...")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
//                    ProgressView("업로딩 중...")
//                        .padding()
//                        .background(.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(radius: 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.4))
            }
        }
        .alert("업로드 실패.", isPresented: $showUploadingAlert) {
            Button("확인", role: .cancel) {
                self.showUploadingAlert = false
            }
        } message: {
            Text(viewModel.isUpLoadingError ?? "알 수 없는 오류가 발생했습니다.")
        }
        
    }
}

struct StepRowView: View {
    @ObservedObject var viewModel: RecipeCreateViewModel
    var index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            if let image = viewModel.recipeStepData[index].image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text("Step \(index + 1)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary7)
                
                Text(viewModel.recipeStepData[index].description)
                    .font(.footnote)
                    .lineLimit(3)
            }
            .padding(8)
            
            Spacer()
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .modifier(CustomBorderModifier())
    }
}

struct StepEditorView: View {
    @ObservedObject var viewModel: RecipeCreateViewModel
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    var index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            if let image = viewModel.recipeStepData[index].image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 80)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black.opacity(0.5))
                        Text("편집")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
//                    .sheet(isPresented: $showImagePicker) {
//                        ImagePicker(selectedImage: selectedImage)
//                    }
            }
            
            VStack(alignment: .leading) {
                Text("Step \(index + 1)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary7)
                
                TextField("", text: $viewModel.recipeStepData[index].description, axis: .vertical)
                    .font(.footnote)
                
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            viewModel.updateStep(index, selectedImage)
                        }
                    } label: {
                        Text("완료")
                            .font(.caption)
                            .foregroundStyle(.primary7)
                            .padding()
                            .modifier(CustomBorderModifier(lineWidth: 0, background: .primary2))
                    }
                }
                
            }
            .padding(8)
            
            Spacer()
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .modifier(CustomBorderModifier())
    }
}

struct CreateChatView: View {
    @ObservedObject var viewModel: RecipeCreateViewModel
    
    @State private var textEditorText: String = ""
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        HStack(alignment: .bottom) {
            Button {
                showImagePicker.toggle()
            } label: {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 50)
                        .modifier(CustomBorderModifier())
                } else {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 21)
                        .padding()
                        .foregroundStyle(.gray5)
                        .modifier(CustomBorderModifier(background: .gray3))
                }
            }
            .padding(.bottom, 8)
            
            HStack(alignment: .bottom) {
                TextField("조리과정을 입력해주세요.", text: $textEditorText, axis: .vertical)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                    .lineLimit(5)
                
                Button {
                    addStep()
                } label: {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary7)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .modifier(CustomBorderModifier(lineWidth: 0, background: .primary2))
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
            }
            .modifier(CustomBorderModifier())
        }
        .padding()
    }
    
    private func addStep() {
        guard !textEditorText.isEmpty &&
                selectedImage != nil &&
                viewModel.recipeStepImageURL != nil else { return }
        let stepData = RecipeStep(description: textEditorText,
                                  image: selectedImage,
                                  imageURL: viewModel.recipeStepImageURL,
                                  imageExtension: viewModel.recipeStepImageExtension)
        withAnimation(.easeInOut(duration: 0.3)) {
            viewModel.addStep(stepData)
            textEditorText = ""
            selectedImage = nil
            viewModel.recipeStepImageURL = nil
        }
    }
    
}

#Preview {
    NavigationStack {
        RecipeStepView(viewModel: RecipeCreateViewModel(cookTalkUseCase: RecipeUseCase(eatCookRepository: EatCookRepository(networkProvider: NetworkProviderImpl(requestManager: NetworkManager())))))
            .environmentObject(NavigationPathFinder.shared)
    }
}
