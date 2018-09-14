class YEA_UNIT_TEST_SERVICE definition
  public
  inheriting from YEA_ABS_SERVICE
  final
  create public .

public section.

  aliases HANDLE_REQUEST
    for IF_HTTP_EXTENSION~HANDLE_REQUEST .
  aliases TRACE
    for YEA_SERVICE~TRACE .

  methods CONSTRUCTOR .

  methods YEA_SERVICE~ROOT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YEA_UNIT_TEST_SERVICE IMPLEMENTATION.


  method CONSTRUCTOR.
    super->constructor( ).
    data(method_echo) = new method_echo( ).
    data(query_echo) = new query_echo( ).
    data(param_echo) = new params_echo( ).
    data(headers_echo) = new headers_echo( ).
    data(body_echo) = new body_echo( ).
    data(role_check) = new role_check( 'Z_NWBC_TEST_ROLE' ).
    data(ctype_check) = new role_check( 'text/plain' ).
    data(json_check) = new ctype_check( 'application/json' ).
    get( path = '/' route = new root( ) ).
    " Echo, returns the data received from the client
    get( path = '/echo/method' route = method_echo ).
    post( path = '/echo/method' route = method_echo ).
    put( path = '/echo/method' route = method_echo ).
    delete( path = '/echo/method' route = method_echo ).
    get( path = '/echo/query' route = query_echo ).
    get( path = '/echo/headers' route = headers_echo ).
    post( path = '/echo/body' route = body_echo ).
    " Param Checks in URI
    get( path = '/params/test1/:arg' route = param_echo ).
    get( path = '/params/test2/:arg1/:arg2' route = param_echo ).
    get( path = '/p/:arg1/nonarg/:agr2/end/:arg3' route = param_echo ).
    " Auth check (user that runs test must have role Z_NWBC_TEST_ROLE
    use( path = '/private/api' route = role_check ).
    use( path = '/private/api' route = json_check ).
    post( path = '/private/api' route = body_echo ).
  endmethod.


  method YEA_SERVICE~ROOT.
    returning = '/yea/unit/test'.
  endmethod.
ENDCLASS.
