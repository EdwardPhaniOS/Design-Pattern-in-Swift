//: A UIKit based Playground for presenting user interface
//Protocol: giong nhu mot ban liet ke cac cong viec can lam nhung chi co giao dien phuong thuc (khong co implement)

//Trong Java ta co Interface thi trong Swift to co Protocol, Protocol trong SWIFT tuong ung voi Interface trong Java
import UIKit

public protocol MovieRatingStrategy {
    // 1
    var ratingServiceName: String { get }
    // 2
    func fetchRating(for movieTitle: String,
                     success: (_ rating: String, _ review: String) -> ())
}

public class RottenTomatoesClient: MovieRatingStrategy {
    public let ratingServiceName = "Rotten Tomatoes"
    public func fetchRating(
        for movieTitle: String,
        success: (_ rating: String, _ review: String) -> ()) {
        // In a real service, you’d make a network request...
        // Here, we just provide dummy values...
        let rating = "95%"
        let review = "It rocked!"
        success(rating, review)
    }
}

public class IMDbClient: MovieRatingStrategy {
    public let ratingServiceName = "IMDb"
    public func fetchRating(
        for movieTitle: String,
        success: (_ rating: String, _ review: String) -> ()) {
        let rating = "3 / 10"
        let review = """
      It was terrible! The audience was throwing rotten
      tomatoes!
      """
        success(rating, review)
    }
}


public class MoviewRatingViewController: UIViewController {
    // MARK: - Properties
    public var movieRatingClient: MovieRatingStrategy!
    // MARK: - Outlets
    @IBOutlet public var movieTitleTextField: UITextField!
    @IBOutlet public var ratingServiceNameLabel: UILabel!
    @IBOutlet public var ratingLabel: UILabel!
    @IBOutlet public var reviewLabel: UILabel!
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //The determination of which MovieRatingStrategy to use can be deferred until runtime, for example:
        movieRatingClient = IMDbClient()
        
        ratingServiceNameLabel.text =
            movieRatingClient.ratingServiceName
    }
    // MARK: - Actions
    @IBAction public func searchButtonPressed(sender: Any) {
        guard let movieTitle = movieTitleTextField.text
            else { return }
        movieRatingClient.fetchRating(for: movieTitle) {
            (rating, review) in
            self.ratingLabel.text = rating
            self.reviewLabel.text = review
        } }
}






