//
//  ViewController.swift
//  FileManagement_Swift
//
//  Created by TheAppGuruz-New-6 on 19/08/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIAlertViewDelegate
{
    var fileManagaer:NSFileManager?
    var documentDir:NSString?
    var filePath:NSString?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fileManagaer=NSFileManager .defaultManager()
        var dirPaths:NSArray=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDir=dirPaths[0] as? NSString
        println("path : \(documentDir)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnRemoveFile(sender: AnyObject)
    {
        filePath=documentDir?.stringByAppendingPathComponent("file1.txt")
        fileManagaer?.removeItemAtPath(filePath as! String, error: nil)
        self.showSuccessAlert("Message", messageAlert: "File removed successfully.")
    }
    
    @IBAction func btnEqualityClicked(sender: AnyObject)
    {
        var filePath1=documentDir?.stringByAppendingPathComponent("file1.txt")
        var filePath2=documentDir?.stringByAppendingPathComponent("file2.txt")
        
        if((fileManagaer? .contentsEqualAtPath(filePath1!, andPath: filePath2!)) != nil)
        {
            self.showSuccessAlert("Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert("Message", messageAlert: "Files are not equal.")
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMoveClicked(sender: AnyObject)
    {
        var oldFilePath:String=documentDir!.stringByAppendingPathComponent("file1.txt") as String
        var newFilePath:String=documentDir!.stringByAppendingPathComponent("/folder1/file1.txt") as String
        var err :NSError?
        fileManagaer?.moveItemAtPath(oldFilePath, toPath: newFilePath, error:&err)
        if((err) != nil)
        {
            println("errorrr \(err)")
        }
        self.showSuccessAlert("Success", messageAlert: "File moved successfully")
    }
    
    @IBAction func btnWriteFileClicked(sender: AnyObject)
    {
        var content:NSString=NSString(string: "helllo how are you?")
        var fileContent:NSData=content.dataUsingEncoding(NSUTF8StringEncoding)!
        fileContent .writeToFile(documentDir!.stringByAppendingPathComponent("file1.txt"), atomically: true)
        self.showSuccessAlert("Success", messageAlert: "Content written successfully")
    }
    
    @IBAction func btnCreateFileClicked(sender: AnyObject)
    {
        var error: NSError? = nil
        filePath=documentDir?.stringByAppendingPathComponent("file1.txt")
        fileManagaer?.createFileAtPath(filePath! as String, contents: nil, attributes: nil)
        
        filePath=documentDir?.stringByAppendingPathComponent("file2.txt")
        fileManagaer?.createFileAtPath(filePath! as String, contents: nil, attributes: nil)
        
        self.showSuccessAlert("Success", messageAlert: "File created successfully")
    }
    
    @IBAction func btnCreateDirectoryClicked(sender: AnyObject)
    {
        filePath=documentDir?.stringByAppendingPathComponent("/folder1")
        fileManagaer?.createDirectoryAtPath(filePath! as String, withIntermediateDirectories: false, attributes: nil, error: nil)
        self.showSuccessAlert("Success", messageAlert: "Directory created successfully")
    }
    
    @IBAction func btnReadFileClicked(sender: AnyObject)
    {
        filePath=documentDir?.stringByAppendingPathComponent("/file1.txt")
        var fileContent:NSData?
        fileContent=fileManagaer?.contentsAtPath(filePath! as String)
        var str:NSString=NSString(data: fileContent!, encoding: NSUTF8StringEncoding)!
        self.showSuccessAlert("Success", messageAlert: "data : \(str)")
    }
    
    @IBAction func btnCopyFileClicked(sender: AnyObject)
    {
        var originalFile=documentDir?.stringByAppendingPathComponent("file1.txt")
        var copyFile=documentDir?.stringByAppendingPathComponent("copy.txt")
        fileManagaer?.copyItemAtPath(originalFile!, toPath: copyFile!, error: nil)
        self.showSuccessAlert("Success", messageAlert:"File copied successfully")
    }
    
    @IBAction func btnDirectoryContentsClicked(sender: AnyObject)
    {
        var error: NSError? = nil
        var arrDirContent=fileManagaer!.contentsOfDirectoryAtPath(documentDir as! String, error: &error)
        self.showSuccessAlert("Success", messageAlert: "Content of directory \(arrDirContent)")
    }
    
    func showSuccessAlert(titleAlert:NSString,messageAlert:NSString)
    {
        var alert:UIAlertController=UIAlertController(title:titleAlert as String, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.Alert)
        var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
        {
                UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func btnFilePermissionClicked(sender: AnyObject)
    {
        filePath=documentDir?.stringByAppendingPathComponent("file1.txt")
        var filePermissions:NSString = ""
    
        if((fileManagaer?.isWritableFileAtPath(filePath! as String)) != nil)
        {
            filePermissions=filePermissions.stringByAppendingString("file is writable. ")
        }
        if((fileManagaer?.isReadableFileAtPath(filePath! as String)) != nil)
        {
            filePermissions=filePermissions.stringByAppendingString("file is readable. ")
        }
        if((fileManagaer?.isExecutableFileAtPath(filePath! as String)) != nil)
        {
            filePermissions=filePermissions.stringByAppendingString("file is executable.")
        }
        self.showSuccessAlert("Success", messageAlert: "\(filePermissions)")
    }
}

