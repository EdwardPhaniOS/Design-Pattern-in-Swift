import UIKit

var str = "Hello, playground"

struct JobApplicant {
    let name: String
    let email: String
    let status: Status
    
    enum Status {
        case new
        case interview
        case hired
        case rejected
    }
}

struct Email {
    let subject: String
    let messageBody: String
    let recepientEmail: String
    let senderEmail: String
}

struct EmailFactory {
    
    let sender: String
    
    func createEmail(to recipient: JobApplicant) -> Email {
        
        let subject: String
        let messageBody: String
        
        switch recipient.status {
        case .new:
            subject = "We Received Your Application"
            messageBody = "Thanks for applying for a job here! " +
            "You should hear from us in 17-42 business days."
        case .interview:
            subject = "We Want to Interview You"
            messageBody = "Thanks for your resume, \(recipient.name)! " +
            "Can you come in for an interview in 30 minutes?"
        case .hired:
            subject = "We Want to Hire You"
            messageBody = "Congratulations, \(recipient.name)! " +
                "We liked your code, and you smelled nice. " +
            "We want to offer you a position! Cha-ching! $$$"
        case .rejected:
            subject = "Thanks for Your Application"
            messageBody = "Thank you for applying, \(recipient.name)! " +
                "We have decided to move forward with other candidates. " +
            "Please remember to wear pants next time!"
    }
    
        return Email(subject: subject, messageBody: messageBody, recepientEmail: recipient.name, senderEmail: self.sender)
    }
}


var applicant1 = JobApplicant(name: "Vinh", email: "vinh@gmail.com", status: .hired)

let emailFactory = EmailFactory(sender: "ABC Company")
let email1 = emailFactory.createEmail(to: applicant1)

print(email1)
