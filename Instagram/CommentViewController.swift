//
//  CommentViewController.swift
//  Instagram
//
//  Created by 岸本 諒太 on 2017/10/03.
//  Copyright © 2017年 ryota.kishimoto. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController{
    
    var postData:PostData!//データを受け取る変数

    
    @IBOutlet weak var commentText: UITextField!
    
    
    @IBAction func addComment(_ sender: Any) {
        
        if commentText.text! == ""{
            let storyboard: UIStoryboard = self.storyboard!
            let homeView = storyboard.instantiateViewController(withIdentifier:"Home") as! HomeViewController
            self.present(homeView, animated: true, completion: nil)
        }else{
        
            let name = Auth.auth().currentUser?.displayName//ユーザー名を取り出し
            postData.comments.append("\(name!): \(commentText.text!)")//commentsにユーザー名とコメント内容を追加
        
            let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
            let comments = ["comments": postData.comments]//commentsをfirebaseに追加する
            postRef.updateChildValues(comments)//保存
        
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントしました")
        
            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelComment(_ sender: Any) {
        print("DEBUG_PRINT: キャンセルボタンがタップされました。")
        let storyboard: UIStoryboard = self.storyboard!
        let homeView = storyboard.instantiateViewController(withIdentifier:"Home") as! HomeViewController
        self.present(homeView, animated: true, completion: nil)
    }
}


