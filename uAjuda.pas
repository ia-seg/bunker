unit uAjuda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  Imaging.pngimage, SHELLAPI;

type
  TfrmAjuda = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    btnGeral: TButton;
    btnValidade: TButton;
    btnDatas: TButton;
    btnListaCompras: TButton;
    btnEditandoCompras: TButton;
    btnFinalizandoLista: TButton;
    btnCancelaLista: TButton;
    btnBackup: TButton;
    btnExportar: TButton;
    btnImportar: TButton;
    btnCancelarBackup: TButton;
    btnBuscandoRecurso: TButton;
    btnDetalhesBusca: TButton;
    btnSalvamento: TButton;
    btnFechar: TButton;
    btnSobre: TButton;
    btnImprimir: TButton;
    btnPDF: TButton;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnGeralClick(Sender: TObject);
    procedure btnValidadeClick(Sender: TObject);
    procedure btnDatasClick(Sender: TObject);
    procedure btnListaComprasClick(Sender: TObject);
    procedure btnEditandoComprasClick(Sender: TObject);
    procedure btnFinalizandoListaClick(Sender: TObject);
    procedure btnCancelaListaClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure btnCancelarBackupClick(Sender: TObject);
    procedure btnBuscandoRecursoClick(Sender: TObject);
    procedure btnDetalhesBuscaClick(Sender: TObject);
    procedure btnSalvamentoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnSobreClick(Sender: TObject);
    procedure btnVisitarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAjuda: TfrmAjuda;

implementation

{$R *.dfm}





procedure TfrmAjuda.btnGeralClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_0.png');
Image1.Refresh;
Image1.Update;
end;



procedure TfrmAjuda.btnValidadeClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_1.png');
Image1.Refresh;
Image1.Update;
end;


procedure TfrmAjuda.btnDatasClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_2.png');
Image1.Refresh;
Image1.Update;
end;



procedure TfrmAjuda.btnListaComprasClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_3.png');
Image1.Refresh;
Image1.Update;
end;




procedure TfrmAjuda.btnEditandoComprasClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_4.png');
Image1.Refresh;
Image1.Update;
end;




procedure TfrmAjuda.btnFinalizandoListaClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_5.png');
Image1.Refresh;
Image1.Update;
end;



procedure TfrmAjuda.btnCancelaListaClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_6.png');
Image1.Refresh;
Image1.Update;
end;

procedure TfrmAjuda.btnBackupClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_7.png');
Image1.Refresh;
Image1.Update;
end;


procedure TfrmAjuda.btnImprimirClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_8B.png');
Image1.Refresh;
Image1.Update;
end;


procedure TfrmAjuda.btnExportarClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_8.png');
Image1.Refresh;
Image1.Update;
end;

procedure TfrmAjuda.btnImportarClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_9.png');
Image1.Refresh;
Image1.Update;
end;



procedure TfrmAjuda.btnCancelarBackupClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_10.png');
Image1.Refresh;
Image1.Update;
end;

procedure TfrmAjuda.btnBuscandoRecursoClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_11.png');
Image1.Refresh;
Image1.Update;
end;

procedure TfrmAjuda.btnDetalhesBuscaClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_12.png');
Image1.Refresh;
Image1.Update;
end;

procedure TfrmAjuda.btnSalvamentoClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR_13.png');
Image1.Refresh;
Image1.Update;
end;



procedure TfrmAjuda.btnPDFClick(Sender: TObject);
begin
ShellExecute(handle, 'open', PChar('.\Ajuda\ajuda_Bunker.pdf'),'','',SW_SHOWNORMAL);
end;






procedure TfrmAjuda.btnSobreClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_Sobre.png');
Image1.Refresh;
Image1.Update;

end;



procedure TfrmAjuda.btnVisitarClick(Sender: TObject);
begin
ShellExecute(handle, 'open', PChar('https://www.paralaxe.org'),'','',SW_SHOWNORMAL);
end;





procedure TfrmAjuda.btnFecharClick(Sender: TObject);
begin
Image1.Picture.LoadFromFile('.\Ajuda\Ajuda_PT_BR.png');
Image1.Refresh;
Image1.Update;
Close;
end;


end.
