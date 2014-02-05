DATOutletSegue
==============

This projects demonstrates how to use a subclass of a segue to initialize the child controllers for a custom parent controller. 

Steps to implement

1. In the storyboard connect parent controller to child controllers using the DATOutletSegue.
2. Set the identifier of each segue to the property name the child controller should be connected too
3. In the parent controller import "DATOutletSegue.h"
4. Call [self loadSegueControllers] in viewDidLoad

