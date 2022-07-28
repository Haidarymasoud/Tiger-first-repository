@Test
Feature: Generate Token, add new Account, Add address, Add phone Number and Car to your created Account.

  Scenario: End to End Account Creation.
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request
      """
      {
        "username": "supervisor",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then status 200
    * def generatedToken = response.token
    And print generatedToken
    * def generator = Java.type('tiger_api_project.tiger_api_project_tek.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def DOB = generator.getDoB()
    * def Job = generator.getJob()
    Given path '/api/accounts/add-primary-account'
    And request
      """
      {
        "email": "#(email)",
        "firstName": "#(firstName)",
        "lastName": "#(lastName)",
        "title": "Mr",
        "gender": "MALE",
        "maritalStatus": "MARRIED",
        "employmentStatus": "#(Job)",
        "dateOfBirth": "#(DOB)",
        "new": true
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    * def ID = response.id
    And print response
    * def generator = Java.type('tiger_api_project.tiger_api_project_tek.DataGenerator')
    * def country = generator.getCountry()
    * def city = generator.getCity()
    * def zipCode = generator.getZipCode()
    * def state = generator.getState()
    * def street = generator.getStreetAdd()
    * def CountryCode = generator.getCountryCode()
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
       "addressType": "Home",
       "addressLine1": "#(street)",
       "city": "#(city)",
       "state": "#(state)",
       "postalCode": "#(zipCode)",
       "countryCode": "#(CountryCode)",
       "current": true
      }
      """
    When method post
    Then status 201
    And print response
    * def generator = Java.type('tiger_api_project.tiger_api_project_tek.DataGenerator')
    * def phoneNumber = generator.getPhone()
    * def phoneExtension = generator.getPhoneExtension()
    
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "#(phoneExtension)",
      "phoneTime": "Morning",
      "phoneType": "Work"
      }
      """
    When method post
    Then status 201
    And print response
    
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
      "make": "Honda",
      "model": "Accord",
      "year": "2022",
      "licensePlate": "2019-VA"
      }
      """
    When method post
    Then status 201
    And print response
