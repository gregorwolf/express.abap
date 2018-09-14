interface YEA_ROUTE
  public .


  methods EXECUTE
    importing
      !REQUEST type ref to YEA_REQUEST
      !RESPONSE type ref to YEA_RESPONSE
    returning
      value(RETURNING) type ABAP_BOOL .
endinterface.
