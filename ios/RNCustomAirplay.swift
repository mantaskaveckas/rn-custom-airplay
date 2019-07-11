import MediaPlayer

@objc(RNCustomAirplay)
class RNCustomAirplay: RCTEventEmitter {
    func methodQueue() -> DispatchQueue {
        return DispatchQueue.main
    }

    @objc func startScan() -> Void {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RNCustomAirplay.airplayChanged(sender:)),
                                               name: AVAudioSession.routeChangeNotification,
                                               object: AVAudioSession.sharedInstance())
        self.isConnected()
    }

    @objc func endScan() -> Void {
      NotificationCenter.default.removeObserver(self)
    }

    @objc func airplayChanged(sender: NSNotification) {
        self.isConnected()
    }

    @objc func isConnected() -> Void {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        var isConnected = false
        for output in currentRoute.outputs {
            if output.portType == AVAudioSession.Port.airPlay {
                isConnected = true
                break;
            }
        }
        self.sendEvent(withName: "airplayConnected",
                       body: ["connected": isConnected])
    }

    @objc func isAvailable() -> Void {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        var isAvailable = false
        if (currentRoute.outputs.count > 0) {
            isAvailable = true
        }
        self.sendEvent(withName: "airplayAvailable",
                        body: ["available": isAvailable])
    }

    override func supportedEvents() -> [String]! {
        return ["airplayConnected"]
    }
}
