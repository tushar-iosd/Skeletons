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

    //RX List view Model
    let rxListVM = ListDataViewModel()
    
    //String array in Observable type
    let contentItems = Observable.just(["Item1", "Item2", "Items3"])
    //Food (Custom class) array in Observable type (Initialised)
    var foodItems = Observable.just([Food.init(name: "Pizza", imageName: "pizza", favItem: true), Food.init(name: "Burger", imageName: "burger", favItem: false),
        Food.init(name: "Dosa", imageName: "dosa", favItem: true),Food.init(name: "Paratha", imageName: "paratha", favItem: false)])
    //Dispose Bag
    let disposeBag = DisposeBag()
    
    /* IBOutlets*/
    @IBOutlet weak var contentTableView: UITableView!
    
    /* View Life cycle methods*/
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromAPI()
        // Do any additional setup after loading the view.
        contentTableView.delegate = self
        bindTableWithCustomCell()
       // rxListVM.randomApiCall()
    }
    
    /// A simple table view binding example
    func bindTable(){
        contentItems.bind(to: contentTableView
                            .rx
                            .items(cellIdentifier: "contentCell")) {
            (tableView, tableViewItem, cell) in
            cell.textLabel?.text = tableViewItem
        }.disposed(by: disposeBag)
    }
    
    func fetchDataFromAPI(){
        ApiClient.getPosts(userId: 1)
            .observe(on:MainScheduler.instance)
                    .subscribe(onNext: { postsList in
                        print("List of posts:", postsList)
                    }, onError: { error in
                        switch error {
                        case ApiError.conflict:
                            print("Conflict error")
                        case ApiError.forbidden:
                            print("Forbidden error")
                        case ApiError.notFound:
                            print("Not found error")
                        default:
                            print("Unknown error:", error)
                        }
                    })
                    .disposed(by: disposeBag)
            }
    
    
    /// Binding a table view with data array || selection of table view cell
    func bindTableWithCustomCell(){
        
        //Bind the Food items to table
        foodItems.bind(to: contentTableView.rx
                            .items(cellIdentifier: "contentCell",cellType: FoodItemTableViewCell.self)){
            (tableview, tableViewItem, cell) in
            cell.selectionStyle = .none
            if tableViewItem.favItem {
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .red
            }
            cell.foodNameLbl.text = tableViewItem.name
            cell.foodItemImageView.image = UIImage.init(named: tableViewItem.imageName)
            cell.foodItemImageView.contentMode = .scaleAspectFit
        }.disposed(by: disposeBag)
        
        
        // userNameTF.rx.text.map{ $0 ?? "" }.bind(to: loginVM.userNameTextPublishSubject).disposed(by: disposeBag)
       // loginVM.isValid().bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        
        //Model selection
      contentTableView.rx.modelSelected(Food.self)
            .subscribe(onNext: {
                foodObject in
         if let foodItemDescVCObj: FoodItemDescription = Constants.StoryboardName.secondModuleStoryboard.instantiateViewController() {            foodItemDescVCObj.labelText = foodObject.name
            foodItemDescVCObj.imageName = foodObject.imageName
            self.navigationController?.pushViewController(foodItemDescVCObj, animated: true)
         }
            
            }).disposed(by: disposeBag)
        
        //index path selection (did select method)
   /*   contentTableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
        self.contentTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            
        }).disposed(by: disposeBag)*/
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
