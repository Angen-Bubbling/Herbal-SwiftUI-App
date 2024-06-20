
import SwiftUI
import Lottie

struct LoginLottieView: UIViewRepresentable {
    
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LoginLottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named("shoppingCart")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([ animationView.heightAnchor.constraint(equalTo: view.heightAnchor), animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LoginLottieView>) {
        
    }
}

