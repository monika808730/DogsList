import Foundation

class ListVM{
    internal typealias modelSuccess = (([DogsListModel]) -> Void)

    func getRespFromAPI(successResp : @escaping modelSuccess,
                 failure : @escaping Failure){

        getAPIReponse(url: baseUrl, completion: {
            (response, error) in
            guard let error = error else {
                if response != nil{
                    let dogsListModel = ListsModel(json: response ?? [[:]])
                    successResp(dogsListModel.dogsList)
                }
                return
            }

            failure(NSError(domain: error, code: 0))
        })
    }
}
