import Foundation

struct DisplayRequest {
    let id:UUID
    let mirrorIdentifier:String
    let dictionary:[String:Any]
    let completionBlock:((Error?) -> Void)?
    
    init(mirrorIdentifier:String, dictionary:[String:Any], completion:((_ error:Error?) -> Void)? = nil) {
        self.id = UUID()
        self.mirrorIdentifier = mirrorIdentifier
        self.dictionary = dictionary
        self.completionBlock = completion
    }
    
    init(mirrorIdentifier:String, view:View, completion:((_ error:Error?) -> Void)? = nil) {
        self.id = UUID()
        self.mirrorIdentifier = mirrorIdentifier
        self.dictionary = [
            "template": "estimote/__built-in_views",
            "actions": [[
                "showView": [
                    "id": self.id.uuidString,
                    "type": view.typeName,
                    "data": view.dataDict
                ]]
            ]
        ]
        self.completionBlock = completion
    }
}
