This application displays the list of Dogs. When user selects any dog from the list then the detailed information of the dog will be displayed. User can filter the list based on the dog name and breed of the dog.



https://user-images.githubusercontent.com/67224585/168266143-ab324d7a-0a6c-4e0b-ab19-27f6769703fb.mov



Listing Screen --

ListVC.xib - Design is creted with UIView, UISearchBar, UIcollectionView to display the list of dogs.

ListVC.Swift -  Getting reponse from View Model to display result on screen. UISearchBar methods call to filter and display data depending upon the searched text.

ListVC+Delegate.swift - UICollectionView datasource methods are written in this file. Along with the UISearchBar delegate methods.

ListVM.swift - API call is made in this file and passed the reponse to ListVC to display on UI.

ListModel.swift - Reponse from API call is converted into the model and can be used inside the app.



Details Screen --

DetailsVC.storyboard - UITableviewController is designed to display details about selected dog.

DetailsVC.Swift - Details about the dog is displayed here by setting values to perticular Label.



AppNetwrking.Swift - API Calling and getting response in this file.

Reachability.Swift - Network related checks are thier in this file.
