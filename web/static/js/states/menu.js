import {Keyboard} from "./key_map"

//Menu with Phaser
export class MenuState extends Phaser.State {
  create() {
    this.label = this.addText('Type your name\n and press enter', this.world.centerX, this.world.centerY - 100)
    this.input.keyboard.addCallbacks(this, this.onDown)
    this.fullName = ""
    this.keyboard = new Keyboard ()
    this.xValueGame = -200
    this.xValue = -80
    this.insideGame = false
  }

  fingerNumber(finger) {
    let fingerLabel = this.addText(`Finger ${finger}`, this.world.centerX, this.world.centerY - 200)
    let tween = this.add.tween(fingerLabel)
    tween.to({x: 350, y: 350}, 200, Phaser.Easing.Linear.None)
    tween.to({alpha: 0}, 1000, Phaser.Easing.Linear.None)
    tween.onComplete.add(function() { fingerLabel.destroy()})
    tween.start()
    console.log(finger)
  }

  startGame(msg) {
    this.game.world.removeAll()
    this.insideGame = true
    this.addText(`${msg.user}`, this.world.centerX, this.world.centerY - 180)
  }

  addText(message, x, y, style = { font: '48px Arial Black', fill: '#ff69b4' }) {
    let text = this.add.text(x, y, message, style)
    text.stroke = "#260d19"
    text.strokeThickness = 16
    text.setShadow(2, 2, "#333333", 2, true, true)
    text.anchor.setTo(0.5)
    return text
  }

  onDown(e) {
    let keyCode = this.keyboard.charFromCode(e.which, e.shiftKey)
    if (this.insideGame == false) {
      console.log("onDown")
      if (e.which == 13) {
        this.game.sendToServer(this.fullName)
      }
      this.recordLetter(keyCode)
    } else {
      this.recordKeyStroke(keyCode)
      console.log("onKeyPress")
    }
  }

  recordKeyStroke(keyCode) {
    let keyLabel = this.addText(keyCode, this.world.centerX + this.xValueGame, this.world.centerY)
    this.xValueGame = this.xValueGame + 50
    let tween = this.add.tween(keyLabel)
    tween.to({x: 350, y: 350}, 200, Phaser.Easing.Linear.None)
    tween.to({alpha: 0}, 1000, Phaser.Easing.Linear.None)
    tween.onComplete.add(function() { keyLabel.destroy()})
    tween.start()
    console.log("key pressed", keyCode)
    this.game.sendToServerKey(this.fullName, keyCode)
  }

  recordLetter(keyCode) {
    let name = this.addText(keyCode, this.world.centerX + this.xValue, this.world.centerY + 50)
    this.xValue = this.xValue + 50

    this.fullName = this.fullName + name._text
    console.log(this.fullName)
  }

  update() {
    // this.label.rotation += 0.01
  }
}
