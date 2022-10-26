//
//  NetSpeed.swift
//  WapeSpeed
//
//  Created by HeHeMobi on 23/9/2022.
//

import Foundation

class WSNetSpeed {
    /// 单例
    static let shared = WSNetSpeed()
    // 代理
    weak var delegate: WSNetSpeedProtocol?
    
    /// 定时器
    private var timer: Timer?
    // 每隔多少秒刷新一次
    private var duration = 0
    /// 标记是否是第一次
    private var isNotFirstTime = false
    /// 上传八位字节数
    private var sentOctets: UInt32 = 0
    /// 接收的八位字节数
    private var receivedOctets: UInt32 = 0
    /// 最后一次上传的八位字节数
    private var lastSentOctets: UInt32 = 0
    /// 最后一次接收的八位字节数
    private var lastReceivedOctets: UInt32 = 0
    
    /// 开始测速
    /// - Parameter duration: 每'duration'秒测一次
    func begin(duration: Int = 1) {
        self.duration = duration
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(duration),
                                     target: self,
                                     selector: #selector(getCurrentSpeed),
                                     userInfo: nil,
                                     repeats: true)
        guard let timer = timer else { return }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    /// 停止测速
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func getCurrentSpeed() {
        var addrs = UnsafeMutablePointer<ifaddrs>.init(bitPattern: 0)
        if getifaddrs(&addrs) == 0 {
            while addrs != nil {
                if let ifa_data = addrs?.pointee.ifa_data {
                    let if_data = ifa_data.load(as: if_data.self)
                    receivedOctets &+= if_data.ifi_ibytes
                    sentOctets &+= if_data.ifi_obytes
                }
                addrs = addrs?.pointee.ifa_next
            }
        }
        freeifaddrs(addrs)
        
        // 第一次不回调
        if isNotFirstTime {
            let sent = (sentOctets &- lastSentOctets) / UInt32(duration)
            delegate?.didSent(octets: sent)
            
            let received = (receivedOctets &- lastReceivedOctets) / UInt32(duration)
            delegate?.didReceived(octets: received)
        } else {
            isNotFirstTime = true
        }
        
        lastReceivedOctets = receivedOctets;
        lastSentOctets = sentOctets;
        receivedOctets = 0;
        sentOctets = 0;
    }
}

protocol WSNetSpeedProtocol: AnyObject {
    func didSent(octets: UInt32)
    func didReceived(octets: UInt32)
}
