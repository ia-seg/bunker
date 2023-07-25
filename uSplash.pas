unit uSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Imaging.pngimage, Imaging.jpeg;

type
  TfrmSplash = class(TForm)
    Image1: TImage;
    TimerSplash: TTimer;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure TimerSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses uPrincipal;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  TimerSplash.Enabled := True;
end;

procedure TfrmSplash.TimerSplashTimer(Sender: TObject);
begin
  Label1.Caption := ProgressBar1.Position.ToString + '%';
  ProgressBar1.Position := ProgressBar1.Position + 1;
     if ProgressBar1.Position = 100 then
        begin
          TimerSplash.Enabled := False;
          frmPrincipal.ShowModal;
          frmSplash.Close;
          frmSplash.Free;
        end;
end;

end.
