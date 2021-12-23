// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program InfoServ;

uses
  Vcl.SvcMgr,
  Main in 'Main.pas' {InsightiTrackWatcher: TService},
  AccountCreate in 'AccountCreate.pas' {dmAccountCreate: TDataModule},
  ServiceManager in 'ServiceManager.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //

//  Application.Free;
//  Application := TDebugServiceApplication.Create(nil);


  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TInsightiTrackWatcher, InsightiTrackWatcher);
  //  InsightiTrackWatcher.ServiceStart(InsightiTrackWatcher, InsightiTrackWatcher.started);
  Application.Run;
end.
