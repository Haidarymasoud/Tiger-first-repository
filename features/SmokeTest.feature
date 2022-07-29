Feature: Authentication Smoke Test

  @smoke
  Scenario: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisor",  "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response.token

  @smoke
  Scenario: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisor11",  "password": "tek_supervisor"}
    When method post
    Then status 404
    And assert response.errorMessage == "USER_NOT_FOUND"
