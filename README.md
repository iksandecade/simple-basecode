# Sample BaseCode

Hello World, this is my Sample BaseCode iOS Swift. I created this base code for my reference to create an iOS application. I want to share this basecode to the public in the hope that it will be a reference for other developers as well.

## Installation

You can see the base code in branch [develop](https://github.com/iksandecade/simple-basecode/tree/develop)

## Usage
This basecode uses the [MVVM architecture](https://medium.com/flawless-app-stories/mvvm-in-ios-swift-aa1448a66fb4).  And there are several classes for API requests.

![alt text](https://i.ibb.co/2FGw31p/Screen-Shot-2021-11-02-at-14-19-23.png)


#
I will show you how to make a page. First create subgroup in ```Views```, give a name according to the name of the page that will be created so as not to be confused when we are looking for the class we want to look for. as I have shown in the picture above, I created a subgroup ```Main```. Then create a viewcontroller with xib as usual.

Then create ViewModel in ```ViewModels``` group. Give it the same name as the page created along with the **ViewModel**. As the name of the page is login, then create a **LoginViewModel**, which I demonstrated above should be **MainViewModel** but instead I created a **SampleViewModel** LOL. then we assume the name of the page is Sample to make it easier hahaha.

In this viewmodel class we will fill with logic and store the data we get from the API and input from the view. The rule in this class is that all data obtained must be stored here, no data should be stored in the view, this is intended when there is an error in the data section we simply check in this viewmodel class. This is an example of the SampleViewModel class

```swift
import Foundation

final class MainViewModel {
    
    var sampleList = [SampleResponseModel]()
    
    weak var responseDelegate: ResponseForViewDelegate?
    
    func getData() {
        let request = SampleService()
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: [String:Any]()) { [weak self] models, error in
            if let _ = error {
                self?.responseDelegate?.getResponse(response: models)
            } else {
                if let models = models{
                    self?.sampleList = models
                    self?.responseDelegate?.getResponse(response: models)
                }
            }
        }
    }
}
```
#
After that, we will create a service class. This class is to get and handle the data that we get from the API which we then store into the viewmodel. But before creating the service class first we add the url which we will call, in this example we want to call the API **https://example.co.id/sample** with httpMethod **GET**. Open **Environment.swift** in the ``Config`` group. in this environtment class we store a url or a global callable variable. we store the base url in this class.

```swift
import Foundation

let environment: Environment = .Development //This is to change which variable to call

enum Environment {
    case Production
    case Development
    
    var baseUrl: String {
        switch self {
        case .Production: return "https://example.co.id/"
        case .Development: return "https://example.co.id/"
        }
    }
}
```

after we add the url in the environment. we also add the request url in the **APIList.swift** class in the ```Networks``` group.

```swift
import Foundation

struct APIList {
    let baseURL = environment.baseUrl //we call the base url that we store in the environment
    
    var sampleRequest: URL {
        return URL(string: baseURL + "sample")! //here we enter the URL Request. this will return value https://example.co.id/sample
    }
}
```

After we add the request url, we create a model for mapping the request from the API. Here we get a response like the following

```swift
{[
    "userId": 1,
    "id": 1,
    "title": "Sample Title",
    "body": "Sample body",
    "userName": "iksandecade"
]}
```

We create a struct model with a codable protocol. We make the model class naming according to the API request, here we request the Sample API, then we create a **SampleModel.swift** in the ```Models``` group.
```swift
import Foundation

struct SampleResponseModel: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    var userName: String?
}
```
We have prepared what is needed to create a **Service**. Now we start to create a **Service**. Naming a service is the same as naming a Model, which is using an API request. We create **SampleService.swift** in the ```Services``` group

```swift
import Foundation

struct SampleService: APIHandler {
    
    func makeRequest(from param: [String: Any]) -> URLRequest? { //If you have param request from API, insert in here
        let url =  APIList().sampleRequest //call the API request from the APIList we added earlier
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue // this is httpMethod, there is POST, GET, PUT. here we use GET
        return urlRequest
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [SampleResponseModel] { //Insert your model here, if response array insert model in []
        return try defaultParseResponse(data: data,response: response) //this will handle you response and convert to model
    }
}
```

Voila, we have finished creating a **Service** for API requests. How to use it is already in the **ViewModel** above.

Now we add a few lines of code to call ViewModel in ViewController

```swift
import UIKit

class ViewController: UIViewController {
    
    private var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.responseDelegate = self //Always call responseDelegate if you want to get data from response api
    }
}

extension ViewController: ResponseForViewDelegate {
    func getResponse(response: Any?) {
        // This is success get data from api
        if let sampleList = response as? [SampleResponseModel] {
            print(sampleList)
        }
    }
    
    func getResponseError(response: Any?) {
        // This is error or failed get data from api
        if let errorResponse = response as? ServiceError {
            print(errorResponse)
        }
    }
}
```

Congratulations, we have created a base code, then please explore the contents of this basecode yourself, such as a custom response API or a reusable view, do what you like. This is just a starting point for creating a Project.
Sorry if the English is not good, I'm still learning hehe and thank you for reading this github, I hope it's useful.

## License
[MIT](https://choosealicense.com/licenses/mit/)
