interface YEA_SERVICE
  public .


  interfaces IF_HTTP_EXTENSION .

  methods USE
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods GET
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods HEAD
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods POST
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods PUT
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods DELETE
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods PATCH
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods COPY
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods OPTIONS
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods LINK
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods UNLINK
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods PURGE
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods LOCK
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods UNLOCK
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods PROPFIND
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods VIEW
    importing
      !PATH type STRING
      !ROUTE type ref to YEA_ROUTE
    returning
      value(RETURNING) type ref to YEA_SERVICE .
  methods ROOT
    returning
      value(RETURNING) type STRING .
  methods TRACE
    returning
      value(RETURNING) type STRINGTAB .
endinterface.
