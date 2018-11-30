Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://7ou4zkpy84.execute-api.us-east-1.amazonaws.com/dev'


Scenario: Should return invalid access

Given path 'avengers','any-id'
When method get
Then status 401 





Scenario: should return not found Avenger

Given path 'avengers','not-found-id'
When method get
Then status 404


Scenario: Create Avenger

Given path 'avengers'
And request {name:'Iron Man', secretIdentity: 'Tony Stark (create)'}
When method post
Then status 201
And match response == {id:'#string', name:'Iron Man', secretIdentity: 'Tony Stark (create)'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match response == savedAvenger






Scenario: Must return 400 for invalid creation payload

Given path 'avengers'
And request {secretIdentity: 'Tony Stark'}
When method post
Then status 400


Scenario: Delete 404*
Given path 'avengers','92887517-e487-4321-8d3d-23f6da226b28'
When method delete
Then status 404


Scenario: Delete by id *

Given path 'avengers'
And request {name:'Iron (Delete)', secretIdentity: 'Tony (Delete)'}
When method post
Then status 201
And match response == {id:'#string', name:'Iron (Delete)', secretIdentity: 'Tony (Delete)'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method delete
Then status 204

Given path 'avengers',savedAvenger.id
When method delete
Then status 404



Scenario: Should return not found Avenger for a attempt to delete

Given path 'avengers','not-found-id'
When method delete
Then status 404





Scenario: Update Avenger *

Given path 'avengers'
And request {name:'Iron', secretIdentity: 'Tony'}
When method post
Then status 201
And match response == {id:'#string', name:'Iron', secretIdentity: 'Tony'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And request {id:savedAvenger.id, name:'Iron Man', secretIdentity: 'Tony Stark (update)'}
When method put
Then status 200
And match response == {id:'#string', name:'Iron Man', secretIdentity: 'Tony Stark (update)'}

* def updateAvenger = response

Given path 'avengers', response.id
When method get
Then status 200
And match response == updateAvenger





Scenario: Must return 400 for invalid update payload

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {secretIdentity: 'Tony Stark'}
When method put
Then status 400

Scenario: Should return not found Avenger for a attempt do update

Given path 'avengers','not-found-id'
And request {name:'Iron Man' , secretIdentity: 'Tony Stark'}
When method put
Then status 404
