//
//  CacheService.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 26.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

/// Save and load data to memory and disk cache
final class CacheService {

  /// For get or load data in memory
  private let memory = NSCache<NSString, NSData>()

  /// The path url that contain cached files
  private let diskPath: URL

  /// For checking file or directory exists in a specified path
  private let fileManager: FileManager

  /// Make sure all operation are executed serially
  private let serialQueue = DispatchQueue(label: "Requests")

  init(fileManager: FileManager = FileManager.default) {
    self.fileManager = fileManager
    do {
      let documentDirectory = try fileManager.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )
      diskPath = documentDirectory.appendingPathComponent("Requests")
      try createDirectoryIfNeeded()
    } catch {
      fatalError()
    }
  }

  /// Save data
  ///
  /// - Parameters:
  ///   - data: The data to save
  ///   - key: Key to identify cached item
  func save(data: Data, key: String, completion: (() -> Void)? = nil) {
    //let key = MD5(key)

    serialQueue.async {
      self.memory.setObject(data as NSData, forKey: key as NSString)
      do {
        try data.write(to: self.filePath(key: key))
        completion?()
      } catch {
        print(error)
      }
    }
  }

  /// Load data specified by key
  ///
  /// - Parameters:
  ///   - key: Key to identify cached item
  ///   - completion: Called when operation finishes
  func load(key: String, completion: @escaping (Data?) -> Void) {
    //let key = MD5(key)

    serialQueue.async {
      // If object is in memory
      if let data = self.memory.object(forKey: key as NSString) {
        completion(data as Data)
        return
      }

      // If object is in disk
      if let data = try? Data(contentsOf: self.filePath(key: key)) {
        // Set back to memory
        self.memory.setObject(data as NSData, forKey: key as NSString)
        completion(data)
        return
      }

      completion(nil)
    }
  }

  /// Convenient method to access file named key in diskPath directory
  ///
  /// - Parameter key: The key, this is the file name
  /// - Returns: The file url
  private func filePath(key: String) -> URL {
    diskPath.appendingPathComponent(key)
  }

  private func createDirectoryIfNeeded() throws {
    if !fileManager.fileExists(atPath: diskPath.path) {
      try fileManager.createDirectory(at: diskPath, withIntermediateDirectories: false, attributes: nil)
    }
  }

  /// Clear all items in memory and disk cache
  func clear() throws {
    memory.removeAllObjects()
    try fileManager.removeItem(at: diskPath)
    try createDirectoryIfNeeded()
  }
}

//class FirstURLCache: URLCache {
//    //@available(iOS 8.0, *)
//    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
//
//        guard let response = cachedResponse.response as? HTTPURLResponse else {
//            NSLog("couldn't convert to http response")
//            return
//        }
//
//        guard response.statusCode == 200 else {
//            if response.statusCode == 429 {
//                NSLog("Over API Hourly Limit")
//            } else {
//                NSLog("\(response.statusCode)")
//            }
//            return
//        }
//
//        var headers = response.allHeaderFields
//        headers.removeValue(forKey: "Cache-Control")
//        headers["Cache-Control"] = "max-age=\(7 * 24 * 60 * 60)"
//
//        if let headers = headers as? [String: String],
//            let newHTTPURLResponse = HTTPURLResponse(url: response.url!,
//                                                     statusCode: response.statusCode,
//                                                     httpVersion: "HTTP/1.1",
//                                                     headerFields: headers) {
//            let newCachedResponse = CachedURLResponse(response: newHTTPURLResponse, data: cachedResponse.data)
//            super.storeCachedResponse(newCachedResponse, for: request)
//        }
//    }
//
//    @available(iOS 8.0, *)
//    open override func getCachedResponse(for dataTask: URLSessionDataTask,
//                                         completionHandler: @escaping (CachedURLResponse?) -> Void) {
//        
//    }
//
//    @available(iOS 8.0, *)
//    open override func removeCachedResponse(for dataTask: URLSessionDataTask) {
//
//    }
//}

class SecondtUrlCache: URLCache {
    
    let cacheExpiry = "cache_expiry"
    let cacheExpireInterval: TimeInterval = 60 * 60
    
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        var response: CachedURLResponse?
        
        if let cachedResponse = super.cachedResponse(for: request) {
            if let userInfo = cachedResponse.userInfo {
                if let cacheDate = userInfo[cacheExpiry] as! NSDate? {
                    
                    // check if the cache data are expired
                    if (cacheDate.timeIntervalSinceNow < -cacheExpireInterval) || cachedResponse.data.isEmpty {
                        self.removeCachedResponse(for: request)
                    } else {
                        response = cachedResponse
                    }
                }
            }
        }
        
        return response
    }
    
    override func removeCachedResponse(for request: URLRequest) {
        super.removeCachedResponse(for: request)
    }
    
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        var userInfo = NSMutableDictionary()
        if let cachedUserInfo = cachedResponse.userInfo {
            userInfo = NSMutableDictionary(dictionary: cachedUserInfo)
        }
        
        if let cacheDate = userInfo[cacheExpiry] as! NSDate? {
            // check if the cache data are expired
            if cacheDate.timeIntervalSinceNow < -cacheExpireInterval {
                userInfo[cacheExpiry] = NSDate()
            }
        } else {
            userInfo[cacheExpiry] = NSDate()
        }

        let newCachedResponse = CachedURLResponse(response: cachedResponse.response,
                                                  data: cachedResponse.data,
                                                  userInfo: userInfo as [NSObject: AnyObject],
                                                  storagePolicy: cachedResponse.storagePolicy)
        super.storeCachedResponse(newCachedResponse, for: request)
    }
}

