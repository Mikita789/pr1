import UIKit
import Foundation

var greeting = "Hello, playground"
let str = "https://oauth.vk.com/blank.html#payload=%7B%22type%22:%22silent_token%22,%22auth%22:1,%22user%22:%7B%22id%22:839182040,%22first_name%22:%22Unwrap%22,%22last_name%22:%22F.%22,%22avatar%22:%22https:%5C/%5C/sun56-1.userapi.com%5C/s%5C/v1%5C/ig2%5C/2JXoyWyGolOqpt908vyefZgqegaqSblAHR_v3HgF3ppiChvMgKsfc-BsYSZGE6n2bHmJAnQXfIqrWImo08YSRziR.jpg?size=200x200&quality=95&crop=1,640,1919,1919&ava=1%22,%22avatar_base%22:null,%22phone%22:%22+375%20**%20***%20**%2055%22%7D,%22token%22:%22LdXbNX-78M6y8Zm6IoMQV8eQSo6jOU05FlhXBUkIcwVlU8YvLlzEGSWr2f_iVIVivyVrjtBw-fQvAs_JSs1TdNeSevLookZ83rdLlzODPdJ_RhAG1eSMH9tIpZLD0Lh8XxBRspKRENw80cl_y5cserUO_tujGQKt_zu80L5FK3jeQ_dnC4vmOOOA6zqiGQdzVN1oP3abE2Dl6x0PcMAWNRfSxeLeqgKev8ewpjvYW4sPxZaiAvzfgGX-h7LTYSTV2_ZAbNXkGj3KjBKFINhrmPxlncjwlYdX2WTuDoa7LIFkkKa3R4vZ4I2SLj0aPstJ12mPxyFFCBWjOnMd8e6ncTTTXQqICTg9Rw8E3KSTpETUmaIHw1g-kVEUDVZZ0FKd%22,%22ttl%22:600,%22uuid%22:%22%22,%22hash%22:%220Z6p2aAd7iYx4jWZfNPWhBHzwKmIf4AvAWcmVZStXD4%22%7D"
let url = URL(string: str)!
if let fragm = url.fragment(), let data = fragm.data(using: .utf8){
    if let json = try? JSONSerialization.jsonObject(with: data, options: []){
        print(json)
    }
}
