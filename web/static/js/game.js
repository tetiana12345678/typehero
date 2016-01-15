import {MenuState} from './states/menu'
import {Socket} from "phoenix"

export class Game extends Phaser.Game {

// Initialize Phaser
  constructor(width, height, container) {
    super(width, height, Phaser.AUTO, container, null)

    //Phoenix sockets and channels
    let socket = new Socket("/socket")
    socket.connect()
    socket.onClose( e => console.log("Closed connection") )

    //setting up main channel
    let channel = socket.chan("rooms:lobby", {})
    channel.join().receive("ignore", () => console.log("auth error"))
                  .receive("ok", () => console.log("join ok"))
                  .after(10000, () => console.log("Connection interruption"))
    channel.onError(e => console.log("something went wrong", e))
    channel.onClose(e => console.log("channel closed", e))
    channel.on("arduino:finger", ({finger}) => this.fingerPress(finger))

    channel.on("user:join", msg => this.startGameMessage(msg))
    channel.on("user:key", msg => this.playGameMessage(msg))

    // Game States
    this.state.add('menu', new MenuState(), false)
    this.state.start('menu')
    this.channel = channel
  }

  sendToServer(name) {
    this.channel.push("user:join", {
      user: name
    })
  }

  sendToServerKey(name, key) {
    console.log("name in sendToServerKey", name)
    console.log("key in sendToServerKey", key)
    this.channel.push("user:key", {
      user: name,
      body: key
    })
  }


  //Display to browser info from channel
  fingerPress(finger) {
    let currentState = this.state.states[this.state.current]
    currentState.fingerNumber(finger)
  }

  startGameMessage(msg) {
    let currentState = this.state.states[this.state.current]
    currentState.startGame(msg)
  }

  playGameMessage(msg) {
    let currentState = this.state.states[this.state.current]
    currentState.playGame(msg)
  }
}

