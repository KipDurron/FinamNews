//
//  BaseTextView.swift
//  FinamNews
//
//  Created by Илья Кадыров on 21.08.2021.
//

import UIKit

class BaseTextView: UITextView {

    init() {
        super.init(frame: .zero, textContainer: nil)
        configuration()
        
    }

    private func configuration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isEditable = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
