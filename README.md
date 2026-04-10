# iOS Architectures

A hands-on comparison of five iOS architecture patterns, each implemented as a runnable demo app. Built to internalize the tradeoffs — not just the theory — of each pattern through real code.

## Why I Built This

After working across codebases using every pattern below, I wanted a single reference repo that shows the same domain (data fetching, rendering, testing) implemented five different ways. Each demo is minimal enough to read in 10 minutes but complete enough to show where each pattern shines and where it breaks down.

---

## Architecture Patterns at a Glance

| | **MVC** | **MVVM** | **MVP** | **VIPER** | **Clean** |
|---|---|---|---|---|---|
| **Full Name** | Model-View-Controller | Model-View-ViewModel | Model-View-Presenter | View-Interactor-Presenter-Entity-Router | Clean Architecture |
| **One-liner** | Controller does everything | ViewModel owns logic, View observes | Presenter drives a passive View | Every concern gets its own layer | Domain is king, everything else is a plugin |
| **Who holds business logic?** | ViewController | ViewModel | Presenter | Interactor | UseCase / Interactor |
| **Who handles navigation?** | ViewController | View / Coordinator | View / Wireframe | Router | Router / Coordinator |
| **Who updates UI?** | Controller pushes to View | View reacts to ViewModel state | Presenter calls View protocol methods | Presenter calls View protocol methods | Presenter / ViewModel |
| **Data flow** | Bidirectional (tight) | Unidirectional (reactive) | Unidirectional (callback) | Unidirectional (protocol chain) | Unidirectional (layered) |
| **Key binding mechanism** | IBOutlets, delegates | `@Published` + Combine / `@Observable` | Protocol methods | Protocol methods | Protocol / async-await |
| **Number of layers** | 3 | 3-4 | 3 | 5 | 3-4 (Domain, Data, Presentation) |

---

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

---

## Tradeoffs Comparison

| | **MVC** | **MVVM** | **MVP** | **VIPER** | **Clean** |
|---|---|---|---|---|---|
| **Setup speed** | Fastest | Fast | Moderate | Slow | Slow |
| **Boilerplate** | Minimal | Low | Medium | High | High |
| **Testability** | Poor | Good | Very Good | Excellent | Excellent |
| **Scalability** | Poor | Good | Good | Excellent | Excellent |
| **Learning curve** | Easy | Easy-Medium | Medium | Hard | Hard |
| **SwiftUI fit** | Poor | Native fit | Awkward | Overkill | Good |
| **Common pitfall** | Massive ViewController | Bloated ViewModel | Too many protocols | File explosion | Over-engineering |

---

## When to Use What

| Pattern | Best For |
|---|---|
| **MVC** | Prototypes, small apps, learning iOS basics |
| **MVVM** | Most SwiftUI/Combine apps, mid-size teams, real-time data |
| **MVP** | UIKit apps that need testability without reactive frameworks |
| **VIPER** | Large teams, feature-modular apps, strict code ownership |
| **Clean** | Enterprise apps with long lifecycles, apps needing swappable data sources |

---

## How Data Flows

```
MVC:      User → Controller → Model → Controller → View
MVVM:     User → View → ViewModel → Model → ViewModel → View (reactive)
MVP:      User → View → Presenter → Model → Presenter → View (via protocol)
VIPER:    User → View → Presenter → Interactor → Entity → Presenter → View
Clean:    User → View → ViewModel → UseCase → Repository → UseCase → ViewModel → View
```

---

## Testing Comparison

Each pattern handles testability differently:

| Pattern | What's Testable | Mock Strategy |
|---|---|---|
| **MVC** | Model only | Hard to mock ViewController |
| **MVVM** | ViewModel + Model + Service | Inject mock service via protocol |
| **MVP** | Presenter + Model | Mock View protocol |
| **VIPER** | All 5 layers independently | Mock each protocol boundary |
| **Clean** | All layers independently | Mock Repository & UseCase protocols |

---

## Summary

**Bottom line:** Start with **MVVM** for most Swift/SwiftUI projects — it hits the sweet spot of testability, simplicity, and native framework support. Graduate to **VIPER** or **Clean** only when team size or app complexity genuinely demands it.

<img width="764" alt="Summary" src="https://github.com/user-attachments/assets/fe066286-a868-4c0a-a6d7-41128a21c440" />
