import UIKit

class ListVC: UIViewController
{
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    
    var result = [DogsListModel]()
    var tempResult = [DogsListModel]()
    static let shared = ListVC()
    let listVM = ListVM()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        getAPIResponse()
        searchBar.delegate = self
        listCollectionView.register(UINib.init(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
    }
    
    func getAPIResponse(){
        listVM.getRespFromAPI(successResp: {
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


//MARK:- Filter Logic
extension ListVC
{
    func filterResults(searchText:String)
    {
        var filteredResults = [DogsListModel]()
        
        let _ = self.result.filter { item in
            
            // Filter By Name
            if !item.name.isEmpty, (item.name.range(of: searchText, options: .caseInsensitive) != nil){
                filteredResults.append(item)
                return true
            }
            
            // Filter By breed_group
            if !item.breed_group.isEmpty, item.breed_group.range(of: searchText, options: .caseInsensitive) != nil {
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
