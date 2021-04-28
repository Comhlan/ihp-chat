module Web.View.Messages.Edit where
import Web.View.Prelude

data EditView = EditView { message :: Message }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={MessagesAction}>Messages</a></li>
                <li class="breadcrumb-item active">Edit Message</li>
            </ol>
        </nav>
        <h1>Edit Message</h1>
        {renderForm message}
    |]

renderForm :: Message -> Html
renderForm message = formFor message [hsx|
    {(textField #negotiationId)}
    {(textField #body)}
    {(textField #sentBy)}
    {submitButton}
|]
