//
//  ViewController.swift
//  002demo
//
//  Created by ymy on 2020/8/3.
//  Copyright © 2020 ymy. All rights reserved.
//

import UIKit


//下面的代码会导致什么问题  答案会出现循环引用不能释放
//class Node {
//    var value = 0
//    var prev : Node?
//    var next : Node?
//
//    init(_ value : Int) {
//        self.value = value
//    }
//
//    deinit {
//        print("deinit")
//    }
//}

//正确的写法
class Node {
    var value = 0
    weak var prev : Node?
    weak var next : Node?

    init(_ value : Int) {
        self.value = value
    }

    deinit {
        print("deinit")
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let a = Node(0)
        let b = Node(1)
        
        a.prev = b
        b.next = a
        
        
        
    }


}

