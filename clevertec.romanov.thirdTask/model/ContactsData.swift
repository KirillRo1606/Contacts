import UIKit
import Contacts

// var contact: Contact?

class ContactsData {
    static func getContacts() -> [Contact] {
        let contactStore = CNContactStore()
        var contactsData = [Contact]()
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try? contactStore.enumerateContacts(with: request, usingBlock: { (contact, stoppingPointer) in
            let fullName = contact.givenName + " " + contact.familyName
            let phoneNumber: String = contact.phoneNumbers.map{ $0.value.stringValue }[0]
            contactsData.append(Contact(fullName: fullName, phoneNumber: phoneNumber))
        })
        return contactsData
    }
}
