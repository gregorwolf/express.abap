
# Express.abap

ABAP Framework for developing HTTP web services. 

## Instructions

### Create a service in transaction `sicf`. 

![SICF](http://i.imgur.com/t0pwm2p.jpg)

### Create a class that inherits `yea_abs_service` 

```abap
class yea_testing_service definition
  public
  inheriting from yea_abs_service
  final
  create public .
  public section.
    methods constructor.
    methods yea_service~root redefinition.
endclass.

class yea_testing_service implementation.
	method yea_service~root.
		returning = '/yea/tests'.
    endmethod.
	method constructor.
		super->constructor( ).
    endmethod.
endclass. 
```

### Create a class that implements interface `yea_route`.
   
```abap
class yea_root_route definition
  public
  final
  create public .
  public section.
    interfaces yea_route.
endclass.

class yea_root_route implementation.
 	method yea_route~execute.
		response->set_status( 200 )->send_text( request->method( ) ).
	endmethod. 
endclass.
```
 
### Add route via constructor

```abap
method constructor.
  super->constructor( ).
  data(route) = new yea_root_route( ).
  me->get( path = '/' route = route ).
  me->post( path = '/' route = route ).
  me->put( path = '/' route = route ).
  me->delete( path = '/' route = route ). 
endmethod. 
```

### Run your service via any HTTP client. 

```
 ~ > curl -H "sap-user: ..." -H "sap-password: ..." -X GET -si http://linux-nsts:8000/yea/tests
HTTP/1.1 200 Ok
set-cookie: sap-usercontext=sap-client=001; path=/
set-cookie: SAP_SESSIONID_NPL_001=YiuQPa3taGgJpycbgKq-dwGa-lNKzxHnmJ4IACflDbk%3d; path=/
content-type: text/plain; charset=utf-8
content-length: 3

GET
```

```
 ~ > curl -H "sap-user: ..." -H "sap-password: ..." -X POST -si http://linux-nsts:8000/yea/tests
HTTP/1.1 200 Ok
set-cookie: sap-usercontext=sap-client=001; path=/
set-cookie: SAP_SESSIONID_NPL_001=61tLssgv-TlhcX34DWutIQlGUn9KzxHnmJ4IACflDbk%3d; path=/
content-type: text/plain; charset=utf-8
content-length: 4

POST
```

```
 ~ > curl -H "sap-user: ..." -H "sap-password: ..." -H -X PUT -si http://linux-nsts:8000/yea/tests
HTTP/1.1 200 Ok
set-cookie: sap-usercontext=sap-client=001; path=/
content-type: text/plain; charset=utf-8
content-length: 3

PUT
```

```
 ~ > curl -H "sap-user: ..." -H "sap-password: ..." -H -X DELETE -si http://linux-nsts:8000/yea/tests
HTTP/1.1 200 Ok
set-cookie: sap-usercontext=sap-client=001; path=/
set-cookie: SAP_SESSIONID_NPL_001=rpwC8DRGLZcppBE2sJeVnBLMRRtKzxHnmJ4IACflDbk%3d; path=/
content-type: text/plain; charset=utf-8
content-length: 6

DELETE
```

## Errors

```
 ~ > curl -H "sap-user: ..." -H "sap-password: ..." -X GET -si http://linux-nsts:8000/yea/tests/nowhere
HTTP/1.1 404 Not found
set-cookie: sap-usercontext=sap-client=001; path=/
set-cookie: SAP_SESSIONID_NPL_001=Ikv5NdI1ntxa7lWxdSr3SeLQ6cVK2BHnmn4IACflDbk%3d; path=/
content-type: text/html
content-length: 0
```

```
 ~/ > curl -H "sap-user: ..." -H "sap-password: ..." -X MADEUP -si http://linux-nsts:8000/yea/tests
HTTP/1.1 405 Method not allowed
set-cookie: sap-usercontext=sap-client=001; path=/
set-cookie: SAP_SESSIONID_NPL_001=pP0bOFv495KiZPX70RNdEetgloVK2BHnmn4IACflDbk%3d; path=/
content-type: text/html
content-length: 0
```

## API

* `yea_abs_service` an abstract implementation for building web services
	* `root` returns the root path to the service as defined in SICF

* `yea_request` an abstraction for `i_http_request`.
	* `method` get the method used in the request
	* `content_type` get the content-type supplied by the client
	* `headers` todo
	* `body` returns a string representation of the body
	* `raw` returns a xstring representation of the body
	* `path` the path that was used in the request
	* `query` an interface to access queries used in the uri
	* `parameters` an interface to access parameters used in the uri
	* `root` returns the root of the service

* `yea_response` an abstraction for `i_http_response`.
	* `redirect` tells the client to visit another route
	* `set_status` sets the HTTP status code
	* `send_text` send a plain text message
	* `send_file` send a file
	* `send_json` send a json object (not implemeneted yet)
	* `end` prevents this instance from future modification
	* `finished` 

* `yea_route` an interface for providing a route implementation

* `yea_parameters` an interface for retreiving variables in a URI
	* `get` get a value
	* `has` checks if a value is avaliable
	* `list` a string table of keys

* `yea_query` similar to parameters but for URI queries. 
	* `get`
	* `has`
	* `list`




