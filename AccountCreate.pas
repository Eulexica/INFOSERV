unit AccountCreate;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Uni,
  glComponentUtil;

type
  TdmAccountCreate = class(TDataModule)
    qryAccount: TUniQuery;
    qryAllocs: TUniQuery;
    qryUpdateInvoice: TUniQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function SaveAccount(AMatter, ACreditor: integer; AOrderID: string; ATotalAmt, ATax,
                          ARetailerFee, ARetailerFeeGST, ASupplierFee, ASupplierFeeGST: double;
                          ADescr, AFileID: string; ACreated: TDateTime): boolean;

  end;

var
  dmAccountCreate: TdmAccountCreate;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Main;


{$R *.dfm}

procedure TdmAccountCreate.DataModuleCreate(Sender: TObject);
begin
   qryAccount.Open;
   qryAllocs.Open;
end;

procedure TdmAccountCreate.DataModuleDestroy(Sender: TObject);
begin
   qryAccount.Close;
   qryAllocs.Close;
end;

function TdmAccountCreate.SaveAccount(AMatter, ACreditor: integer; AOrderID: string;
                                      ATotalAmt, ATax, ARetailerFee, ARetailerFeeGST,
                                      ASupplierFee, ASupplierFeeGST: double;
                                      ADescr, AFileID: string;
                                      ACreated: TDateTime): boolean;
var
  cAccTotal, cAccTax: Double;
  bPostingFailed, matterPosting: boolean;
  sCreditorCode, sLedgerCode, sLegalCode,
  sLedgerKey,sLedgerKeyDr, TaxCode, sAllocDescr: string;
  iNINVOICE, nmatter, dAllocRetailer, dAllocSupplier : integer;
  cMatterTotal, cTradeTotal : Double;
  glInstance : TglComponentInstance ;
  glComponentSetup : TglComponentSetup;
  iPos, iOrderID: integer;
begin
   try
      with InsightiTrackWatcher.qryTmp do
      begin
         close;
         SQL.Text := 'select ninvoice from invoice where ncreditor = :ncreditor and '+
                     'refno = :refno';  // and descr = :descr';
         ParamByName('ncreditor').AsInteger := ACreditor;
         ParamByName('refno').AsString := AOrderID;
//         ParamByName('descr').AsString := ADescr;
         Open;
         InsightiTrackWatcher.WriteLog('checking existence of invoice - Creditror: '+ IntToStr(ACreditor) +' REFNO:'+ AOrderID);
         if (EOF = True) then
         begin
            TaxCode := 'GST';
            glComponentSetup := InsightiTrackWatcher.getGlComponents;

            try