// Задание 2
private class NSCacheEntry<KeyType: AnyObject, ObjectType: AnyObject> {
    var key: KeyType
    var value: ObjectType
    var cost: Int
    var prevByCost: NSCacheEntry?
    var nextByCost: NSCacheEntry?
    init(key: KeyType, value: ObjectType, cost: Int) {
        self.key = key
        self.value = value
        self.cost = cost
    }
}

private class NSCacheKey: NSObject {
    
    var value: AnyObject
    
    init(_ value: AnyObject) {
        self.value = value
        super.init()
    }
    
    override var hash: Int {
        switch self.value {
        case let nsObject as NSObject:
            return nsObject.hashValue
        case let hashable as AnyHashable:
            return hashable.hashValue
        default:
            return 0
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = (object as? NSCacheKey) else { return false }
        
        if self.value === other.value {
            return true
        } else {
            guard let left = self.value as? NSObject,
                let right = other.value as? NSObject else { return false }
            
            return left.isEqual(right)
        }
    }
}

open class NSCache<KeyType: AnyObject, ObjectType: AnyObject>: NSObject {
    
    // swiftlint:disable:next syntactic_sugar
    private var _entries = Dictionary<NSCacheKey, NSCacheEntry<KeyType, ObjectType>>()
    private let _lock = NSLock()
    private var _totalCost = 0
    private var _head: NSCacheEntry<KeyType, ObjectType>?
    
    open var name: String = ""
    open var totalCostLimit: Int = 0 // limits are imprecise/not strict
    open var countLimit: Int = 0 // limits are imprecise/not strict
    open var evictsObjectsWithDiscardedContent: Bool = false

    public override init() {}
    
    open weak var delegate: NSCacheDelegate?
    
    open func object(forKey key: KeyType) -> ObjectType? {
        var object: ObjectType?
        
        let key = NSCacheKey(key)
        
        _lock.lock()
        if let entry = _entries[key] {
            object = entry.value
        }
        _lock.unlock()
        
        return object
    }
    
    open func setObject(_ obj: ObjectType, forKey key: KeyType) {
        setObject(obj, forKey: key, cost: 0)
    }
    
    private func remove(_ entry: NSCacheEntry<KeyType, ObjectType>) {
        let oldPrev = entry.prevByCost
        let oldNext = entry.nextByCost
        
        oldPrev?.nextByCost = oldNext
        oldNext?.prevByCost = oldPrev
        
        if entry === _head {
            _head = oldNext
        }
    }
   
    private func insert(_ entry: NSCacheEntry<KeyType, ObjectType>) {
        guard var currentElement = _head else {
            // The cache is empty
            entry.prevByCost = nil
            entry.nextByCost = nil
            
            _head = entry
            return
        }
        
        guard entry.cost > currentElement.cost else {
            // Insert entry at the head
            entry.prevByCost = nil
            entry.nextByCost = currentElement
            currentElement.prevByCost = entry
            
            _head = entry
            return
        }
        
        while let nextByCost = currentElement.nextByCost, nextByCost.cost < entry.cost {
            currentElement = nextByCost
        }
        
        // Insert entry between currentElement and nextElement
        let nextElement = currentElement.nextByCost
        
        currentElement.nextByCost = entry
        entry.prevByCost = currentElement
        
        entry.nextByCost = nextElement
        nextElement?.prevByCost = entry
    }
    
    open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int) {
        let g = max(g, 0)
        let keyRef = NSCacheKey(key)
        
        _lock.lock()
        
        let costDiff: Int
        
        if let entry = _entries[keyRef] {
            costDiff = g - entry.cost
            entry.cost = g
            
            entry.value = obj
            
            if costDiff != 0 {
                remove(entry)
                insert(entry)
            }
        } else {
            let entry = NSCacheEntry(key: key, value: obj, cost: g)
            _entries[keyRef] = entry
            insert(entry)
            
            costDiff = g
        }
        
        _totalCost += costDiff
        
        var purgeAmount = (totalCostLimit > 0) ? (_totalCost - totalCostLimit) : 0
        while purgeAmount > 0 {
            if let entry = _head {
                delegate?.cache(unsafeDowncast(self, to: NSCache<AnyObject, AnyObject>.self),
                                willEvictObject: entry.value)
                
                _totalCost -= entry.cost
                purgeAmount -= entry.cost
                
                remove(entry) // _head will be changed to next entry in remove(_:)
                _entries[NSCacheKey(entry.key)] = nil
            } else {
                break
            }
        }
        
        var purgeCount = (countLimit > 0) ? (_entries.count - countLimit) : 0
        while purgeCount > 0 {
            if let entry = _head {
                delegate?.cache(unsafeDowncast(self, to: NSCache<AnyObject, AnyObject>.self),
                                willEvictObject: entry.value)
                
                _totalCost -= entry.cost
                purgeCount -= 1
                
                remove(entry) // _head will be changed to next entry in remove(_:)
                _entries[NSCacheKey(entry.key)] = nil
            } else {
                break
            }
        }
        
        _lock.unlock()
    }
    
    open func removeObject(forKey key: KeyType) {
        let keyRef = NSCacheKey(key)
        
        _lock.lock()
        if let entry = _entries.removeValue(forKey: keyRef) {
            _totalCost -= entry.cost
            remove(entry)
        }
        _lock.unlock()
    }
    
    open func removeAllObjects() {
        _lock.lock()
        _entries.removeAll()
        
        while let currentElement = _head {
            let nextElement = currentElement.nextByCost
            
            currentElement.prevByCost = nil
            currentElement.nextByCost = nil
            
            _head = nextElement
        }
        
        _totalCost = 0
        _lock.unlock()
    }
}

public protocol NSCacheDelegate: NSObjectProtocol {
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any)
}

extension NSCacheDelegate {
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        // Default implementation does nothing
    }
}
