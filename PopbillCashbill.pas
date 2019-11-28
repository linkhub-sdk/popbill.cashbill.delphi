(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* For strongly secured communications, this module uses SSL/TLS with OpenSSL.
*
* http://www.popbill.com
* Author : Kim Seongjun (pallet027@gmail.com)
* Written : 2014-03-22
* Contributor : Jeong Yohan (code@linkhub.co.kr)
* Updated : 2019-11-28
* Thanks for your interest. 
*=================================================================================
*)
unit PopbillCashbill;

interface

uses
        TypInfo,SysUtils,Classes,
        Popbill,
        Linkhub;
type
        TCashbillChargeInfo = class
        public
                unitCost : String;
                chargeMethod : string;
                rateSystem : string;
        end;

        
        TCashbill = class
        public
                mgtKey               : string;
                orgConfirmNum        : string;
                orgTradeDate         : string;
                tradeDate            : string;
                tradeType            : string;
                tradeUsage           : string;
                tradeOpt             : string;
                taxationType         : string;
                totalAmount          : string;
                supplyCost           : string;
                tax                  : string;
                serviceFee           : string;
                franchiseCorpNum     : string;
                franchiseCorpName    : string;
                franchiseCEOName     : string;
                franchiseAddr        : string;
                franchiseTEL         : string;
                identityNum          : string;
                customerName         : string;
                itemName             : string;
                orderNumber          : string;
                email                : string;
                hp                   : string;
                fax                  : string;
                smssendYN            : Boolean;
                faxsendYN            : Boolean;
                confirmNum           : string;
                cancelType           : Integer;
                emailSubject         : string;                
        end;

        TCashbillInfo = class
        public
                itemKey              : string;
                mgtKey               : string;
                tradeDate            : string;
                tradeType            : string;
                tradeUsage           : string;
                tradeOpt             : string;
                taxationType         : string;
                totalAmount          : string;
                issueDT              : string;
                regDT                : string;
                stateMemo            : string;
                stateCode            : Integer;
                stateDT              : string;
                identityNum          : string;
                itemName             : string;
                customerName         : string;
                confirmNum           : string;
                orgConfirmNum        : string;
                orgTradeDate         : string;
                ntssendDT            : string;
                ntsresultDT          : string;
                ntsresultCode        : string;
                ntsresultMessage     : string;
                printYN              : Boolean;
                ntsresult            : string;
        end;

        TCashbillInfoList = Array of TCashbillInfo;

        TCashbillSearchList = class
        public
                code            : Integer;
                total           : Integer;
                perPage         : Integer;
                pageNum         : Integer;
                pageCount       : Integer;
                message         : String;
                list            : TCashbillInfoList;
                destructor Destroy; override;
        end;

        TCashbillLog = class
        public
                docLogType      : Integer;
                log             : string;
                procType        : string;
                procMemo        : string;
                regDT           : string;
                ip              : string;
        end;

        TCashbillLogList = Array Of TCashbillLog;

        TEmailConfig = class
        public
                EmailType : String;
                SendYN    : Boolean;
        end;

        TEmailConfigList = Array of TEmailConfig;

        TCashbillService = class(TPopbillBaseService)
        private
                
                function jsonToTCashbillInfo(json : String) : TCashbillInfo;
                function jsonToTCashbill(json : String) : TCashbill;
                function TCashbillTojson(Cashbill : TCashbill; Memo : String) : String;

        public
                constructor Create(LinkID : String; SecretKey : String);
                
                //�˺� ���ݿ��������� url.
                function GetURL(CorpNum : String; UserID : String; TOGO : String) : String; overload;
                
                //�˺� ���ݿ��������� url. overload
                function GetURL(CorpNum : String; TOGO : String) : String; overload;

                //������ȣ ��뿩�� Ȯ��
                function CheckMgtKeyInUse(CorpNum : String; MgtKey : String) : boolean;
                
                //��ù���
                function RegistIssue(CorpNum : String; Cashbill : TCashbill; Memo : String; UserID : String = ''; EmailSubject : String = '') : TResponse;

                //�ӽ�����.
                function Register(CorpNum : String; Cashbill : TCashbill; UserID : String = '') : TResponse;

                //������ݿ����� ��ù���
                function RevokeRegistIssue(CorpNum : String; mgtKey : String; orgConfirmNum : String; orgTradeDate : String; smssendYN : Boolean = False; memo : String = ''; UserID : String = '';
                        isPartCancel: Boolean = False; cancelType : Integer = 0; supplyCost : String = ''; tax : String = ''; serviceFee : String = ''; totalAmount : String = '') : TResponse;

                //������ݿ����� �ӽ�����
                function RevokeRegister(CorpNum : String; mgtKey : String; orgConfirmNum : String; orgTradeDate : String; smssendYN : Boolean = False; UserID : String = '';
                        isPartCancel: Boolean = False; cancelType : Integer = 0; supplyCost : String = ''; tax : String = ''; serviceFee : String = ''; totalAmount : String = '') : TResponse;
                

                //����.
                function Update(CorpNum : String; MgtKey : String; Cashbill : TCashbill; UserID : String = '') : TResponse;

                //����.
                function Issue(CorpNum : String; MgtKey : String; Memo : String; UserID : String = '') : TResponse;
                
                //�������.
                function CancelIssue(CorpNum : String; MgtKey : String; Memo : String; UserID : String = '') : TResponse;

                //����.
                function Delete(CorpNum : String;  MgtKey: String; UserID : String = '') : TResponse;

                
                //�̸���������.
                function SendEmail(CorpNum : String;  MgtKey :String; Receiver:String; UserID : String = '') : TResponse;

                //����������.
                function SendSMS(CorpNum : String; MgtKey :String; Sender:String; Receiver:String; Contents : String; UserID : String = '') : TResponse;

                // �ѽ� ������.
                function SendFAX(CorpNum : String; MgtKey :String; Sender:String; Receiver:String; UserID : String = '') : TResponse;


                //���ݿ����� �����ȸ
                function Search(CorpNum : String; DType : String; SDate : String; EDate : String; State:Array Of String; TradeType:Array Of String; TradeUsage: Array Of String; TaxationType : Array Of String; Page:Integer; PerPage: Integer; Order : String) : TCashbillSearchList; overload;

                //���ݿ����� �����ȸ
                function Search(CorpNum : String; DType : String; SDate : String; EDate : String; State:Array Of String; TradeType:Array Of String; TradeUsage: Array Of String; TaxationType : Array Of String; QString:String; Page:Integer; PerPage: Integer; Order : String) : TCashbillSearchList; overload;

                //���ݿ����� �����ȸ
                function Search(CorpNum : String; DType : String; SDate : String; EDate : String; State:Array Of String; TradeType:Array Of String; TradeUsage: Array Of String; TaxationType : Array Of String; Page:Integer; PerPage: Integer; Order : String; TradeOpt : Array of String) : TCashbillSearchList; overload;

                //���ݿ����� �����ȸ
                function Search(CorpNum : String; DType : String; SDate : String; EDate : String; State:Array Of String; TradeType:Array Of String; TradeUsage: Array Of String; TaxationType : Array Of String; QString:String; Page:Integer; PerPage: Integer; Order : String; TradeOpt : Array of String) : TCashbillSearchList; overload;



                //���ݿ����� ������� �� �������� Ȯ��.
                function GetInfo(CorpNum : string; MgtKey: string) : TCashbillInfo;

                //���ݿ����� ������ Ȯ��
                function GetDetailInfo(CorpNum : string; MgtKey: string) : TCashbill;

                //���ݿ����� ������� �� ���� �ٷ� Ȯ��.
                function GetInfos(CorpNum : string; MgtKeyList: Array Of String) : TCashbillInfoList;


                //�����̷� Ȯ��.
                function GetLogs(CorpNum : string; MgtKey: string) : TCashbillLogList;


                //�˾�URL
                function GetPopUpURL(CorpNum: string; MgtKey : String; UserID: String = '') : string;

                //�μ�URL
                function GetPrintURL(CorpNum: string; MgtKey : String; UserID: String = '') : string;

                //���޹޴��� �μ�URL
                function GetEPrintURL(CorpNum: string; MgtKey : String; UserID: String = '') : string;

                //�ٷ��μ�URL
                function GetMassPrintURL(CorpNum: string; MgtKeyList: Array Of String; UserID: String = '') : string;

                //Mail URL
                function GetMailURL(CorpNum: string; MgtKey : String; UserID: String = '') : string;


                // ���ݿ����� ����ܰ� Ȯ��.
                function GetUnitCost(CorpNum : String) : Single;

                // �������� Ȯ��
                function GetChargeInfo(CorpNum : String) : TCashbillChargeInfo;

                // �˸����� ���۸�� ��ȸ
                function ListEmailConfig(CorpNum : String; UserID : String = '') : TEmailConfigList;

                // �˸����� ���ۼ��� ����
                function UpdateEmailConfig(CorpNum : String; EmailType : String; SendYN : Boolean; UserID : String = '') : TResponse;

        end;



