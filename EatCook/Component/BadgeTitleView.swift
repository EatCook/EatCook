//
//  BadgeTitleView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

enum BadgeTitle: String, CaseIterable {
    case levelone
    case leveltwo
    case levelthree
    case levelfour
    case levelfive
    
    var title: String {
        switch self {
        case .levelone:
            return "요리 사망꾼"
        case .leveltwo:
            return "요리 새싹"
        case .levelthree:
            return "초보 칼잡이"
        case .levelfour:
            return "고독한 미식가"
        case .levelfive:
            return "미쉐린 쉐프"
        }
    }
    
    var titleColor: Color {
        switch self {
        case .levelone:
            return .gray6
        case .leveltwo:
            return .white
        case .levelthree:
            return .white
        case .levelfour:
            return .white
        case .levelfive:
            return .white
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .levelone:
            return .gray3
        case .leveltwo:
            return .primary3
        case .levelthree:
            return .primary4
        case .levelfour:
            return .primary5
        case .levelfive:
            return .primary6
        }
    }
    
}

struct BadgeTitleView: View {
    var badgeLevel: BadgeTitle
    
    var body: some View {
        Text(badgeLevel.title)
            .foregroundStyle(badgeLevel.titleColor)
            .font(.footnote)
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .fill(badgeLevel.backgroundColor)
            }
    }
    
    
    static func checkBadgeLevel(_ postCount: Int) -> BadgeTitle {
        switch postCount {
        case 0...29: return .levelone
        case 30...49: return .leveltwo
        case 50...69: return .levelthree
        case 70...99: return .levelfour
        case 100...: return .levelfive
        default: return .levelfive
        }
    }
}

#Preview {
    BadgeTitleView(badgeLevel: .levelfive)
}
