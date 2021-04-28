module Web.View.Users.Show where
import Web.View.Prelude

data ShowView = ShowView {
                           user :: User
                         , negotiation :: MessagingConfig User
                         }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Welcome</a></li>
            </ol>
        </nav>
        <h1>Hey {get #name user}</h1>
        <p>Fancy chatting to an installer?</p>
        <div class="correspondence mb-2">
                <div class="inbox">
                    <div class="inbox-header">
                        <div class="inbox-search">
                            <div class="contacts-header">
                                <h6> Inbox </h6>
                            </div>
                        </div>
                    </div>
                    <div class="inbox-contents">
                        {renderNegotiationInbox negotiation}
                    </div>
                </div>
                <div class="messages irradiated">
                    {renderNegotiationMessages negotiation}
                </div>
            </div>

    |]
      where
        renderNegotiationInbox :: MessagingConfig User -> Html
        renderNegotiationInbox x = [hsx|
                                       <div class="inbox-line" data-id={tshow (get #id x)}>
                                       <p class="inbox-siteowner"> Installer: {get #installerId x |> get #name} </p>
                                       </div>
                                       |]

        renderNegotiationMessages :: MessagingConfig User -> Html
        renderNegotiationMessages x = [hsx|
                            <div class="message-set" data-id={tshow (get #id x)}>
                                <div class="compose-message">
                                    <form method="POST" action="/CreateMessage" autocomplete="off">
                                            <input class="message-formfield"  name="body" type="text" placeholder="Type Your Message here."/>
                                            <input type="hidden" name="sentBy" value={tshow (get #id user)}/>
                                            <input type="hidden" name="negotiationId" value={tshow (get #id x)}/>
                                            <input type="hidden" name="userId" value={tshow (get #userId x)}/>
                                            <input type="hidden" name="installerId" value={tshow (get #installerId x)}/>
                                            <input type="hidden" name="sender" value="user"/>
                                            <button class="send-message-button" type="submit">
                                            <img src="send.svg" alt="send"/>
                                            </button>
                                        </form>
                                    </div>
                                    { renderMessages (reverse (get #messages x)) }
                                </div>
                            |]

        renderMessages :: [Message] -> Html
        renderMessages [] = [hsx||]
        renderMessages (x:xs) = let
                                    senderId = (get #sentBy x)
                                    currentInstallerId = (get #id user)
                                in
                                    [hsx|
                                            <div class= {fst (tagSenderMessage currentInstallerId senderId)}>
                                              <div class={snd (tagSenderMessage currentInstallerId senderId)}>
                                                <p> {get #body x}<br/>
                                                    <small class="text-muted">
                                                        {get #createdAt x |> timeAgo}
                                                    </small>
                                                </p>
                                              </div>
                                            </div>
                                    |] <> renderMessages xs

        tagSenderMessage :: Id' "users" -> UUID -> (Text, Text)
        tagSenderMessage a b = case (a == ((Id b):: Id User) ) of
                                        True -> ("outgoing-message","sent-message")
                                        False ->("incoming-message","received-message")
