# iOS Architectures

A hands-on comparison of five iOS architecture patterns, each implemented as a runnable demo app. Built to internalize the tradeoffs — not just the theory — of each pattern through real code.

## Why I Built This

After working across codebases using every pattern below, I wanted a single reference repo that shows the same domain (data fetching, rendering, testing) implemented five different ways. Each demo is minimal enough to read in 10 minutes but complete enough to show where each pattern shines and where it breaks down.

## Patterns

### MVC — Model-View-Controller

Apple's default. The ViewController owns both UI and business logic.

```swift
// Controller handles everything — fetch, transform, render
class AddressViewController: UITableViewController {
    var addresses: [Address] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addresses = AddressService.fetchAll()
        tableView.reloadData()
    }
}
```

**Tradeoff:** Fast to build, hard to test. Controllers grow into "Massive View Controllers."

### MVVM — Model-View-ViewModel

ViewModel transforms model data; View observes and renders.

```swift
// ViewModel — owns business logic, publishes state
class StockListViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    private let service: StockStreamingService

    func startStreaming() {
        service.stockPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$stocks)
    }
}

// View — observes ViewModel, zero logic
struct StockListView: View {
    @ObservedObject var viewModel: StockListViewModel
    var body: some View {
        List(viewModel.stocks) { stock in
            Text("\(stock.symbol): \(stock.price)")
        }
    }
}
```

**Tradeoff:** Clean separation, works naturally with SwiftUI/Combine. Can lead to bloated ViewModels without discipline.

### MVP — Model-View-Presenter

Presenter drives UI logic; View is a passive protocol.

```swift
// Presenter — testable without UIKit
class ProductPresenter {
    weak var view: ProductViewProtocol?
    let useCase: ProductUseCaseProtocol

    func loadProducts() {
        useCase.fetch { [weak self] result in
            self?.view?.render(products: result ?? [])
        }
    }
}

// View protocol — presenter tests mock this
protocol ProductViewProtocol: AnyObject {
    func render(products: [Product])
}
```

**Tradeoff:** Highly testable. More boilerplate than MVVM; less native framework support.

### VIPER — View, Interactor, Presenter, Entity, Router

Full separation with dedicated navigation layer.

```swift
// Each layer has a single responsibility:
// Interactor — business logic only
// Presenter  — formats data for View
// Router     — handles navigation
// Entity     — plain data models
```

**Tradeoff:** Maximum modularity and testability. Significant boilerplate — best for large teams.

### Clean Architecture

Layered dependency inversion: Domain knows nothing about Data or Presentation.

```swift
// Domain layer — pure business logic, no framework imports
protocol ProductRepository {
    func fetchProducts() async throws -> [Product]
}

// Data layer — implements domain protocol
class APIProductRepository: ProductRepository {
    func fetchProducts() async throws -> [Product] {
        // Network call, mapping DTO → domain model
    }
}
```

**Tradeoff:** Long-term maintainability. Complex setup — justified for enterprise apps with long lifecycles.

## Testing Comparison

Each pattern handles testability differently:

| Pattern | What's Testable | Mock Strategy |
|---------|----------------|---------------|
| MVC | Model only | Hard to mock ViewController |
| MVVM | ViewModel + Model | Inject mock service via protocol |
| MVP | Presenter + Model | Mock View protocol |
| VIPER | All layers | Mock each protocol boundary |
| Clean | All layers | Mock repository/use case protocols |

## Summary

<img width="764" alt="Summary" src="https://github.com/user-attachments/assets/fe066286-a868-4c0a-a6d7-41128a21c440" />
