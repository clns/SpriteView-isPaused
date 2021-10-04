import SwiftUI
import SpriteKit

class GameScene: SKScene, ObservableObject {
    private let label = SKLabelNode(text: "Updates:\n0")
    private var updates = 0
    
    override func didMove(to view: SKView) {
        addChild(label)
        label.numberOfLines = 2
    }
    
    override func update(_ currentTime: TimeInterval) {
        updates += 1
        label.text = "Updates:\n\(updates)"
    }
    
    func isPaused(_ isPaused: Bool) {
        print("isPaused(\(isPaused))")
    }
}

struct ContentView: View {
    @State private var showingLevelChooser = false
    
    @StateObject var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .fill
        return scene
    }()
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene, isPaused: showingLevelChooser)
                .ignoresSafeArea()
            VStack {
                Button("Level Chooser") {
                    showingLevelChooser.toggle()
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showingLevelChooser) {
            VStack {
                Button("Cancel") {
                    showingLevelChooser.toggle()
                }
                Spacer()
            }
            .background(BackgroundClearView())
        }
        .onChange(of: showingLevelChooser) {
            scene.isPaused($0)
        }
    }
}

/*
 Make the .sheet() transparent, so we can see the scene behind.
 
 Idea from https://stackoverflow.com/questions/63745084/how-can-i-make-a-background-color-with-opacity-on-a-sheet-view
 */
struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
