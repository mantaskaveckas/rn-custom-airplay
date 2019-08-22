import MediaPlayer

@objc(RNCustomAirplayButton)
class RNCustomAirplayButton: RCTViewManager {
  func methodQueue() -> DispatchQueue {
    return DispatchQueue.main
  }

  override func view() -> UIView! {
    let volumeView = MPVolumeView()
    volumeView.showsVolumeSlider = false

    return volumeView
  }
}
