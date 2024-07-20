//
//  gallery.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 07.07.2024.
//

import SwiftUI
import Nuke
import NukeUI
import SwiftUIIntrospect
import NukeVideo
import AVKit

public struct GalleryConfiguration {
    let navBarColor: UIColor
    let saveEnabled: Bool
    let errorImage: UIImage

    public init(navBarColor: UIColor = .white, saveEnabled: Bool = false, errorImage: UIImage) {
        self.navBarColor = navBarColor
        self.saveEnabled = saveEnabled
        self.errorImage = errorImage
    }
}

struct GalleryItemView: View {
    let item: (url: URL, type: PacketType)

    var body: some View {
        Group {
            if item.type == .image {
                GalleryZoomableView {
                    LazyImage(url: item.url) {
                        $0.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            } else if item.type == .video {
                VideoPlayer(url: item.url)
                    .clipped()
            }
        }
    }
}



public struct GalleryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var presented: Binding<Bool>?
    @StateObject private var viewModel: GalleryViewModel
    private let config: GalleryConfiguration
    public var dismissed: (() -> Void)?
    let showDismiss: Bool

    public init(presented: Binding<Bool>? = nil, urls: [(url: URL, type: PacketType)], selected: Int, showDismiss: Bool = true, configuration: GalleryConfiguration, dismissed: (() -> Void)? = nil) {
        self.presented = presented
        self.config = configuration
        self.dismissed = dismissed
        self.showDismiss = showDismiss
        self._viewModel = StateObject(wrappedValue: GalleryViewModel(urls: urls, selected: selected))
    }
    
    public var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack {
                if !viewModel.urls.isEmpty {
                    TabView(selection: $viewModel.selected) {
                        ForEach(Array(viewModel.urls.enumerated()), id: \.offset) { index, item in
                            GalleryItemView(item: viewModel.urls[index])
                                .tag(index)
                            
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
       // .background(Color.white.edgesIgnoringSafeArea(.all))
        .toolbar {
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                if showDismiss {
                    leadingToolbarView
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
    }

    private var leadingToolbarView: some View {
        TopBackButton {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct VideoGalleryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    public var body: some View {
        VideoPlayer(url: url)
            .navigationBarBackButtonHidden(true)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    leadingToolbarView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.all)
        
    }
    
    private var leadingToolbarView: some View {
        TopBackButton {
            self.presentationMode.wrappedValue.dismiss()
        }
      }
}



struct LightButtonStyle: ButtonStyle {
    var disabled = false
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(disabled ? Color(white: 0.8) : Color.white)
    }
}

struct DarkButtonStyle: ButtonStyle {
    var disabled = false
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(disabled ? Color(white: 0.8) : Color.black)
    }
}

public struct GalleryZoomableView<Content: View>: UIViewRepresentable {
    private var content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 10
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        hostedView.backgroundColor = UIColor(Color("background"))
        scrollView.addSubview(hostedView)
        return scrollView
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: content))
    }

    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        uiView.setZoomScale(1.0, animated: true)
        context.coordinator.hostingController.rootView = content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }

    public class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        public init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }

        public func viewForZooming(in _: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}

class GalleryViewModel: ObservableObject {
    @Published var urls: Array<(url: URL, type: PacketType)>
    @Published var selected: Int
    var shareData: UIImage?

    var presentingImageURL: URL {
        return urls[selected].url
    }

    init(urls: Array<(url: URL, type: PacketType)>, selected: Int, shareData: UIImage? = nil) {
        self.urls = urls
        self.selected = selected
        self.shareData = shareData
    }
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero
    private let dismissHeight: CGFloat = 100

    func body(content: Content) -> some View {
        content
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 && gesture.translation.height > 10 {
                            offset = gesture.translation
                            print(offset)
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.height) > dismissHeight {
                            onDismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}

extension View {
    func swipeToClose(onDismiss: @escaping () -> Void) -> some View {
        modifier(SwipeToDismissModifier(onDismiss: onDismiss))
    }
}


public enum PacketType: Equatable {
    case typeUnspecified // = 0
    case image // = 1
    case audio // = 2
    case file // = 3
    case video // = 6
    case location // = 7
    case contact // = 8
    case audioCall // = 9
    case videoCall // = 10
    case system // = 11
    case text // = 12
    case voice // = 13
    case pinMessage // = 14
    case UNRECOGNIZED(Int)

    public init() {
        self = .typeUnspecified
    }

    public init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .typeUnspecified
        case 1: self = .image
        case 2: self = .audio
        case 3: self = .file
        case 6: self = .video
        case 7: self = .location
        case 8: self = .contact
        case 9: self = .audioCall
        case 10: self = .videoCall
        case 11: self = .system
        case 12: self = .text
        case 13: self = .voice
        case 14: self = .pinMessage
        default: self = .UNRECOGNIZED(rawValue)
        }
    }

