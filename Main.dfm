object InsightiTrackWatcher: TInsightiTrackWatcher
  OldCreateOrder = False
  AllowPause = False
  DisplayName = 'InsightiTrackWatcher'
  ServiceStartName = 'NT AUTHORITY\NetworkService'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 300
  Width = 400
  object qryMatterAttachment: TUniQuery
    UpdatingTable = 'DOC'
    KeyFields = 'docid'
    Connection = uniInsight
    SQL.Strings = (
      'SELECT'
      '  DOC.DOCUMENT,'
      '  DOC.IMAGEINDEX,'
      '  DOC.FILE_EXTENSION,'
      '  DOC.DOC_NAME,'
      '  DOC.SEARCH,'
      '  DOC.DOC_CODE,'
      '  DOC.JURIS,'
      '  DOC.D_CREATE,'
      '  DOC.AUTH1,'
      '  DOC.D_MODIF,'
      '  DOC.AUTH2,'
      '  DOC.PATH,'
      '  DOC.DESCR,'
      '  DOC.FILEID,'
      '  DOC.DOCID,'
      '  DOC.NPRECCATEGORY,'
      '  DOC.NMATTER,'
      '  DOC.PRECEDENT_DETAILS,'
      '  DOC.NPRECCLASSIFICATION,'
      '  DOC.KEYWORDS,'
      '  DOC.DISPLAY_PATH,'
      '  DOC.EXTERNAL_ACCESS,'
      '  DOC.EMAIL_FROM,'
      '  DOC.EMAIL_SENT_TO,'
      '  DOC.NFEE, '
      '  DOC.ROWID'
      'FROM'
      '  DOC'
      'where'
      '  DOCID = :DOCID')
    CachedUpdates = True
    OnNewRecord = qryMatterAttachmentNewRecord
    Left = 41
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object qrySearches: TUniQuery
    UpdatingTable = 'AXIOM.SEARCHES'
    KeyFields = 'SEARCH_ID'
    SQLInsert.Strings = (
      'INSERT INTO AXIOM.SEARCHES'
      
        '  (SEARCH_ID, AVAILABLEONLINE, BILLINGTYPENAME, CLIENTREFERENCE1' +
        ', COMMENTS, DATEORDERED, DATECOMPLETED, DESCRIPTION, ORDERID, PA' +
        'RENTORDERID, ORDEREDBY, REFERENCE, RETAILERREFERENCE_OLD, RETAIL' +
        'ERFEE, RETAILERFEEGST, RETAILERFEETOTAL, SUPPLIERFEE, SUPPLIERFE' +
        'EGST, SUPPLIERFEETOTAL, TOTALFEE, TOTALFEEGST, TOTALFEETOTAL, SE' +
        'RVICENAME, STATUS, STATUSMESSAGE, DOWNLOADURL, ONLINEURL, ISBILL' +
        'ABLE, FILEHASH, EMAIL, CLIENTID, SEQUENCENUMBER, CLIENTREFERENCE' +
        ', RETAILERREFERENCE, FILE_NAME)'
      'VALUES'
      
        '  (:SEARCH_ID, :AVAILABLEONLINE, :BILLINGTYPENAME, :CLIENTREFERE' +
        'NCE1, :COMMENTS, :DATEORDERED, :DATECOMPLETED, :DESCRIPTION, :OR' +
        'DERID, :PARENTORDERID, :ORDEREDBY, :REFERENCE, :RETAILERREFERENC' +
        'E_OLD, :RETAILERFEE, :RETAILERFEEGST, :RETAILERFEETOTAL, :SUPPLI' +
        'ERFEE, :SUPPLIERFEEGST, :SUPPLIERFEETOTAL, :TOTALFEE, :TOTALFEEG' +
        'ST, :TOTALFEETOTAL, :SERVICENAME, :STATUS, :STATUSMESSAGE, :DOWN' +
        'LOADURL, :ONLINEURL, :ISBILLABLE, :FILEHASH, :EMAIL, :CLIENTID, ' +
        ':SEQUENCENUMBER, :CLIENTREFERENCE, :RETAILERREFERENCE, :FILE_NAM' +
        'E)')
    SQLDelete.Strings = (
      'DELETE FROM AXIOM.SEARCHES'
      'WHERE'
      '  SEARCH_ID = :Old_SEARCH_ID')
    SQLUpdate.Strings = (
      'UPDATE AXIOM.SEARCHES'
      'SET'
      
        '  SEARCH_ID = :SEARCH_ID, AVAILABLEONLINE = :AVAILABLEONLINE, BI' +
        'LLINGTYPENAME = :BILLINGTYPENAME, CLIENTREFERENCE1 = :CLIENTREFE' +
        'RENCE1, COMMENTS = :COMMENTS, DATEORDERED = :DATEORDERED, DATECO' +
        'MPLETED = :DATECOMPLETED, DESCRIPTION = :DESCRIPTION, ORDERID = ' +
        ':ORDERID, PARENTORDERID = :PARENTORDERID, ORDEREDBY = :ORDEREDBY' +
        ', REFERENCE = :REFERENCE, RETAILERREFERENCE_OLD = :RETAILERREFER' +
        'ENCE_OLD, RETAILERFEE = :RETAILERFEE, RETAILERFEEGST = :RETAILER' +
        'FEEGST, RETAILERFEETOTAL = :RETAILERFEETOTAL, SUPPLIERFEE = :SUP' +
        'PLIERFEE, SUPPLIERFEEGST = :SUPPLIERFEEGST, SUPPLIERFEETOTAL = :' +
        'SUPPLIERFEETOTAL, TOTALFEE = :TOTALFEE, TOTALFEEGST = :TOTALFEEG' +
        'ST, TOTALFEETOTAL = :TOTALFEETOTAL, SERVICENAME = :SERVICENAME, ' +
        'STATUS = :STATUS, STATUSMESSAGE = :STATUSMESSAGE, DOWNLOADURL = ' +
        ':DOWNLOADURL, ONLINEURL = :ONLINEURL, ISBILLABLE = :ISBILLABLE, ' +
        'FILEHASH = :FILEHASH, EMAIL = :EMAIL, CLIENTID = :CLIENTID, SEQU' +
        'ENCENUMBER = :SEQUENCENUMBER, CLIENTREFERENCE = :CLIENTREFERENCE' +
        ', RETAILERREFERENCE = :RETAILERREFERENCE, FILE_NAME = :FILE_NAME'
      'WHERE'
      '  SEARCH_ID = :Old_SEARCH_ID')
    SQLLock.Strings = (
      
        'SELECT SEARCH_ID, AVAILABLEONLINE, BILLINGTYPENAME, CLIENTREFERE' +
        'NCE1, COMMENTS, DATEORDERED, DATECOMPLETED, DESCRIPTION, ORDERID' +
        ', PARENTORDERID, ORDEREDBY, REFERENCE, RETAILERREFERENCE_OLD, RE' +
        'TAILERFEE, RETAILERFEEGST, RETAILERFEETOTAL, SUPPLIERFEE, SUPPLI' +
        'ERFEEGST, SUPPLIERFEETOTAL, TOTALFEE, TOTALFEEGST, TOTALFEETOTAL' +
        ', SERVICENAME, STATUS, STATUSMESSAGE, DOWNLOADURL, ONLINEURL, IS' +
        'BILLABLE, FILEHASH, EMAIL, CLIENTID, SEQUENCENUMBER, CLIENTREFER' +
        'ENCE, RETAILERREFERENCE, FILE_NAME FROM AXIOM.SEARCHES'
      'WHERE'
      '  SEARCH_ID = :Old_SEARCH_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT SEARCH_ID, AVAILABLEONLINE, BILLINGTYPENAME, CLIENTREFERE' +
        'NCE1, COMMENTS, DATEORDERED, DATECOMPLETED, DESCRIPTION, ORDERID' +
        ', PARENTORDERID, ORDEREDBY, REFERENCE, RETAILERREFERENCE_OLD, RE' +
        'TAILERFEE, RETAILERFEEGST, RETAILERFEETOTAL, SUPPLIERFEE, SUPPLI' +
        'ERFEEGST, SUPPLIERFEETOTAL, TOTALFEE, TOTALFEEGST, TOTALFEETOTAL' +
        ', SERVICENAME, STATUS, STATUSMESSAGE, DOWNLOADURL, ONLINEURL, IS' +
        'BILLABLE, FILEHASH, EMAIL, CLIENTID, SEQUENCENUMBER, CLIENTREFER' +
        'ENCE, RETAILERREFERENCE, FILE_NAME FROM AXIOM.SEARCHES'
      'WHERE'
      '  SEARCH_ID = :SEARCH_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM AXIOM.SEARCHES'
      ''
      ')')
    Connection = uniInsight
    SQL.Strings = (
      'SELECT '
      '   AVAILABLEONLINE, BILLINGTYPENAME, CLIENTID, '
      '   CLIENTREFERENCE, CLIENTREFERENCE1, COMMENTS, '
      '   DATECOMPLETED, DATEORDERED, DESCRIPTION, '
      '   DOWNLOADURL, EMAIL, FILE_NAME, '
      '   FILEHASH, ISBILLABLE, ONLINEURL, '
      '   ORDEREDBY, ORDERID, PARENTORDERID, '
      '   REFERENCE, RETAILERFEE, RETAILERFEEGST, '
      '   RETAILERFEETOTAL, RETAILERREFERENCE, RETAILERREFERENCE_OLD, '
      '   SEARCH_ID, SEQUENCENUMBER, SERVICENAME, '
      '   STATUS, STATUSMESSAGE, SUPPLIERFEE, '
      '   SUPPLIERFEEGST, SUPPLIERFEETOTAL, TOTALFEE, '
      '   TOTALFEEGST, TOTALFEETOTAL, rowid'
      'FROM AXIOM.SEARCHES')
    CachedUpdates = True
    OnNewRecord = qrySearchesNewRecord
    Left = 104
    Top = 53
    object qrySearchesAVAILABLEONLINE: TStringField
      FieldName = 'AVAILABLEONLINE'
      Size = 5
    end
    object qrySearchesBILLINGTYPENAME: TStringField
      FieldName = 'BILLINGTYPENAME'
      Size = 100
    end
    object qrySearchesCLIENTID: TStringField
      FieldName = 'CLIENTID'
      Size = 30
    end
    object qrySearchesCLIENTREFERENCE: TStringField
      FieldName = 'CLIENTREFERENCE'
    end
    object qrySearchesCLIENTREFERENCE1: TFloatField
      FieldName = 'CLIENTREFERENCE1'
    end
    object qrySearchesCOMMENTS: TStringField
      FieldName = 'COMMENTS'
      Size = 4000
    end
    object qrySearchesDATECOMPLETED: TDateTimeField
      FieldName = 'DATECOMPLETED'
    end
    object qrySearchesDATEORDERED: TDateTimeField
      FieldName = 'DATEORDERED'
    end
    object qrySearchesDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 1000
    end
    object qrySearchesDOWNLOADURL: TStringField
      FieldName = 'DOWNLOADURL'
      Size = 400
    end
    object qrySearchesEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 250
    end
    object qrySearchesFILE_NAME: TStringField
      FieldName = 'FILE_NAME'
      Size = 250
    end
    object qrySearchesFILEHASH: TStringField
      FieldName = 'FILEHASH'
      Size = 50
    end
    object qrySearchesISBILLABLE: TStringField
      FieldName = 'ISBILLABLE'
      Size = 5
    end
    object qrySearchesONLINEURL: TStringField
      FieldName = 'ONLINEURL'
      Size = 400
    end
    object qrySearchesORDEREDBY: TStringField
      FieldName = 'ORDEREDBY'
      Size = 100
    end
    object qrySearchesORDERID: TFloatField
      FieldName = 'ORDERID'
    end
    object qrySearchesPARENTORDERID: TFloatField
      FieldName = 'PARENTORDERID'
    end
    object qrySearchesREFERENCE: TStringField
      FieldName = 'REFERENCE'
      Size = 150
    end
    object qrySearchesRETAILERFEE: TFloatField
      FieldName = 'RETAILERFEE'
    end
    object qrySearchesRETAILERFEEGST: TFloatField
      FieldName = 'RETAILERFEEGST'
    end
    object qrySearchesRETAILERFEETOTAL: TFloatField
      FieldName = 'RETAILERFEETOTAL'
    end
    object qrySearchesRETAILERREFERENCE: TStringField
      FieldName = 'RETAILERREFERENCE'
    end
    object qrySearchesRETAILERREFERENCE_OLD: TFloatField
      FieldName = 'RETAILERREFERENCE_OLD'
    end
    object qrySearchesSEARCH_ID: TFloatField
      FieldName = 'SEARCH_ID'
    end
    object qrySearchesSEQUENCENUMBER: TFloatField
      FieldName = 'SEQUENCENUMBER'
    end
    object qrySearchesSERVICENAME: TStringField
      FieldName = 'SERVICENAME'
      Size = 100
    end
    object qrySearchesSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 50
    end
    object qrySearchesSTATUSMESSAGE: TStringField
      FieldName = 'STATUSMESSAGE'
      Size = 1000
    end
    object qrySearchesSUPPLIERFEE: TFloatField
      FieldName = 'SUPPLIERFEE'
    end
    object qrySearchesSUPPLIERFEEGST: TFloatField
      FieldName = 'SUPPLIERFEEGST'
    end
    object qrySearchesSUPPLIERFEETOTAL: TFloatField
      FieldName = 'SUPPLIERFEETOTAL'
    end
    object qrySearchesTOTALFEE: TFloatField
      FieldName = 'TOTALFEE'
    end
    object qrySearchesTOTALFEEGST: TFloatField
      FieldName = 'TOTALFEEGST'
    end
    object qrySearchesTOTALFEETOTAL: TFloatField
      FieldName = 'TOTALFEETOTAL'
    end
    object qrySearchesROWID: TStringField
      FieldName = 'ROWID'
      ReadOnly = True
      Size = 18
    end
  end
  object qryTmp: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'SELECT * FROM FEE')
    Left = 159
    Top = 18
  end
  object qrySysFile: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'SELECT * FROM SYSTEMFILE')
    Left = 14
    Top = 65
  end
  object qryGetDocSeq: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'select DOC_DOCID.nextval as nextdoc from dual')
    Left = 75
    Top = 101
  end
  object uniInsight: TUniConnection
    ProviderName = 'Oracle'
    SpecificOptions.Strings = (
      'Oracle.Direct=True'
      'Oracle.IPVersion=ivIPBoth')
    Options.KeepDesignConnected = False
    Options.LocalFailover = True
    PoolingOptions.MaxPoolSize = 50
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 10000000
    PoolingOptions.Validate = True
    Username = 'axiom'
    Server = 'dev-oracle:1521:sn=jcl'
    LoginPrompt = False
    Left = 310
    Top = 15
    EncryptedPassword = '9EFF87FF96FF90FF92FF'
  end
  object procTemp: TUniStoredProc
    Connection = uniInsight
    Left = 90
    Top = 159
  end
  object qryCharts: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'SELECT * FROM CHART WHERE BANK = :P_Bank AND CODE = :P_Code')
    Left = 221
    Top = 29
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'P_Bank'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'P_Code'
        Value = nil
      end>
  end
  object qryExpenseAllocations: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'select *'
      'from gl_expense_allocations gl '
      'where master_code = :code'
      'and master_bank = :bank')
    Left = 187
    Top = 109
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'code'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'bank'
        Value = nil
      end>
  end
  object qryEmps: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'SELECT CODE FROM EMPLOYEE')
    Left = 21
    Top = 185
  end
  object qryTransItemInsert: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'INSERT INTO transitem'
      '            ( created, acct, amount, tax, refno, descr, chart,'
      
        '             owner_code, nowner, ncheque, nreceipt, ninvoice, nj' +
        'ournal,'
      
        '             creditorcode, who, taxcode, parent_chart, nalloc, n' +
        'matter,'
      '             rvdate, VERSION, ntrans, bas_tax'
      '            )'
      
        '     VALUES (:created, :acct, :amount, :tax, :refno, :descr, :ch' +
        'art,'
      
        '             :owner_code, :nowner, :ncheque, :nreceipt, :ninvoic' +
        'e, :njournal,'
      
        '             :creditorcode, :who, :taxcode, :parent_chart, :nall' +
        'oc, :nmatter,'
      '             :rvdate, :VERSION, :ntrans, :bas_tax'
      '            )')
    Left = 96
    Top = 229
    ParamData = <
      item
        DataType = ftDate
        Name = 'CREATED'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'ACCT'
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'AMOUNT'
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'TAX'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'REFNO'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'DESCR'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'CHART'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'OWNER_CODE'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NOWNER'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NCHEQUE'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NRECEIPT'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NINVOICE'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NJOURNAL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'CREDITORCODE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'WHO'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'TAXCODE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'PARENT_CHART'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NALLOC'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NMATTER'
        Value = nil
      end
      item
        DataType = ftDate
        Name = 'RVDATE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'VERSION'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'NTRANS'
        Value = nil
      end
      item
        DataType = ftFloat
        Name = 'BAS_TAX'
        Value = nil
      end>
  end
  object OracleUniProvider1: TOracleUniProvider
    Left = 316
    Top = 78
  end
  object qrySearchesUpdate: TUniQuery
    UpdatingTable = 'SEARCHES'
    KeyFields = 'search_id'
    Connection = uniInsight
    SQL.Strings = (
      'UPDATE searches'
      '   SET availableonline = :availableonline,'
      '       billingtypename = :billingtypename,'
      '       clientreference1 = :clientreference1,'
      '       comments = :comments,'
      '       dateordered = :dateordered,'
      '       datecompleted = :datecompleted,'
      '       description = :description,'
      '       orderid = :orderid,'
      '       parentorderid = :parentorderid,'
      '       orderedby = :orderedby,'
      '       REFERENCE = :REFERENCE,'
      '       retailerfee = NVL (:retailerfee, retailerfee),'
      '       retailerfeegst = NVL (:retailerfeegst, retailerfeegst),'
      
        '       retailerfeetotal = NVL (:retailerfeetotal, retailerfeetot' +
        'al),'
      '       supplierfee = NVL (:supplierfee, supplierfee),'
      '       supplierfeegst = NVL (:supplierfeegst, supplierfeegst),'
      
        '       supplierfeetotal = NVL (:supplierfeetotal, supplierfeetot' +
        'al),'
      '       totalfee = NVL (:totalfee, totalfee),'
      '       totalfeegst = NVL (:totalfeegst, totalfeegst),'
      '       totalfeetotal = NVL (:totalfeetotal, totalfeetotal),'
      '       servicename = :servicename,'
      '       status = :status,'
      '       statusmessage = :statusmessage,'
      '       downloadurl = :downloadurl,'
      '       onlineurl = :onlineurl,'
      '       isbillable = :isbillable,'
      '       filehash = :filehash,'
      '       email = :email,'
      '       clientid = :clientid,'
      '       sequencenumber = :sequencenumber,'
      '       clientreference = :clientreference,'
      '       retailerreference = :retailerreference'
      ' WHERE search_id = :search_id')
    Left = 312
    Top = 146
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AVAILABLEONLINE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'BILLINGTYPENAME'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CLIENTREFERENCE1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'COMMENTS'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATEORDERED'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATECOMPLETED'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ORDERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'PARENTORDERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ORDEREDBY'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'REFERENCE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'RETAILERFEE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'RETAILERFEEGST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'RETAILERFEETOTAL'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUPPLIERFEE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUPPLIERFEEGST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUPPLIERFEETOTAL'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'TOTALFEE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'TOTALFEEGST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'TOTALFEETOTAL'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SERVICENAME'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'STATUS'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'STATUSMESSAGE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOWNLOADURL'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ONLINEURL'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ISBILLABLE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FILEHASH'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'EMAIL'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CLIENTID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SEQUENCENUMBER'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CLIENTREFERENCE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'RETAILERREFERENCE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SEARCH_ID'
        Value = nil
      end>
  end
  object qrySearchID: TUniQuery
    UpdatingTable = 'SEARCHES'
    KeyFields = 'search_id'
    SQLInsert.Strings = (
      'INSERT INTO SEARCHES'
      
        '  (SEARCH_ID, AVAILABLEONLINE, BILLINGTYPENAME, CLIENTREFERENCE1' +
        ', COMMENTS, DATEORDERED, DATECOMPLETED, DESCRIPTION, ORDERID, PA' +
        'RENTORDERID, ORDEREDBY, REFERENCE, RETAILERREFERENCE_OLD, RETAIL' +
        'ERFEE, RETAILERFEEGST, RETAILERFEETOTAL, SUPPLIERFEE, SUPPLIERFE' +
        'EGST, SUPPLIERFEETOTAL, TOTALFEE, TOTALFEEGST, TOTALFEETOTAL, SE' +
        'RVICENAME, STATUS, STATUSMESSAGE, DOWNLOADURL, ONLINEURL, ISBILL' +
        'ABLE, FILEHASH, EMAIL, CLIENTID, SEQUENCENUMBER, CLIENTREFERENCE' +
        ', RETAILERREFERENCE, FILE_NAME)'
      'VALUES'
      
        '  (:SEARCH_ID, :AVAILABLEONLINE, :BILLINGTYPENAME, :CLIENTREFERE' +
        'NCE1, :COMMENTS, :DATEORDERED, :DATECOMPLETED, :DESCRIPTION, :OR' +
        'DERID, :PARENTORDERID, :ORDEREDBY, :REFERENCE, :RETAILERREFERENC' +
        'E_OLD, :RETAILERFEE, :RETAILERFEEGST, :RETAILERFEETOTAL, :SUPPLI' +
        'ERFEE, :SUPPLIERFEEGST, :SUPPLIERFEETOTAL, :TOTALFEE, :TOTALFEEG' +
        'ST, :TOTALFEETOTAL, :SERVICENAME, :STATUS, :STATUSMESSAGE, :DOWN' +
        'LOADURL, :ONLINEURL, :ISBILLABLE, :FILEHASH, :EMAIL, :CLIENTID, ' +
        ':SEQUENCENUMBER, :CLIENTREFERENCE, :RETAILERREFERENCE, :FILE_NAM' +
        'E)')
    SQLDelete.Strings = (
      'DELETE FROM SEARCHES'
      'WHERE'
      '  SEARCH_ID = :Old_SEARCH_ID')
    SQLUpdate.Strings = (
      'UPDATE SEARCHES'
      'SET'
      
        '  SEARCH_ID = :SEARCH_ID, AVAILABLEONLINE = :AVAILABLEONLINE, BI' +
        'LLINGTYPENAME = :BILLINGTYPENAME, CLIENTREFERENCE1 = :CLIENTREFE' +
        'RENCE1, COMMENTS = :COMMENTS, DATEORDERED = :DATEORDERED, DATECO' +
        'MPLETED = :DATECOMPLETED, DESCRIPTION = :DESCRIPTION, ORDERID = ' +
        ':ORDERID, PARENTORDERID = :PARENTORDERID, ORDEREDBY = :ORDEREDBY' +
        ', REFERENCE = :REFERENCE, RETAILERREFERENCE_OLD = :RETAILERREFER' +
        'ENCE_OLD, RETAILERFEE = :RETAILERFEE, RETAILERFEEGST = :RETAILER' +
        'FEEGST, RETAILERFEETOTAL = :RETAILERFEETOTAL, SUPPLIERFEE = :SUP' +
        'PLIERFEE, SUPPLIERFEEGST = :SUPPLIERFEEGST, SUPPLIERFEETOTAL = :' +
        'SUPPLIERFEETOTAL, TOTALFEE = :TOTALFEE, TOTALFEEGST = :TOTALFEEG' +
        'ST, TOTALFEETOTAL = :TOTALFEETOTAL, SERVICENAME = :SERVICENAME, ' +
        'STATUS = :STATUS, STATUSMESSAGE = :STATUSMESSAGE, DOWNLOADURL = ' +
        ':DOWNLOADURL, ONLINEURL = :ONLINEURL, ISBILLABLE = :ISBILLABLE, ' +
        'FILEHASH = :FILEHASH, EMAIL = :EMAIL, CLIENTID = :CLIENTID, SEQU' +
        'ENCENUMBER = :SEQUENCENUMBER, CLIENTREFERENCE = :CLIENTREFERENCE' +
        ', RETAILERREFERENCE = :RETAILERREFERENCE, FILE_NAME = :FILE_NAME'
      'WHERE'
      '  SEARCH_ID = :Old_SEARCH_ID')
    SQLLock.Strings = (
      
        'SELECT SEARCH_ID, AVAILABLEONLINE, BILLINGTYPENAME, CLIENTREFERE' +
        'NCE1, COMMENTS, DATEORDERED, DATECOMPLETED, DESCRIPTION, ORDERID' +
        ', PARENTORDERID, ORDEREDBY, REFERENCE, RETAILERREFERENCE_OLD, RE' +
        'TAILERFEE, RETAILERFEEGST, RETAILERFEETOTAL, SUPPLIERFEE, SUPPLI' +
        'ERFEEGST, SUPPLIERFEETOTAL, TOTALFEE, TOTALFEEGST, TOTALFEETOTAL' +
        ', SERVICENAME, STATUS, STATUSMESSAGE, DOWNLOADURL, ONLINEURL, IS' +
        'BILLABLE, FILEHASH, EMAIL, CLIENTID, SEQUENCENUMBER, CLIENTREFER' +
        'ENCE, RETAILERREFERENCE, FILE_NAME FROM SEARCHES'
      'WHERE'
      '  SEARCH_ID = :Old_SEARCH_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT SEARCH_ID, AVAILABLEONLINE, BILLINGTYPENAME, CLIENTREFERE' +
        'NCE1, COMMENTS, DATEORDERED, DATECOMPLETED, DESCRIPTION, ORDERID' +
        ', PARENTORDERID, ORDEREDBY, REFERENCE, RETAILERREFERENCE_OLD, RE' +
        'TAILERFEE, RETAILERFEEGST, RETAILERFEETOTAL, SUPPLIERFEE, SUPPLI' +
        'ERFEEGST, SUPPLIERFEETOTAL, TOTALFEE, TOTALFEEGST, TOTALFEETOTAL' +
        ', SERVICENAME, STATUS, STATUSMESSAGE, DOWNLOADURL, ONLINEURL, IS' +
        'BILLABLE, FILEHASH, EMAIL, CLIENTID, SEQUENCENUMBER, CLIENTREFER' +
        'ENCE, RETAILERREFERENCE, FILE_NAME FROM SEARCHES'
      'WHERE'
      '  SEARCH_ID = :SEARCH_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM SEARCHES'
      ''
      ')')
    Connection = uniInsight
    SQL.Strings = (
      'select searches.*, searches.rowid'
      'from searches'
      'where'
      'search_id = :search_id')
    Left = 317
    Top = 202
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'search_id'
        Value = nil
      end>
  end
  object qrySearchesUpdateyy: TUniSQL
    Connection = uniInsight
    SQL.Strings = (
      'UPDATE SEARCHES'
      'SET'
      
        '  AVAILABLEONLINE = :AVAILABLEONLINE, BILLINGTYPENAME = :BILLING' +
        'TYPENAME, '
      
        '  CLIENTREFERENCE1 = :CLIENTREFERENCE1, COMMENTS = :COMMENTS, DA' +
        'TEORDERED = :DATEORDERED, DATECOMPLETED = :DATECOMPLETED, '
      '  DESCRIPTION = :DESCRIPTION, ORDEREDBY = :ORDEREDBY, '
      
        '  REFERENCE = :REFERENCE, RETAILERFEE = :RETAILERFEE, RETAILERFE' +
        'EGST = :RETAILERFEEGST, '
      
        '  RETAILERFEETOTAL = :RETAILERFEETOTAL, SUPPLIERFEE = :SUPPLIERF' +
        'EE, SUPPLIERFEEGST = :SUPPLIERFEEGST, SUPPLIERFEETOTAL = :SUPPLI' +
        'ERFEETOTAL, '
      
        '  TOTALFEE = :TOTALFEE, TOTALFEEGST = :TOTALFEEGST, TOTALFEETOTA' +
        'L = :TOTALFEETOTAL, SERVICENAME = :SERVICENAME, '
      
        '  STATUS = :STATUS, STATUSMESSAGE = :STATUSMESSAGE, DOWNLOADURL ' +
        '= :DOWNLOADURL, ONLINEURL = :ONLINEURL, ISBILLABLE = :ISBILLABLE' +
        ', '
      
        '  FILEHASH = :FILEHASH, EMAIL = :EMAIL, CLIENTID = :CLIENTID, SE' +
        'QUENCENUMBER = :SEQUENCENUMBER, CLIENTREFERENCE = :CLIENTREFEREN' +
        'CE, RETAILERREFERENCE = :RETAILERREFERENCE'
      'WHERE'
      '  SEARCH_ID = :SEARCH_ID')
    Left = 217
    Top = 183
    ParamData = <
      item
        DataType = ftString
        Name = 'AVAILABLEONLINE'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'BILLINGTYPENAME'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'CLIENTREFERENCE1'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'COMMENTS'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftDateTime
        Name = 'DATEORDERED'
        Value = nil
      end
      item
        DataType = ftDateTime
        Name = 'DATECOMPLETED'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'DESCRIPTION'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'ORDEREDBY'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'REFERENCE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'RETAILERFEE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'RETAILERFEEGST'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'RETAILERFEETOTAL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'SUPPLIERFEE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'SUPPLIERFEEGST'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'SUPPLIERFEETOTAL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'TOTALFEE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'TOTALFEEGST'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'TOTALFEETOTAL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'SERVICENAME'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'STATUS'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'STATUSMESSAGE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'DOWNLOADURL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'ONLINEURL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'ISBILLABLE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'FILEHASH'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'EMAIL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'CLIENTID'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'SEQUENCENUMBER'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'CLIENTREFERENCE'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'RETAILERREFERENCE'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'SEARCH_ID'
        ParamType = ptInput
        Value = nil
      end>
  end
  object tmrScan: TTimer
    OnTimer = tmrScanTimer
    Left = 176
    Top = 240
  end
  object qryGetSearchSeq: TUniQuery
    Connection = uniInsight
    SQL.Strings = (
      'select sqnc_searches.nextval as nextsearch from dual')
    Left = 251
    Top = 245
  end
end
