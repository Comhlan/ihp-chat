module Web.View.Messages.New where
import Web.View.Prelude

data NewView = NewView { message :: Message }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={MessagesAction}>Messages</a></li>
                <li class="breadcrumb-item active">New Message</li>
            </ol>
        </nav>
        <h1>New Message</h1>
        {renderForm message}
    |]

renderForm :: Message -> Html
renderForm message = formFor message [hsx|
    {(textField #negotiationId)}
    {(textField #body)}
    {(textField #sentBy)}
    {submitButton}
|]
