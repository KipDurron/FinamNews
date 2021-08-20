//
//  CurrentNewsController.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import UIKit

class CurrentNewsController: UIViewController {
    
    var currentNewsView: CurrentNewsView?
    let currentNews: News

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(news: News) {
        self.currentNews = news
        super.init(nibName: nil, bundle: nil)

    }
    
    override func loadView() {
        currentNewsView = CurrentNewsView()
        self.view = currentNewsView
    }

}
