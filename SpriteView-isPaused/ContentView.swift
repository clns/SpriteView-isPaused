import SwiftUI
import SpriteKit

class GameScene: SKScene {
    private let label = SKLabelNode(text: "Time Elapsed:\n0")
    private var lastUpdateTime : TimeInterval = 0
    
    override func didMove(to view: SKView) {
        addChild(label)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let seconds = Int(currentTime - lastUpdateTime)
        label.text = "Time Elapsed:\n\(seconds)"
        label.numberOfLines = 2
    }
}

struct ContentView: View {
    @State private var showingLevelChooser = false
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .fill
        return scene
    }
    
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
                Text("Level Chooser")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
