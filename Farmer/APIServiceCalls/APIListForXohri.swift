//
//  APIListForXohri.swift
//  Xohri
//
//  Created by Apple on 04/02/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import SystemConfiguration
var spinner = UIActivityIndicatorView()
var loadingView: UIView = UIView()


let initialURL = "http://3.17.6.57:9393/"

class APIListForXohri: NSObject {
    
    public static var getLanguages = initialURL + "api/MasterTable/GetLanguages"
    
    public static var languageChange = initialURL + "api/Lang/ChangeCurrentCulture"

    public static var login = initialURL + "api/Auth/ValidateUser"
    
    public static var registerCustomer = initialURL + "api/Auth/RegisterUser"
    
    public static var verifyRegOTP = initialURL + "api/Auth/VerifyOTPNewUser"
    
    public static var resendOTP = initialURL + "api/Auth/ResendOTP"
    
    public static var forgetPassword = initialURL + "api/Auth/ForgotPassword"
    
    public static var changePassord = initialURL + "api/Auth/ChangePassword"
    
    public static var getCategories = initialURL + "api/MasterTable/GetCatagories"
    
    public static var selectedCatagories = initialURL + "api/MasterTable/GetCrops"
    
    public static var cropDetailsByCurrentUser = initialURL + "api/CropDetails/GetCropListings"
    
    public static var editingCropDetails = initialURL + "api/MasterTable/GetSellMasterInformation"
    
    public static var updateCropDetails = initialURL + "api/CropDetails/UpdateCropDetails"
    
    public static var addCropDetails = initialURL + "api/CropDetails/AddCropDetails"
    
    public static var getCropID = initialURL + "api/CropDetails/GetInventoryCropDetails"
    
    public static var getUserAddress = initialURL + "api/MasterTable/GetUserAddress"
    
    public static var addNewAddress = initialURL + "api/MasterTable/AddUserAddress"
    
    public static var openOrdersList = initialURL + "api/Order/GetOrdersOfFarmer"
    
    public static var acceptOrdersInActiveList = initialURL + "api/Order/AcceptOrder"
    
    public static var cancelOrderInActiveList = initialURL + "api/Order/CancellOrder"
    
    public static var processIngOrderList = initialURL + "api/Order/GetAcceptedOrders"
    
    public static var listOfCancelledCrop = initialURL + "api/Order/GetCancelledOrders"
    
    public static var removeCropInventortList = initialURL + "api/CropDetails/DeleteCropList"
    
    public static var marketListOfBusiness = initialURL + "api/Business/GetCommodityList?State=Karnataka&District=Bangalore&Market=Ramanagara"
    
    public static var commoditiesListOfBusiness = initialURL + "api/Business/GetCommodityList?State=Karnataka&District=Bangalore&Market=Ramanagara&Commodity=Beans"
    
    public static var getBankList = initialURL + "api/MasterTable/GetUserBankDetails"
    
    public static var deletebankList = initialURL + "api/MasterTable/DeleteBankDetails"
    
    public static var addNewBankDetails = initialURL + "api/MasterTable/AddUpdateUserBankDetails"
    
    public static var listOfKycDetails = initialURL + "api/MasterTable/GetUserKYCDetails"
    
    public static var updateKYCDetails = initialURL + "api/MasterTable/AddUpdateUserKYCDetails"
    
    public static var updateUserDefaultAddress = initialURL + "api/MasterTable/UpdateUserDefaultAddress"
    
    public static var getAllOrders = initialURL + "api/Order/GetAllOrders"

    public static var getMyOrder = initialURL + "api/Order/GetMyOrder"
    
    public static var getTransporationlist = initialURL + "api/MasterTable/GetTransportationDetails"
    
    public static var deleteTranportationList = initialURL + "api/MasterTable/DeleteTransportationDetails"
    
    public static var addEditTransportation = initialURL + "api/MasterTable/AddUpdateTransportationDetails"
    