implementation
destructor TCashbillSearchList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(list)-1 do
    if Assigned(list[I]) then
      list[I].Free;
  SetLength(list, 0);
  inherited Destroy;
end;

constructor TCashbillService.Create(LinkID : String; SecretKey : String);
begin
       inherited Create(LinkID,SecretKey);
       AddScope('140');
end;

function UrlEncodeUTF8(stInput : widestring) : string;
  const
    hex : array[0..255] of string = (
     '%00', '%01', '%02', '%03', '%04', '%05', '%06', '%07',
     '%08', '%09', '%0a', '%0b', '%0c', '%0d', '%0e', '%0f',
     '%10', '%11', '%12', '%13', '%14', '%15', '%16', '%17',
     '%18', '%19', '%1a', '%1b', '%1c', '%1d', '%1e', '%1f',
     '%20', '%21', '%22', '%23', '%24', '%25', '%26', '%27',
     '%28', '%29', '%2a', '%2b', '%2c', '%2d', '%2e', '%2f',
     '%30', '%31', '%32', '%33', '%34', '%35', '%36', '%37',
     '%38', '%39', '%3a', '%3b', '%3c', '%3d', '%3e', '%3f',
     '%40', '%41', '%42', '%43', '%44', '%45', '%46', '%47',
     '%48', '%49', '%4a', '%4b', '%4c', '%4d', '%4e', '%4f',
     '%50', '%51', '%52', '%53', '%54', '%55', '%56', '%57',
     '%58', '%59', '%5a', '%5b', '%5c', '%5d', '%5e', '%5f',
     '%60', '%61', '%62', '%63', '%64', '%65', '%66', '%67',
     '%68', '%69', '%6a', '%6b', '%6c', '%6d', '%6e', '%6f',
     '%70', '%71', '%72', '%73', '%74', '%75', '%76', '%77',
     '%78', '%79', '%7a', '%7b', '%7c', '%7d', '%7e', '%7f',
     '%80', '%81', '%82', '%83', '%84', '%85', '%86', '%87',
     '%88', '%89', '%8a', '%8b', '%8c', '%8d', '%8e', '%8f',
     '%90', '%91', '%92', '%93', '%94', '%95', '%96', '%97',
     '%98', '%99', '%9a', '%9b', '%9c', '%9d', '%9e', '%9f',
     '%a0', '%a1', '%a2', '%a3', '%a4', '%a5', '%a6', '%a7',
     '%a8', '%a9', '%aa', '%ab', '%ac', '%ad', '%ae', '%af',
     '%b0', '%b1', '%b2', '%b3', '%b4', '%b5', '%b6', '%b7',
     '%b8', '%b9', '%ba', '%bb', '%bc', '%bd', '%be', '%bf',
     '%c0', '%c1', '%c2', '%c3', '%c4', '%c5', '%c6', '%c7',
     '%c8', '%c9', '%ca', '%cb', '%cc', '%cd', '%ce', '%cf',
     '%d0', '%d1', '%d2', '%d3', '%d4', '%d5', '%d6', '%d7',
     '%d8', '%d9', '%da', '%db', '%dc', '%dd', '%de', '%df',
     '%e0', '%e1', '%e2', '%e3', '%e4', '%e5', '%e6', '%e7',
     '%e8', '%e9', '%ea', '%eb', '%ec', '%ed', '%ee', '%ef',
     '%f0', '%f1', '%f2', '%f3', '%f4', '%f5', '%f6', '%f7',
     '%f8', '%f9', '%fa', '%fb', '%fc', '%fd', '%fe', '%ff');
 var
   iLen,iIndex : integer;
   stEncoded : string;
   ch : widechar;
 begin
   iLen := Length(stInput);
   stEncoded := '';
   for iIndex := 1 to iLen do
   begin
     ch := stInput[iIndex];
     if (ch >= 'A') and (ch <= 'Z') then
       stEncoded := stEncoded + ch
     else if (ch >= 'a') and (ch <= 'z') then
       stEncoded := stEncoded + ch
     else if (ch >= '0') and (ch <= '9') then
       stEncoded := stEncoded + ch
     else if (ch = ' ') then
       stEncoded := stEncoded + '+'
     else if ((ch = '-') or (ch = '_') or (ch = '.') or (ch = '!') or (ch = '*')
       or (ch = '~') or (ch = '\')  or (ch = '(') or (ch = ')')) then
       stEncoded := stEncoded + ch
     else if (Ord(ch) <= $07F) then
       stEncoded := stEncoded + hex[Ord(ch)]
     else if (Ord(ch) <= $7FF) then
     begin
        stEncoded := stEncoded + hex[$c0 or (Ord(ch) shr 6)];
        stEncoded := stEncoded + hex[$80 or (Ord(ch) and $3F)];
     end
     else
     begin
        stEncoded := stEncoded + hex[$e0 or (Ord(ch) shr 12)];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch) shr 6) and ($3F))];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch)) and ($3F))];
     end;
   end;
   result := (stEncoded);
 end;
