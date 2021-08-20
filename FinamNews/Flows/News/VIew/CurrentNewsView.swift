//
//  CurrentView.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import UIKit

class CurrentNewsView: UIView {
    
    lazy var stackContent: BaseHorizontalStackView = {
        let stackContent = BaseHorizontalStackView()
        return stackContent
    }()
    
    lazy var image: BaseUIImageView = {
        let image = BaseUIImageView()
        return image
    }()
    
    lazy var title: BaseLabel = {
        let title = BaseLabel()
        return title
    }()
    
    lazy var newsDescription: BaseLabelArea = {
        let newsDescription = BaseLabelArea()
        return newsDescription
    }()
    
    init() {
        super.init(frame: .zero)
        addView()
    }
    
    func addView() {
        self.addSubview(stackContent)
        stackContent.addArrangedSubview(image)
        stackContent.addArrangedSubview(title)
        self.addSubview(newsDescription)
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 100),
            
            stackContent.topAnchor.constraint(equalTo: self.topAnchor,
                                              constant: MarginSettingsEnum.baseTopAnchor.rawValue),
            stackContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            stackContent.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            stackContent.bottomAnchor.constraint(equalTo: self.newsDescription.topAnchor,
                                                 constant: -MarginSettingsEnum.baseBottomAnchor.rawValue),

            newsDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                    constant: -MarginSettingsEnum.baseBottomAnchor.rawValue),

            newsDescription.leadingAnchor.constraint(equalTo: self.stackContent.leadingAnchor),
            newsDescription.trailingAnchor.constraint(equalTo: self.stackContent.trailingAnchor),
            
//            photo.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
//            photo.heightAnchor.constraint(equalTo: self.photo.widthAnchor, multiplier: 1.2)


        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
