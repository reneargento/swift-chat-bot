# swift-chat-bot
A chat bot using Telegram API that receives, handles and answers chat messages. 

##Creating a bot
1- To create a bot you need to search for the [@BotFather](https://telegram.me/botfather) on the search field of [Telegram Web](https://web.telegram.org/) </br>
2- Submit the command /newbot </br>
3- After you write your name and username, The BotFather will generate an <b>authorization token</b> for the bot 

##Getting the chat id
1- Start a chat with your bot on Telegram, finding it by the username you set when you created it </br>
2- Get a list of updates of your bot by accessing this URL: </br>
https://api.telegram.org/<b>BOTToken</b>/getUpdates </br>
where BOTToken is the token you received from The BotFather </br>
Example of URL: https://api.telegram.org/bot4534344564:BBSA12asfTAhHhvG2MPd4SPa2aAPQdGzZ9l/getUpdates <br/>
3- On the response, look fo the "chat" object: </br>
```json
{
    "update_id":1424493, 
    "message":
    {
        "message_id":2,
        "from":
        {
            "id":7474,
            "first_name": "Rene",
            "last_name": "Argento"
        },
        "chat":
        {
            "id":"1234",
            "first_name": "Rene",
            "last_name": "Argento",
            "type": "private"
        },
        "date":2549732,
        "text": "Test"
    }
    
}
```
The <b>chat id</b> is the "id" in the "chat" object. </br>
##Setting up this chat bot
All you have to do is replace the values on the Constants class. <br/>
Replace botToken with your <b>authorization token</b> and chatId with your <b>chat id</b>. <br/>
With that, you can start a conversation with the bot on Telegram while the app is running and see the automated responses.


Reference: https://core.telegram.org/bots#botfather 
