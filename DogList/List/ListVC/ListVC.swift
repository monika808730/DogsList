import UIKit

class ListVC: UIViewController
{
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    
    var result = [JSONDictionary]()
    var tempResult = [JSONDictionary]()
    static let shared = ListVC()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        apiCall()
        searchBar.delegate = self
        listCollectionView.register(UINib.init(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
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
        details.details = self.result[indexPath.row]
        present(details, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2-10 , height: 200)
    }
}

//MARK:- Filter Logic
extension ListVC
{
    
    func filterResults(searchText:String)
    {
        var filteredResults = [JSONDictionary]()
        
        let _ = self.result.filter { item in
            
            //            Filter By Name
            if let name = item["name"] as? String, name.range(of: searchText, options: .caseInsensitive) != nil {
                filteredResults.append(item)
                return true
            }
            
            //            Filter By breed_group
            if let breed_group = item["breed_group"] as? String, breed_group.range(of: searchText, options: .caseInsensitive) != nil {
                filteredResults.append(item)
                return true
            }
            return false
        }
        
        if filteredResults.count > 0{
            self.listCollectionView.isHidden = false
            self.noDataFoundLabel.isHidden = true
            
            self.result = filteredResults
            self.listCollectionView.reloadData()
        }else{
            self.listCollectionView.isHidden = true
            self.noDataFoundLabel.isHidden = false
        }
    }
}

//MARK:- API Call

extension ListVC
{    
    func apiCall(){
        AppNetworking.shared.APICalling(apiUrl: baseUrl, successResp: {
            [weak self] (resp) in
            
            guard let sSelf = self else {return}
            
            DispatchQueue.main.async {
                if resp.count > 0{
                    sSelf.listCollectionView.isHidden = false
                    sSelf.noDataFoundLabel.isHidden = true
                    
                    sSelf.tempResult = resp
                    sSelf.result = resp
                    sSelf.listCollectionView.reloadData()
                }else{
                    sSelf.noDataFoundLabel.text = "No Data Found"
                    sSelf.listCollectionView.isHidden = true
                    sSelf.noDataFoundLabel.isHidden = false
                }
            }
            
        }, failure: { (error) in

            self.noDataFoundLabel.text = error.localizedDescription
            self.listCollectionView.isHidden = true
            self.noDataFoundLabel.isHidden = false
        })
    }
}
