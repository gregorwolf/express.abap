class YEA_UNIT_TEST_SERVER definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_SERVER .

  aliases REQUEST
    for IF_HTTP_SERVER~REQUEST .
  aliases RESPONSE
    for IF_HTTP_SERVER~RESPONSE .

  methods CONSTRUCTOR .
  methods METHOD
    importing
      !METHOD type STRING
    returning
      value(RETURNING) type ref to YEA_UNIT_TEST_SERVER .
  methods PATH
    importing
      !PATH type STRING
    returning
      value(RETURNING) type ref to YEA_UNIT_TEST_SERVER .
  methods BODY
    importing
      !BODY type STRING
    returning
      value(RETURNING) type ref to YEA_UNIT_TEST_SERVER .
protected section.
private section.
ENDCLASS.



CLASS YEA_UNIT_TEST_SERVER IMPLEMENTATION.


  method BODY.
    request->set_cdata( body ).
    returning = me.
  endmethod.


  method constructor.
    me->if_http_server~request = new yea_unit_test_request( ).
    me->if_http_server~response = new yea_unit_test_response( ).
  endmethod.


  method METHOD.
    me->request->set_method( method ).
    returning = me.
  endmethod.


  method PATH.
    me->request->set_header_field(
      name = '~path'
      value = path
    ).
    returning = me.
  endmethod.
ENDCLASS.
