void OnStart()
{
string text = "Message from MT5";
string id = "-1002123527134";
string token = "6606815801:AAGiHaILLrrO_FCEnGAB9wQn_vt-GsrGKbo";

Alert(sendMessage(text, id, token));

}

int sendMessage(string text, string chatID, string botToken)
{
string baseUrl = "https://api.telegram.org";
string headers = "";
string requestURL ="";
string requestHeaders = "";
char resultData[];
char posData[];
int timeout = 2000;

requestURL = StringFormat("%s/bot%s/sendmessage?chat_id=%s&text=%s",baseUrl, botToken, chatID,text);
int response = WebRequest("POST", requestURL, headers, timeout, posData, resultData,requestHeaders);

string resultMessage = CharArrayToString(resultData);
Print(resultMessage);

return response; 
}