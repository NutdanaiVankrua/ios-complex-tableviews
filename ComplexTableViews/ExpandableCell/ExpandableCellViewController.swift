import UIKit

struct CellData {
    var open: Bool = false
    let title: String
    let sectionData: [String]
}

class ExpandableCellViewController: UIViewController {
    
    // MARK: Properties
    
    private var tableData = [CellData]()
    
    // MARK: Views
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Expandable Cell"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        for index in 0...10 {
            let data = CellData(
                open: false,
                title: "section \(index)",
                sectionData: ["Data 1", "Data 2", "Data 3", "Data 4"]
            )
            tableData.append(data)
        }
        
        setupConstraints()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    // MARK: Setup
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

// MARK: - Table View Data Source

extension ExpandableCellViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData[section].open {
            return tableData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            cell.textLabel?.text = tableData[indexPath.section].title
            cell.backgroundColor = .white
        } else {
            cell.textLabel?.text = tableData[indexPath.section].sectionData[indexPath.row - 1]
            cell.backgroundColor = .green
        }
        return cell
    }
    
}

// MARK: - Table View Delegate

extension ExpandableCellViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.section].open {
            tableData[indexPath.section].open = false
            let sections = IndexSet(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableData[indexPath.section].open = true
            let sections = IndexSet(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}