    public static func == (lhs: PacketType, rhs: PacketType) -> Bool {
        switch (lhs, rhs) {
        case (.typeUnspecified, .typeUnspecified),
             (.image, .image),
             (.audio, .audio),
             (.file, .file),
             (.video, .video),
             (.location, .location),
             (.contact, .contact),
             (.audioCall, .audioCall),
             (.videoCall, .videoCall),
             (.system, .system),
             (.text, .text),
             (.voice, .voice),
             (.pinMessage, .pinMessage):
            return true
        case let (.UNRECOGNIZED(lhsValue), .UNRECOGNIZED(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }

    public var rawValue: Int {
        switch self {
        case .typeUnspecified: return 0
        case .image: return 1
        case .audio: return 2
        case .file: return 3
        case .video: return 6
        case .location: return 7
        case .contact: return 8
        case .audioCall: return 9
        case .videoCall: return 10
        case .system: return 11
        case .text: return 12
        case .voice: return 13
        case .pinMessage: return 14
        case .UNRECOGNIZED(let i): return i
        }
    }
}




class PlayerViewModel: ObservableObject {
    @Published var currentDuration: Double = 0.0
    
    let fileName: String
    let url: URL
    
    var timeObserver: Any?
    
    public init(url: URL, filename: String = "") {
        self.avPlayer = AVPlayer(url: url)
        self.fileName = filename
        self.url = url
    }
    
    private var avPlayer: AVPlayer
    
    public var player: AVPlayer {
        get { return avPlayer }
        set { avPlayer = newValue }
    }
    
    public var status:  AVPlayer.TimeControlStatus {
        return avPlayer.playbackCoordinator.player?.timeControlStatus ?? .paused
    }
    
    public var isPlaying: Bool {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
        return status == .playing
    }
    
    public var totalDuration: Double {
        guard let duration = avPlayer.currentItem?.duration.seconds
        else { return 1 }
        return duration > 0 ? duration : 1
    }
    
    public func playOrPuse() {
        isPlaying ? avPlayer.pause() : avPlayer.play()
    }
    
    public func pause() {
        avPlayer.pause()
    }
    
    public func seek(to time: Double) {
        let time = CMTime(seconds: time, preferredTimescale: 600)
        avPlayer.seek(to: time)
    }
    
    public func startMonitoringPlayer() {
        let interval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.timeObserver = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] elapsedTime in
            self?.currentDuration = elapsedTime.seconds
        })
    }
    
    public func stopMonitoringPlayer() {
        avPlayer.removeTimeObserver(timeObserver as Any)
        timeObserver = nil
    }
}


public struct VideoPlayer: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var playerViewModel: PlayerViewModel
    
    @State private var isShowingControllPannel = true
    @State private var playbackTime: Double = .zero
    @State private var hideControllPannelTask: Task<Void, Never>?
    
    let url: URL
    
    public init(url: URL) {
        self._playerViewModel = StateObject(
            wrappedValue: PlayerViewModel(url: url)
        )
        self.url = url
    }
    
    public var body: some View {
        
        VStack {
            PlayerView(player: playerViewModel.player, url: playerViewModel.url)
                .onTapGesture {
                    withAnimation {
                        if isShowingControllPannel {
                            isShowingControllPannel = false
                            hideControllPannelTask?.cancel()
                        } else {
                            isShowingControllPannel = true
                        }
                    }
                }
                .overlay(alignment: .bottom) {
                    if isShowingControllPannel {
                        HStack {
                            Button(action: {
                                playerViewModel.playOrPuse()
                            }) {
                                Image(systemName: playerViewModel.isPlaying ? "pause.fill" : "play.fill")
                            }
                            .foregroundStyle(Color.black)
                            
                            CustomSlider(
                                value: $playerViewModel.currentDuration,
                                maxValue: playerViewModel.totalDuration,
                                thumbColor: .black,
                                minTrackColor: .black,
                                onSliderBegun: {
                                    playerViewModel.stopMonitoringPlayer()
                                },
                                onSliderEnded: {
                                    playerViewModel.startMonitoringPlayer()
                                },
                                onSliderChangedValue: {
                                    let targetTime:CMTime = CMTimeMake(value: Int64(playerViewModel.currentDuration), timescale: 1)
                                    playerViewModel.player.seek(to: targetTime)
                                }
                                
                            )
                            .padding(.horizontal)
                            .id(playerViewModel.totalDuration)
                        }
                        .transition(.move(edge: .bottom))
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .background(Color.white)
                    }
                }
                .onAppear {
                    self.hideControllPannelTask = Task {
                        try? await Task.sleep(nanoseconds: 5_000_000_000)
                        await MainActor.run {
                            if isShowingControllPannel {
                                withAnimation {
                                    isShowingControllPannel = false
                                }
                            }
                        }
                    }
                    playerViewModel.startMonitoringPlayer()
                }
                .onDisappear {
                    playerViewModel.pause()
                }
        }
    }
}

