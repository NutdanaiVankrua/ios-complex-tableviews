import UIKit

class MultiObjectTypesViewController: UIViewController {
    
    enum Item {
        case flight(Flight)
        case hotel(Hotel)
        case car(Car)
        
        func getName() -> String {
            switch self {
            case .flight(let flight):
                return flight.plane
            case .hotel(let hotel):
                return hotel.name
            case .car(let car):
                return car.brand
            }
        }
    }
    
    class Section {
        
        let name: String
        private var items = [Item]()
        
        init(name: String) {
            self.name = name
        }
        
        func getItem(at position: Int) -> Item {
            return items[position]
        }
        
        func count() -> Int {
            return items.count
        }
        
        func add(flights: [Flight]) {
            items.append(contentsOf: flights.map { (flight) -> Item in
                .flight(flight)
            })
        }
        
        func add(hotels: [Hotel]) {
            items.append(contentsOf: hotels.map { (hotel) -> Item in
                .hotel(hotel)
            })
        }
        
        func add(cars: [Car]) {
            items.append(contentsOf: cars.map { (car) -> Item in
                .car(car)
            })
        }
    }
    
    // MARK: Properties
    
    private var list = [Section]()
    
    // MARK: Views
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Multi Object Types"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupConstraints()
        
        // Mock Data
        
        let firstSection = Section(name: "Disney Land")
        firstSection.add(flights: mockFlights())
        firstSection.add(cars: mockCars())
        
        let secondSection = Section(name: "Future Park")
        secondSection.add(hotels: mockHotels())
        secondSection.add(cars: mockCars())
        
        list.append(firstSection)
        list.append(secondSection)
        
        // Setup TableView
    
        tableView.register(MultiObjectTypesUITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Setup
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    // MARK: Mocks
    
    private func mockFlights() -> [Flight] {
        var flights = [Flight]()
        for _ in 0...4 {
            let flight = Flight(code: "MHI", plane: "NokAir", seat: "3A")
            flights.append(flight)
        }
        return flights
    }
    
    private func mockHotels() -> [Hotel] {
        var hotels = [Hotel]()
        for _ in 0...2 {
            let hotel = Hotel(
                name: "The Mansion",
                phone: "0321231234",
                email: "rand@mail.com",
                city: "New York"
            )
            hotels.append(hotel)
        }
        return hotels
    }
    
    private func mockCars() -> [Car] {
        var cars = [Car]()
        for _ in 0...3 {
            let car = Car(brand: "Toyota", engine: "4xAMI", seats: 3, isHybrid: false)
            cars.append(car)
        }
        return cars
    }
    
}

// MARK: - TableView DataSource

extension MultiObjectTypesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MultiObjectTypesUITableViewCell
        cell.item = list[indexPath.section].getItem(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].name
    }
    
}
