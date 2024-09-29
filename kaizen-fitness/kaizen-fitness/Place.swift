import MapKit

struct Place {
    static let daiNagoyaBuilding = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 35.172054987155555,
                    longitude: 136.88456594373685
                )
            )
        )
        item.name = "大名古屋ビルヂング"
        return item
    }()
    
    static let nadyaPark = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 35.165644999461755,
                    longitude: 136.90506350950815
                )
            )
        )
        item.name = "ナディアパーク"
        return item
    }()
    
    static let tmna = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 33.08575588060863,
                    longitude: -96.83921907513722
                )
            )
        )
        item.name = "Toyota Motor North America, Inc."
        return item
    }()
    
    static let walmart = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 33.09894497818888,
                    longitude: -96.7971603902402
                )
            )
        )
        item.name = "Walmart Neighborhood Market"
        return item
    }()
    
    static let atAndTStadium = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 32.74816795373609,
                    longitude: -97.09333068671008
                )
            )
        )
        item.name = "AT&T Stadium"
        return item
    }()
}
