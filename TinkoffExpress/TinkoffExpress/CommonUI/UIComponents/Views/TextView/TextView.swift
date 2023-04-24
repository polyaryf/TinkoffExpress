//
//  TextView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 17.04.2023.
//

import UIKit

class TextView: UITextView {
    // MARK: Property
    
    var textDidChangeHandler: (() -> Void)?
    var viewSizeDidChangeHandler: (() -> Void)?
    
    // MARK: Init

    convenience init() {
        self.init(frame: CGRect.zero, textContainer: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChangeNotification),
            name: UITextView.textDidChangeNotification ,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textDidChangeNotification(_ notif: Notification) {
        guard self == notif.object as? UITextView else {
            return
        }
        viewSizeDidChange()
        checkPlaceholder()
        checkClearTextButton()
        textDidChange()
        
        if text.count > 100 {
            self.deleteBackward()
        }
    }

    func textDidChange() {
        textDidChangeHandler?()
    }
    
    func viewSizeDidChange() {
        viewSizeDidChangeHandler?()
    }
}
