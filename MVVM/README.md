
# MVVM + Combine + SwiftUI Demo App

A simple demo iOS application built using **SwiftUI**, **Combine**, and **MVVM architecture**. 

This project showcases how to:
- Fetch data from a remote API using Combine
- Implement pagination
- Add search functionality
- Use a generic API service
- Perform unit testing on the ViewModel and Service layers

---

## 🧱 Features

- MVVM architecture
- Combine-based API handling
- Generic and reusable `APIService`
- Pagination on scroll
- Search bar for filtering products
- SwiftUI views with clean separation of concerns
- Unit tests for `ProductViewModel` and `APIService`

---

## 📁 Folder Structure

<img width="366" alt="Screenshot 2025-05-23 at 10 07 45 PM" src="https://github.com/user-attachments/assets/45ace3fd-57cd-487a-a316-95752e5b63a9" />

 
## 🔧 API Used

This demo uses a free public JSON API:
https://dummyjson.com/products


## 🚀 Getting Started

Clone the repository:

- git clone https://github.com/shaqir29/MVVM_Demo.git
- Open the project in Xcode:

- open MVVM_Demo.xcodeproj
- Build and run on a simulator or device.

🔍 Search & Pagination
- The app fetches products from the API in batches of 10.
- A SearchBar allows you to filter products by title.
- Pagination loads more products as you scroll.

## 🧪 Running Tests : XCTest

- In Xcode, go to the Test Navigator (⌘ + 6).
- https://www.linkedin.com/in/sakirali-saiyed-57387762/Click the ▶️ button next to MVVM_SwiftUI_Combine_DemoTests to run all tests.
 
Tests include:

- Successful product fetch
- Failure scenario handling
- ViewModel state updates

✅ Tech Stack

- SwiftUI
- Combine
- MVVM Architecture


🧑‍💻 Author
Sakir Saiyed
[LinkedIn]([https://github.com/your-username](https://www.linkedin.com/in/sakirali-saiyed-57387762).


📝 License
This project is open source and available under the MIT License.
 


