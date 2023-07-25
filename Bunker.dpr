program Bunker;

uses
  
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uSplash in 'uSplash.pas' {frmSplash},
  uAjuda in 'uAjuda.pas' {frmAjuda},
  uRelatorio in 'uRelatorio.pas' {frmRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Bunker';
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
