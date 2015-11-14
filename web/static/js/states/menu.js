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

    console.log(name)
  }

  update() {
    // this.label.rotation += 0.01
  }
}
