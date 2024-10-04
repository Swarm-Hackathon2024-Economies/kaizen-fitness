import Foundation
import MapKit


struct FitnessPlan: Identifiable, Hashable, Codable {
    var id = UUID()
    let destinationName: String
    let destinationLatitude: Float
    let destinationLongitude: Float
    let activities: [Activity]
    
    static let toDaiNagoyaBuilding = {
        FitnessPlan(
            destinationName: "大名古屋ビルヂング",
            destinationLatitude: 35.172054987155555,
            destinationLongitude: 136.88456594373685,
            activities: [.breathMethod, .seatedNeckRoll, .shout]
        )
    }()
    
    static let toNadyaPark = {
        FitnessPlan(
            destinationName: "ナディアパーク",
            destinationLatitude: 35.165644999461755,
            destinationLongitude: 136.90506350950815,
            activities: [.breathMethod, .seatedNeckRoll, .shout]
        )
    }()
    
    static let toTMNA = {
        FitnessPlan(
            destinationName: "Toyota Motor North America, Inc.",
            destinationLatitude: 33.08575588060863,
            destinationLongitude: -96.83921907513722,
            activities: [.breathMethod, .seatedNeckRoll, .shout]
        )
    }()
    
    static let toWalmart = {
        FitnessPlan(
            destinationName: "Walmart Neighborhood Market",
            destinationLatitude: 33.09894497818888,
            destinationLongitude: -96.7971603902402,
            activities: [.breathMethod, .seatedNeckRoll, .shout]
        )
    }()
    
    static let toATAndTStadium = {
        FitnessPlan(
            destinationName: "AT&T Stadium",
            destinationLatitude: 32.74816795373609,
            destinationLongitude: -97.09333068671008,
            activities: [.breathMethod, .seatedNeckRoll, .shout]
        )
    }()
}
