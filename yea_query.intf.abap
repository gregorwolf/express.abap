interface YEA_QUERY
  public .


  methods GET
    importing
      !ARGUMENT type STRING
    returning
      value(RETURNING) type STRING .
  methods HAS
    importing
      !ARGUMENT type STRING
    returning
      value(RETURNING) type ABAP_BOOL .
  methods LIST
    returning
      value(RETURNING) type YEA_KEY_VALUES .
endinterface.
