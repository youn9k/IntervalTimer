//
//  Utility.swift
//  IntervalTimer
//
//  Created by YoungK on 12/16/23.
//

import Foundation
import UIKit

public func APP_WIDTH() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

public func APP_HEIGHT() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

public func STATUS_BAR_HEIGHT() -> CGFloat {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let statusBarManager = windowScene.statusBarManager {
        return max(20, statusBarManager.statusBarFrame.height)
    }
    return 20
}

public func SAFEAREA_BOTTOM_HEIGHT() -> CGFloat {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        return windowScene.windows.first?.safeAreaInsets.bottom ?? 0
    }
    return 0
}