    public static var walletBalance = initialURL + "api/MasterTable/GetWalletDetails"
    
    public static var listOfBankInPopUp = initialURL + "api/MasterTable/GetBankLists"

    public static var categorylist = initialURL + "api/MasterTable/GetLookingFor"
    
    public static var getLookingDetail = initialURL + "api/MasterTable/GetLookingForDetails"

    public static var updateUserProfile = initialURL + "api/Auth/UpdateUserProfile"
    
    public static var getStates = initialURL + "api/MasterTable/GetStates"
    
    public static var getDistricts = initialURL + "api/MasterTable/GetDistricts"
    
    public static var getTaluks = initialURL + "api/MasterTable/GetTaluks"
    
    public static var getHoblies = initialURL + "api/MasterTable/GetHoblis"
    
    public static var getLookingsForList = initialURL + "api/MasterTable/GetLookingForLists"
    
    public static var getFarmsList = initialURL + "api/MasterTable/GetFarmsList"
    
    public static var getBrandsList = initialURL + "api/MasterTable/GetBrandList"
    
    public static var getHPList = initialURL + "api/MasterTable/GetHPList"
    
    public static var getModelList = initialURL + "api/MasterTable/GetModels"
    
    public static var feedbackPosting = initialURL + "api/MasterTable/AddFeedback"
    
    public static var requestQuotation = initialURL + "api/MasterTable/AddRequestForQuotation"
    
    public static var farmerList = initialURL + "api/MasterTable/GetFarmersList"
    
    public static var getVillages = initialURL + "api/MasterTable/GetVillages"
    
    public static var getUserDetails = initialURL + "api/Auth/GetUserDetails"
    public static var getFarmersList = initialURL + "api/Farmer/GetFarmersList"
    public static var getLocationAccess = initialURL + "api/Auth/GetAccessContentByLangCode" //LocationAccess
    
    public static var getSMSAccess = initialURL + "api/Auth/GetAccessContentByLangCode" //SMSAccess
    public static var getMediaAccess = initialURL + "api/Auth/GetAccessContentByLangCode" //MediaAccess
    public static var getLoanRequest = initialURL + "api/Loan/GetLoanRequestsSentByUser"
    public static var getComposeCategories = initialURL + "api/MasterTable/GetComposeCatagories"
    public static var getComposeSubCate = initialURL + "api/MasterTable/GetComposeSubCatagories"
    public static var updateUserDevId = initialURL + "api/Auth/UpdateUserDeviceId"
    public static var sendNotification = initialURL + "api/CropDetails/SendNotification"
    public static var changeCulture = initialURL + "api/Lang/ChangeCurrentCulture"
    public static var updatePassword = initialURL + "api/Auth/UpdateUserPassword"
    
    //Activity Indicator Function
    static func showActivityIndicator(view : UIView,spinnerColor: UIActivityIndicatorView.Style) {
        DispatchQueue.main.async {
            loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
            loadingView.center = view.center
            loadingView.backgroundColor = UIColor.clear
            loadingView.alpha = 0.7
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            view.addSubview(loadingView)
            
            spinner = UIActivityIndicatorView(style: spinnerColor)
            spinner.frame = CGRect(x: 0.0, y: 0.0, width:loadingView.frame.size.width, height: loadingView.frame.size.height)
            //spinner.center = CGPoint(x:loadingView.bounds.size.width / 2, y:loadingView.bounds.size.height / 2)
            loadingView.addSubview(spinner)
            spinner.startAnimating()
        }
    }

    static func hideActivityIndicator() {
        DispatchQueue.main.async {
            spinner.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
    
    // Check Whether internet is Available or Not Function
    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    //Alert Message Function
    static func showAlertMessage(vc: UIViewController, messageStr:String) -> Void {
        let alert = UIAlertController(title: "Alert!", message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    //Toast Message Function
    static func showToast(view : UIView, message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 55, y: view.frame.size.height-120, width: view.frame.size.width-110, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Ubuntu-Medium", size: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
