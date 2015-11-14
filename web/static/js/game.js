import {MenuState} from './states/menu'

export class Game extends Phaser.Game {

// Initialize Phaser
  constructor(width, height, container) {
    super(width, height, Phaser.AUTO, container, null)

    // Game States
    this.state.add('menu', new MenuState(), false)
    this.state.start('menu')
  }

}