function TCashbillService.GetChargeInfo (CorpNum : string) : TCashbillChargeInfo;
var
        responseJson : String;
begin
        responseJson := httpget('/Cashbill/ChargeInfo',CorpNum,'');

        try
                result := TCashbillChargeInfo.Create;

                result.unitCost := getJSonString(responseJson, 'unitCost');
                result.chargeMethod := getJSonString(responseJson, 'chargeMethod');
                result.rateSystem := getJSonString(responseJson, 'rateSystem');

        except on E:Exception do
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                end
                else
                begin
                        result := TCashbillChargeInfo.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('���ó�� ����.[Malformed Json]');
                        exit;
                end;
        end;
end;

function TCashbillService.GetURL(CorpNum : String; TOGO : String) : String;
begin
        result := GetURL(CorpNum, '', TOGO);
end;

function TCashbillService.GetURL(CorpNum : String; UserID : String; TOGO : String) : String;
var
        responseJson : String;
begin
        responseJson := httpget('/Cashbill/?TG='+ TOGO,CorpNum,UserID);
        result := getJSonString(responseJson,'url');
end;

function TCashbillService.CheckMgtKeyInUse(CorpNum : String; MgtKey : String): boolean;
var
        responseJson : string;
        cashbillInfo : TCashbillInfo;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end;
                result := false;
                setLastErrCode(-99999999);
                setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                exit;
        end;

        try
                responseJson := httpget('/Cashbill/'+MgtKey, CorpNum,'');
                cashbillInfo := jsonToTCashbillInfo(responseJson);

                result:= cashbillInfo.ItemKey <> '';                
        except
                on E : EPopbillException do
                begin
                        if E.code = -14000003 then begin
                                result := false;
                                Exit;
                        end;
                end;
        end;

