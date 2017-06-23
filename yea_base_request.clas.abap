class YEA_BASE_REQUEST definition
  public
  final
  create public .

public section.

  interfaces YEA_REQUEST .

  methods CONSTRUCTOR
    importing
      !SAP_REQUEST type ref to IF_HTTP_REQUEST
      !SERVICE_ROOT type STRING .
  methods SET_PARAMS
    importing
      !PARAMS type ref to YEA_PARAMETERS .
  methods SET_QUERY
    importing
      !QUERY type ref to YEA_QUERY .
  protected section.
private section.

  data _SAP_REQUEST type ref to IF_HTTP_REQUEST .
  data _METHOD type STRING .
  data _CONTENT_TYPE type STRING .
  data _HEADERS type ZTT_EA_KEY_VALUES .
  data _PATH type STRING .
  data _accept type string.
  data _QUERY type ref to YEA_QUERY .
  data _ROOT type STRING .
  data _PARAMS type ref to YEA_PARAMETERS .
ENDCLASS.



CLASS YEA_BASE_REQUEST IMPLEMENTATION.


  method CONSTRUCTOR.

    " Prevent null ptr
    _params = new yea_base_parameters( ).

    data headers type tihttpnvp.
    sap_request->get_header_fields( changing fields = headers ).

    try.
        _path = headers[ name = '~request_uri' ]-value.
        replace first occurrence of service_root in _path with ''.
      catch cx_root.
    endtry.

    try.
        _accept = headers[ name = 'accept' ]-value.
    catch cx_root.
    endtry.

    data query_url type string.
    try.
      query_url = headers[ name = '~query_string' ]-value.
    catch cx_root.
    endtry.
    me->_query = new yea_base_query( query_url ).

    _method = sap_request->get_method( ).
    _sap_request = sap_request.
    _content_type = sap_request->get_content_type( ).
    _root = service_root.

  endmethod.


  method SET_PARAMS.
    _params = params.
  endmethod.


  method SET_QUERY.
  endmethod.


  method yea_request~accept.
    returning = me->_accept.
  endmethod.


  method YEA_REQUEST~BODY.
    returning = me->_sap_request->get_cdata( ).
  endmethod.


  method YEA_REQUEST~CONTENT_TYPE.
    returning = _content_type.
  endmethod.


  method YEA_REQUEST~METHOD.
    returning = me->_method.
  endmethod.


  method YEA_REQUEST~PARAMETERS.
    returning = _params.
  endmethod.


  method YEA_REQUEST~PATH.
    returning = me->_path.
  endmethod.


  method YEA_REQUEST~QUERY.
  endmethod.


  method YEA_REQUEST~RAW.
    returning = _sap_request->get_raw_message( ).
  endmethod.


  method YEA_REQUEST~ROOT.
    returning = _root.
  endmethod.
ENDCLASS.
