import {Socket} from "phoenix"

//Phoenix sockets and channels
class App {

  static init() {
    //setting up the socket
    console.log("Initialized")
    let socket = new Socket("/socket")
    console.log(socket)
    socket.connect()
    socket.onClose( e => console.log("Closed connection") )

    //setting up main channel
    let channel = socket.chan("rooms:lobby", {})
    channel.join().receive("ignore", () => console.log("auth error"))
                  .receive("ok", () => console.log("join ok"))
                  .after(10000, () => console.log("Connection interruption"))
    channel.onError(e => console.log("something went wrong", e))
    channel.onClose(e => console.log("channel closed", e))
  }
}

//Menu with Phaser
export class MenuState extends Phaser.State {
  create() {
    this.label = this.addText('Type your name', this.world.centerX, this.world.centerY - 100)
    this.input.keyboard.addCallbacks(this, this.onDown)
  }

  addText(message, x, y, style = { font: '74px Arial Black', fill: '#ff69b4' }) {
    let text = this.add.text(x, y, message, style)
    text.stroke = "#de77ae"
    text.strokeThickness = 16
    text.setShadow(2, 2, "#333333", 2, true, true)
    text.anchor.setTo(0.5)
    return text
  }

  onDown(e) {
    this.recordLetter(e.keyCode)
  }

  recordLetter(keyCode) {
    console.log(keyCode)
    let name = this.addText(String.fromCharCode(keyCode), this.world.centerX, this.world.centerY)
    let tween = this.add.tween(name)
    tween.to({ alpha: 0, x: 500, y: 30 }, 2000, Phaser.Easing.Linear.None)
    tween.onComplete.add(function () {
      name.destroy()
    })
    tween.start()

    let fullName = ""
    fullName = fullName + name._text
    console.log(fullName)
  }

  update() {
    // this.label.rotation += 0.01
  }
}

App.init()
export default App
