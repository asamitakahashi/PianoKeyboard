//
//  Menu2ViewController.swift
//  Example
//
//  Created by user on 2021/01/10.
//  Copyright © 2021 Gary Newby. All rights reserved.
//

import UIKit

class Menu2ViewController: UIViewController {


    @IBOutlet weak var menu2View: UIImageView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // メニューの位置を取得する
            let menuPos = self.menu2View.layer.position
            // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
            self.menu2View.layer.position.x = -self.menu2View.frame.width
            // 表示時のアニメーションを作成する
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.menu2View.layer.position.x = menuPos.x
            },
                completion: { bool in
            })
            
        }

        // メニューエリア以外タップ時の処理
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
            for touch in touches {
                if touch.view?.tag == 1 {
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0,
                        options: .curveEaseIn,
                        animations: {
                            self.menu2View.layer.position.x = -self.menu2View.frame.width
                    },
                        completion: { bool in
                            self.dismiss(animated: true, completion: nil)
                    }
                    )
                }
            }
        }
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