end;

function TCashbillService.TCashbillTojson(Cashbill : TCashbill; Memo : String) : String;
var
        requestJson : string;

begin
        requestJson := '{';

        requestJson := requestJson + '"memo":"'+ Memo +'",';
        requestJson := requestJson + '"emailSubject":"'+ EscapeString(Cashbill.emailSubject) +'",';

        requestJson := requestJson + '"mgtKey":"'+ EscapeString(Cashbill.mgtKey) +'",';
        requestJson := requestJson + '"tradeUsage":"'+ EscapeString(Cashbill.tradeUsage) +'",';
        requestJson := requestJson + '"tradeOpt":"'+ EscapeString(Cashbill.tradeOpt) +'",';
        requestJson := requestJson + '"tradeType":"'+ EscapeString(Cashbill.tradeType) +'",';
        requestJson := requestJson + '"taxationType":"'+ EscapeString(Cashbill.taxationType) +'",';
        requestJson := requestJson + '"supplyCost":"'+ EscapeString(Cashbill.supplyCost) +'",';
        requestJson := requestJson + '"tax":"'+ EscapeString(Cashbill.tax) +'",';
        requestJson := requestJson + '"serviceFee":"'+ EscapeString(Cashbill.serviceFee) +'",';
        requestJson := requestJson + '"totalAmount":"'+ EscapeString(Cashbill.totalAmount) +'",';
        
        requestJson := requestJson + '"franchiseCorpNum":"'+ EscapeString(Cashbill.franchiseCorpNum) +'",';
        requestJson := requestJson + '"franchiseCorpName":"'+ EscapeString(Cashbill.franchiseCorpName) +'",';
        requestJson := requestJson + '"franchiseCEOName":"'+ EscapeString(Cashbill.franchiseCEOName) +'",';
        requestJson := requestJson + '"franchiseAddr":"'+ EscapeString(Cashbill.franchiseAddr) +'",';
        requestJson := requestJson + '"franchiseTEL":"'+ EscapeString(Cashbill.franchiseTEL) +'",';
        
        requestJson := requestJson + '"identityNum":"'+ EscapeString(Cashbill.identityNum) +'",';
        requestJson := requestJson + '"customerName":"'+ EscapeString(Cashbill.customerName) +'",';
        requestJson := requestJson + '"itemName":"'+ EscapeString(Cashbill.itemName) +'",';
        requestJson := requestJson + '"orderNumber":"'+ EscapeString(Cashbill.orderNumber) +'",';
        requestJson := requestJson + '"email":"'+ EscapeString(Cashbill.email) +'",';
        requestJson := requestJson + '"hp":"'+ EscapeString(Cashbill.hp) +'",';
        requestJson := requestJson + '"fax":"'+ EscapeString(Cashbill.fax) +'",';

        if Cashbill.smssendYN then
        requestJson := requestJson + '"smssendYN":true,';

        if Cashbill.faxsendYN then
        requestJson := requestJson + '"faxsendYN":true,';

        requestJson := requestJson + '"orgTradeDate":"'+ EscapeString(Cashbill.orgTradeDate) +'",';
        requestJson := requestJson + '"orgConfirmNum":"'+ EscapeString(Cashbill.orgConfirmNum) +'"';


        requestJson := requestJson + '}';

        result := requestJson;
end;