//               if InsightiTrackWatcher.uniInsight.InTransaction then
//                  InsightiTrackWatcher.uniInsight.Rollback;
//               InsightiTrackWatcher.uniInsight.StartTransaction;
               if not qryAccount.Modified then
                  qryAccount.Edit;

               iNINVOICE := InsightiTrackWatcher.GetSequenceNumber('sqnc_ninvoice');    //  GetSeqNum('NINVOICE');
               InsightiTrackWatcher.Writelog('New Ninvoice ' + IntToStr(iNINVOICE));
               qryAccount.FieldByName('ACCT').AsString := InsightiTrackWatcher.Entity;
               qryAccount.FieldByName('TYPE').AsString := 'IV';
               qryAccount.FieldByName('CREDITOR').AsString := InsightiTrackWatcher.TableString('PHONEBOOK', 'NCREDITOR', IntToStr(ACreditor), 'NAME');
               qryAccount.FieldByName('AMOUNT').AsFloat := ATotalAmt + ATax;
               qryAccount.FieldByName('TAX').AsFloat := ATax;
               qryAccount.FieldByName('CREDITED').AsFloat := ATotalAmt;
               qryAccount.FieldByName('REFNO').AsString := AOrderID;
               qryAccount.FieldByName('DESCR').AsString := ADescr;
               qryAccount.FieldByName('INVOICE_DATE').AsDateTime := ACreated;
               qryAccount.FieldByName('DUE_DATE').AsDateTime := ACreated + 30;
               qryAccount.FieldByName('PAY_DATE').AsDateTime := ACreated + 30;
               qryAccount.FieldByName('NCREDITOR').AsInteger := ACreditor;

               qryAccount.FieldByName('HOLD').AsString := InsightiTrackWatcher.TableString('CREDITOR', 'NCREDITOR', qryAccount.FieldByName('NCREDITOR').AsString, 'HOLD');

               qryAccount.FieldByName('NINVOICE').AsInteger := iNINVOICE;
               qryAccount.FieldByName('OWING').AsFloat := ATotalAmt + ATax;

               qryAccount.Post; // Puts Account into cached buffer

               sLedgerCode := InsightiTrackWatcher.TableStringEntity('CREDITOR', 'NCREDITOR', qryAccount.FieldByName('NCREDITOR').AsInteger, 'CHART', InsightiTrackWatcher.Entity);
               if (InsightiTrackWatcher.ValidLedger(InsightiTrackWatcher.Entity, sLedgerCode) = False) then
                  sLedgerCode := InsightiTrackWatcher.TableString('ENTITY', 'CODE', InsightiTrackWatcher.Entity, 'CREDITORS');

               sLegalCode := InsightiTrackWatcher.TableString('ENTITY', 'CODE', InsightiTrackWatcher.Entity, 'NEW_UPCRED_DR');
               sCreditorCode := InsightiTrackWatcher.TableString('CREDITOR', 'NCREDITOR', qryAccount.FieldByName('NCREDITOR').AsString, 'CODE');

              // Initialise the totals for legal (matter) and ledger (trade) creditors amount
               cMatterTotal := 0;
               cTradeTotal  := 0;

               nmatter := AMATTER;
               if (ASupplierFee <> 0) then
               begin
                   qryAllocs.Insert;
                   dAllocSupplier := InsightiTrackWatcher.GetSequenceNumber('sqnc_nalloc');   //  GetSeqnum('NALLOC');
                   InsightiTrackWatcher.Writelog('New NAlloc ' + IntToStr(dAllocSupplier));
                   qryAllocs.FieldByName('NALLOC').AsInteger := dAllocSupplier;
                   qryAllocs.FieldByName('NMATTER').AsInteger := nmatter;
                   qryAllocs.FieldByName('NCLIENT').AsInteger := InsightiTrackWatcher.TableInteger('MATTER', 'NMATTER', IntToStr(AMatter), 'NCLIENT');
                   qryAllocs.FieldByName('FILEID').AsString := AFileID;
                   qryAllocs.FieldByName('DESCR').AsString := ADescr;
                   qryAllocs.FieldByName('CLIENT_NAME').AsString := InsightiTrackWatcher.MatterString(AMatter, 'TITLE');
                   qryAllocs.FieldByName('MATTER_DESC').AsString := InsightiTrackWatcher.MatterString(AMatter, 'SHORTDESCR');
                   qryAllocs.FieldByName('OVERDRAWN').AsString := 'N';
                   qryAllocs.FieldByName('SYSTEM_DATE').AsDateTime := Date;
                   qryAllocs.FieldByName('PAYER').AsString := qryAccount.FieldByName('CREDITOR').AsString;
                   qryAllocs.FieldByName('ACCT').AsString := InsightiTrackWatcher.Entity;
                   qryAllocs.FieldByName('TYPE').AsString := qryAccount.FieldByName('TYPE').AsString;
                   qryAllocs.FieldByName('NINVOICE').AsInteger := iNINVOICE;
                   qryAllocs.FieldByName('REFNO').AsString := qryAccount.FieldByName('REFNO').AsString;
                   qryAllocs.FieldByName('BILLED').AsString := 'N';
                   qryAllocs.FieldByName('TRUST').AsString := 'G';
                   qryAllocs.FieldByName('AMOUNT').AsFloat := 0 - (ASupplierFee);
                   qryAllocs.FieldByName('UPCRED').AsFloat :=  (ASupplierFee);
                   qryAllocs.FieldByName('TAX').AsFloat := 0 - ASupplierFeeGST;
                   if (ASupplierFeeGST = 0) then
                      qryAllocs.FieldByName('TAXCODE').AsString := 'FREE'
                   else
                      qryAllocs.FieldByName('TAXCODE').AsString := TaxCode;
                   qryAllocs.FieldByName('CREATED').AsDateTime := Now;
    //               qryAllocs.FieldByName('SUNDRYTYPE').AsString := qryLedger.FieldByName('SUNDRYTYPE').AsString;;   // not sure what to do about this

                   qryAllocs.Post;  // Put it into the cached bufer
               end;
               if (ARetailerFee <> 0) then
               begin
                  qryAllocs.Insert;
                  dAllocRetailer := InsightiTrackWatcher.GetSequenceNumber('sqnc_nalloc');
                  InsightiTrackWatcher.Writelog('New NAlloc ' + IntToStr(dAllocRetailer));   //   GetSeqnum('NALLOC');
                  qryAllocs.FieldByName('NALLOC').AsInteger := dAllocRetailer;
                  qryAllocs.FieldByName('NMATTER').AsInteger := nmatter;
                  qryAllocs.FieldByName('NCLIENT').AsInteger := InsightiTrackWatcher.TableInteger('MATTER', 'NMATTER', IntToStr(AMatter), 'NCLIENT');
                  qryAllocs.FieldByName('FILEID').AsString := AFileID;
                  qryAllocs.FieldByName('DESCR').AsString := ADescr;
                  qryAllocs.FieldByName('CLIENT_NAME').AsString := InsightiTrackWatcher.MatterString(AMatter, 'TITLE');
                  qryAllocs.FieldByName('MATTER_DESC').AsString := InsightiTrackWatcher.MatterString(AMatter, 'SHORTDESCR');
                  qryAllocs.FieldByName('OVERDRAWN').AsString := 'N';
                  qryAllocs.FieldByName('SYSTEM_DATE').AsDateTime := Date;
                  qryAllocs.FieldByName('PAYER').AsString := qryAccount.FieldByName('CREDITOR').AsString;
                  qryAllocs.FieldByName('ACCT').AsString := InsightiTrackWatcher.Entity;
                  qryAllocs.FieldByName('TYPE').AsString := qryAccount.FieldByName('TYPE').AsString;
                  qryAllocs.FieldByName('NINVOICE').AsInteger := iNINVOICE;
                  qryAllocs.FieldByName('REFNO').AsString := qryAccount.FieldByName('REFNO').AsString;
                  qryAllocs.FieldByName('BILLED').AsString := 'N';
                  qryAllocs.FieldByName('TRUST').AsString := 'G';
                  qryAllocs.FieldByName('AMOUNT').AsFloat := 0 - (ARetailerFee);
                  qryAllocs.FieldByName('UPCRED').AsFloat :=  (ARetailerFee);
                  qryAllocs.FieldByName('TAX').AsFloat := 0 - ARetailerFeeGST;
                  if (ARetailerFeeGST = 0) then
                     qryAllocs.FieldByName('TAXCODE').AsString := 'FREE'
                  else
                     qryAllocs.FieldByName('TAXCODE').AsString := TaxCode;
                  qryAllocs.FieldByName('CREATED').AsDateTime := Now;
    //               qryAllocs.FieldByName('SUNDRYTYPE').AsString := qryLedger.FieldByName('SUNDRYTYPE').AsString;;   // not sure what to do about this

                  qryAllocs.Post;  // Put it into the cached bufer
               end;
               // Now make the General Ledger entry
               cAccTotal := 0 - ATotalAmt;
               cAccTax := 0 - ATax;

               if (ASupplierFee <> 0) then
               begin
                  if (ASupplierFeeGST <> 0) then
                     TaxCode := 'GST'
                  else
                     TaxCode := 'FREE';
                   {post components}
                  sLedgerKey :=  glComponentSetup.buildLedgerKey('',InsightiTrackWatcher.TableString('ENTITY', 'CODE', InsightiTrackWatcher.Entity, 'NEW_UPCRED_CR'),'',true,'');

                  InsightiTrackWatcher.PostLedger(qryAccount.FieldByName('INVOICE_DATE').AsDateTime
                     , (0 - ASupplierFee)
                     , (0 - ASupplierFeeGST)
                     , qryAccount.FieldByName('REFNO').AsString
                     , 'INVOICE'
                     , qryAccount.FieldByName('NINVOICE').AsInteger
                     , ADescr
                     , sLedgerKey
                     , ''
                     , qryAccount.FieldByName('NINVOICE').AsInteger
                     , sCreditorCode
                     , TaxCode //);
                     , FALSE   // bJournalSplit: Default to False
                     , '0'     // sParentChart: Default to '0'
                     , dAllocSupplier     // nalloc
                     , nmatter);  // nmatter
                end;

               if (ARetailerFee <> 0) then
               begin
                  if (ARetailerFeeGST <> 0) then
                      TaxCode := 'GST'
                  else
                      TaxCode := 'FREE';
                   {post components}
                  sLedgerKey :=  glComponentSetup.buildLedgerKey('',InsightiTrackWatcher.TableString('ENTITY', 'CODE', InsightiTrackWatcher.Entity, 'NEW_UPCRED_CR'),'',true,'');

                  InsightiTrackWatcher.PostLedger(qryAccount.FieldByName('INVOICE_DATE').AsDateTime
                     , (0 - ARetailerFee)
                     , (0 - ARetailerFeeGST)
                     , qryAccount.FieldByName('REFNO').AsString
                     , 'INVOICE'
                     , qryAccount.FieldByName('NINVOICE').AsInteger
                     , ADescr
                     , sLedgerKey
                     , ''
                     , qryAccount.FieldByName('NINVOICE').AsInteger
                     , sCreditorCode
                     , TaxCode //);
                     , FALSE   // bJournalSplit: Default to False
                     , '0'     // sParentChart: Default to '0'
                     , dAllocRetailer     // nalloc
                     , nmatter);  // nmatter
                end;
               // Total the legal creditor amount
               cMatterTotal := cMatterTotal + (ATotalAmt + ATax);

               if (ATax <> 0) then
               begin
                  TaxCode := 'GST';
                  {post components}
                  sLedgerKey :=  glComponentSetup.buildLedgerKey('',InsightiTrackWatcher.TableString('TAXTYPE', 'CODE', TAXCODE, 'LEDGER'),'',true,'');

                  InsightiTrackWatcher.PostLedger(qryAccount.FieldByName('INVOICE_DATE').AsDateTime
                     , 0 - ATax
                     , 0
                     , qryAccount.FieldByName('REFNO').AsString
                     , 'INVOICE'
                     , qryAccount.FieldByName('NINVOICE').AsInteger
                     , ADescr
                     , sLedgerKey
                     , ''
                     , qryAccount.FieldByName('NINVOICE').AsInteger
                     , sCreditorCode
                     , TaxCode //)
                     , FALSE   // bJournalSplit: Default to False
                     , '0'     // sParentChart: Default to '0'
                     , dAllocRetailer                        // nalloc
                     , nmatter);                                   // nmatter
               end;

              {post components}
               sLedgerKey :=  glComponentSetup.buildLedgerKey('',sLegalCode,'',true,'');

               // Create Creditor Control Entry
               InsightiTrackWatcher.PostLedger(qryAccount.FieldByName('INVOICE_DATE').AsDateTime
                  , cMatterTotal
                  , 0
                  , qryAccount.FieldByName('REFNO').AsString, 'INVOICE'
                  , qryAccount.FieldByName('NINVOICE').AsInteger
                  , qryAccount.FieldByName('DESCR').AsString
                  , sLedgerKey
                  , ''
                  , qryAccount.FieldByName('NINVOICE').AsInteger
                  , sCreditorCode
                  , TaxCode );

               {post components}
{               sLedgerKey :=  glComponentSetup.buildLedgerKey('',sLedgerCode,'',true,'');

               InsightiTrackWatcher.PostLedger(qryAccount.FieldByName('INVOICE_DATE').AsDateTime
                  , cTradeTotal
                  , 0
                  , qryAccount.FieldByName('REFNO').AsString, 'INVOICE'
                  , qryAccount.FieldByName('NINVOICE').AsInteger
                  , qryAccount.FieldByName('DESCR').AsString
                  , sLedgerKey
                  , ''
                  , qryAccount.FieldByName('NINVOICE').AsInteger
                  , sCreditorCode
                  , TaxCode);      }

               if qryAccount.UpdatesPending then
                  qryAccount.ApplyUpdates;

               if qryAllocs.UpdatesPending then
                  qryAllocs.ApplyUpdates;

//               CheckLedgerTotal;

//               InsightiTrackWatcher.uniInsight.Commit;

              // we need to commit prior to updating the invoice record. cannot update cached record.
               qryUpdateInvoice.ParamByName('LEGAL_CR_AMOUNT').AsFloat := cMatterTotal;
               qryUpdateInvoice.ParamByName('TRADE_CR_AMOUNT').AsFloat := cTradeTotal;
               qryUpdateInvoice.ParamByName('NINVOICE').AsInteger := qryAccount.FieldByName('NINVOICE').AsInteger;
               qryUpdateInvoice.ExecSQL;

            except
               on E: Exception do
               begin
                  InsightiTrackWatcher.uniInsight.Rollback;
                  bPostingFailed := True;
                  if qryAccount.UpdatesPending then
                     qryAccount.CancelUpdates;
                  if qryAllocs.UpdatesPending then
                     qryAllocs.CancelUpdates;
                  InsightiTrackWatcher.uniInsight.Rollback;
               end;
            end;
         end;
      end;
   finally
      InsightiTrackWatcher.qryTmp.Close;
   end;
end;


end.
