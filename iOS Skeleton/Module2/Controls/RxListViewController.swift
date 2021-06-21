//
//  RxListViewController.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit
import RxSwift
import RxCocoa
class RxListViewController: UIViewController {

    let contentItems = Observable.just(["Item1", "Item2", "Items3"])
    let disposeBag = DisposeBag()
    @IBOutlet weak var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTable()
        // Do any additional setup after loading the view.
    }
    
    func bindTable(){
        contentItems.bind(to: contentTableView
                            .rx
                            .items(cellIdentifier: "contentCell")) {
            (tableView, tableViewItem, cell) in
            cell.textLabel?.text = tableViewItem
        }.disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
