module Web.View.Installers.New where
import Web.View.Prelude

data NewView = NewView { installer :: Installer }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={InstallersAction}>Installers</a></li>
                <li class="breadcrumb-item active">New Installer</li>
            </ol>
        </nav>
        <h1>New Installer</h1>
        {renderForm installer}
    |]

renderForm :: Installer -> Html
renderForm installer = formFor installer [hsx|
    {(textField #name)}
    {(textField #email)}
    {(textField #passwordHash)}
    {(textField #failedLoginAttempts)}
    {submitButton}
|]
