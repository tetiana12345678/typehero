// Import the game
import {Game} from "./game"
//Start the Game
new Game(700, 450, 'phaser')

// class App {
//   static init() {
//     //setting up socket
//     let socket = new Socket("/socket", {
//       logger: (kind, msg, data) => {
//         console.log(`${kind}: ${msg}`, data)
//       }
//     })

//     socket.connect()
//     socket.onClose( e => console.log("Closed connection") )

//     //init counter
//     this.counter = new Counter()

//     //setting up the main channel
//     let channel = socket.chan("rooms:lobby", {})

//     channel.join().receive("ignore", () => console.log("auth error"))
//                   .receive("ok", () => console.log("join ok"))
//                   .after(10000, () => console.log("Connection interruption"))
//     channel.onError(e => console.log("something went wrong", e))
//     channel.onClose(e => console.log("channel closed", e))

//     //pushing message from client to server
//     let username = $("#username")
//     let page  = $("html body")

//     username.on("focus", e => {
//       this.enterUserName = true

//     }).on("blur", e => {
//       this.enterUserName = false
//     })


//     $(document).ready(function(){
//       $(".container-text").hide();
//       $("#replay").hide();

//       $("#go").click(function(){
//         $(".container-text").show();
//         $("#replay").show();
//         $(".welcome").hide();
//       });
//     });

//     page.bind("keydown keypress", e => {
//       if (this.enterUserName == true) { return }
//       //disable backspace browser weirdness
//       console.log("e.which", e.which)
//       let rx = /INPUT|SELECT|TEXTAREA/i
//       if( e.which == 8 ){
//         if(!rx.test(e.target.tagName) || e.target.disabled || e.target.readOnly ){
//           e.preventDefault()
//         }
//       }
//       let key_pressed = String.fromCharCode(e.charCode)
//       channel.push("new:keystroke", {
//         user: username.val(),
//         body: key_pressed,
//         counter: this.counter.getValue()
//       }).receive("ok", () => this.successfullKeystroke())
//         .receive("error", () => console.log("not good!"))
//     })

//     // msgBody.off("keypress") ...
//     channel.on( "new:keystroke", msg => this.renderMessage(msg) )
//   }

//   static successfullKeystroke() {
//     console.log("great")
//     let string = $('#text').text()
//     $('#key-correct').text(string.substring(0, this.counter.getValue()))
//     this.counter.increment()
//   }

//   static renderMessage(msg) {
//     let user = this.sanitize(msg.user || "New User")
//     let string = $('#text').text()
//     let user_id = this.hashCode(user)
//     let other = $('#key-others #' + user_id)
//     if(!other.length) {
//       other = $('<div id="' + user_id + '"></div>').appendTo('#key-others')
//     }
//     other.text(string.substring(0, msg.counter) + "    ---" + user)
//   }

//   static sanitize(str) { return $("<div/>").text(str).html() }

//   static hashCode(str) {
//     let hash = ""
//     if (str.length == 0) return hash;
//     for (let i = 0; i < str.length; i++) {
//       let char = str.charCodeAt(i);
//       hash = ((hash<<5)-hash)+char;
//       hash = hash & hash; // Convert to 32bit integer
//     }
//     return hash;
//   }
// }


// class Counter {
//   constructor() {
//     this.index = 1
//   }

//   getValue() {
//     return this.index
//   }

//   increment() {
//     this.index++
//   }
// }


// $( () => App.init() )

// export default App
