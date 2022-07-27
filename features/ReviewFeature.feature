@test
Feature: End to End Test

  Scenario: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    And print generatedToken
    * def generator = Java.type('tiger_api_project.tiger_api_project_tek.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def DOB = generator.getDoB()
    Given path "/api/accounts/add-primary-account"
    And request
      """
      {
      "email": "string",
      "firstName": "string",
      "lastName": "string",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "string",
      "dateOfBirth": "2022-07-27T00:54:57.474Z",
      "new": true
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
        * def ID = response.id
    Given path "/api/accounts/add-account-addess"
    And param primaryPersonId = ID
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
