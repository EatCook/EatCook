//
//  FoodThemeView.swift
//  EatCook
//
//  Created by 김하은 on 2/13/24.
//

import SwiftUI

struct FoodThemeView: View {
    var email: String = ""
    var userImage: UIImage?
    
    @StateObject private var foodThemeViewModel = FoodThemeViewModel()
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State var isButtonEnabled = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("어떤 요리에 관심 있으신가요?")
                    .bold()
                    .font(.title2)
                
                Text("관심있는 요리를 3가지 이하로 선택해주세요.\n취향에 맞는 레시피를 추천해드려요")
                    .foregroundColor(.gray6)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .lineLimit(2)
                    .padding(.horizontal, 24)
                
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(FoodTheme.themes, id: \.id) { data in
                        Button(action: {
                            if !foodThemeViewModel.cookingType.contains(data.title) && foodThemeViewModel.cookingType.count < 3 {
                                foodThemeViewModel.cookingType.append(data.title)
                            }
                            else if foodThemeViewModel.cookingType.contains(data.title) {
                                let newCookingType = foodThemeViewModel.cookingType.filter{
                                    $0 != data.title
                                }
                                foodThemeViewModel.cookingType = newCookingType
                            }
                            print(data.title)
                            print(foodThemeViewModel.cookingType)
                            
                            
                        }, label: {
                            VStack {
                                data.image
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text(data.title)
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                    .padding(.top , 5)
                            }
                        })
                        .frame(width: 90, height: 90)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(foodThemeViewModel.cookingType.contains(data.title) ? Color.primary7 : Color.gray1, lineWidth:1)
                        )
                    }
                }.padding(.horizontal, 40)
                    .padding(.vertical, 65)
                
                Spacer()
                
                NavigationLink(destination: HouseholdCompositionView(email: email , cookingType: foodThemeViewModel.cookingType , userImage: userImage).toolbarRole(.editor)) {
                    Text("다음")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.primary7)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 46)
                }
            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray1)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension FoodThemeView {
    struct FoodTheme {
        let id = UUID()
        let image: Image
        let title: String
        
        static let themes: [FoodTheme] = [
            FoodTheme(image: Image(.fish), title: "반찬"),
            FoodTheme(image: Image(.sushi), title: "일식"),
            FoodTheme(image: Image(.noodle), title: "중식"),
            FoodTheme(image: Image(.rice), title: "한식"),
            FoodTheme(image: Image(.burger), title: "양식"),
            FoodTheme(image: Image(.cakeSlice), title: "디저트"),
            FoodTheme(image: Image(.noodle), title: "아시아"),
            FoodTheme(image: Image(.riceCake), title: "분식"),
            FoodTheme(image: Image(.moon), title: "야식")
            
        ]
    }
}

#Preview {
    FoodThemeView()
}
