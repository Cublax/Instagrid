# README 🔥

This architecture is split in differents layers/concepts 🏋️‍♀️: 
* `ViewControllers`
* `ViewModels`
* `Tests`


### Context


I created Instagrid in the context of the **Project 5** from my **IOS Developpment** course on **OpenClassrooms**.
To complete this project I had to build an Application on which I could display the Grid I would have chosen out of 3 different ones. 
I would then display pictures from my library in the free spaces of this Grid, and finally either save this picture on my phone or share it on the social network of my choice.

My bonus: 
- I was also asked to implement a bonus of my choice. First of all, I have been implementing a Flip from the Grid Container during the SwipeGesture, it gives the user a better sensorial experience when swipping to share.
- I have been writting the tests for the `GridViewModel` and `HomeViewModel`.


### Architecture


My project has been written following the MVVM achitecture rules. 

#### ViewModel:

The `ViewModel` encapsulates the whole logic which doesn't have to be in the ViewController. It's divided in two parts :

* **Inputs**: Every event from the viewController needs to be implemented in the viewModel, since it's listening for them. The main event which always need to be added is `viewDidLoad()`.
* **Outputs**: After `viewDidLoad()`, the viewController is listening for some changes from the `viewModel`. For this, the `viewModel` needs to provide reactive var for each data/state needed. The main rule is to keep separate the UI logic between viewModel and viewController, so keep in mind that a viewModel can only `import Foundation` -> reactive var con't provide data from `UIKit` like `UIImage` for example ☝️.

#### ViewController:

The last layer and not the less important 🙇‍♂️. But as it is mentioned in it's name, a `ViewController` only exists to **control**. So, if you want to test it, you'll only provide UI test, since the logic is extracted in the corresponding `ViewModel`.

#### Tests

This target contains the differents tests on `GridViewModel` and `HomeViewModel`.


