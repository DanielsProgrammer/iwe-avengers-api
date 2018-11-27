Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://7ou4zkpy84.execute-api.us-east-1.amazonaws.com/dev'


Scenario: should return not found Avenger

Given path 'avengers','not-found-id'
When method get
Then status 404


Scenario: Get Avenger by Id

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id:'#string', name:'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Create Avenger

Given path 'avengers'
And request {name:'Iron Man', secretIdentity: 'Tony Stark'}
When method post
Then status 201
And match response == {id:'#string', name:'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Must return 400 for invalid creation payload

Given path 'avengers'
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400

Scenario: Delete by id

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method delete
Then status 204

Scenario: Put

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {id:'aaa-bbb-ccc-ddd', name:'Iron Man 2', secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match response == {id:'#string', name:'Iron Man 2', secretIdentity: 'Tony Stark'}


Scenario: Must return 400 for invalid update payload

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {secretIdentity: 'Tony Stark'}
When method put
Then status 400


