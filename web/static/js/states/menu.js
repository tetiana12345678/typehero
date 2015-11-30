import {Keyboard} from "./key_map"

//Menu with Phaser
export class MenuState extends Phaser.State {
  create() {
    this.label = this.addText('Type your name\n and press enter', this.world.centerX, this.world.centerY - 100)
    this.input.keyboard.addCallbacks(this, this.onDown)
    this.fullName = ""
    this.keyboard = new Keyboard ()
    this.xValue = -80
    this.fingerLabel = this.addText('Finger', this.world.centerX, this.world.centerY - 200)
  }

  getName(name) {
    console.log("name", name)
  }

  fingerNumber(finger) {
    this.finger = finger
    console.log(finger)
  }

  addText(message, x, y, style = { font: '54px Arial Black', fill: '#ff69b4' }) {
    let text = this.add.text(x, y, message, style)
    text.stroke = "#260d19"
    text.strokeThickness = 16
    text.setShadow(2, 2, "#333333", 2, true, true)
    text.anchor.setTo(0.5)
    return text
  }

  onDown(e) {
    if (e.which == 13) {
      console.log("here we should send message to server with name, return from this method and start the game")
    }

    console.log(e.which)
    let character = this.keyboard.charFromCode(e.which, e.shiftKey)
    this.recordLetter(character)
  }

  recordLetter(keyCode) {
    //send message with name to server if someone hits enter
    console.log(keyCode)
    let name = this.addText(keyCode, this.world.centerX + this.xValue, this.world.centerY + 50)
    this.xValue = this.xValue + 50

    this.fullName = this.fullName + name._text
    console.log(this.fullName)
  }

  update() {
    this.fingerLabel.text = `finger ${this.finger}`
    // this.label.rotation += 0.01
  }
}
