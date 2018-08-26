class yea_base_response definition
  public
  final
  create public .

  public section.

    interfaces yea_response .

    methods constructor
      importing
        !sap_response type ref to if_http_response .
  protected section.
  private section.

    data _sap_response type ref to if_http_response .
    data _binary type xstring .
    data _text type string .
    data _done type abap_bool .

    methods check .
ENDCLASS.



CLASS YEA_BASE_RESPONSE IMPLEMENTATION.


  method check.
    if ( _done = abap_true ).
      data(no) = 1 / 0.
    endif.
  endmethod.


  method constructor.
    _sap_response = sap_response.
  endmethod.


  method yea_response~end.
    _done = abap_true.
    returning = me.
  endmethod.


  method yea_response~finished.
    returning = _done.
  endmethod.


  method yea_response~redirect.
    check( ).
    _sap_response->redirect( url = route ).
  endmethod.


  method yea_response~send_file.
    check( ).
  endmethod.


  method yea_response~send_json.
    check( ).
    _sap_response->set_header_field(
      name = 'Content-type'
      value = 'application/json' ).
    _sap_response->set_cdata( json ).
    returning = me.
    yea_response~end( ).
  endmethod.


  method yea_response~send_text.
    check( ).
    _sap_response->set_header_field(
      name = 'Content-type'
      value = 'text/plain' ).
    _sap_response->set_cdata( text ).
    returning = me.
    yea_response~end( ).
  endmethod.


  method yea_response~set_status.
    check( ).
    message id 'YEA_HTTP' type 'I' number status into data(status_text).
    _sap_response->set_status( code = status reason = status_text ).
    returning = me.
  endmethod.
ENDCLASS.
