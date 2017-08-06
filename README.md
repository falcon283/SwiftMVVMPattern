# MVVMSwiftPattern

MVVMSwiftPattern is a set of protocols that allow you to enforce your iOS application to conform the MVVM Design Pattern.

## Description

When you start a new iOS application you will probably end up using a classic MVC approach and probably you will start writing your code in the ViewController. This will lead you to have Massive View Controller.
To move towards MVVM Design Pattern you should image your application composed by some `Model`s, objects that represent your app data, `View`s as UIView + UIViewController and `ViewModel`s as adapters between your `View` and your `Application Backend`. Application Backend (AB) is not properly mentioned in the Apple Documentation describing the MVC and nor in the MVVM description. AB it's something that all application has and too many time using MVC in iOS is just mixed with the ViewController code.
AB is the abstract world of the non UI elements where some classes accomplish real jobs with no need to have an Full Interactive UI, i.e. download/upload a file, run an algorithm and so on. AB objects expose some functions that allow you to accomplish some jobs, that's it.

The schematic representation of an MVVM application is:

```
 View + ViewController <-> ViewModel <-> AB + Model
```

### Getting Started Base

```
class CustomView: UIView {}

extension CustomView: View {}

class CustomViewModel: ViewModel {
  var info: String
  ...

  func save() { ... }
}

class ViewController: UIViewController, ViewModelObserver {

  var viewModel: CustomViewModel?

  func bind() {
    // Here you can use an observing technique like KVO, Rx
    // Update the View
  }

  @IBAction func didTapSave(_ sender: Any) {
    viewModel.save()
  }
}
```

To keep MVVM clear in your project we can state this as a rule of thumb:
**never use View/UIKit classes into your ViewModel class. Views are in the ViewController domain and are not allowed in ViewModel**

## Bonus 1: Presenter

If you would like to have an even clear separation of your classes responsabilities, a `Presenter` base class and a `Presentable` protocol are available.

Doing this your ViewController need to choice, or even better is injected, a suitable `Presenter` subclass and the proper `ViewModel`.
When appropriate your ViewController will call `presenter.update(view: customView, with: viewModel)`

### Getting Started Presenter

```
class CustomViewPresenter : Presenter<CustomView, CustomViewModel> {
  func update(view: CustomView, with viewModel: CustomViewModel) {
    // Here you can use an observing technique like KVO, Rx
    // You could require to keep a strong ref to your ViewModel

    // Update View
  }
}

class ViewController: UIViewController, ViewModelHolder, Presentable {

  @IBOutlet weak var customView: CustomView?  
  var viewModel: CustomViewModel?
  var presenter: CustomViewPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let v = customView, let vm = viewModel else {
      return
    }

    presenter.update(v, with: vm)
  }

  @IBAction func didTapSave(_ sender: Any) {
    viewModel.save()
  }
}
```

## Bonus 2: Context

It's not elegant but sometimes some objects are used as holder of some abstract context suitable for the entity owner. This technique is used to reduce the complexity of the entity owner and make it free from further discovery of the entity. A very simple example of where the context may be useful is a TableViewController.

When a TableViewDataSource requests the new values in order to render its TableView it starts an asynchronous process that begin with the discovery of how many cells compose the TableView and ends asking the specific cells asynchronously. Because this process is asynchronous in some rare cases, like when the refresh rate of the TableView is very high, the user may end up selecting a still visible cell while the DataSource has been invalidated and new cells are about to be rendered.
When this happen the indexPath of the visibleCell could be invalid or, if valid, refer a different entity used for the cell render. As you can imagine we are now in an unpredictable situation.

To avoid this kind of inconvenience we can make a `CustomCell` adopting the `Contextable` protocol and assign a `Context` while the cell is dispatched. Doing this, while the cell view is valid, it will carry the context used to be rendered and that context can be returned back for future actions.

**Keep in mind that in a Functional Programming Environment, like RxSwift or ReactiveCocoa, this protocol could be completely useless because the entity could be carried by the function bound to the objects.**

### Getting Started Context

```

class CustomCell : UITableViewCell, Contextable {
  var context: Any?
}

class TableViewController: UITableViewController {

  var dataSource: [String]?

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
      fatalError("No Valid Cell")
    }

    cell.context = dataSource[indexPath.row]

    ...

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    // Get the still valid cell in the view.
    guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell,
      let entity = cell.context as? String else {
      return
    }

    print("\(entity)")
  }
}
```

## Installing

###### CocoaPod
`pod 'MVVMSwiftPattern'`

`pod 'MVVMSwiftPattern/Presenter'`

`pod 'MVVMSwiftPattern/Context'`

###### Carthage
`github "falcon283/MVVMSwiftPattern"`

## Authors

* **Gabriele Trabucco**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
