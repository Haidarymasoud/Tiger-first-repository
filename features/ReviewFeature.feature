Feature: End to End Test

  Scenario: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/accounts/add-primary-account"
    And request
      """
      {
      "email": "QandNOOR2@yahoo.com",
      "firstName": "Rahman2",
      "lastName": "Ahmad",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "1999-07-07",
      "new": true
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
     * def primaryPersonId = result.response.id
    Given path "/api/accounts/add-account-addess"
    And param primaryPersonId = primaryPersonId
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "4508 Bathgate",
      "city": "Ellicot",
      "state": "MD",
      "postalCode": "2104",
      "countryCode": "001",
      "current": true
      }
      """
     And header Authorization = "Bearer " + generatedToken
     When method post
     Then status 201
     And print response 
