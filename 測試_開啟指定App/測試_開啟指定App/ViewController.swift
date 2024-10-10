//
//  ViewController.swift
//  測試_開啟指定App
//
//  Created by Bob on 2024/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    
    @IBAction func tapOpenApp(_ sender: Any) {
        //方法1
        //openDirectApp()
        
        //方法2
        openAppStore(appURLString: "https://apps.apple.com/tw/app/line/id443904275")
    }
 
    
    // MARK: 方法1
    /// 參考 https://stackoverflow.com/questions/25882936/open-appstore-through-button
    /// App List 參考 https://github.com/bhagyas/app-urls
    func openDirectApp() {
        if let url = URL(string: "line://") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /*
     搭配info.plist加上
     <key>LSApplicationQueriesSchemes</key>
     <array>
         <string>line</string>
     </array>
     */
    
    

    // MARK: 方法2
    /// 參考1 https://medium.com/ios-app%E9%96%8B%E7%99%BC%E4%B9%8B%E4%B8%96%E7%95%8C%E9%80%99%E9%BA%BC%E5%A4%A7/link-to-app-store-specific-app-from-ios-app-by-url-scheme-a98b571b83a6
    /// 參考2 https://medium.com/ios-app%E9%96%8B%E7%99%BC%E4%B9%8B%E4%B8%96%E7%95%8C%E9%80%99%E9%BA%BC%E5%A4%A7/%E5%9C%A8ios-app%E5%85%A7%E9%96%8B%E5%95%9F%E7%AC%AC%E4%B8%89%E6%96%B9app-73de299efcb0
    func openAppStore(appURLString: String) {
        // 1
        /*
         split(separator: "/"): 這個方法將 appURLString 字符串按照 "/" 分隔符進行分割。
         例如，如果 appURLString 是 "https://apps.apple.com/tw/app/udnreport/id893922027"，
         分割後的結果會是 ["https:", "", "apps.apple.com", "tw", "app", "udnreport", "id893922027"]。
        .last: 這個屬性用於獲取分割後數組的最後一個元素。在這個例子中，最後一個元素就是 "id893922027"，也就是我們需要的 App ID。
         */
        guard let id = appURLString.split(separator: "/").last else {
            print("擷取 App ID 失敗")
            return
        }
        // 2
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/\(id)") else {
            print("實例化 App Store Open specific URL Scheme 失敗")
            return
        }
        
        // 3
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}

