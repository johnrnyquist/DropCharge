/*
 * Copyright (c) 2015 Razeware LLC
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit
import GameplayKit

class Lava: GKState {
    unowned let scene: GameScene

    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        scene.playerTrail.particleBirthRate = 0
        scene.run(scene.soundHitLava)
        let smokeTrail = scene.addTrail(name: "SmokeTrail")
        scene.run(SKAction.sequence([
                                        SKAction.wait(forDuration: 3.0),
                                        SKAction.run() {
                                            self.scene.removeTrail(trail: smokeTrail)
                                        }
                                    ]))
        scene.boostPlayer()
        scene.lives -= 1
        scene.screenShakeByAmt(amt: 50)
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Jump.Type || stateClass is Fall.Type || stateClass is Dead.Type
    }
}
