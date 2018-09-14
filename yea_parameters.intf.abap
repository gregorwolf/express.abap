interface YEA_PARAMETERS
  public .


  methods GET
    importing
      !PARAMETER type STRING
    returning
      value(RETURNING) type STRING .
  methods HAS
    importing
      !PARAMETER type STRING
    returning
      value(RETURNING) type ABAP_BOOL .
  methods LIST
    returning
      value(RETURNING) type YEA_KEY_VALUES .
endinterface.
