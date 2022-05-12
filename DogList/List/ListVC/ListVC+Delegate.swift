import UIKit

//MARK:- CollectionView Methods
extension ListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCollectionViewCell{
            listCell.displayResult(result: self.result[indexPath.row])
            return listCell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "DetailsVC", bundle: nil)
        let details : DetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        details.details = [self.result[indexPath.row]]
        present(details, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2-10 , height: 200)
    }
}


//MARK:- Seachbar delegates
extension ListVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == ""{
            self.view.endEditing(true)
            self.result = self.tempResult
            self.listCollectionView.reloadData()
        }else{
            filterResults(searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
