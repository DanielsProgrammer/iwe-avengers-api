Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://7ou4zkpy84.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Get Avenger by Id

Given path 'avengers','aaa-bbb-ccc-ddd'
When method get
Then status 200
And match response == {id:'#string', name:'Iron Man', secretIdentity: 'Tony Stark'}