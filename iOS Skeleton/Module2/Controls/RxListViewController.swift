//
//  RxListViewController.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit
import RxSwift
import RxCocoa
class RxListViewController: UIViewController, UITableViewDelegate {

    let contentItems = Observable.just(["Item1", "Item2", "Items3"])
    let foodItems = Observable.just([Food.init(name: "Pizza", imageName: "pizza"), Food.init(name: "Burger", imageName: "burger"),
        Food.init(name: "Dosa", imageName: "dosa"),Food.init(name: "Paratha", imageName: "paratha")])
    let disposeBag = DisposeBag()
    @IBOutlet weak var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        contentTableView.delegate = self
        bindTableWithCustomCell()
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
    
    
    func bindTableWithCustomCell(){
        
        //Bind the Food items
        foodItems.bind(to: contentTableView.rx
                            .items(cellIdentifier: "contentCell",cellType: FoodItemTableViewCell.self)){
            (tableview, tableViewItem, cell) in
            cell.selectionStyle = .none
            cell.foodNameLbl.text = tableViewItem.name
            cell.foodItemImageView.image = UIImage.init(named: tableViewItem.imageName)
            cell.foodItemImageView.contentMode = .scaleAspectFit
        }.disposed(by: disposeBag)
        
        //Model selection
       contentTableView.rx.modelSelected(Food.self)
            .subscribe(onNext: {
                foodObject in
                print("Itemselected", foodObject.name)
                if let listViewObj: ModuleTwoLogin = Constants.StoryboardName.secondModuleStoryboard.instantiateViewController() {
                   self.navigationController?.pushViewController(listViewObj, animated: true)
                }
            }).disposed(by: disposeBag)
        
        
        /*
        //index path selection (did select method)
        contentTableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            if let listViewObj: ModuleTwoLogin = Constants.StoryboardName.secondModuleStoryboard.instantiateViewController() {
               self.navigationController?.pushViewController(listViewObj, animated: true)
            }
        }).disposed(by: disposeBag)*/
    }

}
