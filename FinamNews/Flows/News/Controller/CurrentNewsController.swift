//
//  CurrentNewsController.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import UIKit

class CurrentNewsController: UIViewController {
    
    var currentNewsView: BaseViewWithScroll<CurrentNewsView>?
    let currentNews: News

    override func viewDidLoad() {
        super.viewDidLoad()
        UIImage.load(from: currentNews.urlToImage) {[weak self] image in
            self?.currentNewsView?.contentView.image.image = image
        }
        currentNewsView?.contentView.title.text = currentNews.title
        currentNewsView?.contentView.newsDescription.text = currentNews.newsDescription
        if let urlNews = currentNews.url,
           currentNewsView?.contentView.newsDescription.text != nil{
            currentNewsView?.contentView.newsDescription.text! += "\n" + urlNews
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(news: News) {
        self.currentNews = news
        super.init(nibName: nil, bundle: nil)

    }
    
    override func loadView() {
        currentNewsView = BaseViewWithScroll<CurrentNewsView>(contentView: CurrentNewsView())
        self.view = currentNewsView
    }

}

extension CurrentNewsController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText newText: String) -> Bool {
            return textView.text.count + (newText.count - range.length) <= 140
        }
}
