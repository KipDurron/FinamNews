//
//  ExUIImage.swift
//  ForVK
//
//  Created by Илья Кадыров on 30.09.2020.
//  Copyright © 2020 Илья Кадыров. All rights reserved.
//
import UIKit

extension UIImage {
    static func load(from: String?, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            do {
                guard let urlStr = from else {
                    DispatchQueue.main.async {
                        completion(UIImage(systemName: "photo")!)
                    }
                    return
                }
                let url = URL(string: urlStr)
                let data = try Data(contentsOf: url!)
                guard let image = UIImage(data: data) else {
                    debugPrint("faled get Image")
                    return
                }

                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                debugPrint("faled get Image from Url")
                DispatchQueue.main.async {
                    completion(UIImage(systemName: "photo")!)
                }
            }
        }
    }
}
