class YEA_UNIT_TEST_REQUEST definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_ENTITY .
  interfaces IF_HTTP_REQUEST .

  aliases GET_CDATA
    for IF_HTTP_REQUEST~GET_CDATA .
  aliases GET_CONTENT_TYPE
    for IF_HTTP_REQUEST~GET_CONTENT_TYPE .
  aliases GET_HEADER_FIELD
    for IF_HTTP_REQUEST~GET_HEADER_FIELD .
  aliases GET_HEADER_FIELDS
    for IF_HTTP_REQUEST~GET_HEADER_FIELDS .
  aliases GET_METHOD
    for IF_HTTP_REQUEST~GET_METHOD .
  aliases SET_CDATA
    for IF_HTTP_REQUEST~SET_CDATA .
  aliases SET_CONTENT_TYPE
    for IF_HTTP_REQUEST~SET_CONTENT_TYPE .
  aliases SET_HEADER_FIELD
    for IF_HTTP_REQUEST~SET_HEADER_FIELD .
  aliases SET_HEADER_FIELDS
    for IF_HTTP_REQUEST~SET_HEADER_FIELDS .
  aliases SET_METHOD
    for IF_HTTP_REQUEST~SET_METHOD .
protected section.
private section.

  data _HEADERS type YEA_KEY_VALUES .
  data _BODY type STRING .
  data _CONTENT_TYPE type STRING .
  data _METHOD type STRING .
ENDCLASS.



CLASS YEA_UNIT_TEST_REQUEST IMPLEMENTATION.


  method IF_HTTP_ENTITY~GET_CDATA.
    data = me->_body.
  endmethod.


  method IF_HTTP_ENTITY~GET_CONTENT_TYPE.
    content_type = _content_type.
  endmethod.


  method if_http_entity~get_header_field.
    try.
      value = me->_headers[ key = name ]-value.
    catch cx_root.
    endtry.
  endmethod.


  method if_http_entity~get_header_fields.
    data out type ihttpnvp.
    field-symbols <header> type yea_key_value.
    loop at _headers assigning <header>.
      out-name = <header>-key.
      out-value = <header>-value.
      append out to fields.
      clear out.
    endloop.
  endmethod.


  method IF_HTTP_ENTITY~SET_CDATA.
    _body = data.
  endmethod.


  method IF_HTTP_ENTITY~SET_CONTENT_TYPE.
    _content_type = content_type.
  endmethod.


  method IF_HTTP_ENTITY~SET_COOKIE.
  endmethod.


  method if_http_entity~set_header_field.
    data header type yea_key_value.
    header-key = name.
    header-value = value.
    append header to me->_headers.
  endmethod.


  method if_http_entity~set_header_fields.
    field-symbols <header> type IHTTPNVP.
    data header type yea_key_value.
    loop at fields assigning <header>.
      header-key = <header>-name.
      header-value = <header>-value.
      append header to me->_headers.
      clear header.
    endloop.
  endmethod.


  method IF_HTTP_REQUEST~GET_METHOD.
    method = me->_method.
  endmethod.


  method IF_HTTP_REQUEST~SET_METHOD.
    me->_method = method.
  endmethod.
ENDCLASS.
