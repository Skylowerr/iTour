# iTour

**A Travel Destination Manager for iOS**
*Built with SwiftUI + SwiftData*

---

## 📌 About

iTour is an iOS app built with SwiftUI and SwiftData that lets users manage a personal list of travel destinations. Users can add, edit, delete, and search destinations, set priorities, and sort them by name, date, or priority level.

This project was developed as a hands-on learning exercise to explore SwiftData — Apple's modern persistence framework — while reinforcing Git and GitFlow branching workflows.

---

## ✨ Features

- Add, edit, and delete travel destinations
- Set priority levels: **Meh**, **Maybe**, or **Must**
- Schedule a target visit date per destination
- Real-time search with `localizedStandardContains` (case-insensitive, locale-aware)
- Sort destinations by **Name**, **Date**, or **Priority**
- Dynamic `@Query` with runtime filter and sort support
- SwiftData persistence — data survives app restarts

---

## 🛠 Tech Stack

### SwiftUI
- `NavigationStack` with programmatic navigation via `path: [Destination]`
- `@Bindable` for two-way binding to SwiftData model objects
- `.searchable` modifier with `displayMode: .always`
- Toolbar with sort `Menu` + `Picker`

### SwiftData
- `@Model` macro for automatic persistence
- `@Query` with dynamic filter (`#Predicate`) and sort (`SortDescriptor`)
- Custom `init` on views to configure `@Query` at runtime using `_destinations` wrapper access
- `ModelContainer` & `ModelContext` environment injection

### Git & GitFlow
- `main` — stable, production-ready code
- `develop` — integration branch for ongoing work
- `feature/*` — one branch per feature (e.g. `feature/search`, `feature/sorting`)
- Commits follow conventional commit style: `feat:`, `fix:`, `refactor:`

---

## 📁 Project Structure

```
iTour/
├── iTourApp.swift                  # App entry point, ModelContainer setup
├── ContentView.swift               # Root view, NavigationStack, toolbar
├── DestinationListingView.swift    # @Query list with dynamic filter/sort
├── EditDestinationView.swift       # Edit form, @Bindable destination
└── Destination.swift               # @Model — name, details, date, priority
```

---

## 🧠 Key Learnings

### Dynamic @Query with SwiftData

By default, `@Query` is configured at compile time and cannot react to runtime changes like a search string or sort toggle. The solution is to write a custom `init` and assign directly to the property wrapper's backing storage:

```swift
init(sort: SortDescriptor<Destination>, searchString: String) {
    _destinations = Query(filter: #Predicate {
        if searchString.isEmpty {
            return true
        } else {
            return $0.name.localizedStandardContains(searchString)
        }
    }, sort: [sort])
}
```

The `_` prefix accesses the `Query` wrapper itself rather than the `[Destination]` array it exposes. This pattern applies to `@State`, `@Binding`, and other property wrappers too — it's a low-level escape hatch that gives full control over how the wrapper is initialized.

### Git & GitFlow

Using GitFlow kept the commit history clean and traceable. Each feature was developed in isolation on its own branch, merged into `develop` after testing, and only promoted to `main` when stable. This mirrors real-world team workflows and made it easy to experiment without breaking working code.

---

## 🚀 How to Run

```bash
git clone https://github.com/Skylowerr/iTour.git
```

1. Open `iTour.xcodeproj` in Xcode 15 or later
2. Select an iOS 17+ simulator or a real device
3. Press `Cmd + R` to build and run

**Requirements:**
- Xcode 15+
- iOS 17+ deployment target
- No third-party dependencies — pure Apple frameworks

---

*Made with ♥ while learning SwiftData — Emirhan Gökçe, May 2026*
