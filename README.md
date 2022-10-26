# NetSpeed
##### 注意
##### 1. 支持Swift 5
##### 2. iOS 11+

##### usage
```swift
// 开始测速
NetSpeed.shared.delegate = self
// 默认1秒更新一次
NetSpeed.shared.begin()
// 自定义刷新时间
NetSpeed.shared.begin(duration: 2)
```

```swift
// 停止测速
NetSpeed.shared.stop()
```

```swift
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
```
