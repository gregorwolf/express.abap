interface YEA_RESPONSE
  public .


  methods REDIRECT
    importing
      !STATUS type I
      !ROUTE type STRING .
  methods SET_STATUS
    importing
      !STATUS type I
    returning
      value(RETURNING) type ref to YEA_RESPONSE .
  methods SEND_TEXT
    importing
      !TEXT type STRING
    returning
      value(RETURNING) type ref to YEA_RESPONSE .
  methods SEND_FILE
    importing
      !BINARY type XSTRING
    returning
      value(RETURNING) type ref to YEA_RESPONSE .
  methods SEND_JSON
    importing
      !JSON type STRING
    returning
      value(RETURNING) type ref to YEA_RESPONSE .
  methods END
    returning
      value(RETURNING) type ref to YEA_RESPONSE .
  methods FINISHED
    returning
      value(RETURNING) type ABAP_BOOL .
endinterface.
