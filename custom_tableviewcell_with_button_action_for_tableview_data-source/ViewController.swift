import UIKit

struct State {
    let title: String
    let detailText: String
    let description: String
    let image: String
    let document: String
    let url: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "CELL_ID"
    private var states = [State]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        states.append(State(title: "Alabama", detailText: "State", description:"Reciprocal", image: "alabama", document: "alabama.pdf", url: "https://www.dps.texas.gov"))
        states.append(State(title:"Texas", detailText: "State", description: "Reciprocal", image: "Texas", document: "texas.pdf", url: "https://www.texas.gov"))
        
        self.tableView.reloadData()
    }
    
    @objc func openUrl(_ sender: UIButton) {
        let index = sender.tag
        
        guard
            index < states.count, // to prevent index of bounds
            let url = URL(string: states[index].url)
        else {
            return
        }
        
        // open url
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.states[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CustomCell
        cell.titleLabel?.text = item.title
        cell.isUserInteractionEnabled = true
        
        cell.button.removeTarget(nil, action: nil, for: .allEvents)
        cell.button.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
        cell.button.tag = indexPath.row

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.item = self.states[indexPath.row]
    }
}
