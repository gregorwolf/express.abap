" Call ABAP services and simulate SICF calls by mocking server
report.

parameters:
  service type c length 36 default 'YEA_UNIT_TEST_SERVICE',
  uri type c length 50 lower case default '/',
  method type c length 10 default 'GET',
  ctype type c length 36 lower case default 'text/plain',
  body type c length 50 lower case.

start-of-selection.
  data(server) = new yea_unit_test_server( ).
  server->method( conv #( method ) )->path( conv #( uri ) )->body( conv #( body ) ).
  data http_interface type ref to if_http_extension.
  data yea_interface type ref to yea_service.
  try.
    create object yea_interface type (service).
    http_interface = cast if_http_extension( yea_interface ).
    http_interface->handle_request( server ).
    server->response->get_status( importing code = data(code) reason = data(reason) ).
    data(output) = server->response->get_cdata( ).
    data(trace) = yea_interface->trace( ).
    write : / 'code:   ' color col_key, code.
    write : / 'reason: ' color col_key, reason.
    write : / 'body:   ' color col_key, output.
    write : / 'trace   ' color col_key.
    loop at trace assigning field-symbol(<t>).
      write : / '    ', <t>.
    endloop.
  catch cx_root.
    write : 'Error'.
  endtry.
