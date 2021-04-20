/*:
# Testing your skills 🤹
 
 Let's move on to the final chapter of the Playground. Your newly learned skills will now be put to the test! 😎 For this we will play a little quiz.
 
 ## The rules
 You will be shown a traffic sign and under it there are three actions, but only one of them is the right one. It will be played 8 times, but you have the possibility to change the number of rounds and play again after the end. Will you be able to answer everything correctly? Great, because afterwards a surprise is waiting for you. 🎁 For each correct answer you will receive a star. ⭐️

 ### Let's import all dependencies first:
 */
//#-editable-code
import PlaygroundSupport
import ViewControllers
//#-end-editable-code
/*:
 Next, we create an instance of our GameViewController and call the startGame function. Here you have the possibility to adjust the number of rounds.
 */
//#-editable-code
let gameViewController = GameViewController()
gameViewController.startGame(rounds: 8)
//#-end-editable-code
/*:
 Nice! Once you are done, press "Run my code" and let the game begin. Have fun! 😉
 */
//#-hidden-code
PlaygroundPage.current.setLiveView(gameViewController)
//#-end-hidden-code
/*:
 Thank you for joining this quick educational journey. Hope to see you online soon at WWDC 2021!
 */
