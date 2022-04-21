//
//  MagicView.swift
//  Runner
//
//  Created by Walker Zhao on 2022/4/21.
//

import Foundation
import UIKit

class MagicView: UIView {
    
    static let RECEIVE_TITLE = "Receive from Flutter: "
    static let SEND_TITLE = "Send to Flutter: "
    static let SEND_MESSAGE = "Hello, i am ios."
    
    private let receive: UILabel = UILabel()
    private let send: UILabel = UILabel()
    private let sendButton: UIButton = UIButton()
    var onSendButtonClick: (String) -> Void = { _ in }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.darkGray

        // 初始化控件属性，逐个添加控件
        receive.text = "\(MagicView.RECEIVE_TITLE)"
        receive.textAlignment = NSTextAlignment.center
        addSubview(receive)
        
        send.text = "\(MagicView.SEND_TITLE)\(MagicView.SEND_MESSAGE)"
        send.textAlignment = NSTextAlignment.center
        addSubview(send)
        
        sendButton.setTitle("Send", for: UIControl.State.normal)
        sendButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sendButton.backgroundColor = UIColor.purple
        sendButton.layer.cornerRadius = 10.0
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
        addSubview(sendButton)
    }
    
    override func layoutSubviews() {
        let height = self.frame.size.height
        let width = self.frame.size.width
        
        // 平分空间算法
        let itemValidSpace = height / 3
        let itemOffset = itemValidSpace / 2 - 48 / 2
        
        // 设置每个控件的大小
        receive.frame = CGRect(x: 0, y: itemValidSpace * 0 + itemOffset, width: width, height: 48)
        send.frame = CGRect(x: 0, y: itemValidSpace * 1 + itemOffset, width: width, height: 48)
        sendButton.frame = CGRect(x: width / 2 - 100 / 2, y: itemValidSpace * 2 + itemOffset, width: 100, height: 48)
        print(height, width)
    }
    
    @objc private func sendButtonClick(sender: UIButton) {
        onSendButtonClick(MagicView.SEND_MESSAGE)
    }
    
    func receiveMessage(message: String) {
        receive.text = "\(MagicView.RECEIVE_TITLE)\(message)"
    }
}
