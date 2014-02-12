DATOutletSegue
==============

This projects demonstrates how to use a subclass of a segue to initialize the child controllers for a custom parent controller. 

Steps to implement

1. In the storyboard connect parent controller to child controllers using the DATOutletSegue.
2. Set the identifier of each segue to the property name the child controller should be connected too
3. In the parent controller import "DATOutletSegue.h"
4. Call [self loadSegueControllers] in viewDidLoad

Arrays are now supported. To connect a controller to an array the segue identifier should be "<name of peropert>-<index>"

Example: viewControllers-0, viewControllers-1.

Note: If you have a breakpoint for all excpetions, then the array implementation will throw an exception (that is caught). This is because I have not found a way to detect if the controller can support the segue without calling performSegueWithIdentifier:sender:. To prevent this exception from being called you can implenent the function +arrayPropertyListLength: and return the length of the array. 
