interface YEA_REQUEST
  public .


  methods METHOD
    returning
      value(RETURNING) type STRING .
  methods CONTENT_TYPE
    returning
      value(RETURNING) type STRING .
  methods HEADERS
    returning
      value(RETURNING) type YEA_KEY_VALUES .
  methods ACCEPT
    returning
      value(RETURNING) type STRING .
  methods BODY
    returning
      value(RETURNING) type STRING .
  methods RAW
    returning
      value(RETURNING) type XSTRING .
  methods PATH
    returning
      value(RETURNING) type STRING .
  methods QUERY
    returning
      value(RETURNING) type ref to YEA_QUERY .
  methods PARAMETERS
    returning
      value(RETURNING) type ref to YEA_PARAMETERS .
  methods ROOT
    returning
      value(RETURNING) type STRING .
endinterface.
