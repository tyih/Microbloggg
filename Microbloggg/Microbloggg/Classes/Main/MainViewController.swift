//
//  MainViewController.swift
//  Microbloggg
//
//  Created by tiany on 2018/9/3.
//  Copyright © 2018 ty. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var rocketButton: UIButton = {
        let btn = UIButton()
        
        let image = UIImage.init(icon: FAType.FARocket, size: CGSize(width: 40, height: 40), textColor: kGrayColor)
        let imageH = UIImage.init(icon: FAType.FARocket, size: CGSize(width: 40, height: 40), textColor: kRedColor)
        btn.setImage(image, for: .normal)
        btn.setImage(imageH, for: .highlighted)
//        btn.setImage(UIImage(named: "tabbar_rocket"), for: .normal)
//        btn.setImage(UIImage(named: "tabbar_rocket_highlighted"), for: .highlighted)

        btn.addTarget(self, action: #selector(rocketBtnClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加子控制器
//        addChildViewControllers()
        
        //        tabBar.items![0].setFAIcon(icon: FAType.FANewspaperO)
        //        tabBar.items![1].setFAIcon(icon: FAType.FAEnvelopeO)
        //        //        tabBar.items![2].setFAIcon(icon: FAType.FARocket)
        //        tabBar.items![3].setFAIcon(icon: FAType.FASearch)
        //        tabBar.items![4].setFAIcon(icon: FAType.FASmileO)
        
        // 使用字体图标
        addChildViewControllerFA(childControllerName: "NewsViewController", title: "", faType: .FANewspaperO)
        addChildViewControllerFA(childControllerName: "MessageViewController", title: "", faType: .FAEnvelopeO)
        addChildViewControllerFA(childControllerName: "NullViewController", title: "", faType: nil)
        addChildViewControllerFA(childControllerName: "DiscoverViewController", title: "", faType: .FASearch)
        addChildViewControllerFA(childControllerName: "ProfileViewController", title: "", faType: .FASmileO)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 添加中间按钮
        setupRocketButton()
    }
    
    private func setupRocketButton() {
        tabBar.addSubview(rocketButton)
        
        // 调整位置
        let width = UIScreen.main.bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x: 0, y: 0, width: width, height: 50)
        rocketButton.frame = rect.offsetBy(dx: 2 * width, dy: 0)
    }
    
    @objc func rocketBtnClick() {
        
        MBprint("rocket clicked")
    }
    
    /// 添加子控制器
    private func addChildViewControllers() {
        let path = Bundle.main.path(forResource: "MainControllersSetting.json", ofType: nil)
        if let jsonPath = path {
            if let jsonData = try? Data.init(contentsOf: URL.init(fileURLWithPath: jsonPath)) {
                
                do {
                    let dicArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    for dic in dicArray as! [[String: String]] {
                        addChildViewController(childControllerName: dic["vc"]!, title: dic["title"]!, imageName: dic["image"]!)
                    }
                } catch {
                    MBprint(error)
                    addChildViewController(childControllerName: "NewsViewController", title: "", imageName: "tabbar_news")
                    addChildViewController(childControllerName: "MessageViewController", title: "", imageName: "tabbar_message")
                    addChildViewController(childControllerName: "NullViewController", title: "", imageName: "")
                    addChildViewController(childControllerName: "DiscoverViewController", title: "", imageName: "tabbar_discover")
                    addChildViewController(childControllerName: "ProfileViewController", title: "", imageName: "tabbar_profile")
                }
            }
        }
    }
    
    /// 初始化子控制器
    ///
    /// - Parameters:
    ///   - childControllerName: 子控制器名称
    ///   - title: 标题
    ///   - imageName: 图片
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        // 获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转换成类
        let cls: AnyClass? = NSClassFromString(nameSpace + "." + childControllerName)
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        vc.title = title
        
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }
    
    
    /// 初始化子控制器（使用字体图标）
    ///
    /// - Parameters:
    ///   - childControllerName: 子控制器名称
    ///   - title: 标题
    ///   - faType: 字体类型
    private func addChildViewControllerFA(childControllerName: String, title: String, faType: FAType?) {
        // 获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转换成类
        let cls: AnyClass? = NSClassFromString(nameSpace + "." + childControllerName)
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()

        // 使用字体图标（Font Awesome字体库，非图片）
        if faType != nil {
            
            let image = UIImage.init(icon: faType!, size: CGSize(width: 30, height: 30), textColor: kGrayColor).withRenderingMode(.alwaysOriginal)
            let imageH = UIImage.init(icon: faType!, size: CGSize(width: 30, height: 30), textColor: kRedColor).withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.image = image
            vc.tabBarItem.selectedImage = imageH
        }
        vc.title = title
        
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
