class YEA_BASE_QUERY definition
  public
  final
  create public .

public section.

  interfaces YEA_QUERY .

  methods CONSTRUCTOR
    importing
      !URI_QUERY type STRING .
protected section.
private section.

  data _KEYS type YEA_KEY_VALUES .
ENDCLASS.



CLASS YEA_BASE_QUERY IMPLEMENTATION.


  method constructor.
    " data(uri_clean) = cl_http_utility=>if_http_utility~unescape_url( uri_query ).
    split uri_query at '&' into table data(query_splits).
    loop at query_splits assigning field-symbol(<u_q>).
      split <u_q> at '=' into table data(query_values).
      data kv type yea_key_value.
      try.
        kv-key   = cl_http_utility=>if_http_utility~unescape_url( query_values[ 1 ] ).
        kv-value = cl_http_utility=>if_http_utility~unescape_url( query_values[ 2 ] ).
      catch cx_root.
      endtry.
      if ( kv is not initial ).
        append kv to _keys.
        clear kv.
      endif.
    endloop.
  endmethod.


  method YEA_QUERY~GET.
    try.
      returning = _keys[ key = argument ]-value.
    catch cx_root.
    endtry.
  endmethod.


  method YEA_QUERY~HAS.
    try.
      data(found) = _keys[ key = argument ].
      returning = abap_true.
    catch cx_root.
    endtry.
  endmethod.
ENDCLASS.