function TCashbillService.RegistIssue(CorpNum : String; Cashbill : TCashbill; Memo : String; UserID : String = ''; EmailSubject : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        try
                if EmailSubject <> '' then
                begin
                        Cashbill.emailSubject := EmailSubject;
                end;



                requestJson := TCashbillTojson(Cashbill, Memo);
                responseJson := httppost('/Cashbill',CorpNum,UserID,requestJson, 'ISSUE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;

function TCashbillService.Register(CorpNum : String; Cashbill : TCashbill; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        try
                requestJson := TCashbillTojson(Cashbill, '');
                responseJson := httppost('/Cashbill',CorpNum,UserID,requestJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;                        
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;        
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;

// ������ݿ����� ��ù��� �߰�. 2017/08/18
function TCashbillService.RevokeRegistIssue(CorpNum : String; mgtKey : String; orgConfirmNum : String; orgTradeDate : String; smssendYN : Boolean = False; memo : String = ''; userID : String = '';
        isPartCancel: Boolean = False; cancelType : Integer = 0; supplyCost : String = ''; tax : String = ''; serviceFee : String = ''; totalAmount : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        try
                requestJson := '{"mgtKey":"'+EscapeString(mgtKey)+'","orgConfirmNum":"'+EscapeString(orgConfirmNum) + '",';
                requestJson := requestJson + '"orgTradeDate":"'+EscapeString(orgTradeDate) + '",';

                if smssendYN then
                requestJson := requestJson + '"smssendYN":true,';

                if isPartCancel then
                requestJson := requestJson + '"isPartCancel":true,';

                if cancelType > 0 then
                requestJson := requestJson + '"cancelType":"' + IntToStr(cancelType) + '",';

                requestJson := requestJson + '"supplyCost":"' + EscapeString(supplyCost) + '",';
                requestJson := requestJson + '"tax":"' + EscapeString(tax) + '",';
                requestJson := requestJson + '"serviceFee":"' + EscapeString(serviceFee) + '",';
                requestJson := requestJson + '"totalAmount":"' + EscapeString(totalAmount) + '",';

                requestJson := requestJson + '"memo":"'+EscapeString(memo) + '"}';
               
                responseJson := httppost('/Cashbill',CorpNum,UserID,requestJson, 'REVOKEISSUE');

        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;        
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;

// ������ݿ����� �ӽ����� �߰�. 2017/08/18
function TCashbillService.RevokeRegister(CorpNum : String; mgtKey : String; orgConfirmNum : String; orgTradeDate : String; smssendYN : Boolean = False; userID : String = '';
         isPartCancel: Boolean = False; cancelType : Integer = 0; supplyCost : String = ''; tax : String = ''; serviceFee : String = ''; totalAmount : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        try
                requestJson := '{"mgtKey":"'+EscapeString(mgtKey)+'","orgConfirmNum":"'+EscapeString(orgConfirmNum) + '",';
                requestJson := requestJson + '"orgTradeDate":"'+EscapeString(orgTradeDate) + '",';
                
                if smssendYN then
                requestJson := requestJson + '"smssendYN":true,';

                if isPartCancel then
                requestJson := requestJson + '"isPartCancel":true,';

                if cancelType > 0 then
                requestJson := requestJson + '"cancelType":"' + IntToStr(cancelType) + '",';

                requestJson := requestJson + '"supplyCost":"' + EscapeString(supplyCost) + '",';
                requestJson := requestJson + '"tax":"' + EscapeString(tax) + '",';
                requestJson := requestJson + '"serviceFee":"' + EscapeString(serviceFee) + '",';
                requestJson := requestJson + '"totalAmount":"' + EscapeString(totalAmount) + '",';
                
                requestJson := requestJson + '"}';
               
                responseJson := httppost('/Cashbill',CorpNum,UserID,requestJson, 'REVOKE');
                
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;        
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;



function TCashbillService.Update(CorpNum : String; MgtKey : String; Cashbill : TCashbill; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit;
                end;
        end;

        try
                requestJson := TCashbillTojson(Cashbill, '');
                responseJson := httppost('/Cashbill/'+MgtKey,
                                        CorpNum,UserID,requestJson,'PATCH');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;        
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
        
end;

function TCashbillService.Issue(CorpNum : String; MgtKey : String; Memo : String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit;
                end;
        end;

        try
                requestJson := '{"memo":"'+EscapeString(Memo)+'"}';

                responseJson := httppost('/Cashbill/'+MgtKey,
                                        CorpNum,UserID,requestJson,'ISSUE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;

function TCashbillService.CancelIssue(CorpNum : String; MgtKey : String; Memo : String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit;
                end;

        end;
        try
                requestJson := '{"memo":"'+EscapeString(Memo)+'"}';
                responseJson := httppost('/Cashbill/'+MgtKey,
                                        CorpNum,UserID,requestJson,'CANCELISSUE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;                        
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;        
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;



function TCashbillService.SendEmail(CorpNum : String; MgtKey :String; Receiver:String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;                
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit; 
                end;

        end;

        try
                requestJson := '{"receiver":"'+EscapeString(Receiver)+'"}';
                responseJson := httppost('/Cashbill/'+MgtKey,
                                        CorpNum,UserID,requestJson,'EMAIL');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;

function TCashbillService.SendSMS(CorpNum : String; MgtKey :String; Sender:String; Receiver:String; Contents : String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit;
                end;
        end;
        
        try
                requestJson := '{"sender":"'+EscapeString(Sender)+'","receiver":"'+EscapeString(Receiver)+'","contents":"'+EscapeString(Contents)+'"}';
                responseJson := httppost('/Cashbill/'+MgtKey,
                                        CorpNum,UserID,requestJson,'SMS');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;                        
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function TCashbillService.SendFAX(CorpNum : String; MgtKey :String; Sender:String; Receiver:String; UserID : String = '') : TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if MgtKey = '' then
        begin

                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit; 
                end;
        end;
        
        try
                requestJson := '{"sender":"'+EscapeString(Sender)+'","receiver":"'+EscapeString(Receiver)+'"}';

                responseJson := httppost('/Cashbill/'+MgtKey,
                                        CorpNum,UserID,requestJson,'FAX');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;


function TCashbillService.jsonToTCashbillInfo(json : String) : TCashbillInfo;
begin
        result := TCashbillInfo.Create;

        result.itemKey := getJSonString(json,'itemKey');
        result.mgtKey := getJSonString(json,'mgtKey');
        result.tradeDate := getJSonString(json,'tradeDate');
        result.tradeType := getJSonString(json,'tradeType');
        result.tradeUsage := getJSonString(json,'tradeUsage');
        result.tradeOpt := getJSonString(json,'tradeOpt');
        result.taxationType := getJSonString(json,'taxationType');
        result.totalAmount := getJSonString(json,'totalAmount');
        result.issueDT := getJSonString(json,'issueDT');
        result.regDT := getJSonString(json,'regDT');
        result.stateMemo := getJSonString(json,'stateMemo');
        result.stateCode := getJSonInteger(json,'stateCode');
        result.stateDT := getJSonString(json,'stateDT');
        result.identityNum := getJSonString(json,'identityNum');
        result.itemName := getJSonString(json,'itemName');
        result.customerName := getJSonString(json,'customerName');
        result.confirmNum := getJSonString(json,'confirmNum');
        result.orgConfirmNum := getJSonString(json,'orgConfirmNum');
        result.orgTradeDate := getJSonString(json,'orgTradeDate');
        result.ntssendDT := getJSonString(json,'ntssendDT');
        result.ntsresult := getJSonString(json,'ntsresult');
        result.ntsresultDT := getJSonString(json,'ntsresultDT');
        result.ntsresultCode := getJSonString(json,'ntsresultCode');
        result.ntsresultMessage := getJSonString(json,'ntsresultMessage');
        result.printYN := getJSonBoolean(json,'printYN');
end;

function TCashbillService.getInfo(CorpNum : string; MgtKey: string) : TCashbillInfo;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := TCashbillInfo.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;

        end;

        try
                responseJson := httpget('/Cashbill/'+MgtKey , CorpNum,'');
                result := jsonToTCashbillInfo(responseJson);
        except
                on le : EPopbillException do
                begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := TCashbillInfo.Create;
                                exit;
                        end;
                end;
        end;
end;


function TCashbillService.jsonToTCashbill(json : String) : TCashbill;
begin
        result := TCashbill.Create;

        result.mgtKey                := getJSonString(json,'mgtKey');
        result.tradeDate             := getJSonString(json,'tradeDate');
        result.tradeUsage            := getJSonString(json,'tradeUsage');
        result.tradeOpt              := getJSonString(json,'tradeOpt');
        result.tradeType             := getJSonString(json,'tradeType');

        result.taxationType          := getJSonString(json,'taxationType');
        result.supplyCost            := getJSonString(json,'supplyCost');
        result.tax                   := getJSonString(json,'tax');
        result.serviceFee            := getJSonString(json,'serviceFee');
        result.totalAmount           := getJSonString(json,'totalAmount');

        result.franchiseCorpNum      := getJSonString(json,'franchiseCorpNum');
        result.franchiseCorpName     := getJSonString(json,'franchiseCorpName');
        result.franchiseCEOName      := getJSonString(json,'franchiseCEOName');
        result.franchiseAddr         := getJSonString(json,'franchiseAddr');
        result.franchiseTEL          := getJSonString(json,'franchiseTEL');

        result.identityNum           := getJSonString(json,'identityNum');
        result.customerName          := getJSonString(json,'customerName');
        result.itemName              := getJSonString(json,'itemName');
        result.orderNumber           := getJSonString(json,'orderNumber');

        result.email                 := getJSonString(json,'email');
        result.hp                    := getJSonString(json,'hp');
        result.fax                   := getJSonString(json,'fax');
        
        result.smssendYN             := getJSonBoolean(json,'smssendYN');
        result.faxsendYN             := getJSonBoolean(json,'faxsendYN');
        
        result.confirmNum            := getJSonString(json,'confirmNum');
        
        result.orgConfirmNum         := getJSonString(json,'orgConfirmNum');
        result.orgTradeDate          := getJSonString(json,'orgTradeDate');
        result.cancelType          := getJSonInteger(json,'cancelType');        
     
end;

function TCashbillService.GetDetailInfo(CorpNum : string; MgtKey: string) : TCashbill;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := TCashbill.Create();
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;
        end;
        
        try
                responseJson := httpget('/Cashbill/'+MgtKey + '?Detail' , CorpNum,'');
                result := jsonToTCashbill(responseJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                        end
                        else
                        begin
                                result := TCashbill.Create();
                                exit;
                        end;
                end;
        end;
end;

function TCashbillService.getLogs(CorpNum : string; MgtKey: string) : TCashbillLogList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;                
                end
                else
                begin
                        SetLength(result,0);
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;

        end;



        try
                responseJson := httpget('/Cashbill/' + MgtKey + '/Logs', CorpNum, '');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;                                
                        end
                        else
                        begin
                                SetLength(result,0);
                                SetLength(jSons, 0);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                try
                        jSons := ParseJsonList(responseJson);
                        SetLength(result,Length(jSons));

                        for i := 0 to Length(jSons)-1 do
                        begin
                                result[i] := TCashbillLog.Create;

                                result[i].docLogType            := getJSonInteger(jSons[i],'docLogType');
                                result[i].log                   := getJSonString(jSons[i],'log');
                                result[i].procType              := getJSonString(jSons[i],'procType');
                                result[i].procMemo              := getJSonString(jSons[i],'procMemo');
                                result[i].regDT                 := getJSonString(jSons[i],'regDT');
                                result[i].iP                    := getJSonString(jSons[i],'ip');
                        end;
                except on E:Exception do
                        begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        SetLength(result,0);
                                        SetLength(jSons,0);
                                        setLastErrCode(-99999999);
                                        setLastErrMessage('���ó�� ����.[Malformed Json]');
                                        exit;
                                end;
                        end;
                end;        
        end;
end;

function TCashbillService.Search(CorpNum : String; DType : String; SDate : String; EDate : String; State:Array Of String; TradeType:Array Of String; TradeUsage: Array Of String; TaxationType : Array Of String;Page:Integer; PerPage: Integer; Order : String) : TCashbillSearchList;
var
  emptyList : Array of String;
begin
        SetLength(emptyList, 0);
        result := Search(CorpNum, DType, SDate, EDate, State, TradeType, TradeUsage, TaxationType, '', Page, PerPage, Order, emptyList);
end;

function TCashbillService.Search(CorpNum : String; DType : String; SDate : String; EDate : String; State:Array Of String; TradeType:Array Of String; TradeUsage: Array Of String; TaxationType : Array Of String; QString:String; Page:Integer; PerPage: Integer; Order : String) : TCashbillSearchList;
var
  emptyList : Array of String;
begin
        SetLength(emptyList, 0);
        result := Search(CorpNum, DType, SDate, EDate, State, TradeType, TradeUsage, TaxationType, QString, Page, PerPage, Order, emptyList);
end;

function TCashbillService.Search(CorpNum, DType, SDate, EDate: String; State, TradeType, TradeUsage, TaxationType: array of String; Page, PerPage: Integer; Order: String; TradeOpt: array of String): TCashbillSearchList;
begin
        result := Search(CorpNum, DType, SDate, EDate, State, TradeType, TradeUsage, TaxationType, '', Page, PerPage, Order, TradeOpt);
end;

function TCashbillService.Search(CorpNum, DType, SDate, EDate: String; State, TradeType, TradeUsage, TaxationType: array of String; QString: String; Page, PerPage: Integer; Order: String; TradeOpt: array of String): TCashbillSearchList;
var
        responseJson : String;
        uri : String;
        StateList : String;
        TradeTypeList : String;
        TradeUsageList : String;
        TaxationTypeList : String;
        TradeOptList : String;
        i : integer;
        jSons : ArrayOfString;

begin
        for i := 0 to High(State) do
        begin
                if State[i] <> '' Then
                begin
                        if i = High(State) Then
                        begin
                                StateList := StateList + State[i];
                        end
                        else begin
                                StateList := StateList + State[i] +',';
                        end;
                end
        end;

        for i := 0 to High(TradeType) do
        begin
                if TradeType[i] <> '' Then
                begin
                        if i = High(TradeType) Then
                        begin
                                TradeTypeList := TradeTypeList + TradeType[i];
                        end
                        else begin
                                TradeTypeList := TradeTypeList + TradeType[i] +',';
                        end;
                end
        end;

        for i := 0 to High(TradeOpt) do
        begin
                if TradeOpt[i] <> '' Then
                begin
                        if i = High(TradeOpt) Then
                        begin
                                TradeOptList := TradeOptList + TradeOpt[i];
                        end
                        else begin
                                TradeOptList := TradeOptList + TradeOpt[i] +',';
                        end;
                end
        end;

        for i := 0 to High(TradeUsage) do
        begin
                if TradeUsage[i] <> '' Then
                begin
                        if i = High(TradeUsage) Then
                        begin
                                TradeUsageList := TradeUsageList + TradeUsage[i];
                        end
                        else begin
                                TradeUsageList := TradeUsageList + TradeUsage[i] +',';
                        end;
                end
        end;

        for i := 0 to High(TaxationType) do
        begin
                if TaxationType[i] <> '' Then
                begin
                        if i = High(TaxationType) Then
                        begin
                                TaxationTypeList := TaxationTypeList + TaxationType[i];
                        end
                        else begin
                                TaxationTypeList := TaxationTypeList + TaxationType[i] +',';
                        end;
                end
        end;


        uri := '/Cashbill/Search?DType='+DType+'&&SDate='+SDate+'&&EDate='+EDate;
        uri := uri + '&&State='+StateList + '&&TradeType='+TradeTypeList;
        uri := uri + '&&TradeUsage='+TradeUsageList + '&&TradeOpt='+TradeOptList + '&&TaxationType='+TaxationTypeList;
        uri := uri + '&&Page='+IntToStr(Page)+'&&PerPage='+IntToStr(PerPage);
        uri := uri + '&&Order=' + Order;
        uri := uri + '&&QString=' + UrlEncodeUTF8(QString);

        try
                responseJson := httpget(uri, CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := TCashbillSearchList.Create;
                                result.code := le.code;
                                result.message := le.message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result := TCashbillSearchList.Create;
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
                result := TCashbillSearchList.Create;

                result.code             := getJSonInteger(responseJson,'code');
                result.total            := getJSonInteger(responseJson,'total');
                result.perPage          := getJSonInteger(responseJson,'perPage');
                result.pageNum          := getJSonInteger(responseJson,'pageNum');
                result.pageCount        := getJSonInteger(responseJson,'pageCount');
                result.message          := getJSonString(responseJson,'message');

                try
                        jSons := getJSonList(responseJson,'list');
                        SetLength(result.list,Length(jSons));

                        for i := 0 to Length(jSons)-1 do
                        begin
                                result.list[i] := jsonToTCashbillInfo(jSons[i]);
                        end;

                except on E:Exception do
                        begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        result := TCashbillSearchList.Create;
                                        result.code := -99999999;
                                        result.message := '���ó�� ����.[Malformed Json]';
                                        exit;
                                end;
                        end;
                end;
        end;
end;

function TCashbillService.getInfos(CorpNum : string; MgtKeyList: Array Of String) : TCashbillInfoList;
var
        requestJson : string;
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin
        if Length(MgtKeyList) = 0 then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        SetLength(result, 0);
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;
        end;

        requestJson := '[';
        for i:=0 to Length(MgtKeyList) -1 do
        begin
                requestJson := requestJson + '"' + MgtKeyList[i] + '"';
                if (i + 1) < Length(MgtKeyList) then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';


        try
                responseJson := httppost('/Cashbill/States', CorpNum,'',requestJson);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;        
                        end
                        else
                        begin
                                SetLength(result, 0);
                                exit;
                        end;
                end;

        end;

        if LastErrCode <> 0 then
        begin
                SetLength(result, 0);
                SetLength(jSons, 0);
                exit;
        end
        else
        begin
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result[i] := jsonToTCashbillInfo(jSons[i]);
                end;
        end;


        
end;


function TCashbillService.Delete(CorpNum : String; MgtKey: String; UserID : String = '') : TResponse;
var
        responseJson : string;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '������ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        exit; 
                end;
        end;
        
        try
                responseJson := httppost('/Cashbill/'+MgtKey,CorpNum,UserID,'','DELETE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;                        
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;        
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');        
        end;
end;


function TCashbillService.GetPopUpURL(CorpNum: string; MgtKey : String; UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;

        end;

        try
                responseJson := httpget('/Cashbill/'+MgtKey +'?TG=POPUP',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;
end;

function TCashbillService.GetPrintURL(CorpNum: string; MgtKey : String; UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/Cashbill/'+MgtKey +'?TG=PRINT',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;
end;

function TCashbillService.GetEPrintURL(CorpNum: string; MgtKey : String; UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;

        end;

        try
                responseJson := httpget('/Cashbill/'+MgtKey +'?TG=EPRINT',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.Message);
                                exit;
                        end;
                end;
        end;
end;

function TCashbillService.GetMassPrintURL(CorpNum: string; MgtKeyList: Array Of String; UserID: String = '') : string;
var
        requestJson,responseJson:string;
        i : integer;
begin
        if Length(MgtKeyList) = 0 then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;

        end;

        requestJson := '[';
        for i:=0 to Length(MgtKeyList) -1 do
        begin
                requestJson := requestJson + '"' + EscapeString(MgtKeyList[i]) + '"';
                if (i + 1) < Length(MgtKeyList) then requestJson := requestJson + ',';
        end;

        requestJson := requestJson + ']';

        try
                responseJson := httppost('/Cashbill/Prints', CorpNum, UserID, requestJson);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.Message);
                                exit;
                        end;
                end;
        end;

end;

function TCashbillService.GetMailURL(CorpNum: string; MgtKey : String; UserID : String = '') : string;
var
        responseJson : String;
begin
        if MgtKey = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999,'������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('������ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        exit;
                end;
        end;


        try
                responseJson := httpget('/Cashbill/'+ MgtKey +'?TG=MAIL',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;

        end;
end;

function TCashbillService.GetUnitCost(CorpNum : String) : Single;
var
        responseJson : string;
begin
        try
                responseJson := httpget('/Cashbill?cfg=UNITCOST',CorpNum,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := 0.0;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result := 0.0;
                exit;
        end
        else
        begin
                result := strToFloat(getJSonString(responseJson,'unitCost'));
        end;
end;

//End Of Unit.
function TCashbillService.ListEmailConfig(CorpNum, UserID: String): TEmailConfigList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : integer;
begin
        try
                responseJson := httpget('/Cashbill/EmailSendConfig',CorpNum,UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                try
                        jSons := ParseJsonList(responseJson);
                        SetLength(result,Length(jSons));

                        for i := 0 to Length(jSons)-1 do
                        begin
                                result[i] := TEmailConfig.Create;

                                result[i].EmailType := getJSonString (jSons[i],'emailType');
                                result[i].SendYN    := getJSonBoolean(jSons[i],'sendYN');
                        end;
                except on E:Exception do
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                setLength(result,0);
                                setLength(jSons,0);
                                setLastErrCode(-99999999);
                                setLastErrMessage('���ó�� ����.[Malformed Json]');
                                exit;
                        end;
                end;
        end;
end;

Function BoolToStr(b:Boolean):String;
begin
    if b = true then BoolToStr:='True';
    if b = false then BoolToStr:='False';
end;

function TCashbillService.UpdateEmailConfig(CorpNum, EmailType: String; SendYN: Boolean; UserID: String): TResponse;
var
        requestJson : string;
        responseJson : string;
begin
        if Trim(EmailType) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '�������������� �Էµ��� �ʾҽ��ϴ�.');
                        exit
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '�������������� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        try
                requestJson := '{"EmailType":"'+EscapeString(EmailType)+'","SendYN":"'+EscapeString(BoolToStr(SendYN))+'"}';

                responseJson := httppost('/Cashbill/EmailSendConfig?EmailType=' + EmailType + '&SendYN=' + BoolToStr(SendYN),
                                        CorpNum,UserID,requestJson,'');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;


end.
