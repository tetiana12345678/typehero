import {Socket} from "phoenix"

class App {
  static init() {
    //setting up socket
    let socket = new Socket("/socket", {
      logger: (kind, msg, data) => {
        console.log(`${kind}: ${msg}`, data)
      }
    })

    socket.connect()
    socket.onClose( e => console.log("Closed connection") )

    //init counter
    this.counter = new Counter()

    //setting up the main channel
    let channel = socket.chan("rooms:lobby", {})

    channel.join().receive("ignore", () => console.log("auth error"))
                  .receive("ok", () => console.log("join ok"))
                  .after(10000, () => console.log("Connection interruption"))
    channel.onError(e => console.log("something went wrong", e))
    channel.onClose(e => console.log("channel closed", e))

    //pushing message from client to server
    let username = $("#username")
    let msgBody  = $("html body")

    msgBody.off("keypress")
    .on("keypress", e => {
      let key_pressed = String.fromCharCode(e.keyCode)
      console.log(key_pressed)
      channel.push("new:keystroke", {
        user: username.val(),
        body: key_pressed
      }).receive("ok", () => this.successfullKeystroke())
        .receive("error", () => console.log("not good!"))
    })

    // msgBody.off("keypress") ...
    channel.on( "new:keystroke", msg => this.renderMessage(msg) )
  }

  static successfullKeystroke() {
    console.log("great")
    let string = $('#text').text()
    $('#key-correct').text(string.substring(0, this.counter.getValue()))
    this.counter.increment()
  }

  static renderMessage(msg) {
    let messages = $("#messages")
    let user = this.sanitize(msg.user || "New User")

  }

  static sanitize(str) { return $("<div/>").text(str).html() }
}


class Counter {
  constructor() {
    this.index = 1
  }

  getValue() {
    return this.index
  }

  increment() {
    this.index++
  }
}


$( () => App.init() )

export default App
