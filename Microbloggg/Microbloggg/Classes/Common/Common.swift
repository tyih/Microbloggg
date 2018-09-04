//
//  Common.swift
//  Microbloggg
//
//  Created by tiany on 2018/9/3.
//  Copyright © 2018 ty. All rights reserved.
//

import UIKit
import Foundation

func MBprint<T>(_ message: T, filePath: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".Swift", with: "")
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    print("[" + dateFormatter.string(from: Date()) + " " + fileName + " " + function + " \(line)" + "]: " + "\(message)")
    #endif
}

let kRedColor: UIColor! = UIColor.init(hexString: "#D74049FF")
let kGrayColor: UIColor! = UIColor.init(hexString: "#617282FF")

