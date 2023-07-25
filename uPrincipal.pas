unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, WinXPickers, System.JSON.Builders, System.JSON.Writers,
  System.JSON.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Grids, DBGrids, System.JSON.Readers, System.DateUtils,
  ComCtrls, FireDAC.Stan.StorageBin, System.Notification, WinXCalendars,
  Imaging.pngimage, ExtCtrls, DBCtrls, Buttons, Web.HTTPApp, SHELLAPI, System.UITypes,
  Web.HTTPProd, Data.FMTBcd, Data.SqlExpr, uAjuda;

type
  TfrmPrincipal = class(TForm)
    edtRecurso: TEdit;
    edtQuantidade: TEdit;
    dpValidade: TDatePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memoJSON: TMemo;
    btnAdicionar: TButton;
    mtSuprimentos: TFDMemTable;
    mtSuprimentosRecurso: TStringField;
    mtSuprimentosQuantidade: TIntegerField;
    mtSuprimentosValidade: TDateField;
    dbgImportados: TDBGrid;
    btnImportar: TButton;
    DataSource1: TDataSource;
    btnChecarValidade: TButton;
    MemoVencidos: TMemo;
    lblVencidos: TLabel;
    NotificationCenter1: TNotificationCenter;
    btnAgendar: TButton;
    CalendarView1: TCalendarView;
    memoDatas: TMemo;
    btnFechar: TButton;
    btnAlterar: TButton;
    btnApagar: TButton;
    btnExportar: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    pnlEdicao: TPanel;
    btnBackup: TButton;
    btnCompras: TButton;
    Timer1: TTimer;
    memoCompras: TMemo;
    btnListaCompras: TButton;
    lblListaCompras: TLabel;
    btnCancelaLista: TButton;
    btnListaAnterior: TButton;
    Image1: TImage;
    resumoMemTable: TFDMemTable;
    sbtnVerificar: TSpeedButton;
    DataSource2: TDataSource;
    dbgBusca: TDBGrid;
    resumoMemTableRecurso: TStringField;
    resumoMemTableQuantidade: TIntegerField;
    resumoMemTableValidade: TDateTimeField;
    lblTotalRecurso: TLabel;
    edtBusca: TEdit;
    pnlTopo: TPanel;
    imgAjuda: TImage;
    Panel1: TPanel;
    btnFecharPesquisa: TButton;
    imgBusca: TImage;
    btnCancelarBkp: TButton;
    btnImprimir: TButton;
    SpeedButton1: TSpeedButton;

    procedure dpValidadeCloseUp(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure dbgImportadosTitleClick(Column: TColumn);
    procedure dbgImportadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnChecarValidadeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgImportadosCellClick(Column: TColumn);
    procedure btnAgendarClick(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure CalendarView1DrawDayItem(Sender: TObject;
      DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnComprasClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnListaComprasClick(Sender: TObject);
    procedure btnCancelaListaClick(Sender: TObject);
    procedure btnListaAnteriorClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure sbtnVerificarClick(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure dbgBuscaCellClick(Column: TColumn);
    procedure btnFecharPesquisaClick(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure imgBuscaClick(Sender: TObject);
    procedure dbgBuscaDblClick(Sender: TObject);
    procedure dbgBuscaTitleClick(Column: TColumn);
    procedure btnCancelarBkpClick(Sender: TObject);
    procedure imgAjudaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
    vencidos :String;
    datando : String;
    datasVencidas : String;
    alterar : String;
    algumVencido : Boolean;


  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uRelatorio, uSplash;

procedure TfrmPrincipal.btnAdicionarClick(Sender: TObject);
var
LJSONWritter: TJsonTextWriter;


begin
  if ((Trim(edtRecurso.Text))<>'') and ((Trim(edtQuantidade.Text))<>'0')  then
  begin


  if not (mtSuprimentos.Active) then

  mtSuprimentos.Open;
  mtSuprimentos.Append;
  mtSuprimentosRecurso.AsString := edtRecurso.Text;
  mtSuprimentosQuantidade.AsString := edtQuantidade.Text;
  mtSuprimentosValidade.AsString := FormatDateTime('dd/MM/yyyy', dpValidade.Date); 
  mtSuprimentos.Post;

  edtRecurso.Clear;
  edtQuantidade.Clear;
  edtRecurso.SetFocus;


   LJSONWritter := TJsonTextWriter.Create(TStringWriter.Create, True);
    try
       mtSuprimentos.Open;
       mtSuprimentos.First;
       LJSONWritter.WriteStartObject;
       LJSONWritter.WritePropertyName('Abrigo');
       LJSONWritter.WriteStartArray; 
       while not mtSuprimentos.Eof do 
       begin
         LJSONWritter.WriteStartObject;   
              LJSONWritter.WritePropertyName('Recurso');
              LJSONWritter.WriteValue(mtSuprimentosRecurso.AsString);
              LJSONWritter.WritePropertyName('Quantidade');
              LJSONWritter.WriteValue(mtSuprimentosQuantidade.AsInteger);
              LJSONWritter.WritePropertyName('Validade');
              LJSONWritter.WriteValue(FormatDateTime('dd/MM/yyyy', mtSuprimentosValidade.AsDateTime));

         LJSONWritter.WriteEndObject;
         mtSuprimentos.Next;
       end;
       LJSONWritter.WriteEndArray;
       LJSONWritter.WriteEndObject; 
       memoJSON.Text := LJSONWritter.Writer.ToString;
       memoJSON.Lines.SaveToFile('.\suprimentos.txt');   
    Finally
      LJSONWritter.Free;

    End;
  end;
end;

 
procedure TfrmPrincipal.btnAgendarClick(Sender: TObject);
 var
  MyNotification: TNotification;

begin
    MyNotification := NotificationCenter1.CreateNotification;
      try
         MyNotification.Name := 'ValidadeNotification';
         MyNotification.Title := 'ALERTA BUNKER!!!';
         MyNotification.AlertBody := 'Revise a data de validade ou manuten  o de seus suprimentos';



         NotificationCenter1.ScheduleNotification(MyNotification); 
        
      finally
         MyNotification.Free;
      end;
end;


procedure TfrmPrincipal.btnAlterarClick(Sender: TObject);
var
LJSONWritter: TJsonTextWriter;

begin
  if ((Trim(edtRecurso.Text))<>'') and ((Trim(edtQuantidade.Text))<>'0')  then
  begin


  if not (mtSuprimentos.Active) then
  mtSuprimentos.Open;
  mtSuprimentos.Delete; 
  mtSuprimentos.Append;
  mtSuprimentosRecurso.AsString := edtRecurso.Text;
  mtSuprimentosQuantidade.AsString := edtQuantidade.Text;
  mtSuprimentosValidade.AsString := FormatDateTime('dd/MM/yyyy', dpValidade.Date); 
  mtSuprimentos.Post;
  edtRecurso.Clear;
  edtQuantidade.Clear;
  edtRecurso.SetFocus;


   LJSONWritter := TJsonTextWriter.Create(TStringWriter.Create, True);
    try
       mtSuprimentos.Open;
       mtSuprimentos.First;
       LJSONWritter.WriteStartObject;
       LJSONWritter.WritePropertyName('Abrigo');
       LJSONWritter.WriteStartArray;
       while not mtSuprimentos.Eof do 
       begin
         LJSONWritter.WriteStartObject;  
              LJSONWritter.WritePropertyName('Recurso');
              LJSONWritter.WriteValue(mtSuprimentosRecurso.AsString);
              LJSONWritter.WritePropertyName('Quantidade');
              LJSONWritter.WriteValue(mtSuprimentosQuantidade.AsInteger);
              LJSONWritter.WritePropertyName('Validade');
              LJSONWritter.WriteValue(FormatDateTime('dd/MM/yyyy', mtSuprimentosValidade.AsDateTime));

         LJSONWritter.WriteEndObject; 
         mtSuprimentos.Next;
       end;
       LJSONWritter.WriteEndArray;
       LJSONWritter.WriteEndObject; 
       memoJSON.Text := LJSONWritter.Writer.ToString;
       memoJSON.Lines.SaveToFile('.\suprimentos.txt'); 
    Finally
      LJSONWritter.Free;
      dbgImportados.DataSource.DataSet.First;
    End;
  end;
end;




procedure TfrmPrincipal.btnApagarClick(Sender: TObject);
var
LJSONWritter: TJsonTextWriter; 
 begin
   if ((Trim(edtRecurso.Text))<>'') and ((Trim(edtQuantidade.Text))<>'0')  then
    begin


    if MessageDlg('Confirma a exclus o?', mtConfirmation,[mbYes, mbNo],0) = mrYes then
      begin





        if not (mtSuprimentos.Active) then
         mtSuprimentos.Open;
         mtSuprimentos.Delete;  // deleta a linha selecionada
         mtSuprimentos.ApplyUpdates(-1);


         edtRecurso.Clear;
         edtQuantidade.Clear;
         edtRecurso.SetFocus;

   
         LJSONWritter := TJsonTextWriter.Create(TStringWriter.Create, True);
       try
       mtSuprimentos.Open;
       mtSuprimentos.First;
       LJSONWritter.WriteStartObject;
       LJSONWritter.WritePropertyName('Abrigo');
       LJSONWritter.WriteStartArray;
          while not mtSuprimentos.Eof do
          begin
              LJSONWritter.WriteStartObject; 
              LJSONWritter.WritePropertyName('Recurso');
              LJSONWritter.WriteValue(mtSuprimentosRecurso.AsString);
              LJSONWritter.WritePropertyName('Quantidade');
              LJSONWritter.WriteValue(mtSuprimentosQuantidade.AsInteger);
              LJSONWritter.WritePropertyName('Validade');
              LJSONWritter.WriteValue(FormatDateTime('dd/MM/yyyy', mtSuprimentosValidade.AsDateTime));

              LJSONWritter.WriteEndObject; 
              mtSuprimentos.Next;
          end;
       LJSONWritter.WriteEndArray; 
       LJSONWritter.WriteEndObject; 
       memoJSON.Text := LJSONWritter.Writer.ToString;
       memoJSON.Lines.SaveToFile('.\suprimentos.txt');   
      Finally
      LJSONWritter.Free;
      End;

   end;
  end;


end;

   procedure TfrmPrincipal.btnBackupClick(Sender: TObject);
begin


              if MessageDlg(' BOA DECIS O ' +#13+#13+#13+
               'Os bot es Importar e Exportar foram habilitados!' +#13+#13+ '-------> ANTES DE IMPORTAR DADOS <-------' +#13+#13+
                'Lembre-se de fazer um backup: ' +#13+ '---> Exporte os dados j  cadastrados' +#13+ '---> Salve o arquivo em um local seguro' +#13+
                '---> N o altere o nome original do arquivo' , mtWarning, [mbOk],0) = mrOk then
               begin

                  btnImportar.Visible := True;
                  btnExportar.Visible := True;
                  btnCancelarBkp.Visible := True;
                  btnImprimir.Visible := True;
                  btnBackup.Visible := False;
                  btnListaCompras.Visible := False;

               end;

end;


procedure TfrmPrincipal.btnCancelaListaClick(Sender: TObject);
begin

  memoCompras.Visible := False;
  lblListaCompras.Visible := False;
  btnCompras.Visible := False;
  btnCancelaLista.Visible := False;
    btnListaAnterior.Visible := False;
  btnBackup.Visible := True;
  btnFechar.Visible := True;
  btnListaCompras.Visible := True;


end;



procedure TfrmPrincipal.btnCancelarBkpClick(Sender: TObject);
begin
     btnListaCompras.Visible := True;
     btnExportar.Visible := False;
     btnBackup.Visible := True;
     btnImportar.Visible := False;
     btnCancelarBkp.Visible := False;
     btnImprimir.Visible := False;
end;


procedure TfrmPrincipal.btnChecarValidadeClick(Sender: TObject);


 begin


  if algumVencido then

          begin
              if not(mtSuprimentos.IsEmpty) then
                begin
                     Timer1.Interval := 30000;

                  if MessageDlg(' ATEN  O! INTEGRIDADE DOS RECURSOS EM RISCO! ' +#13+#13+#13+
                   'Verifique os  tens com a data destacada em amarelo.' +#13+#13+ '---> CONSUMA OU FA A A MANUTEN  O <---' +#13+#13+
                    'Depois: ' +#13+ '-> Clique no  tem destacado na lista' +#13+ '-> Altere a data no campo de edi  o' +#13+
                    '-> Use o bot o "Alterar" para confirmar' , mtWarning, [mbOk],0) = mrOk then
                   begin
                      Timer1.Enabled := False;
                      MemoVencidos.Lines.Text := vencidos;

                      lblVencidos.Visible := True;
                      lblVencidos.Caption := 'Consumir ou Manutenir  tens destacados em amarelo';

                      vencidos := '';

                      dbgImportados.DataSource.DataSet.RecNo := 0; 

                      mtSuprimentos.IndexFieldNames := 'Validade'; 
                      dbgImportados.DataSource.DataSet.First; 
                   end;

                end;

         end;



                  CalendarView1.Date := Now;

   end;



 procedure TfrmPrincipal.btnComprasClick(Sender: TObject);
 var
 HTML : TStringList;

 P : Integer;

begin

  memoCompras.Visible := False;
  lblListaCompras.Visible := False;
  btnCompras.Visible := False;
  btnCancelaLista.Visible := False;
  btnListaAnterior.Visible := False;
  btnBackup.Visible := True;
  btnFechar.Visible := True;
  btnListaCompras.Visible := True;




HTML := TStringList.Create;
HTML.Add(' <!DOCTYPE html>');

HTML.Add('<html lang="pt-br">');

HTML.Add('<head>');
HTML.Add('<meta charset="UTF-8">');
HTML.Add('<title>BUNKER - Lista de Compras</title>');
HTML.Add('<style type="text/css">');


HTML.Add('        * {');
HTML.Add('            padding: 0;');
HTML.Add('            margin: 0;');
HTML.Add('        }');

HTML.Add('label {');

HTML.Add('    font-size: medium;');
HTML.Add('    margin-left: 5px;');
HTML.Add('    padding: 3px;');
HTML.Add('}');


HTML.Add('ul, ol {');
HTML.Add('    padding: 5px;');
HTML.Add('    font-size: medium;');
HTML.Add('}');

HTML.Add('li {');
HTML.Add('    margin-left: 5px;');
HTML.Add('    font-size: medium;');
HTML.Add('    padding: 5px;');
HTML.Add('}');

HTML.Add('.tag {');
HTML.Add('    border: solid 0px;');
HTML.Add('    margin: 0px;');
HTML.Add('}');

HTML.Add('.tag label {');
HTML.Add('    color: rgb(173, 24, 24);');
HTML.Add('    font-size: 25px;');
HTML.Add('    vertical-align: top;');
HTML.Add('    margin-right: 0px;');
HTML.Add('    padding: 0px 0px 3px 3px;');
HTML.Add('}');

HTML.Add('        header {');
HTML.Add('            font-family: Impact, Haettenschweiler, "Arial Narrow Bold", sans-serif;');
HTML.Add('            grid-area: cabecalho;');
HTML.Add('            background-Color: #050400;');
HTML.Add('            font-style: normal;');
HTML.Add('            color: lawngreen;');
HTML.Add('            font-weight: Bold;');
HTML.Add('            font-stretch: expanded;');
HTML.Add('            padding: 20px;');
HTML.Add('        }');

HTML.Add('        nav {');
HTML.Add('            grid-area: navegacao;');
HTML.Add('            background-Color: #504015;');
HTML.Add('            color: #FFFFFF;');
HTML.Add('            padding: 20px;');
HTML.Add('        }');

HTML.Add('        main {');
HTML.Add('            grid-area: conteudo;');
HTML.Add('            background-Color: #dddab0;');
HTML.Add('            font-size: medium;');
HTML.Add('            padding: 20px;');

HTML.Add('        }');

HTML.Add('        footer {');
HTML.Add('            grid-area: rodape;');
HTML.Add('            background-Color: #050400;');
HTML.Add('            padding: 20px;');
HTML.Add('            color: #FFFFFF;');
HTML.Add('            font-size: small;');
HTML.Add('            padding: 20px;');
HTML.Add('        }');

HTML.Add('        body {');
HTML.Add('            padding: 0;');
HTML.Add('            font-size: 40px;');
HTML.Add('            display: grid;');
HTML.Add('            min-height: 100vh;');
HTML.Add('            grid-template-columns: 300px 1fr;');
HTML.Add('            grid-template-rows: 100px 1fr 100px;');
HTML.Add('            grid-template-areas:');
HTML.Add('                "cabecalho cabecalho"');
HTML.Add('                "navegacao conteudo"');
HTML.Add('                "rodape rodape";');
HTML.Add('        }');

 // ---------------      INSERIDO FORMATAR IMAGEM
HTML.Add('        img {');
HTML.Add('            width: 48px;');
HTML.Add('            height: 48px;');
HTML.Add('        }');

HTML.Add('        img, p {');
HTML.Add('            display: inline-block;');
HTML.Add('        }');

 // -------------       INSERIDO FORMATAR IMAGEM

HTML.Add('        a:link {');
HTML.Add('            text-decoration: none;');
HTML.Add('        }');

HTML.Add('        @media(max-width: 700px) {');
HTML.Add('            body {');
HTML.Add('                grid-template-columns: 1fr;');
HTML.Add('                grid-template-rows: 80px 1fr 100px;');
HTML.Add('                grid-template-areas: "navegacao" "conteudo" "rodape";');
HTML.Add('            }');

HTML.Add('            header { display: none; }');
HTML.Add('        }');
HTML.Add('    </style>');
HTML.Add('</head>');

HTML.Add('<body>');


HTML.Add('    <main class="tag">Para o Bunker:</main>');
HTML.Add('    <main>');
HTML.Add('    <ol>');

  for P := 0 to memoCompras.Lines.Count -1 do
    begin


     HTML.Add('    <li><input type = "checkbox" id="'+memoCompras.Lines[P]+'" name="'+memoCompras.Lines[P]+'"><label for = "'+memoCompras.Lines[P]+'">'+memoCompras.Lines[P]+'</label></li>');


    end;

HTML.Add('    </ol>');
HTML.Add('    </main>');

HTML.Add('    <header class="tag">BUNKER</header>');
HTML.Add('    <footer class="tag">www.ia.seg.br</a></footer>');
HTML.Add('    <nav class="tag">');
HTML.Add('    <img src="LogoBUNKER48PXbco.png">');
HTML.Add('    <p>Comprar Suprimentos</p>');
HTML.Add('    </nav>');


HTML.Add('    <script>const colors = {');
HTML.Add('        p: "#050400",');
HTML.Add('        div: "#050400",');
HTML.Add('        span: "#e53935",');
HTML.Add('        section: "#f67809",');
HTML.Add('        ul: "#5e35b1",');
HTML.Add('        ol: "#fbc02d",');
HTML.Add('        header: "#050400",');
HTML.Add('        nav: "#504015",');
HTML.Add('        main: "#dddab0",');
HTML.Add('        footer: "#050400",');
HTML.Add('        form: "#dddab0",');
HTML.Add('        body: "#dddab0",');
HTML.Add('        padrao: "#616161",');
HTML.Add('        get(tag) {');
HTML.Add('            return this[tag] ? this[tag] : this.padrao');
HTML.Add('        }');
HTML.Add('    }');

HTML.Add('    document.querySelectorAll(".tag").forEach(elemento => {');
HTML.Add('       const tagName = elemento.tagName.toLowerCase()');

HTML.Add('        elemento.style.borderColor = colors.get(tagName)');

HTML.Add('        if (!elemento.classList.contains("nolabel")) {');

HTML.Add('        }');
HTML.Add('    })</script>');
HTML.Add('</body>');

HTML.Add('</html>');
HTML.SaveToFile('.\comprar.htm', TEncoding.UTF8); 
HTML.Free;

ShellExecute(handle, 'open', PChar('.\comprar.htm'),'','',SW_SHOWNORMAL);

end;


   procedure TfrmPrincipal.btnExportarClick(Sender: TObject);
begin

   ShowMessage('ATEN  O! - N o altere o nome ou extens o do arquivo');
   if SaveDialog1.Execute then

     memoJSON.Lines.SaveToFile(SaveDialog1.FileName);
     btnListaCompras.Visible := True;
     btnExportar.Visible := False;
     btnBackup.Visible := True;
     btnImportar.Visible := False;
     btnCancelarBkp.Visible := False;
     btnImprimir.Visible := False;

end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
 Application.Terminate;

end;


procedure TfrmPrincipal.btnFecharPesquisaClick(Sender: TObject);
begin
  btnListaCompras.Visible := True;
  btnBackup.Visible := True;
  btnFechar.Visible := True;
  btnAdicionar.Visible := True;
  btnAlterar.Visible := True;
  btnApagar.Visible := True;
  btnFecharPesquisa.Visible := False;
  lblTotalRecurso.Visible := False;
  dbgBusca.Visible := False;
  edtBusca.Clear;
  imgBusca.Visible := True;
  sbtnVerificar.Visible := False;
  edtBusca.Visible := False;
  lblVencidos.Caption := 'Aten  o!!! Itens vencidos ou precisando de manuten  o!';
  lblVencidos.Visible := False;
end;


procedure TfrmPrincipal.btnImportarClick(Sender: TObject);

var
arquivo : TextFile;
linhasArq: String;
LJSONTextReader: TJsonTextReader;
LStringReader: TStringReader;
LField: TField;
LJSONWritter: TJsonTextWriter;
begin

   ShowMessage('ATEN  O! - N o altere o nome ou extens o do arquivo');
   if OpenDialog1.Execute then
   begin




     memoJSON.Clear;

 

   AssignFile(arquivo,(OpenDialog1.FileName)); 
   Reset (arquivo);
   while not (Eof(arquivo)) do 
     begin
       ReadLn(arquivo, linhasArq);
       memoJSON.Lines.Add(linhasArq);
     end;

     CloseFile(arquivo); 



   LStringReader := TStringReader.Create(memoJSON.Text);  
   LJSONTextReader := TJsonTextReader.Create(LStringReader);
   try
      mtSuprimentos.Close; 
      mtSuprimentos.Open;
      while LJSONTextReader.TokenType <> TJsonToken.StartArray  do 
       LJSONTextReader.Read;
         while LJSONTextReader.Read do
         begin
           case LJSONTextReader.TokenType of
              TJsonToken.StartObject:
                mtSuprimentos.Append;
              TJsonToken.PropertyName:
              begin
                 for LField in mtSuprimentos.Fields do
                 begin
                    if LJSONTextReader.Value.AsString.Equals(LField.FieldName) then     
                      begin
                          LJSONTextReader.Read;
                           case LField.DataType of 
                             ftString:
                               LField.AsString := LJSONTextReader.Value.AsString ;
                             ftInteger:
                               LField.AsInteger := LJSONTextReader.Value.AsInteger ;
                             ftDate:
                               LField.AsString := LJSONTextReader.Value.AsString ;

                           end;
                           Break;
                      end;
                 end;

              end;
              TJsonToken.EndObject:
                mtSuprimentos.Post;
              TJsonToken.EndArray:
                Break;
           end;
         end;
   finally
     LJSONTextReader.Free;
     LStringReader.Free;
     btnListaCompras.Visible := True;
     btnExportar.Visible := False;
     btnBackup.Visible := True;
     btnCancelarBkp.Visible := False;
     btnImportar.Visible := False;
     btnImprimir.Visible := False;
     end;



   

      if not (mtSuprimentos.Active) then
       mtSuprimentos.Open;
       mtSuprimentos.ApplyUpdates(-1);


 
     edtRecurso.Clear;
     edtQuantidade.Clear;
     edtRecurso.SetFocus;


   LJSONWritter := TJsonTextWriter.Create(TStringWriter.Create, True);
    try
       mtSuprimentos.Open;
       mtSuprimentos.First;
       LJSONWritter.WriteStartObject;
       LJSONWritter.WritePropertyName('Abrigo');
       LJSONWritter.WriteStartArray; 
       while not mtSuprimentos.Eof do 
       begin
         LJSONWritter.WriteStartObject;  
              LJSONWritter.WritePropertyName('Recurso');
              LJSONWritter.WriteValue(mtSuprimentosRecurso.AsString);
              LJSONWritter.WritePropertyName('Quantidade');
              LJSONWritter.WriteValue(mtSuprimentosQuantidade.AsInteger);
              LJSONWritter.WritePropertyName('Validade');
              LJSONWritter.WriteValue(FormatDateTime('dd/MM/yyyy', mtSuprimentosValidade.AsDateTime));

         LJSONWritter.WriteEndObject; 
         mtSuprimentos.Next;
       end;
       LJSONWritter.WriteEndArray; 
       LJSONWritter.WriteEndObject; 
       memoJSON.Text := LJSONWritter.Writer.ToString;
       memoJSON.Lines.SaveToFile('.\suprimentos.txt');   
    Finally
      LJSONWritter.Free;
    End;






    end;

end;



procedure TfrmPrincipal.btnImprimirClick(Sender: TObject);
begin
frmRelatorio := TfrmRelatorio.Create(Self);
frmRelatorio.RLReport1.Preview;
btnImprimir.Visible := False;
end;

procedure TfrmPrincipal.btnListaAnteriorClick(Sender: TObject);

begin

  try

    if not FileExists('.\comprar.htm') then    
      raise Exception.CreateFmt('Sem lista anterior! Crie uma nova Lista de Compras.', ['.\comprar.htm']);

    ShellExecute(handle, 'open', PChar('.\comprar.htm'),'','',SW_SHOWNORMAL); 

       memoCompras.Visible := False;
       lblListaCompras.Visible := False;
       btnCompras.Visible := False;
       btnListaAnterior.Visible := False;
       btnCancelaLista.Visible := False;
       btnBackup.Visible := True;
       btnFechar.Visible := True;
       btnListaCompras.Visible := True;


  except   
       memoCompras.Visible := False;
       lblListaCompras.Visible := False;
       btnCompras.Visible := False;
       btnListaAnterior.Visible := False;
       btnCancelaLista.Visible := False;
       btnBackup.Visible := True;
       btnFechar.Visible := True;
       btnListaCompras.Visible := True;
    ShowMessage('Ops! Problemas ao abrir Lista de Compras anterior.'+#13+#13+ 'Por favor, crie uma nova Lista de Compras.');
  end;
end;

procedure TfrmPrincipal.btnListaComprasClick(Sender: TObject);
begin
  memoCompras.Visible := True;
  lblListaCompras.Visible := True;
  btnCompras.Visible := True;
  btnListaAnterior.Visible := True;
  btnCancelaLista.Visible := True;
  btnBackup.Visible := False;
  btnFechar.Visible := False;
  btnListaCompras.Visible := False;
  memoCompras.Clear;

end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin


end;


procedure TfrmPrincipal.CalendarView1DrawDayItem(Sender: TObject;
  DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
  var
 
  linha: String;
  i: Integer;

  begin

  if not(mtSuprimentos.IsEmpty) then




   begin
      memoDatas.Refresh;

     for i := 0 to memoDatas.Lines.Count -1 do


        begin
          linha := memoDatas.Lines.Strings[i];

           if (CalendarViewViewInfo.Date = StrToDate(linha)) then

            DrawParams.ForegroundColor := clRed;
        end;

  

   end;


 end;


   procedure TfrmPrincipal.DataSource2DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TfrmPrincipal.dbgBuscaCellClick(Column: TColumn);
begin
  dbgBusca.Visible := False;

  edtBusca.Clear;
  lblTotalRecurso.Visible := False;

  btnListaCompras.Visible := True;
  btnBackup.Visible := True;
  btnFechar.Visible := True;
  btnAdicionar.Visible := True;
  btnAlterar.Visible := True;
  btnApagar.Visible := True;
  btnFecharPesquisa.Visible := False;
  edtBusca.Visible := False;
  sbtnVerificar.Visible := False;
  imgBusca.Visible := True;
  lblVencidos.Visible := False;

end;

procedure TfrmPrincipal.dbgBuscaDblClick(Sender: TObject);
begin
  dbgBusca.Visible := False;

  edtBusca.Clear;
  lblTotalRecurso.Visible := False;

  btnListaCompras.Visible := True;
  btnBackup.Visible := True;
  btnFechar.Visible := True;
  btnAdicionar.Visible := True;
  btnAlterar.Visible := True;
  btnApagar.Visible := True;
  btnFecharPesquisa.Visible := False;
  edtBusca.Visible := False;
  sbtnVerificar.Visible := False;
  imgBusca.Visible := True;
  lblVencidos.Visible := False;
end;

procedure TfrmPrincipal.dbgBuscaTitleClick(Column: TColumn);
begin
  dbgBusca.Visible := False;
  edtBusca.Clear;
  lblTotalRecurso.Visible := False;

  btnListaCompras.Visible := True;
  btnBackup.Visible := True;
  btnFechar.Visible := True;
  btnAdicionar.Visible := True;
  btnAlterar.Visible := True;
  btnApagar.Visible := True;
  btnFecharPesquisa.Visible := False;
  imgBusca.Visible := True;
  edtBusca.Visible := False;
  sbtnVerificar.Visible := False;
  lblVencidos.Visible := False;
end;

procedure TfrmPrincipal.dbgImportadosCellClick(Column: TColumn);
  var
  editar : String;
begin

     if not(mtSuprimentos.IsEmpty) then
      begin
       
        lblVencidos.Visible := False;
        editar := dbgImportados.SelectedField.DataSet.FieldByName('Validade').AsString;
        dbgImportados.EditorMode := True;

       
       if not (mtSuprimentos.State in [dsInsert, dsEdit]) then  mtSuprimentos.Edit;
         edtRecurso.Text := mtSuprimentos.FieldByName('Recurso').AsString;
         edtBusca.Text := mtSuprimentos.FieldByName('Recurso').AsString;
         edtQuantidade.Text := mtSuprimentos.FieldByName('Quantidade').AsString;
         dpValidade.Date := mtSuprimentos.FieldByName('Validade').AsDateTime;
         memoCompras.Lines.Append(mtSuprimentos.FieldByName('Recurso').AsString);
      end;

end;


procedure TfrmPrincipal.dbgImportadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    dbgImportados.Canvas.Brush.Color := clWhite;

   if not (gdSelected in State) then       
   begin
       if (( Sender as TDBGrid).DataSource.DataSet.RecNo mod 2 = 0) then
           (Sender as TDBGrid).Canvas.Brush.Color := clWhite
           else
           (Sender as TDBGrid).Canvas.Brush.Color := clWhite;

       (Sender as TDBGrid).Canvas.FillRect(Rect);
       (Sender as TDBGrid).DefaultDrawColumnCell(rect,datacol,column,state);

       if gdSelected in State then
         begin
           (Sender as TDBGrid).Canvas.Brush.Color := clRed;
           (Sender as TDBGrid).Font.Color := clInfoText;
         end;
   end;

    (Sender as TDBGrid).DefaultDrawDataCell(Rect,Column.Field,state);

       
     if (Column.Field.FieldName = 'Validade') then
       begin

         if not(mtSuprimentos.IsEmpty) then

          begin
            if  dbgImportados.DataSource.DataSet.FieldByName('Validade').AsDateTime <= Today + 30 then
              begin
                  algumVencido := True;
                  dbgImportados.Canvas.Brush.Color := clYellow; 
                  dbgImportados.Canvas.Font.Color := clRed; 
                  dbgImportados.Canvas.FillRect(Rect);
                  dbgImportados.DefaultDrawColumnCell(Rect,DataCol,Column,State);


               memoDatas.Lines.Add(dbgImportados.DataSource.DataSet.FieldByName('Validade').AsString);
               MemoVencidos.Lines.Add(dbgImportados.DataSource.DataSet.FieldByName('Recurso').AsString);

              end;

           end;

       end;

end;

procedure TfrmPrincipal.dbgImportadosTitleClick(Column: TColumn);
begin
    if not(mtSuprimentos.IsEmpty) then
    begin
     mtSuprimentos.IndexFieldNames := Column.FieldName;
     dbgImportados.SelectedIndex := 0;
    end;
end;



procedure TfrmPrincipal.dpValidadeCloseUp(Sender: TObject);
begin
  datando := FormatDateTime('dd/MM/yyyy', dpValidade.Date);
end;



procedure TfrmPrincipal.edtBuscaChange(Sender: TObject);
begin
   if sbtnVerificar.Visible then
   begin
   lblVencidos.Visible := True;
   lblVencidos.Color := clRed;
   lblVencidos.Caption := 'Escreva o nome do Recurso exatamente como cadastrado';
   end;

end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin


end;




procedure TfrmPrincipal.FormShow(Sender: TObject);
var
arquivo : TextFile; 
linhasArq: String;
LJSONTextReader: TJsonTextReader;
LStringReader: TStringReader;
LField: TField;



begin

  
   memoJSON.Clear;
   AssignFile(arquivo,'suprimentos.txt');
   Reset (arquivo);
   while not (Eof(arquivo)) do 
     begin
       ReadLn(arquivo, linhasArq);
       memoJSON.Lines.Add(linhasArq);
     end;

     CloseFile(arquivo);

   

   LStringReader := TStringReader.Create(memoJSON.Text); 
   LJSONTextReader := TJsonTextReader.Create(LStringReader);
   try
      mtSuprimentos.Close;  
      mtSuprimentos.Open;
      while LJSONTextReader.TokenType <> TJsonToken.StartArray  do 
       LJSONTextReader.Read;
         while LJSONTextReader.Read do
         begin
           case LJSONTextReader.TokenType of
              TJsonToken.StartObject:
                mtSuprimentos.Append;
              TJsonToken.PropertyName:
              begin
                 for LField in mtSuprimentos.Fields do
                 begin
                    if LJSONTextReader.Value.AsString.Equals(LField.FieldName) then  
                      begin
                          LJSONTextReader.Read;
                           case LField.DataType of 
                             ftString:
                               LField.AsString := LJSONTextReader.Value.AsString ;
                             ftInteger:
                               LField.AsInteger := LJSONTextReader.Value.AsInteger ;
                             ftDate:
                               LField.AsString := LJSONTextReader.Value.AsString ;

                           end;
                           Break;
                      end;
                 end;

              end;
              TJsonToken.EndObject:
                mtSuprimentos.Post;
              TJsonToken.EndArray:
                Break;
           end;
         end;
   finally
     LJSONTextReader.Free;
     LStringReader.Free;
    

                  dbgImportados.DataSource.DataSet.RecNo := 0;
                  mtSuprimentos.IndexFieldNames := 'Validade';
                  dbgImportados.DataSource.DataSet.First; 
                  CalendarView1.Date := Now;
          frmSplash.Hide;



   end;

    dpValidade.Date := Now;

   Timer1.Enabled := True;

end;


procedure TfrmPrincipal.imgAjudaClick(Sender: TObject);
begin
  if frmAjuda = nil then
  begin
    frmAjuda := TfrmAjuda.Create(Application);
    try
       frmAjuda.ShowModal;
    finally

    end;




  end

     else frmAjuda.ShowModal;

end;

procedure TfrmPrincipal.imgBuscaClick(Sender: TObject);
begin
  if btnListaCompras.Visible and btnBackup.Visible then
    begin

     btnListaCompras.Visible := False;
     btnBackup.Visible := False;
     btnFechar.Visible := False;
     btnAdicionar.Visible := False;
     btnAlterar.Visible := False;
     btnApagar.Visible := False;
     btnFecharPesquisa.Visible := True;

     edtBusca.Visible := True;
     sbtnVerificar.Visible := True;
     imgBusca.Visible := False;
     lblVencidos.Visible := True;
     lblVencidos.Font.Color := clRed;
     lblVencidos.Caption := 'Escreva o nome do Recurso exatamente como cadastrado';
     edtBusca.SetFocus;
    end;

end;

procedure TfrmPrincipal.NotificationCenter1ReceiveLocalNotification(
  Sender: TObject; ANotification: TNotification);
begin
  MemoVencidos.Lines.Add('Notification received: ' + ANotification.Name);
end;

procedure TfrmPrincipal.sbtnVerificarClick(Sender: TObject);
var
 total : Integer;
begin
  resumoMemTable.Open;
  resumoMemTable.EmptyDataSet;
  resumoMemTable.Close;
  resumoMemTable.CopyDataSet(mtSuprimentos);

  btnListaCompras.Visible := False;
  btnBackup.Visible := False;
  btnFechar.Visible := False;
  btnAdicionar.Visible := False;
  btnAlterar.Visible := False;
  btnApagar.Visible := False;
  btnFecharPesquisa.Visible := True;
  lblVencidos.Visible := True;



  resumoMemTable.Open;
  resumoMemTable.Filtered := False;
  resumoMemTable.Filter := 'Recurso = ' + QuotedStr( edtBusca.Text);
  resumoMemTable.Filtered := True;



while not resumoMemTable.Eof do

  begin

    total := total + resumoMemTable.FieldByName('Quantidade').AsInteger;

    resumoMemTable.Next;
  end;


  dbgBusca.Visible := True;

  lblVencidos.Visible := False;
  lblTotalRecurso.Visible := True;
  lblTotalRecurso.Caption := 'Total deste Recurso no Bunker = ' + total.ToString;
  edtBusca.Clear;
  btnFecharPesquisa.SetFocus;



end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  shellexecute(0, 'open', 'https://www.ia.seg.br/', '', '', sw_shownormal);
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  if not(mtSuprimentos.IsEmpty) then
    begin
     btnChecarValidade.Click;
    end;
end;



end.