struct PlayerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = AVPlayerViewController
    
    let player: AVPlayer
    let url: URL?
    
    public init(player: AVPlayer, url: URL? = nil) {
        self.player = player
        self.url = url
        try! AVAudioSession.sharedInstance().setCategory(.playback)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.playerDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if let newURL = url, let currentItem = uiViewController.player?.currentItem {
            NotificationCenter.default.removeObserver(context.coordinator, name: .AVPlayerItemDidPlayToEndTime, object: currentItem)
            
            uiViewController.player?.replaceCurrentItem(with: AVPlayerItem(url: newURL))
            
            NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.playerDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: uiViewController.player?.currentItem)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: PlayerView
        
        init(_ parent: PlayerView) {
            self.parent = parent
        }
        
        @objc func playerDidFinishPlaying(_ notification: Notification) {
            parent.player.seek(to: .zero)
        }
        
        
        @objc func viewDidDisappear(_ notification: Notification) {
            parent.player.pause()
            parent.player.seek(to: .zero)
        }
    }
}


public struct CustomSlider: UIViewRepresentable {
    
    var maxValue = 100.0
    @Binding var value: Double {
        didSet {
            print(value)
        }
    }
    @Binding var enabled: Bool
    
    var minValue = 1.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .blue
    var maxTrackColor: UIColor = .lightGray
    var thumbSize: CGFloat = 30
    
    let onSliderBegun: (() -> ())?
    let onSliderEnded: (() -> ())?
    let onSliderChangedValue: (() -> ())?
    
    public init(
        value: Binding<Double>,
        enabled: Binding<Bool> = .constant(true),
        minValue: Double = 1.0,
        maxValue: Double = 100.0,
        thumbColor: UIColor = .white,
        minTrackColor: UIColor = .blue,
        maxTrackColor: UIColor = .lightGray,
        thumbSize: CGFloat = 30,
        onSliderBegun: (() -> ())? = nil,
        onSliderEnded: (() -> ())? = nil,
        onSliderChangedValue: (() -> ())? = nil
    ) {
        self._enabled = enabled
        self._value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.thumbColor = thumbColor
        self.minTrackColor = minTrackColor
        self.maxTrackColor = maxTrackColor
        self.thumbSize = thumbSize
        self.onSliderBegun = onSliderBegun
        self.onSliderEnded = onSliderEnded
        self.onSliderChangedValue = onSliderChangedValue
    }
    
   public class Coordinator: NSObject {
       var value: Binding<Double>
       var enabled: Binding<Bool>
       var timeObserver: Any?
       
       let onSliderBegun: (() -> ())?
       let onSliderEnded: (() -> ())?
       let onSliderChangedValue: (() -> ())?
       
       public init(
        value: Binding<Double>,
        enabled: Binding<Bool>,
        onSliderBegun: (() -> ())? = nil,
        onSliderEnded: (() -> ())? = nil,
        onSliderChangedValue: (() -> ())? = nil
       ) {
           self.value = value
           self.enabled = enabled
           self.onSliderBegun = onSliderBegun
           self.onSliderEnded = onSliderEnded
           self.onSliderChangedValue = onSliderChangedValue
       }
       
        @objc func playbackSliderValueChanged(_ playbackSlider:UISlider, event: UIEvent) {
            
            if let onSliderChangedValue {
                onSliderChangedValue()
            }
            if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .began:
                    if let onSliderBegun {
                        onSliderBegun()
                    }
                    break
                case .moved:
                    break
                case .ended:
                    if let onSliderEnded {
                        onSliderEnded()
                    }
                    break
                default:
                    break
                }
            }
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            if enabled.wrappedValue {
                self.value.wrappedValue = Double(sender.value)
            }
        }
    }
    
    public func makeCoordinator() -> CustomSlider.Coordinator {
        Coordinator(
            value: $value,
            enabled: $enabled,
            onSliderBegun: onSliderBegun,
            onSliderEnded: onSliderEnded,
            onSliderChangedValue: onSliderChangedValue
        )
    }
    
    public func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        let circleImage = makeCircleWith(
            size: CGSize(width: thumbSize, height: thumbSize),
            backgroundColor: thumbColor)
        slider.setThumbImage(circleImage, for: .normal)
        slider.setThumbImage(circleImage, for: .highlighted)
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.playbackSliderValueChanged(_:event:)),
            for: .valueChanged
        )
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        slider.isEnabled = enabled
        
        return slider
    }
    
    public func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.isEnabled = enabled
    }
    
    fileprivate func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


