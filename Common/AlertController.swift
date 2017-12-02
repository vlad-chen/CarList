//
// Created by Vladimir Kravchenko on 3/20/16.
// Copyright (c) 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    public func addActions(_ actions: [UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }
}

class AlertController {
    
    public class func show(with message: String,
                           actions: [UIAlertAction] = [AlertAction.ok.default],
                           from controller: UIViewController = AppFlowCoordinator.shared.topViewController,
                           completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addActions(actions)
        controller.present(alert, animated: true) {
            shared.alert = alert
            completion?()
        }
    }
    
    public class func dismiss(animated: Bool = true,
                              completion: (() -> Swift.Void)? = nil) throws {
        guard let alert = shared.alert else { throw Error.with(message: "Alert wasn't saved") }
        alert.dismiss(animated: animated) {
            shared.alert = nil
            completion?()
        }
    }
    
    // MARK: - Private -
    private static let shared = AlertController()
    private weak var alert: UIAlertController?
    private init(){}
    
}

public enum AlertAction {
    case ok, cancel, settings, disabled
    
    // MARK: - Public -
    
    var `default`: UIAlertAction { return with(title) }

    func with(_ title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler ?? self.handler)
    }
    
    // MARK: - Private -
    
    private var title: String {
        switch self {
        case .ok: return "Ok"
        case .cancel: return "Cancel"
        case .disabled: return "Ok"
        case .settings: return "Open settings"
        }
    }
    
    private var style: UIAlertActionStyle {
        switch self {
        case .ok, .disabled, .settings: return UIAlertActionStyle.default
        case .cancel: return UIAlertActionStyle.cancel
        }
    }

    private var handler: ((UIAlertAction) -> Swift.Void)? {
        switch self {
        case .ok, .cancel, .disabled: return nil
        case .settings: return settingsActionHandler
        }
    }
    
    private var settingsActionHandler: (UIAlertAction) -> Swift.Void {
        let application = UIApplication.shared
        guard let url = URL(string: UIApplicationOpenSettingsURLString), application.canOpenURL(url) else {
            return { _ in
                do {
                    try AlertController.dismiss() { AlertController.show(with: "Please open settings app manually") }
                } catch {
                    AlertController.show(with: "Please open settings app manually")
                }
            }
        }
        return { _ in application.open(url) }
    }
    
}
