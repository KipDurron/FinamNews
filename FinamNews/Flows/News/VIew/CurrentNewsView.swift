//
//  CurrentView.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import UIKit

class CurrentNewsView: UIView {
    
    lazy var image: BaseUIImageView = {
        let image = BaseUIImageView()
        return image
    }()
    
    lazy var title: BaseLabelArea = {
        let title = BaseLabelArea()
        title.font = UIFont.boldSystemFont(ofSize: 16.0)
        return title
    }()
    
    lazy var newsDescription: BaseLabelArea = {
        let newsDescription = BaseLabelArea()
        newsDescription.layer.borderWidth = 1
        newsDescription.layer.borderColor = UIColor.black.cgColor
        return newsDescription
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        addView()
    }
    
    func addView() {
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(newsDescription)
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            image.heightAnchor.constraint(equalTo: self.image.widthAnchor),
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                              constant: MarginSettingsEnum.baseTopAnchor.rawValue),
            image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            image.bottomAnchor.constraint(equalTo: self.title.topAnchor,
                                                 constant: -MarginSettingsEnum.baseBottomAnchor.rawValue),
            

            title.leadingAnchor.constraint(equalTo: self.image.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            title.bottomAnchor.constraint(equalTo: self.newsDescription.topAnchor,
                                                    constant: -MarginSettingsEnum.baseBottomAnchor.rawValue),

            newsDescription.leadingAnchor.constraint(equalTo: self.title.leadingAnchor),
            newsDescription.trailingAnchor.constraint(equalTo: self.title.trailingAnchor),
            newsDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            


        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
