//
//  RecipeStepView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

struct RecipeStep: Identifiable, Hashable {
    let id = UUID().uuidString
    var description: String
    var image: UIImage?
    var imageURL: URL?
    var imageExtension: String
    var isEditing: Bool = false
    var isUpdate : Bool = false
}

struct RecipeStepView: View {
    @ObservedObject var viewModel: RecipeCreateViewModel
    
    @State private var showImagePicker: Bool = false
    @State private var showUploadingAlert: Bool = false
    @State private var isEditingMode: Bool = false
    @State private var scrollToEnd = false
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("조리 과정")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            ScrollViewReader { proxy in
                List {
                    ForEach(viewModel.recipeStepData.indices, id: \.self) { index in
                        if !viewModel.recipeStepData[index].isEditing {
                            StepRowView(viewModel: viewModel, index: index)
                                .listRowBackground(Color.gray1)
                                .listRowSeparator(.hidden)
                                .swipeActions {
                                    Button {
                                        viewModel.recipeStepData.remove(at: index)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundStyle(.white)
                                    }
                                    .tint(.primary4)
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            viewModel.recipeStepData[index].isEditing = true
                                        }
                                        isEditingMode = true
                                    } label: {
                                        Image(systemName: "pencil")
                                            .foregroundStyle(.primary4)
                                    }
                                    .tint(.primary2)
                                    
                                }
                                .id(index)
                        } else {
                            StepEditorView(viewModel: viewModel,
                                           showImagePicker: $showImagePicker,
                                           isEditingMode: $isEditingMode,
                                           index: index)
                            .listRowBackground(Color.gray1)
                            .listRowSeparator(.hidden)
                            
                        }
                    }
                    .onChange(of: scrollToEnd) { newValue in
                        if newValue {
                            proxy.scrollTo(viewModel.recipeStepData.indices.last, anchor: .bottom)
                            scrollToEnd = false
                        }
                    }
                }
                .listStyle(.plain)
                
            }
            
            CreateChatView(viewModel: viewModel,
                           showImagePicker: $showImagePicker,
                           selectedImage: $viewModel.recipeStepImage,
                           scrollToEnd: $scrollToEnd)
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: isEditingMode ? $viewModel.recipeStepUpdateImage : $viewModel.recipeStepImage,
                        imageURL: $viewModel.recipeStepImageURL,
                        imageExtension: $viewModel.recipeStepImageExtension,
                        isPresented: $showImagePicker)
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
                        if viewModel.isEditType {
                            await viewModel.requestRecipeUpdate(viewModel.postId)
                            await viewModel.uploadImage()
                        } else {
                            await viewModel.requestRecipeCreate()
                            await viewModel.uploadImage()
                        }
                        
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
            if index < viewModel.recipeStepData.count {
                if let image = viewModel.recipeStepData[index].image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 70)
                        .modifier(CustomBorderModifier())
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
            } else {
                // 배열 범위를 벗어나면 안됨
                Text("Invalid step")
                    .foregroundColor(.red)
            }
            
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
    @Binding var isEditingMode: Bool
    var index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            if let image = viewModel.recipeStepUpdateImage ?? viewModel.recipeStepData[index].image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 70)
                    .modifier(CustomBorderModifier())
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
                            viewModel.updateStep(index)
                        }
                        isEditingMode = false
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
    @Binding var scrollToEnd: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            Button {
                showImagePicker.toggle()
            } label: {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
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
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    scrollToEnd = true
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
                                  imageExtension: viewModel.recipeStepImageExtension , isUpdate: true)
        withAnimation(.easeInOut(duration: 0.3)) {
            viewModel.addStep(stepData)
            textEditorText = ""
            selectedImage = nil
            viewModel.recipeStepImageURL = nil
        }
    }
    
}

//#Preview {
//    NavigationStack {
//        RecipeStepView(viewModel: RecipeCreateViewModel(cookTalkUseCase: RecipeUseCase(eatCookRepository: EatCookRepository(networkProvider: NetworkProviderImpl(requestManager: NetworkManager())))))
//            .environmentObject(NavigationPathFinder.shared)
//    }
//}
