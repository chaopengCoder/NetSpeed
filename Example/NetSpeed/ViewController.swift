//
//  ViewController.swift
//  NetSpeed
//
//  Created by luke on 10/26/2022.
//  Copyright (c) 2022 luke. All rights reserved.
//

import UIKit
import NetSpeed

class ViewController: UIViewController {
    
    fileprivate lazy var iSentLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .darkText
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 18, weight: .bold)
        lb.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 40)
        return lb
    }()
    
    fileprivate lazy var iReceivedLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .darkText
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 18, weight: .bold)
        lb.frame = CGRect(x: 20, y: 160, width: UIScreen.main.bounds.width - 40, height: 40)
        return lb
    }()
    
    fileprivate lazy var iBeginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .red
        btn.setTitle("Begin", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(beginAction), for: .touchUpInside)
        btn.frame = CGRect(x: 20, y: 300, width: 80, height: 40)
        return btn
    }()
    
    fileprivate lazy var iStopBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .red
        btn.setTitle("Stop", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        btn.frame = CGRect(x: 120 , y: 300, width: 80, height: 40)
        return btn
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(iSentLb)
        view.addSubview(iStopBtn)
        view.addSubview(iBeginBtn)
        view.addSubview(iReceivedLb)
    }
    
    @objc func beginAction() {
        // 开始测速
        NetSpeed.shared.delegate = self
        NetSpeed.shared.begin()
    }
    
    @objc func stopAction() {
        NetSpeed.shared.stop()
    }
}

extension ViewController: NetSpeedProtocol {
    
    func didSent(octets: UInt32) {
        iSentLb.text = "upload \(formatSpeed(octets: octets))"
        
    }
    
    func didReceived(octets: UInt32) {
        iReceivedLb.text = "download \(formatSpeed(octets: octets))"
    }
    
    /// 格式化
    private func formatSpeed(octets: UInt32) -> String {
        var speedString = ""
        if octets < 1024 {
            speedString = String(format: "%lludB/S", octets)
        } else if octets >= 1024 && octets < 1024 * 1024 {
            speedString = String(format: "%lluKB/S", octets / 1024)
        } else if octets >= 1024 * 1024 {
            speedString = String(format: "%lluMB/S", octets / (1024*1024))
        }
        return speedString
    }
}
